import 'package:appmeteo/Model/searchModel.dart';
import 'package:appmeteo/data/DataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:gap/gap.dart';
import 'package:http/http.dart';

import '../composant/style.dart';

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
    // curentInfo: curentInfo
  );

  static get cityNamee => '';

  static get tempInfo => null;

  static get weatherInfo => null;
  // static get curentInfo => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1191df),
        body: Center(
          child: Column(children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
            const Gap(50),
            const Center(
              child: Text(
                "Application de météo",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),

            // je créer un condition pour dire si _response est different de null , le widget ne va pas s'afficher

            Column(
              children: [
                const Gap(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: FormBuilderTextField(
                    cursorColor: Colors.white,
                    controller: _cityTextController,
                    decoration: const InputDecoration(
                      labelText: "Entrer la  la ville ",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hoverColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    name: '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const Gap(20),
            ElevatedButton(
              onPressed: _search,
              child: const Text('Rechercher'),
            )
          ]),
        ));
  }

  //la fonction pour la validator

//le message d'alert
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attention "),
          content: Text("Veuiller remplir le champ de texte"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//fonction de la boutton
  void _search() async {
    final respon = await _dataService.getWeather(_cityTextController.text);
    // j'utlise le set State pour donner les valeurs de _response à respon pour me facilité l'affichage
    // print(respon.curentInfo?.sunrise);
    // print(respon.curentInfo?.sunset);
    setState(() {
      _response = respon;
    });
    //afficher la page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WeatherPage(
        response: _response,
      ),
    ));
  }
}

//cette classe stateful va m'aider a afficher cette page dans une autre page
class WeatherPage extends StatefulWidget {
  //j'initialise cette la class weather reponse
  final WeatherResponse response;
//Le Key  un identificateur unique pour utiliser le widget
//selon la réponse que La WeatherPageresponse et ses  données qui lui ont été transmises.

  const WeatherPage({Key? key, required this.response}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBody,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: maCouleurAppBar,
          title: const Text("Weatherman")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: colorBody,
              child: Column(
                children: [
                  Gap(30),
                  Center(
                    child: Text(
                      "${widget.response.cityNamee}",
                      style: TextStyle(color: colorText, fontSize: 30),
                    ),
                  ),
                  Row(
                    //horizontal
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        widget.response.iconUrl,
                        height: 100,
                        width: 100,
                      ),
                      Visibility(
                        visible: widget.response.tempInfo?.temp != null,
                        child: Text(
                          "${widget.response.tempInfo?.temp}  °C",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.response.weatherInfo?.description != null,
                    child: Text(
                      " ${widget.response.weatherInfo?.description}",
                      style: TextStyle(color: colorText, fontSize: 20),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: const Icon(
                Icons.swipe_down,
                size: 50,
              ),
            ),
            const Gap(50),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Gap(5),
                      Column(
                        children: [
                          Visibility(
                            visible: widget.response.tempInfo?.temp != null,
                            child: Text(
                              "${widget.response.tempInfo?.temp}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/temp.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: widget.response.tempInfo?.pressure != null,
                            child: Text(
                              "${widget.response.tempInfo?.pressure}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/pressure.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: widget.response.tempInfo?.humidity != null,
                            child: Text(
                              "${widget.response.tempInfo?.humidity}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/humidityy.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                    ],
                  ),
                  const Gap(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Gap(5),
                      Column(
                        children: [
                          Visibility(
                            visible:
                                widget.response.tempInfo?.feels_like != null,
                            child: Text(
                              "${widget.response.tempInfo?.feels_like}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/pressure.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: widget.response.tempInfo?.temp != null,
                            child: Text(
                              "${widget.response.tempInfo?.temp}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/pressure.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: widget.response.tempInfo?.temp != null,
                            child: Text(
                              "${widget.response.tempInfo?.temp}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Gap(5),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Image.asset(
                                "images/pressure.jfif",
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
