import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookMarksItem extends StatefulWidget {
  const BookMarksItem({super.key, required this.bookModel});
  final BookModel? bookModel;

  @override
  State<BookMarksItem> createState() => _BookMarksItemState();
}

class _BookMarksItemState extends State<BookMarksItem> {
  bool _isDeleting = false;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isDeleting) {
          GoRouter.of(context)
              .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
        }
      },
      child: BlocBuilder<BookMarksBooksCubit, BookMarksState>(
        builder: (context, state) {
          if (state is DeleteBookMarksLoading) {
            _isDeleting = state.bookId == widget.bookModel?.id.toString();
            if (_isDeleting) {
              _controllerBottomCenter.play(); // بدء الانميشن هنا
            }
          } else if (state is DeleteBookMarksSuccess ||
              state is DeleteBookMarksFailure) {
            _isDeleting = false;
            _controllerBottomCenter.stop(); // إيقاف الانميشن
          }

          return Stack(
            children: [
              SizedBox(
                height: 180,
                child: ConfettiWidget(
                  numberOfParticles: 50,
                  confettiController: _controllerBottomCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [Colors.yellow, Colors.orange],
                  child: AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    left: _isDeleting ? -200.0 : 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CustomBookImage(
                              imageUrl: widget.bookModel?.image ?? ''),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Text(
                                    widget.bookModel!.title ?? 'No title',
                                    style: Styles.textStyle18,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  widget.bookModel?.author?.name ?? 'No author',
                                  style: Styles.textStyle14,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  widget.bookModel?.price ?? 'No subtitle',
                                  style: Styles.textStyle20,
                                ),
                                const Spacer(),
                                BookRating(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  rating: widget.bookModel?.rating.toString() ??
                                      '0',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -1,
                child: IconButton(
                  onPressed: () async {
                    if (!_isDeleting) {
                      await BlocProvider.of<BookMarksBooksCubit>(context)
                          .deleteBookMark(
                        uid: BlocProvider.of<ProfileCubit>(context).uid!,
                        bookId: widget.bookModel?.id.toString() ?? '',
                      );
                    }
                  },
                  icon: Icon(
                    _isDeleting
                        ? CupertinoIcons.bookmark
                        : CupertinoIcons.bookmark_fill,
                    color: _isDeleting
                        ? BlocProvider.of<ChangeSettingsCubit>(context)
                            .iconColor
                        : Colors.amber,
                    size: 20,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

bool isArabic(String text) {
  if (text.isEmpty) return false;
  return text.codeUnits[0] >= 0x600 && text.codeUnits[0] <= 0x6FF;
}
