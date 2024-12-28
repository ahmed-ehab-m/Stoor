import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/assets.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BestSellerListViewItem extends StatelessWidget {
  const BestSellerListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 2.5 / 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(AssetsData.testBookCover),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Harry Potter and the Goblet of Fire',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle20.copyWith(fontFamily: KGTSectraFine),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                'J.K. Rowling',
                style: Styles.textStyle14,
              ),
              SizedBox(
                width: 3,
              ),
              Row(children: [
                Text('19.99 \$',
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold)),
              ])
            ],
          )
        ],
      ),
    );
  }
}
