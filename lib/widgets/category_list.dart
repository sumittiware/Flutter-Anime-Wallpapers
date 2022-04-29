import 'package:animages/provider/animagesprovider.dart';
import 'package:animages/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final aniProvider = Provider.of<AnImagesProvider>(context);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(
                  aniProvider.currentCategories.length,
                  (index) => GestureDetector(
                        onTap: () => aniProvider
                            .setCategory(aniProvider.currentCategories[index]),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            aniProvider.currentCategories[index],
                            style: (aniProvider.currentCategory ==
                                    aniProvider.currentCategories[index])
                                ? const TextStyle(
                                    color: primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)
                                : const TextStyle(
                                    color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ))),
        ));
  }
}
