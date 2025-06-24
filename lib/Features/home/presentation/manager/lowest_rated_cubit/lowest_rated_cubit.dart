import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:equatable/equatable.dart';

part 'lowest_rated_state.dart';

class LowestRatedCubit extends Cubit<LowestRatedState> {
  LowestRatedCubit(this.homeRepo) : super(LowestRatedInitial());
  final HomeRepo homeRepo;
  Future<void> fetchLowestRatedBooks() async {
    emit(LowestRatedLoading());
    var result = await homeRepo.fetchLowestRatedBooks();
    result.fold(
      (failure) => emit(LowestRatedFailure(failure.errMessage!)),
      (books) {
        emit(LowestRatedSuccess(books));
        // AllBooks.addAll(books);
      },
    );
  }
}
