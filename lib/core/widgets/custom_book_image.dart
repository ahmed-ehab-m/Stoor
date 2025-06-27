import 'package:bookly_app/core/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor:
          // BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor ==
          //         Colors.black
          Colors.grey,
      // : Colors.black,
      elevation: 5,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: AspectRatio(
          aspectRatio: 2.6 / 4,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: KImagesUrl + imageUrl,
            errorWidget: (context, url, error) => const Icon(
              HugeIcons.strokeRoundedImageNotFound01,
              size: 40,
            ),
          ),
        ),
      ),
    );
    // return Card(
    //   shadowColor:
    //       BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor ==
    //               Colors.black
    //           ? Colors.grey
    //           : Colors.black,
    //   elevation: 10,
    //   child: ClipRRect(
    //     borderRadius: const BorderRadius.only(
    //       topRight: Radius.circular(20),
    //       bottomRight: Radius.circular(20),
    //     ),
    //     child: AspectRatio(
    //       aspectRatio: 2.6 / 4,
    //       child: CachedNetworkImage(
    //         fit: BoxFit.fill,
    //         imageUrl: KImagesUrl + imageUrl,
    //         errorWidget: (context, url, error) => const Icon(
    //           HugeIcons.strokeRoundedImageNotFound01,
    //           size: 40,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
