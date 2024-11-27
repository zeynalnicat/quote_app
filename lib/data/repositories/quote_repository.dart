import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quote_app/data/network/remote/api_service.dart';
import 'package:quote_app/domain/models/home/response_model.dart';

class QuoteRepository {
  final String? apiKey = dotenv.env['API_KEY'];

  Future<ResponseModel> fetchQuote() async {
    final dio = Dio();
    final ApiService apiService = ApiService(dio);
    try {
      final response = await apiService.getQuotes(apiKey ?? '');
      return ResponseModel("", response.first);
    } on DioException catch (e) {
      return ResponseModel(e.toString(), null);
    } catch (e) {
      return ResponseModel(e.toString(), null);
    }
  }
}
