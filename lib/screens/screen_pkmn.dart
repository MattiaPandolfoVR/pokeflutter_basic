import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/pkmn.dart';
import '../viewmodel/pkmn_fetch.dart';
import 'package:transparent_image/transparent_image.dart';

@RoutePage()
class PkmnView extends StatefulWidget {
  const PkmnView({
    super.key,
    required this.id,
  });
  // mi basta l'id da passare a fetchPokemonDetails
  final String id;

  @override
  State<PkmnView> createState() => _PkmnViewState();
}

class _PkmnViewState extends State<PkmnView> {
  late final Future<Pkmn> ftrPkmn;

  @override
  void initState() {
    super.initState();
    ftrPkmn = fetchPokemonDetails(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ftrPkmn,
      builder: (context, pkmnlist) {
        if (pkmnlist.hasData) {
          var pkmn = pkmnlist.data!;
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 238, 21, 21),
                title: Text(
                  // che porcata 2, dio madonna 2
                  '${pkmn.name![0].toUpperCase()}${pkmn.name!.substring(1).toLowerCase()}',
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero per mostrare l'immagine sopra e fare una breve animazione
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
                      Text(
                        'Types: ${pkmn.type1![0].toUpperCase()}${pkmn.type1!.substring(1).toLowerCase()}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Hp: ${pkmn.hp}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Attack: ${pkmn.attack}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Defense: ${pkmn.defense}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Special Attack: ${pkmn.spAttack}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Special Defense: ${pkmn.spDefense}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Speed: ${pkmn.speed}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ));
        }
        if (pkmnlist.hasError) {
          return Text('There is an error: ${pkmnlist.error}');
        }
        // di default se non funziona il fetcher mi mostra un'icona circolare
        return const CircularProgressIndicator();
      },
    );
  }
}
