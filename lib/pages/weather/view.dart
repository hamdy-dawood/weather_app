import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search/view.dart';
import 'package:weather_app/pages/weather/cubit.dart';
import 'package:weather_app/pages/weather/states.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (BuildContext context, state) {
          if (state is WeatherLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccessState) {
            return SuccessWeather(weatherData: state.weatherModel);
          } else if (state is WeatherFailureState) {
            return const FailureWeather();
          } else {
            return const InitialWeather();
          }
        },
      ),
    );
  }
}

class InitialWeather extends StatelessWidget {
  const InitialWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/images/search.png")),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'start searching now 🔍',
            style: TextStyle(
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}

class SuccessWeather extends StatelessWidget {
  const SuccessWeather({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Image.asset(weatherData!.getImage()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${weatherData!.temp.toInt().toString()}°',
                    style: const TextStyle(
                      fontSize: 150,
                    ),
                  ),
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
          const Spacer(
            flex: 3,
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}

class FailureWeather extends StatelessWidget {
  const FailureWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/images/failure_search.png")),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Something Wrong  ❌",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
