import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class GeminiListViewItem extends StatefulWidget {
  const GeminiListViewItem({super.key, this.bookModel});
  final BookModel? bookModel;

  @override
  State<GeminiListViewItem> createState() => _GeminiListViewItemState();
}

class _GeminiListViewItemState extends State<GeminiListViewItem> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: Container(
        // padding: const EdgeInsets.only(top: 20),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 190, 62, 212)
              .withOpacity(0.5), // لون مختلف عن UserChat
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xFF4285F4).withOpacity(0.3),
          //     blurRadius: 8,
          //     spreadRadius: 1,
          //   ),
          // ],
        ),
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              NewestBookImage(
                  imageUrl:
                      widget.bookModel?.volumeInfo.imageLinks.thumbnail ?? ''),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.bookModel?.volumeInfo.title ?? 'No title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textStyle20
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.bookModel?.volumeInfo.authors![0] ?? 'No author',
                      style: Styles.textStyle14,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text(
                        'Free',
                        style: Styles.textStyle20,
                      ),
                    ]),
                    Spacer(),
                    Row(
                      children: [
                        BookRating(
                          rating: '0.0',
                          reviewsCount: 0,
                        ),
                        Spacer(),
                        CustomShaderMask(
                          child: Icon(HugeIcons.strokeRoundedStars,
                              color: Colors.white, size: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
