import 'package:dio/dio.dart';
import 'package:quote_app/data/constants/network.dart';
import 'package:quote_app/domain/models/home/quote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: NetworkConstants.apiUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('')
  Future<List<QuoteModel>> getQuotes(@Header('X-Api-Key') String apiKey);
}
