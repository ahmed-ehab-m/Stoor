import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/data/models/book_model/image_links.dart';
import 'package:bookly_app/Features/home/data/models/book_model/volume_info.dart';
import 'package:bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewestListView extends StatelessWidget {
  const NewestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          print(state.books.length);
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BookListViewItem(
                  bookModel: state.books[index],
                ),
              );
            },
            childCount: state.books.length,
          ));
        } else if (state is NewestBooksFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return Skeletonizer.sliver(
            // effect:ShimmerEffect() ,
            enabled: true,
            child: SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Skeleton.shade(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      width: 50, // نفس عرض CustomBookImage
                      height: 140, // نفس الارتفاع
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // لون الـ skeleton
                        borderRadius:
                            BorderRadius.circular(8), // نفس الـ borderRadius
                      ),
                      child: const Text(''),
                    ),
                  ),
                );
              },
              childCount: 5,
            )),
          );
        }
      },
    );
  }
}

BookModel mockupBookModel = BookModel(
  id: '1',
  volumeInfo: VolumeInfo(
    title: 'Sample Book Title',
    authors: ['Author Name'],
    imageLinks: ImageLinks(
      thumbnail: 'https://example.com/sample-book-cover.jpg',
      smallThumbnail: '',
    ),
  ),
);
