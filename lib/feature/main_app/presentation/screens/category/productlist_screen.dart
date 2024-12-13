import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hm_store/core/helper_extensions.dart';
import 'package:hm_store/feature/main_app/domain/entities/product_section_entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../bloc/product_bloc/product_bloc.dart';
import '../../widgets/productlist_large_widget.dart';
import '../../widgets/productlist_small_widget.dart';

class ProductlistScreen extends StatefulWidget {
  final String categoryName;
  final String tagCodes;
  const ProductlistScreen(
      {super.key, required this.categoryName, required this.tagCodes});

  @override
  State<ProductlistScreen> createState() => _ProductlistScreenState();
}

class _ProductlistScreenState extends State<ProductlistScreen> {
  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 0);
  static const int _pageSize = 5;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      log("Coming !!");
      BlocProvider.of<ProductBloc>(context).add(FetchProductsList(
          page: pageKey ~/ _pageSize, tagCodes: widget.tagCodes));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductsListSuccessState) {
              log(state.productSectionEntity.results.length.toString());
              final isLastPage =
                  state.productSectionEntity.results.length < _pageSize;

              if (isLastPage) {
                _pagingController
                    .appendLastPage(state.productSectionEntity.results);
              } else {
                final nextPageKey =
                    _pagingController.itemList?.length ?? 0 + _pageSize;
                _pagingController.appendPage(
                    state.productSectionEntity.results, nextPageKey);
              }
            } else if (state is ProductsListErrorState) {
              _pagingController.error = state.errorMessage;
            }
          },
          builder: (context, state) => Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: PagedListView<int, Result>(
                  shrinkWrap: true,
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Result>(
                    itemBuilder: (context, result, index) {
                      // Calculate batch indices
                      final batchIndex = index ~/ 3;
                      final batchStartIndex = batchIndex * 3;

                      // Prepare batch of up to 3 items
                      final batch = _pagingController.itemList!.sublist(
                        batchStartIndex,
                        (batchStartIndex + 3 >
                                _pagingController.itemList!.length)
                            ? _pagingController.itemList!.length
                            : batchStartIndex + 3,
                      );

                      // Prepare small and large widget data
                      List<Result> smallWidgetResults =
                          batch.length > 2 ? batch.sublist(0, 2) : batch;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 24,
                        children: [
                          if (index == 0)
                            Container(
                              width: double.infinity,
                              height: mediaQuery.height * .2,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text("Discover new outfit styles",
                                        style: TextStyle(fontSize: 24)),
                                    Container(
                                      width: mediaQuery.width * .4,
                                      height: mediaQuery.height * .07,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      alignment: Alignment.center,
                                      child: const Text("Try-on",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 18)),
                                    )
                                  ]),
                            ),
                          if (smallWidgetResults.isNotEmpty)
                            ProductListSmallWidget(
                              mediaQuery: mediaQuery,
                              title: smallWidgetResults.first.brandName,
                              resultList: smallWidgetResults,
                            ),
                          if (batch.length > 2)
                            ProductListLargeWidget(
                              mediaQuery: mediaQuery,
                              title: batch[2].name,
                              subTitle: batch[2].name,
                              color: HexColor.fromHex(
                                      batch[2].defaultArticle.rgbColor)
                                  .withOpacity(.3),
                              imageUrl:
                                  batch[2].defaultArticle.images.first.url,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              )),
    );
  }
}
