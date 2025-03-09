import 'dart:io';

import 'package:backend_vania/app/models/index.dart';
import 'package:dio/dio.dart' as dio;
import 'package:vania/vania.dart';

class WeatherController extends Controller {
  Future<Response> fetchAndStoreWeather(int locationId) async {
    final String appId = env<String>('WEATHER_APP_ID');

    final String unit = 'metric';

    final location = await LocationModel().query().where('location_id', '=', locationId).first();

    if (location == null) {
      return Response.json(
        {
          'message': 'Location not found',
        },
        HttpStatus.notFound,
      );
    }

    double latitude = location['latitude']?.trim() ?? '';
    double longitude = location['longitude']?.trim() ?? '';

    final response = await dio.Dio().get(
      'https://api.openweathermap.org/data/2.5/onecall',
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'appid': appId,
        'units': unit,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;

      // Extract rainfall data for each day
      final List<dynamic> dailyData = data['daily'];
      for (var dayData in dailyData) {
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(dayData['dt'] * 1000);
        final double rainfall = dayData['rain'] ?? 0.0;

        // Store the weather data in the database
        await WeatherModel().query().insert({
          'location_id': locationId,
          'temperature': dayData['temp']['day'],
          'humidity': dayData['humidity'],
          'rainfall': rainfall,
          'weather_description': dayData['weather'][0]['description'],
          'temp_max': dayData['temp']['max'],
          'temp_min': dayData['temp']['min'],
          'recorded_at': date,
        });
      }

      return Response.json({'message': 'Weather data stored successfully'}, 200);
    } else {
      return Response.json({'message': 'Failed to fetch weather data'}, response.statusCode ?? 500);
    }
  }
}

final WeatherController weatherController = WeatherController();
