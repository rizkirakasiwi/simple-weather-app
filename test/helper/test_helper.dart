import 'package:android/data/data_source/remote_data_source.dart';
import 'package:android/domain/usecase/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:android/domain/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
