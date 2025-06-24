import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchListItem extends StatefulWidget {
  const SearchListItem({super.key, this.bookModel});
  final BookModel? bookModel;

  @override
  State<SearchListItem> createState() => _SearchListItemState();
}

class _SearchListItemState extends State<SearchListItem> {
  // bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.1),
              Colors.grey.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(0),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              NewestBookImage(
                  imageUrl:
                      widget.bookModel?.volumeInfo.imageLinks.thumbnail ?? ''),
              const SizedBox(width: 30),
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
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.bookModel?.volumeInfo.authors![0] ?? 'No author',
                      style: Styles.textStyle14,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Free',
                          style: Styles.textStyle20,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const BookRating(
                      rating: '0.0',
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
