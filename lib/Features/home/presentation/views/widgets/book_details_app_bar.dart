import 'package:bookly_app/Features/home/presentation/manager/book_marks_books_cubit/book_marks_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailsAppBar extends StatefulWidget {
  const BookDetailsAppBar({super.key, required this.bookId});
  final String bookId;

  @override
  State<BookDetailsAppBar> createState() => _BookDetailsAppBarState();
}

class _BookDetailsAppBarState extends State<BookDetailsAppBar> {
  @override
  void initState() {
    super.initState();
    // جلب القائمة عند بدء الـ Widget
    BlocProvider.of<BookMarksBooksCubit>(context).fetchBookMark();
  }

  @override
  Widget build(BuildContext context) {
    String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';
    bool isBookmarked = BlocProvider.of<BookMarksBooksCubit>(context)
        .books
        .any((book) => book.id.toString() == widget.bookId);
    return Padding(
      // padding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: CircleAvatar(
              backgroundColor: kSecondaryColor.withOpacity(0.8),
              foregroundColor: Colors.white,
              child:
                  // IconButton(
                  // color: kSecondaryColor,
                  // onPressed: () {
                  //   GoRouter.of(context).pop();
                  // },
                  const Icon(
                Icons.arrow_back_ios_new,
                // size: 30,
              ),
            ),
          ),
          BlocConsumer<BookMarksBooksCubit, BookMarksBooksState>(
            listener: (context, state) {
              // if (state is AddBookMarksBooksFailure) {
              //   print('add to book marks failure ${state.errMessage}');
              // } else if (state is DeleteBookMarksBooksFailure) {
              //   print('delete from book marks failure ${state.errMessage}');
              // }
              // } else if (state is DeleteBookMarksBooksSuccess ||
              //     state is AddBookMarksBooksSuccess) {
              //   // إعادة تحميل القائمة بعد النجاح
              //   BlocProvider.of<BookMarksBooksCubit>(context).fetchBookMark();
              // }
            },
            builder: (context, state) {
              // تحقق من القائمة المفضلة
              // تحويل id لـ String
              print('isBookmarked in first builder: $isBookmarked'); // للتحقق
              if (state is AddBookMarksBooksLoading ||
                  state is DeleteBookMarksBooksLoading) {
                isBookmarked = !isBookmarked;
                print('in loading isBookmarked: $isBookmarked'); // للتحقق
              }
              if (state is AddBookMarksBooksSuccess) {
                isBookmarked = true;
                print('in add success isBookmarked: $isBookmarked'); // للتحقق
              }
              if (state is DeleteBookMarksBooksSuccess) {
                isBookmarked = false;

                print(
                    'in delete success isBookmarked: $isBookmarked'); // للتحقق
              }

              return IconButton(
                onPressed: () async {
                  if (isBookmarked) {
                    // إذا موجود، احذفه
                    await BlocProvider.of<BookMarksBooksCubit>(context)
                        .deleteBookMark(uid: uid, bookId: widget.bookId);
                  } else {
                    // إذا مش موجود، أضفه
                    await BlocProvider.of<BookMarksBooksCubit>(context)
                        .addtoBookMarks(uid: uid, bookId: widget.bookId);
                  }
                  // تحديث القائمة بعد العملية
                  await BlocProvider.of<BookMarksBooksCubit>(context)
                      .fetchBookMark();
                },
                icon: Icon(
                  size: 25,
                  isBookmarked
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  color: isBookmarked
                      ? Colors.amber
                      : BlocProvider.of<ChangeSettingsCubit>(context).iconColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
