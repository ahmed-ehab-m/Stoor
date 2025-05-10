import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeaturedBookListItem extends StatelessWidget {
  const FeaturedBookListItem(
      {super.key,
      required this.imageUrl,
      required this.bookTitle,
      required this.author});
  final String imageUrl;
  final String bookTitle;
  final String author;
  String getShortTitle(String title) {
    print('in title function');
    final words = title.trim().split(' ');
    print(words);
    if (words.length < 2) {
      print(title);
      return title;
    } else {
      print(words.take(2).join(' '));
      return words.take(2).join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              shadowColor:
                  BlocProvider.of<ChangeThemeCubit>(context).backgroundColor ==
                          Colors.black
                      ? Colors.grey
                      : Colors.black,
              // elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 2.6 / 4,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => const Icon(
                      FontAwesomeIcons.solidImage,
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
              color: Colors.grey.shade700,
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
