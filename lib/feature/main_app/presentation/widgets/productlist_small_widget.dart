import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/product_section_entity.dart';

class ProductListSmallWidget extends StatelessWidget {
  final List<Result> resultList;
  final String title;
  const ProductListSmallWidget({
    super.key,
    required this.title,
    required this.resultList,
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
                  resultList.length,
                  (index) => Container(
                    width: mediaQuery.width * .4,
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
                                      resultList[index].images.first.url),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const Gap(6),
                        Text(
                          resultList[index].articles.first.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          resultList[index].price.formattedValue,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                // if (article.length >= 2)
                const CircleAvatar(
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
