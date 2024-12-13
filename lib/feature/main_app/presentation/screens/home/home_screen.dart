import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hm_store/core/helper_extensions.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';

import '../../bloc/product_bloc/product_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductsListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsListErrorState) {
              return const Center(child: Text("Some Error Occured !!"));
            } else if (state is ProductsListSuccessState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Container(
                        width: double.infinity,
                        height: mediaQuery.height * .2,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Discover new outfit styles",
                                  style: TextStyle(fontSize: 24)),
                              Container(
                                width: mediaQuery.width * .4,
                                height: mediaQuery.height * .07,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: const Text("Try-on",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18)),
                              )
                            ]),
                      ),
                      ...List.generate(
                        state.productSectionEntity.results.length,
                        // 1,
                        (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 18,
                            children: [
                              ProductListSmallWidget(
                                mediaQuery: mediaQuery,
                                title: state.productSectionEntity.results[index]
                                    .brandName,
                                article: state.productSectionEntity
                                    .results[index].articles,
                              ),
                              ProductListLargeWidget(
                                mediaQuery: mediaQuery,
                                title: state
                                    .productSectionEntity.results[index].name,
                                subTitle: state.productSectionEntity
                                    .results[index].defaultArticle.name,
                                color: HexColor.fromHex(state
                                        .productSectionEntity
                                        .results[index]
                                        .defaultArticle
                                        .rgbColor)
                                    .withOpacity(.3),
                                imageUrl: state
                                    .productSectionEntity
                                    .results[index]
                                    .defaultArticle
                                    .images
                                    .first
                                    .url,
                              ),
                            ]),
                      )
                      // ProductListSmallWidget(
                      //   mediaQuery: mediaQuery,
                      //   title: "Trendy looks",
                      // ),
                      // ProductListLargeWidget(
                      //     mediaQuery: mediaQuery, title: "Formal"),
                      // ProductListSmallWidget(
                      //   mediaQuery: mediaQuery,
                      //   title: "Party wear",
                      // ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ));
  }
}

class ProductListLargeWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subTitle;
  final Color color;
  const ProductListLargeWidget(
      {super.key,
      required this.mediaQuery,
      required this.title,
      required this.subTitle,
      required this.color,
      required this.imageUrl});

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
            width: double.infinity,
            height: mediaQuery.height * .4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: mediaQuery.height * .1,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: color,
                      // color: Colors.deepOrangeAccent.shade100.withOpacity(.8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    subTitle,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            )),
      ],
    );
  }
}

class ProductListSmallWidget extends StatelessWidget {
  final List<Article> article;
  final String title;
  const ProductListSmallWidget({
    super.key,
    required this.title,
    required this.article,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IntrinsicHeight(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  article.length >= 2 ? 2 : article.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: mediaQuery.width * .4,
                          height: mediaQuery.height * .1,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      article[index].images.first.url),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const Gap(6),
                        Text(
                          article[index].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          article[index].whitePrice.formattedValue,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                if (article.length >= 2)
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.forward, color: Colors.white),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
