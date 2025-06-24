import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RatedBookItem extends StatefulWidget {
  const RatedBookItem({
    super.key,
    this.bookModel,
  });
  final Apibook? bookModel;

  @override
  State<RatedBookItem> createState() => _RatedBookItemState();
}

class _RatedBookItemState extends State<RatedBookItem> {
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
            height: 180,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  NewestBookImage(imageUrl: widget.bookModel?.image ?? ''),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.bookModel!.title ?? 'No title',
                                  style: Styles.textStyle18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.bookModel?.author?.name ?? 'No author',
                          style: Styles.textStyle14,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            widget.bookModel?.price ?? 'free',
                            style: Styles.textStyle20,
                          ),
                        ]),
                        const Spacer(),
                        BookRating(
                          rating: widget.bookModel?.rating ?? '0.0',
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
              icon: BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
                builder: (context, state) {
                  return Icon(
                    isBookmarked
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                    color: isBookmarked
                        ? Colors.amber
                        : BlocProvider.of<ChangeSettingsCubit>(context)
                            .iconColor,
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

Widget highlightText({
  required String text,
  required String searchQuery,
  required TextStyle baseStyle,
}) {
  if (searchQuery.isEmpty || !text.toLowerCase().contains(searchQuery)) {
    return Text(
      text,
      style: baseStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
  final lowerText = text.toLowerCase();
  final lowerQuery = searchQuery.toLowerCase();
  final startIndex = lowerText.indexOf(lowerQuery);
  final endIndex = startIndex + lowerQuery.length;
  final beforeMatch = text.substring(0, startIndex);
  final match = text.substring(startIndex, endIndex);
  final afterMatch = text.substring(endIndex);
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      children: [
        TextSpan(text: beforeMatch, style: baseStyle),
        TextSpan(
          text: match,
          style: baseStyle.copyWith(
              color: const Color.fromARGB(255, 189, 49, 214),
              fontWeight: FontWeight.bold),
        ),
        TextSpan(text: afterMatch, style: baseStyle)
      ],
    ),
  );
}
