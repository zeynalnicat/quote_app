import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/blocs/quote_state.dart';
import 'package:quote_app/data/repositories/quote_repository.dart';

class QuoteBloc extends Cubit<QuoteState> {
  QuoteBloc() : super(QuoteInitial());

  QuoteRepository repo = QuoteRepository();

  Future<void> fetch() async {
    emit(QuoteLoading());
    try {
      final response = await repo.fetchQuote();
      if (response.quoteModel != null) {
        emit(QuoteLoaded(response.quoteModel!));
      } else {
        emit(QuoteError(response.status));
      }
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }
}
