import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarkIcon extends StatefulWidget {
  const BookMarkIcon(
      {super.key,
      this.bookModel,
      required this.uid,
      required this.isRated,
      this.color});
  final String uid;
  final BookModel? bookModel;
  final bool isRated;
  final Color? color;
  @override
  State<BookMarkIcon> createState() => _BookMarkIconState();
}

class _BookMarkIconState extends State<BookMarkIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarksCubit, BookMarksState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<BookMarksCubit>(context);
        bool isPressed = cubit.isBookBookmarked(widget.bookModel?.id ?? 0);
        if (state is AddBookMarksLoading) {
          state.bookId == widget.bookModel?.id
              ? isPressed = true
              : isPressed = isPressed;
        }
        if (state is DeleteBookMarksLoading) {
          state.bookId == widget.bookModel?.id
              ? isPressed = false
              : isPressed = isPressed;
        }
        return CircleAvatar(
          backgroundColor: widget.isRated ? Colors.transparent : kPrimaryColor,
          child: IconButton(
              onPressed: () async {
                isPressed = !isPressed;
                // setState(() {});
                if (!isPressed) {
                  cubit.deleteBookMark(
                      uid: widget.uid, bookId: widget.bookModel?.id ?? 0);
                } else {
                  cubit.addtoBookMarks(
                      uid: widget.uid, bookId: widget.bookModel?.id ?? 0);
                }
              },
              icon: Icon(
                isPressed
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                color: isPressed ? const Color(0xffFFD400) : widget.color,
              )),
        );
      },
    );
  }
}
