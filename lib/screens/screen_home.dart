import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../model/pkmn.dart';
import 'screen_dex.dart';
import 'package:http/http.dart' as http;

const pokeApidomain = 'pokeapi.co';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Future<List<Pkmn>> ftrPkmnList;

  @override
  void initState() {
    super.initState();
    ftrPkmnList = _fetchListOfPokemon();
  }

  Future<List<Pkmn>> _fetchListOfPokemon() async {
    final response = await http
        .get(Uri.https(pokeApidomain, '/api/v2/pokemon', {'limit': '1302'}));
    if (response.statusCode == 200) {
      final pkmnListJson =
          json.decode(response.body)['results'] as List<dynamic>;
      return pkmnListJson.map((json) => Pkmn.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load the data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 21, 21),
        title: Text(
          'Pokedex di mattia',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color.fromARGB(255, 240, 240, 240)),
        ),
      ),
      body: FutureBuilder(
        future: ftrPkmnList,
        builder: (context, pkmnlist) {
          if (pkmnlist.hasData) {
            return DexView(pkmnItem: pkmnlist.data!);
          }
          if (pkmnlist.hasError) {
            return Text('There is an error: ${pkmnlist.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
