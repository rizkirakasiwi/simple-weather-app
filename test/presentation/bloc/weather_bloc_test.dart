import 'package:android/core/error/failure.dart';
import 'package:android/domain/entity/weather.dart';
import 'package:android/presentation/bloc/weather_bloc.dart';
import 'package:android/presentation/bloc/weather_event.dart';
import 'package:android/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    getCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(getCurrentWeatherUseCase);
  });

  const testData = WeatherEntity(
    cityName: "New York",
    main: "Clouds",
    description: "few clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New york';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(getCurrentWeatherUseCase.execute(testCityName)).thenAnswer((_) async => const Right(testData));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      WeatherLoaded(testData),
    ]
  );

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherFailure] when data is gotten successfully',
      build: () {
        when(getCurrentWeatherUseCase.execute(testCityName)).thenAnswer((_) async => const Left(ServerFailure('server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        WeatherLoadFailure('server failure'),
      ]
  );
}
