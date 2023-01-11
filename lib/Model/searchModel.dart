// ignore: file_names
class TemperatureInfo {
  final double? temp;
  // ignore: non_constant_identifier_names
  final double? feels_like;
  final int? pressure;
  final int? humidity;
  TemperatureInfo(
      // ignore: non_constant_identifier_names
      {required this.temp,
      this.feels_like,
      this.pressure,
      this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final double? temp;
    // ignore: non_constant_identifier_names
    final double? feels_like;
    final int? pressure;
    final int? humidity;

    temp = json["temp"];
    feels_like = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];

    return TemperatureInfo(
        temp: temp,
        feels_like: feels_like,
        pressure: pressure,
        humidity: humidity);
  }
}

//la classe pour obtenir les données de nuit dfe jour
class CurentInfo {
  late final String? sunrise;
  late final String? sunset;
  CurentInfo({required this.sunrise, this.sunset});
  factory CurentInfo.from(Map<String, dynamic> json) {
    final sunrise = json['sunrise'];
    final sunset = json['sunset'];
    return CurentInfo(sunrise: sunrise, sunset: sunset);
  }
}

class WeatherInfo {
  final String? description;
  final String? icon;
  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.from(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

// la classe qui va stocker tout les autre class pour obtenir les données de l'api
class WeatherResponse {
  final String? cityNamee;
  final TemperatureInfo? tempInfo;
  final WeatherInfo? weatherInfo;
  // final CurentInfo? curentInfo;
  //propriété pour obtenir les images
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo?.icon}@2x.png';
  }

  WeatherResponse({
    this.cityNamee,
    required this.tempInfo,
    required this.weatherInfo,
    //  required this.curentInfo
  });
  //obtenir l'objet et l'affecter aux donneé de l'apien json
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final String? cityNamee;
//j'obtient le main pour obtenir le temp
    cityNamee = json["name"];

    final temperatureInfoJson = json["main"];
    final tempInfo = TemperatureInfo.fromJson(temperatureInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.from(weatherInfoJson);
    final curentInfoJson = json['sys'];
    //  final curentInfo = CurentInfo.from(curentInfoJson);
    return WeatherResponse(
      cityNamee: cityNamee,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      //curentInfo: curentInfo
    );
  }
}
