import 'dart:io';

import 'package:android/core/error/exception/server_exception.dart';
import 'package:android/core/error/failure.dart';
import 'package:android/data/data_source/remote_data_source.dart';
import 'package:android/domain/entity/weather.dart';
import 'package:android/domain/repository/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl extends WeatherRepository{
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async {
    try{
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toWeatherEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has Occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}