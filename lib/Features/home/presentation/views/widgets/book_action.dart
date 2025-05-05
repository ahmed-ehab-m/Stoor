import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/functions/launch_url.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookAction extends StatelessWidget {
  const BookAction({super.key, this.bookModel});
  final BookModel? bookModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        spacing: 10,
        children: [
          const Expanded(
              child: CustomButton(
            fontSize: 16,
            text: '19.99\$',
            backGroundColor: Colors.white,
            textColor: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )),
          Expanded(
            child: CustomButton(
              onPressed: () async {
                await launchCustomUrl(
                  context,
                  bookModel?.volumeInfo.previewLink,
                );
              },
              fontSize: 16,
              text: getText(bookModel),
              backGroundColor: kPrimaryColor,
              textColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  String getText(BookModel? bookModel) {
    if (bookModel?.volumeInfo.previewLink != null) {
      return 'Preview';
    } else {
      return 'Not Available';
    }
  }
}
