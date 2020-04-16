import 'package:animated_weather_flutter_app/models/weather.dart';
import 'package:animated_weather_flutter_app/repositories/weatherApiClient.dart';
import 'package:flutter/material.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }
}
