import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
          // color: BlocProvider.of<ChangeThemeCubit>(context).backgroundColor,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 140,
              child: Row(
                children: [
                  CustomBookImage(
                      imageUrl:
                          widget.bookModel?.volumeInfo.imageLinks.thumbnail ??
                              ''),
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
                          widget.bookModel?.volumeInfo.authors![0] ??
                              'No author',
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
                            Icon(HugeIcons.strokeRoundedGoogleGemini,
                                color: Colors.amber, size: 20)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: -1,
              // bottom:,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
                icon: Icon(
                  isBookmarked
                      ? FontAwesomeIcons.solidBookmark
                      : FontAwesomeIcons.bookmark,
                  color: isBookmarked
                      ? Colors.amber
                      : BlocProvider.of<ChangeThemeCubit>(context).iconColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
