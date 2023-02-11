import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  WeatherModel weatherModel;

  WeatherSuccessState({required this.weatherModel}) {
    weatherModel;
  }
}

class WeatherFailureState extends WeatherState {}
