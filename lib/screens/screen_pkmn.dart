import 'package:pokemon_autoroute/model/pkmn.dart';

import "../utils/string_extension.dart";
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

@RoutePage()
class PkmnView extends StatelessWidget {
  const PkmnView({
    super.key,
    required this.id,
    required this.name,
    required this.officialArtworkSprite,
    required this.stats,
    required this.types,
  });
  final int id;
  final String name;
  final String officialArtworkSprite;
  final List<PokemonStat> stats;
  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 21, 21),
        title: Text(
          name.toCapitalized(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: id,
            child:
                // Image.network(
                //   officialArtworkSprite,
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                //   height: 400,
                FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(officialArtworkSprite),
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity,
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: types
                  .map((t) => FilterChip(
                      label: Text(t.name.toCapitalized()), onSelected: (b) {}))
                  .toList()),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: stats
                  .map((baseStat) => Text(
                      '${baseStat.name.toCapitalized()}: ${baseStat.baseStats}',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
