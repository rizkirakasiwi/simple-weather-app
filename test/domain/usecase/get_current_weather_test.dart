import 'package:android/domain/entity/weather.dart';
import 'package:android/domain/usecase/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  MockWeatherRepository? repository;
  GetCurrentWeatherUseCase? getCurrentWeatherUseCase;
  
  setUp(() {
    repository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(repository!);
  });

  const testData = WeatherEntity(
    cityName: "New Yorkd",
    main: "Clouds",
    description: "few clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = "New York";

  test(
    'should get current weather detail from the repository',
    () async {
      // arrange
      when(repository!.getCurrentWeather(testCityName))
          .thenAnswer((_) async => const Right(testData));

      // act
      final result = await getCurrentWeatherUseCase!.execute(testCityName);

      // assert
      expect(result, const Right(testData));
    },
  );
}
