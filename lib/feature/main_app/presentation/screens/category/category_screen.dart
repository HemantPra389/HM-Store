import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/category_bloc/category_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
            return const Center(child: Text("Some Error Occured !!"));
          } else if (state is CategoryListSuccessState) {
            return Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: ListView.separated(
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.categoryEntity[index].catName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Gap(12),
                            GridView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      3, // Adjust this for item aspect ratio
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                children: List.generate(
                                  state.categoryEntity[index].categoriesArray!
                                      .length,
                                  (i) => Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.categoryEntity[index]
                                          .categoriesArray![i].catName,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            const Gap(12)
                          ],
                        ),
                    separatorBuilder: (context, index) => const Gap(8),
                    itemCount: 4));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
