import 'package:quote_app/features/home/domain/quote_model.dart';

class ResponseModel {
  String status;
  QuoteModel? quoteModel;

  ResponseModel(this.status, this.quoteModel);
}
