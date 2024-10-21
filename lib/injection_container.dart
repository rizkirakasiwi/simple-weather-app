import 'package:android/data/data_source/remote_data_source.dart';
import 'package:android/data/repository/weather_repository_impl.dart';
import 'package:android/domain/repository/weather_repository.dart';
import 'package:android/domain/usecase/get_current_weather.dart';
import 'package:android/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator  = GetIt.instance;

void setupLocator(){
  //  bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // useCase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));

  // dataSource
  locator.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}