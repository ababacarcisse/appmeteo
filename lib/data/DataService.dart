import 'dart:convert';

import 'package:appmeteo/Model/searchModel.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    //https:///data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    final queryParamaters = {
      'q': city,
      'appid': 'c4099a39068f8ec2abc163f79e53f88a',
      'units': 'imperial'
    };
    // final urlWeather =Url.https('api.openweathermap.org,'/data/2.5/weather',  queryParamaters);
    final urlWeather = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParamaters);
    final respon = await http.get(urlWeather);
    print(respon.body);
    //contient la reponse de l'api
    final json = jsonDecode(respon.body);
    //les données en json
    return WeatherResponse.fromJson(json);
  }
}
