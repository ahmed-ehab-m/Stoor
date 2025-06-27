import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BookAction extends StatelessWidget {
  const BookAction({super.key, this.bookModel});
  final BookModel? bookModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(double.infinity, 60),
            textStyle: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              const Icon(HugeIcons.strokeRoundedShoppingCartCheckIn02,
                  size: 25),
              Text(
                'Buy Now ${bookModel?.price} EGP',
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
