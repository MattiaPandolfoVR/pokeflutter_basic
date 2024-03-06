import 'package:pokemon_autoroute/model/pkmn_details.dart';
import 'package:pokemon_autoroute/utils/fetch_pokemon.dart';

import "../utils/string_extension.dart";
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
  late final Future<PokemonDetails> ftrPkmn;

  @override
  void initState() {
    super.initState();
    ftrPkmn = fetchPokemonDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ftrPkmn,
      builder: (context, pkmnlist) {
        if (pkmnlist.hasData) {
          final pkmn = pkmnlist.data;
          final capitalName = (pkmn?.name ?? '').toCapitalized();
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
                  // Hero(
                  //   tag: pkmn?.id,
                  //   child:
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(
                        pkmn?.sprites.other?.officialArtwork.frontDefault ??
                            ''),
                    fit: BoxFit.cover,
                    height: 400,
                    width: double.infinity,
                  ),
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pkmn!.types
                          .map((t) => FilterChip(
                              label: Text(t.type.name.toCapitalized()),
                              onSelected: (b) {}))
                          .toList()),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pkmn.stats
                        .map((baseStat) => Text(
                            '${baseStat.stat.name.toCapitalized()}: ${baseStat.baseStat}',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)))
                        .toList(),
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
