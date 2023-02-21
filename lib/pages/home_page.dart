import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/pages/pokemon_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pokeApi =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  List? pokedex;

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: pokedex != null
                ? Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Image.asset(
                          'images/pokeball.png',
                          width: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 20,
                          child: Text(
                        "Pokedex",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                        ),

                      )),
                      Positioned(
                        top: 150,
                        bottom: 0,
                        width: width,
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.4,
                                ),
                                itemCount: pokedex!.length,
                                itemBuilder: (context, index) {
                                  var type = pokedex![index]['type'][0];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12.0),
                                    child: InkWell(
                                      onTap: () {
                                        // TODO: Navigate to detail pokemon page.
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetailPage(),));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: type == 'Grass' ? Colors.greenAccent: type == 'Fire' ? Colors.redAccent: type=='Water' ? Colors.blue: type == 'Electric' ? Colors.yellow: type == 'Rock' ? Colors.grey: type == 'Ground' ? Colors.brown: type == 'Psychic' ? Colors.indigo: type == 'Fighting' ? Colors.orange: type == 'Bug' ? Colors.lightGreenAccent: type == 'Ghost' ? Colors.deepPurple: type == 'Normal' ? Colors.black26: type == 'Poison' ? Colors.deepPurpleAccent: type=='Ice' ? Colors.lightBlueAccent: type == 'Dragon' ? Colors.red.shade800: Colors.pink,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                bottom: -10,
                                                right: -10,
                                                child: Image.asset(
                                                  'images/pokeball.png',
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                )),
                                            Positioned(
                                              top: 20,
                                              left: 10,
                                              child: Text(
                                                pokedex![index]['name'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 45,
                                              left: 20,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black26,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Text(
                                                  type,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: CachedNetworkImage(
                                                imageUrl: pokedex![index]['img'],
                                                height: 100,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
