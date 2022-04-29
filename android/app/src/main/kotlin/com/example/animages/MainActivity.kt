package com.example.animages
import android.annotation.SuppressLint
import android.app.DownloadManager
import android.app.WallpaperManager
import android.content.Context
import android.database.Cursor
import android.graphics.Bitmap
import android.net.Uri
import android.os.AsyncTask
import android.os.Build
import android.os.Environment
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.lifecycle.lifecycleScope
import com.bumptech.glide.Glide.with
import com.squareup.picasso.Picasso
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.sgt.animewallpapers"
    private var msg  = ""
    private var lastMsg = ""

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result -> 
            when {
                call.method.equals("setWallpaper") -> {
                        setWallpaper(call,result)
                }
                call.method.equals("saveWallpaper") -> {
                    lifecycleScope.launch {
                        saveWallpaper(call,result)
                    }

                }
            }
        }
    }

    private fun setWallpaper(call : MethodCall, result : MethodChannel.Result) {
        var type = call.argument<String>("screen")
        var imageUrl = call.argument<String>("imageUrl")
        if(imageUrl!=null){
            type?.let { SetWallpaperClass(this, imageUrl, it) }?.execute(true)
        }
        result.success("Wallpaper Set")
    }

    companion object {
        class  SetWallpaperClass internal  constructor(
            private  val context:Context,
            private val imageUrl : String,
            private val screen : String
        ) : AsyncTask<Boolean, String, String>() {
            @RequiresApi(Build.VERSION_CODES.N)
            override fun doInBackground(vararg  p0: Boolean?): String {

                val imageDrawable: Bitmap = Picasso.get().load(imageUrl).get()

                var wallpaperManager : WallpaperManager = WallpaperManager.getInstance(context)
                if(wallpaperManager.isSetWallpaperAllowed  && wallpaperManager.isWallpaperSupported){
                    when (screen) {
                        "0" -> {
                            wallpaperManager.setBitmap(imageDrawable,null,false, WallpaperManager.FLAG_SYSTEM)
                        }
                        "1" -> {
                            wallpaperManager.setBitmap(imageDrawable,null,true, WallpaperManager.FLAG_LOCK)
                        }
                        else -> {
                            wallpaperManager.setBitmap(imageDrawable)
                        }
                    }
                }
                return "Wallpaper Changed!!"
            }
        }
    }

    @SuppressLint("Range")
    private suspend fun saveWallpaper(call : MethodCall, result : MethodChannel.Result) {
        val imageUrl = call.argument<String>("imageUrl")
        var msg  = ""
        val directory = File(Environment.DIRECTORY_PICTURES)

        if(!directory.exists()){
            directory.mkdirs()
        }

        val downloadManager = getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val downloadUri = Uri.parse(imageUrl)

        val request = DownloadManager.Request(downloadUri).apply {
            setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI or DownloadManager.Request.NETWORK_MOBILE)
                .setAllowedOverRoaming(false)
                .setTitle("Downloading Wallpapers")
                .setDestinationInExternalPublicDir(
                    directory.toString(),
                    imageUrl?.lastIndexOf("/")?.let { imageUrl.substring(it.plus(1)) }
                )
        }

        val downloadId = downloadManager.enqueue(request)
        val query = DownloadManager.Query().setFilterById(downloadId)

        withContext(Dispatchers.IO) {
            var downloading = true
            while (downloading) {
                val cursor: Cursor = downloadManager.query(query)
                cursor.moveToFirst()
                if (cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS)) == DownloadManager.STATUS_SUCCESSFUL) {
                    downloading = false
                }
                val status = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))
                msg = imageUrl?.let { statusMessage(it, directory, status) }.toString()
                if (msg != lastMsg) {
                    runOnUiThread {
                        Toast.makeText(this@MainActivity, msg, Toast.LENGTH_SHORT).show()
                    }
                    lastMsg = msg ?: ""
                }
                cursor.close()
            }
        }
        result.success("Save wallpaper to gallery")
    }

//    function to handle download status toast message
    private fun statusMessage(url: String, directory: File, status: Int): String {

        msg = when (status) {
            DownloadManager.STATUS_FAILED -> "Download Failed. Try Again."
            DownloadManager.STATUS_PAUSED -> "Paused"
            DownloadManager.STATUS_PENDING -> "Pending"
            DownloadManager.STATUS_RUNNING -> "Downloading..."
            DownloadManager.STATUS_SUCCESSFUL -> "Image downloaded successfully in $directory" + File.separator + url.substring(
                url.lastIndexOf("/") + 1
            )
            else -> "There's nothing to download"
        }
        return msg
    }
}
