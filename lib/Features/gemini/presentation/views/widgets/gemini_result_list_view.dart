import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_list_view_item.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiResultListView extends StatelessWidget {
  const GeminiResultListView({super.key, required this.books});
  final List<BookModel?>? books;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        if (state is GeminiLoadingState) {}
        return ListView.builder(
          itemCount: books!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => GeminiListViewItem(
            bookModel: books![index],
          ),
        );
      },
    );
  }
}
