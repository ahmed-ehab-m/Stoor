import 'dart:math';

import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_book_list_item.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeminiResultListView extends StatelessWidget {
  const GeminiResultListView({super.key, required this.books});
  final List<Apibook?>? books;

  @override
  Widget build(BuildContext context) {
    List<String> getRecommendationMessages() {
      return [
        'Here are some amazing books I’ve picked for you!',
        'Check out these fantastic books I recommend!',
        'Dive into these wonderful books I selected just for you!',
        'Explore these top picks of books I think you’ll love!',
      ];
    }

    final random = Random();
    final recommendedMessage = getRecommendationMessages()[
        random.nextInt(getRecommendationMessages().length)];

    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        if (state is GeminiLoadingState) {}
        return Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const BotIcon(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       kPrimaryColor.withOpacity(0.4), // لون فاتح
                  //       kPrimaryColor.withOpacity(0.6), // لون غامق
                  //     ],
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //   ),
                  //   borderRadius: BorderRadius.only(
                  //     topRight: Radius.circular(20),
                  //     topLeft: Radius.circular(0),
                  //     bottomRight: Radius.circular(20),
                  //     bottomLeft: Radius.circular(20),
                  //   ),
                  //   // border: Border.all(color: Colors.red),
                  // ),d
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: Text(
                                // overflow: TextOverflow.ellipsis,
                                // maxLines: 2,
                                recommendedMessage, // First sentence
                                style: const TextStyle(
                                  fontSize: 20,
                                ).copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          // Icon(
                          //   HugeIcons.strokeRoundedBook01,
                          //   size: 25,
                          //   color: Colors.amber,
                          // ),
                        ],
                      ),
                      // Text(
                      //   'I recommended for you!', // Second sentence
                      //   style: Styles.textStyle16.copyWith(
                      //     fontWeight: FontWeight.w900,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          CarouselSlider.builder(
            itemCount: books!.length,
            itemBuilder: (context, index, realIndex) => InkWell(
              onTap: () {
                GoRouter.of(context).push(
                  AppRouter.KBookDetailsView,
                  extra: books![index],
                );
              },
              child: FeaturedBookListItem(
                author: books![index]!.author?.name ?? '',
                bookTitle: books![index]!.title ?? '',
                imageUrl: books![index]!.image ?? '',
              ),
            ),
            //  BookRecommended(
            //   bookModel: books![index],
            // ),
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 0.5,
              height: MediaQuery.of(context).size.height *
                  0.4, // ارتفاع الـ Carousel
              // viewportFraction: 0.5, // نسبة العرض (كل كتاب هيشغل 50% من الشاشة)
              // enlargeCenterPage: true, // الكتاب في المنتصف هيبقى كبير
              enlargeFactor: 0.3, // نسبة التكبير (عدّلها لو عايز أكبر أو أصغر)
              autoPlay: false, // لو عايز يتحرك أوتوماتيك، خلّيه true
              enableInfiniteScroll: false, // يعمل Loop
            ),
          ),
          // BotIcon(),
        ]);
        // return ListView.builder(
        //   itemCount: books!.length,
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemBuilder: (context, index) => GeminiListViewItem(
        //     bookModel: books![index],
        //   ),
        // );
      },
    );
  }
}
