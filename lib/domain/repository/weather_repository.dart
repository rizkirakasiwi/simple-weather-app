import 'package:android/core/error/failure.dart';
import 'package:android/domain/entity/weather.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}