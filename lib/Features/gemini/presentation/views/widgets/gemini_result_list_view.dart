import 'dart:math';

import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/core/widgets/all_books_list_item.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeminiResultListView extends StatelessWidget {
  const GeminiResultListView({super.key, required this.books});
  final List<BookModel?>? books;

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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
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
                                  recommendedMessage, // First sentence
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ).copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                child: AllBooksListItem(
                  author: books![index]!.author?.name ?? '',
                  bookTitle: books![index]!.title ?? '',
                  imageUrl: books![index]!.image ?? '',
                ),
              ),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.5,
                height: MediaQuery.of(context).size.height *
                    0.4, // ارتفاع الـ Carousel

                enlargeFactor:
                    0.3, // نسبة التكبير (عدّلها لو عايز أكبر أو أصغر)
                autoPlay: false, // لو عايز يتحرك أوتوماتيك، خلّيه true
                enableInfiniteScroll: false, // يعمل Loop
              ),
            ),
          ],
        );
      },
    );
  }
}
