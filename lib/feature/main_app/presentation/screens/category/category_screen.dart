import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hm_store/feature/main_app/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:hm_store/feature/main_app/presentation/screens/category/productlist_screen.dart';
import '../../../domain/entities/category_entity.dart';
import '../../bloc/category_bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  Set<String> getCombinedTagCodes(List<CategoryEntity> categories) {
    Set<String> combinedTags = {};

    void traverse(List<CategoryEntity>? categoriesArray) {
      if (categoriesArray == null || categoriesArray.isEmpty) return;

      for (var category in categoriesArray) {
        // Add the current category's tagCodes to the set
        combinedTags.addAll(category.tagCodes);

        // Recursively traverse the nested categoriesArray
        if (category.categoriesArray != null &&
            category.categoriesArray!.isNotEmpty) {
          traverse(category.categoriesArray);
        }
      }
    }

    // Start traversing from the given list
    traverse(categories);

    return combinedTags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Outfit Categories"),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryListErrorState) {
            return const Center(child: Text("Some Error Occurred !!"));
          } else if (state is CategoryListSuccessState) {
            return Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: ListView.separated(
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.categoryEntity[index].catName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Gap(12),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            3, // Adjust this for item aspect ratio
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount:
                          state.categoryEntity[index].categoriesArray!.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            // Collect tag codes from the category
                            Set<String> combinedTags = getCombinedTagCodes(state
                                .categoryEntity[index]
                                .categoriesArray![i]
                                .categoriesArray!);
                            String tagCodesToSend = combinedTags.join(':');

                            log(tagCodesToSend);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ProductBloc(),
                                  child: ProductlistScreen(
                                    categoryName: state.categoryEntity[index]
                                        .categoriesArray![i].catName,
                                    tagCodes: tagCodesToSend,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              state.categoryEntity[index].categoriesArray![i]
                                  .catName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(12)
                  ],
                ),
                separatorBuilder: (context, index) => const Gap(8),
                itemCount: state.categoryEntity.length,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
