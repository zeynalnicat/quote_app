import 'package:dio/dio.dart';
import 'package:quote_app/data/network/api_service.dart';
import 'package:quote_app/features/home/domain/response_model.dart';

class QuoteRepository {
  final String apiKey;

  QuoteRepository(this.apiKey);

  Future<ResponseModel> fetchQuote() async {
    final dio = Dio();
    final ApiService apiService = ApiService(dio);
    try {
      final response = await apiService.getQuotes(apiKey);
      return ResponseModel("", response.first);
    } on DioException catch (e) {
      return ResponseModel(e.toString(), null);
    } catch (e) {
      return ResponseModel(e.toString(), null);
    }
  }
}
