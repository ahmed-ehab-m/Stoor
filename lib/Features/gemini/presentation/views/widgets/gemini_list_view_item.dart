import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
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
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            // border: Border.all(color: Colors.grey),
            // color: BlocProvider.of<ChangeThemeCubit>(context).backgroundColor,
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
                    Container(
                      child: Row(children: [
                        Text(
                          'Free',
                          style: Styles.textStyle20,
                        ),
                      ]),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        BookRating(
                          rating: '0.0',
                          reviewsCount: 0,
                        ),
                        Spacer(),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFFEC4899), // Pink
                                Color(0xFFA855F7), // Purple
                                Color(0xFF3B82F6), // Blue
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.clamp,
                            ).createShader(bounds);
                          },
                          child: Icon(HugeIcons.strokeRoundedStars,
                              color: Colors.white, size: 30),
                        )
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
