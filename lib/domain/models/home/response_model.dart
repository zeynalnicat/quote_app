import 'package:quote_app/domain/models/home/quote_model.dart';

class ResponseModel {
  String status;
  QuoteModel? quoteModel;

  ResponseModel(this.status, this.quoteModel);
}
