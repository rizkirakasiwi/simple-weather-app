import 'dart:io';

import 'package:android/core/error/exception/server_exception.dart';
import 'package:android/core/error/failure.dart';
import 'package:android/data/model/weather_model.dart';
import 'package:android/data/repository/weather_repository_impl.dart';
import 'package:android/domain/entity/weather.dart';
import 'package:android/domain/repository/weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource remoteDataSource;
  late WeatherRepository weatherRepository;

  setUp(() {
    remoteDataSource = MockWeatherRemoteDataSource();
    weatherRepository =
        WeatherRepositoryImpl(weatherRemoteDataSource: remoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: "New York",
    main: "Clear",
    description: "clear sky",
    iconCode: "01n",
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: "New York",
    main: "Clear",
    description: "clear sky",
    iconCode: "01n",
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  const cityName = 'New York';

  group(
    'get current weather',
    () {
      test(
        'should return current weather when a call to data source is success',
        () async {
          // arrange
          when(remoteDataSource.getCurrentWeather(cityName))
              .thenAnswer((_) async => testWeatherModel);

          // act
          final result = await weatherRepository.getCurrentWeather(cityName);

          // assert
          expect(result, equals(const Right(testWeatherEntity)));
        },
      );


      test(
        'should return server failure when call a data source is unsuccessful',
            () async {
          // arrange
          when(remoteDataSource.getCurrentWeather(cityName))
              .thenThrow(ServerException());

          // act
          final result = await weatherRepository.getCurrentWeather(cityName);

          // assert
          expect(result, equals(const Left(ServerFailure('An error has Occurred'))));
        },
      );

      test(
        'should return connection failure when device no internet',
            () async {
          // arrange
          when(remoteDataSource.getCurrentWeather(cityName))
              .thenThrow(SocketException('Failed to connect to the network'));

          // act
          final result = await weatherRepository.getCurrentWeather(cityName);

          // assert
          expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );
}
