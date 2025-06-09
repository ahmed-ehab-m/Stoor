import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewestBookSkeleton extends StatelessWidget {
  const NewestBookSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Stack(
              children: [
                SizedBox(
                  height: 180,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Skeleton.leaf(
                            child: NewestBookImage(imageUrl: '')),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const Skeleton.leaf(
                                  child: Text(
                                    'Book Title Placeholder',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Skeleton.leaf(
                                child: Text(
                                  'No author',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(children: [
                                Skeleton.leaf(
                                  child: Text(
                                    'Free      ',
                                    style: Styles.textStyle20,
                                  ),
                                ),
                              ]),
                              const Spacer(),
                              const Skeleton.leaf(
                                child: Text(
                                  'No rating yet',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
