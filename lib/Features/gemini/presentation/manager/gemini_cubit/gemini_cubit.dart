import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';

part 'gemini_state.dart';

class GeminiCubit extends Cubit<GeminiState> {
  GeminiCubit(this._geminiRepo) : super(GeminiInitial());
  final GeminiRepo _geminiRepo;
  Future<void> getRecommendedBook({
    required String userDescription,
    required String contextDescription,
  }) async {
    emit(GeminiLoadingState());
    var result = await _geminiRepo.getRecommendedBook(
      userDescription: userDescription,
      contextDescription: contextDescription,
    );
    result.fold(
      (failure) => emit(
        GeminiErrorState(failure.errMessage!),
      ),
      (bookModel) => emit(
        GeminiLoadedState(bookModel!),
      ),
    );
  }
}
