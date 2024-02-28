import 'package:pokemon_autoroute/model/pkmn_details.dart';

import "../utils/string_extension.dart";
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const pokeApidomain = 'pokeapi.co';

@RoutePage()
class PkmnView extends StatefulWidget {
  const PkmnView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<PkmnView> createState() => _PkmnViewState();
}

class _PkmnViewState extends State<PkmnView> {
  late final Future<PkmnDetails> ftrPkmn;

  @override
  void initState() {
    super.initState();
    ftrPkmn = fetchPokemonDetails(widget.id.toString());
  }

  Future<PkmnDetails> fetchPokemonDetails(String id) async {
    final response =
        await http.get(Uri.https(pokeApidomain, '/api/v2/pokemon/$id'));
    if (response.statusCode == 200) {
      return PkmnDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ftrPkmn,
      builder: (context, pkmnlist) {
        if (pkmnlist.hasData) {
          var pkmn = pkmnlist.data!;
          var capitalName = (pkmn.name ?? "").toCapitalized();
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 238, 21, 21),
                title: Text(
                  capitalName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: pkmn.id.toString(),
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(pkmn.imageUrl.toString()),
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pkmn.types!
                              .map((Types t) => FilterChip(
                                  label:
                                      Text(t.type?.name?.toCapitalized() ?? ''),
                                  onSelected: (b) {}))
                              .toList()),
                      const SizedBox(height: 10),
                      Text(
                          'HP: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[1]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                          'Attack: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[2]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                          'Defense: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[2]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                          'Special Attack: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[3]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                          'Special Defense: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[4]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                          'Speed: ${pkmn.stats!.map((Stats t) => t.baseStat).toList()[5]}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ));
        }
        if (pkmnlist.hasError) {
          return Text('There is an error: ${pkmnlist.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
