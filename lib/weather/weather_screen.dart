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
  WeatherModel? _weather;
  String _cityName = '';

  _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather('');
  }

  String _getWeatherIcon() {
    switch (_weather?.mainCondition) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _cityName = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _fetchWeather(_cityName);
              },
              child: const Text('Check Weather'),
            ),
            const SizedBox(height: 20),
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(fontSize: 24.0),
            ),
            Text(
              '${_weather?.temperature.round().toString()}°C',
              style: const TextStyle(fontSize: 24.0),
            ),
            Text(
              'Wind Speed: ${_weather?.windSpeed ?? "Unknown"} m/s',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              'Humidity: ${_weather?.humidity ?? "Unknown"}%',
              style: const TextStyle(fontSize: 16.0),
            ),
            Text(
              _getWeatherIcon(),
              style: const TextStyle(fontSize: 50.0),
            ),
          ],
        ),
      ),
    );
  }
}
