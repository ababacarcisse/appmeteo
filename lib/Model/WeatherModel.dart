// ignore: file_names
import 'dart:convert';

class WeatherModel {
  int? id;
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  // ignore: non_constant_identifier_names
  double? feels_like;
  WeatherModel({
    this.id,
    this.cityName,
    this.temp,
    this.wind,
    this.pressure,
    // ignore: non_constant_identifier_names
    this.feels_like,
  });
  //Créons maintenant une fonction pour analyser le fichier JSON dans le modèle
  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json["main"]['id'];
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cityName'] = this.cityName;
    data['temp'] = this.temp;
    data['humidity'] = this.humidity;

    data['pressure'] = this.pressure;

    return data;
  }
}


/* 

Example of API response

                          

{
 
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],

  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
 
  "name": "Zocca",
 
}                        

                        

*/
//vla classe pour la reponse de l'apui
