import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/weather/states.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitialState());

  WeatherService weatherService;
  WeatherModel? weatherData;
  String? cityName;
  void getWeather({required String cityName}) async {
    emit(WeatherLoadingState());
    try {
      WeatherModel weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSuccessState(weatherModel: weatherModel));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
