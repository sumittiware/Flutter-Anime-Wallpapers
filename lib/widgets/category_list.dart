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
    return Consumer<AnImagesProvider>(
      builder: (_, aniProvider, __) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                aniProvider.currentCategories.length,
                (index) => GestureDetector(
                  onTap: () => aniProvider.setCategory(
                    aniProvider.currentCategories[index],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.all(
                      4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (aniProvider.currentCategory ==
                                aniProvider.currentCategories[index])
                            ? primaryColor
                            : Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      aniProvider.currentCategories[index],
                      style: (aniProvider.currentCategory ==
                              aniProvider.currentCategories[index])
                          ? const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            )
                          : const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
