
import 'package:flutter/material.dart';

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
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
      ],
    );
  }
}