import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_book_list_item.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_state.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BookListViewItem extends StatefulWidget {
  const BookListViewItem({super.key, this.bookModel});
  final BookModel? bookModel;

  @override
  State<BookListViewItem> createState() => _BookListViewItemState();
}

class _BookListViewItemState extends State<BookListViewItem> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: Stack(
        children: [
          SizedBox(
            height: 140,
            child: Row(
              children: [
                NewestBookImage(
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
                      BookRating(
                        rating: '0.0',
                        reviewsCount: 0,
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
              icon: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
                builder: (context, state) {
                  return Icon(
                    isBookmarked
                        ? FontAwesomeIcons.solidBookmark
                        : FontAwesomeIcons.bookmark,
                    color: isBookmarked
                        ? Colors.amber
                        : BlocProvider.of<ChangeThemeCubit>(context).iconColor,
                    size: 20,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
