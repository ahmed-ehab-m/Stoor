import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/functions/get_short_title.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class FeaturedBookListItem extends StatelessWidget {
  const FeaturedBookListItem(
      {super.key,
      required this.imageUrl,
      required this.bookTitle,
      required this.author});
  final String imageUrl;
  final String bookTitle;
  final String author;

  @override
  Widget build(BuildContext context) {
    print('http://127.0.0.1:8000/storage/$imageUrl');
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: isArabic(bookTitle)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              shadowColor: BlocProvider.of<ChangeSettingsCubit>(context)
                          .backgroundColor ==
                      Colors.black
                  ? Colors.grey
                  : Colors.black,
              // elevation: 10,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 2.6 / 4,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: 'http://10.0.2.2:8000/storage/$imageUrl',
                    errorWidget: (context, url, error) => const Icon(
                      HugeIcons.strokeRoundedImageNotFound01,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            getShortTitle(bookTitle),
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w900,
              // color: kPrimaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            getShortTitle(author),
            style: Styles.textStyle14.copyWith(
              color: Colors.grey,
              // color: kPrimaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

bool isArabic(String text) {
  if (text.isEmpty) return false;
  return text.codeUnits[0] >= 0x600 && text.codeUnits[0] <= 0x6FF;
}
