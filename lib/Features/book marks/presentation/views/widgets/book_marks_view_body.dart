import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/book_marks_item.dart';
import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/empty_books_widget.dart';
import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/library_title.dart';
import 'package:bookly_app/Features/home/presentation/manager/book_marks_books_cubit/book_marks_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
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

    BlocProvider.of<BookMarksBooksCubit>(context).fetchBookMark();
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
            child: BlocBuilder<BookMarksBooksCubit, BookMarksBooksState>(
              builder: (context, state) {
                List<Apibook> books =
                    BlocProvider.of<BookMarksBooksCubit>(context).books;

                if (state is AddBookMarksBooksSuccess) {
                  print('add to book marks success');
                  print('books length ${books.length}');
                }
                if (state is FetchBookMarksBooksLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchBookMarksBooksFailure) {
                  return CustomErrorWidget(errorMessage: state.errMessage);
                }
                if (state is FetchBookMarksBooksSuccess) {
                  print('fetch book marks success');
                  books = state.books;
                }
                return books.isEmpty
                    ? const Center(
                        child: EmptyBooksWidget(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: books.length,
                          // physics: const NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: BookMarksItem(
                              bookModel: books[index],
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
