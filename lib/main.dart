import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/pages/weather/cubit.dart';

import 'pages/weather/view.dart';
import 'services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return WeatherCubit(WeatherService());
        },
        child: const WeatherApp());
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:
            BlocProvider.of<WeatherCubit>(context).weatherData == null
                ? Colors.blue
                : BlocProvider.of<WeatherCubit>(context)
                    .weatherData!
                    .getThemeColor(),
        platform: TargetPlatform.iOS,
      ),
      home: HomePage(),
    );
  }
}
