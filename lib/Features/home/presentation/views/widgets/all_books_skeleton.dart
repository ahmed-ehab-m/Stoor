import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllBookSkeleton extends StatelessWidget {
  const AllBookSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.34,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Skeleton.leaf(
                      child: Card(
                        shadowColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          child: AspectRatio(
                            aspectRatio: 2.6 / 4,
                            child: Skeleton.leaf(
                                child: Container(
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Skeleton.leaf(
                    child: Text(
                      'Book Title Placeholder',
                      style: Styles.textStyle18.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Skeleton.leaf(
                    child: Text(
                      'Author Placeholder',
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
