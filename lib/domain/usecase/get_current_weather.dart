import 'package:android/core/error/failure.dart';
import 'package:android/domain/entity/weather.dart';
import 'package:android/domain/repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName){
    return repository.getCurrentWeather(cityName);
  }
}