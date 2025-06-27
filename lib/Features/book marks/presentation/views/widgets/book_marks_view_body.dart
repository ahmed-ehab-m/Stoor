import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/book_marks_list_view.dart';
import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/empty_books_widget.dart';
import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/library_title.dart';
import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarksViewBody extends StatefulWidget {
  const BookMarksViewBody({super.key});

  @override
  State<BookMarksViewBody> createState() => _BookMarksViewBodyState();
}

class _BookMarksViewBodyState extends State<BookMarksViewBody> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<BookMarksCubit>(context).fetchBookMark();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper screenSizeHelper = ScreenSizeHelper(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSizeHelper.horizontalPadding,
          vertical: screenSizeHelper.homeVerticalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LibraryTitle(),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<BookMarksCubit, BookMarksState>(
              builder: (context, state) {
                List<BookModel> books =
                    BlocProvider.of<BookMarksCubit>(context).books;

                if (state is AddBookMarksSuccess) {}
                if (state is FetchBookMarksLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchBookMarksFailure) {
                  return CustomErrorWidget(errorMessage: state.errMessage);
                }
                if (state is FetchBookMarksSuccess) {
                  books = state.books;
                }
                return books.isEmpty
                    ? const Center(
                        child: EmptyBooksWidget(),
                      )
                    : BookMarksListView(books: books);
              },
            ),
          ),
        ],
      ),
    );
  }
}
