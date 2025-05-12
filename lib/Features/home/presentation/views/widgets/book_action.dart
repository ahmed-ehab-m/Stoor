import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

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
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  textStyle:
                      Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
                  foregroundColor:
                      BlocProvider.of<ChangeThemeCubit>(context).iconColor,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                ),
                onPressed: () {},
                child: Text(
                  'Buy Now  19.99\$',
                  textAlign: TextAlign.center,
                )),
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  textStyle:
                      Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedBookOpen02,
                      size: 25,
                    ),
                    Text(
                      'Read ',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),

          // Expanded(
          //     child: CustomButton(
          //   fontSize: FontSizeHelper.descriptionFontSize,
          //   text: 'Buy Now for 19.99\$',
          //   backGroundColor: Colors.white,
          //   textColor: Colors.black,
          //   borderRadius: BorderRadius.all(Radius.circular(8)),
          // )),
          // Expanded(
          //   child: CustomButton(
          //     onPressed: () async {
          //       await launchCustomUrl(
          //         context,
          //         bookModel?.volumeInfo.previewLink,
          //       );
          //     },
          //     fontSize: FontSizeHelper.descriptionFontSize,
          //     text: getText(bookModel),
          //     backGroundColor: kPrimaryColor,
          //     textColor: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(8)),
          //   ),
          // ),
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
