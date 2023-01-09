import 'package:appmeteo/Model/searchModel.dart';
import 'package:appmeteo/data/DataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  final _cityTextController = TextEditingController();
  //je créer une variable pour stockerles données de l'api et l'afficher
  final _dataService = DataService();
  //affichage des nouveaux lelement de l'api que je veux obtenir dans le widget
  //late final WeatherResponse? _response;
  var _response = WeatherResponse(
      cityNamee: cityNamee,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      curentInfo: curentInfo);

  static get cityNamee => '';

  static get tempInfo => null;

  static get weatherInfo => null;
  static get curentInfo => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 45, 49, 172),
        appBar: AppBar(backgroundColor: Colors.white, actions: [
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 70,
          ),
        ]),
        body: Center(
          child: Column(children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20)), Gap(50),
            Text(
              "Connaitre les conditions météologique de toutes les villes au monde en 2Sende",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),

            // je créer un condition pour dire si _response est different de null , le widget ne va pas s'afficher
            if (_response != null)
              Column(
                children: [
                  isVisible == true
                      ? Image.network(
                          '',
                          height: 50,
                          width: 50,
                        )
                      : Image.network(
                          _response.iconUrl,
                          height: 50,
                          width: 50,
                        ),
                  Text("${_response.cityNamee}"),
                  isVisible == true
                      ? Text("")
                      : Text("${_response.weatherInfo?.description}"),
                  isVisible == true
                      ? Text("")
                      : Text("${_response.tempInfo?.temp}"),
                  isVisible == true
                      ? Text("")
                      : Text("${_response.tempInfo?.feels_like}"),
                  isVisible == true
                      ? Text("")
                      : Text("${_response.tempInfo?.pressure}"),
                  isVisible == true
                      ? Text("")
                      : Text("${_response.tempInfo?.humidity}"),
                  Gap(20),
                  Container(
                    child: FormBuilderTextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(
                        labelText: "Entrer la  la ville ",
                        border: OutlineInputBorder(),
                      ),
                      name: '',
                    ),
                  ),
                ],
              ),

            Gap(20),
            ElevatedButton(onPressed: _search, child: Text('Rechercher'))
          ]),
        ));
  }

  void _search() async {
    final respon = await _dataService.getWeather(_cityTextController.text);
    // j'utlise le set State pour donner les valeurs de _response à respon pour me facilité l'affichage
    print(respon.curentInfo?.sunrise);
    print(respon.curentInfo?.sunset);
    // print(respon.tempInfo?.feels_like);
    // print(respon.tempInfo?.feels_like);

    //print(respon.tempInfo?.pressure);
    setState(() {
      _response = respon;
    });
  }
}
