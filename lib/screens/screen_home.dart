import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../model/pkmn.dart';
import '../viewmodel/pkmn_fetch.dart';
import 'screen_dex.dart';

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
    ftrPkmnList = fetchListOfPokemon(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Voglio che il colore del background sia il bianco delle pokeball
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        // su iOS il testo è già gentrato, mentre su android di default è a lato
        // sinistro, quindi sovrascrivo questa cosa (trovato qui:
        // https://stackoverflow.com/questions/43981406/how-to-center-the-title-of-an-appbar)
        centerTitle: true,
        // utilizzo il colore del tema per l'AppBar
        backgroundColor: const Color.fromARGB(255, 238, 21, 21),
        // qui per la formattazione devo fare la cagata del giro con copyWith
        title: Text(
          'Pokedex di mattia',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              // il titolo avrà il colore bianco delle pokeball
              .copyWith(color: const Color.fromARGB(255, 240, 240, 240)),
        ),
      ),
      body: FutureBuilder(
        future: ftrPkmnList,
        builder: (context, pkmnlist) {
          if (pkmnlist.hasData) {
            return DexView(
                pkmnItem: pkmnlist
                    .data!); // sarebbe pkmnItem e non pkmnList prima delle modifiche
          }
          if (pkmnlist.hasError) {
            return Text('There is an error: ${pkmnlist.error}');
          }
          // di default se non funziona il fetcher mi mostra un'icona circolare
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
