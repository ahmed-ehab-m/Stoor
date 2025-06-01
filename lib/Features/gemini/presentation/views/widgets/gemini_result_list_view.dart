import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/book_recommended.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiResultListView extends StatelessWidget {
  const GeminiResultListView({super.key, required this.books});
  final List<BookModel?>? books;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        if (state is GeminiLoadingState) {}
        return CarouselSlider.builder(
          itemCount: books!.length,
          itemBuilder: (context, index, realIndex) => BookRecommended(
            bookModel: books![index],
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            height:
                MediaQuery.of(context).size.height * 0.4, // ارتفاع الـ Carousel
            // viewportFraction: 0.5, // نسبة العرض (كل كتاب هيشغل 50% من الشاشة)
            // enlargeCenterPage: true, // الكتاب في المنتصف هيبقى كبير
            enlargeFactor: 0.5, // نسبة التكبير (عدّلها لو عايز أكبر أو أصغر)
            autoPlay: false, // لو عايز يتحرك أوتوماتيك، خلّيه true
            enableInfiniteScroll: false, // يعمل Loop
          ),
        );
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
