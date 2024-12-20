import 'package:quote_app/domain/models/home/quote_model.dart';

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final QuoteModel quote;

  QuoteLoaded(this.quote);
}

class QuoteError extends QuoteState {
  final String message;

  QuoteError(this.message);
}
