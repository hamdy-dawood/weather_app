import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/weather/cubit.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
           height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onChanged: (data) {
                cityName = data;
              },
              onSubmitted: (data) async {
                BlocProvider.of<WeatherCubit>(context)
                    .getWeather(cityName: cityName!);
                BlocProvider.of<WeatherCubit>(context).cityName = cityName;

                Navigator.pop(context);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      WeatherService service = WeatherService();

                      WeatherModel? weather =
                          await service.getWeather(cityName: cityName!);
                      if (context.mounted) return;
                      BlocProvider.of<WeatherCubit>(context).weatherData =
                          weather;

                      BlocProvider.of<WeatherCubit>(context).cityName =
                          cityName;

                      Navigator.pop(context);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}
