import 'dart:convert';
import 'package:animated_weather_flutter_app/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final Response locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for the city');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final Response weatherResponse = await this.httpClient.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for the city');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    Weather weatherData = Weather.fromJson(weatherJson);
    return weatherData;
  }
}
