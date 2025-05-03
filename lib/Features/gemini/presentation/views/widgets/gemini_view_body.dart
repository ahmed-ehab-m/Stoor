import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiViewBody extends StatefulWidget {
  const GeminiViewBody({super.key});

  @override
  State<GeminiViewBody> createState() => _GeminiViewBodyState();
}

class _GeminiViewBodyState extends State<GeminiViewBody> {
  BookModel? bookModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          BookListViewItem(bookModel: bookModel),
          Spacer(),
          BlocListener<GeminiCubit, GeminiState>(
            listener: (context, state) {
              if (state is GeminiLoadedState) {
                print('loaded state');
                setState(() {
                  bookModel = state.recommendedBook;
                });
              } else if (state is GeminiErrorState) {
                print('error state');
                print(state.errorMessage);
                setState(() {});
              }
            },
            child: TextField(
              onSubmitted: (value) {
                print(value);
                print('submitted');
                BlocProvider.of<GeminiCubit>(context).getRecommendedBook(
                  userDescription: 'recommend me a one book about $value',
                  contextDescription: 'write a brief description to search',
                );
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'write a brief description to search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: Icon(Icons.send, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
