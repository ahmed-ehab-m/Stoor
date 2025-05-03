// import 'package:bookly_app/Features/home/presentation/manager/similar_books_cubit.dart/similar_books_cubit.dart';
// import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
// import 'package:bookly_app/core/widgets/custom_error_widget.dart';
// import 'package:bookly_app/core/widgets/custom_loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SimilarBooksListView extends StatelessWidget {
//   const SimilarBooksListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
//         builder: (context, state) {
//       if (state is SimilarBooksSuccess) {
//         return SizedBox(
//           height: MediaQuery.of(context).size.height * 0.15,
//           child: ListView.separated(
//               separatorBuilder: (context, index) => const SizedBox(width: 10),
//               scrollDirection: Axis.horizontal,
//               itemCount: state.books.length,
//               itemBuilder: (context, index) {
//                 return CustomBookImage(
//                   imageUrl: state
//                           .books[index].volumeInfo.imageLinks.thumbnail ??
//                       'https://www.freecodecamp.org/news/content/images/2023/01/Untitled-design-1.png',
//                 );
//               }),
//         );
//       } else if (state is SimilarBooksFailure) {
//         return CustomErrorWidget(errorMessage: state.errorMessage);
//       } else {
//         return const CustomLoadingIndicator();
//       }
//     });
//   }
// }
