import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/core/widgets/custom_book_image.dart';
import 'package:bookly_app/core/widgets/book_mark_icon.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/book_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerticalListBookItem extends StatefulWidget {
  const VerticalListBookItem({
    super.key,
    this.bookModel,
  });
  final BookModel? bookModel;
  @override
  State<VerticalListBookItem> createState() => _VerticalListBookItemState();
}

class _VerticalListBookItemState extends State<VerticalListBookItem> {
  @override
  Widget build(BuildContext context) {
    String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';

    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: BlocBuilder<BookMarksCubit, BookMarksState>(
        builder: (context, state) {
          if (state is AddBookMarksLoading) {
            // إظهار مؤشر التحميل
          }
          if (state is DeleteBookMarksLoading) {
          } else if (state is DeleteBookMarksSuccess ||
              state is DeleteBookMarksFailure) {
            // إيقاف الانميشن
          }
          return Stack(
            children: [
              SizedBox(
                height: 180,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CustomBookImage(imageUrl: widget.bookModel?.image ?? ''),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.bookModel!.title ?? 'No title',
                                      style: Styles.textStyle20.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              widget.bookModel?.author?.name ?? 'No author',
                              style: Styles.textStyle14,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BookPrice(
                              price: widget.bookModel?.price ?? '0.0',
                            ),
                            const Spacer(),
                            BookRating(
                              rating: widget.bookModel?.rating ?? '0.0',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -1,
                child: BookMarkIcon(
                  isRated: true,
                  bookModel: widget.bookModel,
                  uid: uid,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
