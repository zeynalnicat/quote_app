import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class QuoteModel with _$QuoteModel {
    const factory QuoteModel({
        String? quote,
        String? author,
        String? category,
    }) = _QuoteModel;

    factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
}
