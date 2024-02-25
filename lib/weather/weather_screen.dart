import 'package:AgroConnect/misc/config.dart';
import 'package:AgroConnect/weather/weather_model.dart';
import 'package:AgroConnect/weather/weather_service.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('f79ec55ee3843f54705667db3795ab78');
  WeatherModel? weather;
  String _cityName = "";

  Future<WeatherModel> _fetchWeather(String cityName) async {
    return await _weatherService.getWeather(cityName);
  }

  String _getWeatherIcon(WeatherModel? weather) {
    switch (weather?.mainCondition) {
      case 'Clear':
        return '🌞';
      case 'Clouds':
        return '☁️';
      case 'Rain':
        return '🌧️';
      case 'Thunderstorm':
        return '⛈️';
      case 'Snow':
        return '❄️';
      case 'Mist':
        return '🌫️';
      case 'Fog':
        return '🌁';
      case 'Drizzle':
        return '🌦️';
      case 'Haze':
        return '🌫️';
      default:
        return 'Unknown';
    }
  }

// _fetchWeather(_cityName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Weather",
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: config.chosenTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 10,
        ),
        body: FutureBuilder<WeatherModel?>(
          future: _fetchWeather(_cityName == "" ? "New York" : _cityName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error!}"),
                );
              }
              weather = snapshot.data;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: (value) {
                          _cityName = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        weather = await _fetchWeather(_cityName);
                        setState(() {});
                      },
                      child: const Text('Check Weather'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      weather?.cityName ?? "Loading city...",
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      '${weather?.temperature.round().toString()}°C',
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    Text(
                      'Wind Speed: ${weather?.windSpeed ?? "Unknown"} m/s',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Humidity: ${weather?.humidity ?? "Unknown"}%',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      _getWeatherIcon(weather),
                      style: const TextStyle(fontSize: 50.0),
                    ),
                  ],
                ),
              );
            }
            return const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
