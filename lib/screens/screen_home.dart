/* SOLO LISTVIEW.BUILDER*/
/* Paginazione con listview builder e fetch api separata.
Unica pecca, non mostra l'indicatore circolare durante il caricamento di altri elementi ;(*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_autoroute/model/pkmn.dart';

import 'package:pokemon_autoroute/routes/app_router.gr.dart';
import 'package:pokemon_autoroute/utils/fetch_combined.dart';
import 'package:pokemon_autoroute/utils/string_extension.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const pokeApidomain = 'pokeapi.co';

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();
  bool isLoading = false;
  late List<PokemonResults>? pokemonResults = [];
  bool hasMore = true;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    callPokemon();
  }

  Future _scrollListener() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      callPokemon();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void callPokemon() async {
    int limit = 20;
    if (isLoading) return;
    isLoading = true;

    pokemonResults =
        await ApiService().fetchPokemon(limit, page, pokemonResults);
    setState(() {
      page++;
      isLoading = false;

      if ((pokemonResults?.length ?? 0) < limit) {
        hasMore = false;
      }
    });
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      pokemonResults?.clear();
    });

    callPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 21, 21),
        title: Text(
          'Pokedex',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color.fromARGB(255, 240, 240, 240)),
        ),
      ),
      body: pokemonResults!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(12.0),
                controller: scrollController,
                itemCount: isLoading
                    ? ((pokemonResults?.length ?? 0) + 1)
                    : pokemonResults?.length,
                itemBuilder: ((context, index) {
                  if (index < (pokemonResults?.length ?? 0)) {
                    final pokemonResult = pokemonResults?[index];
                    final name = pokemonResult?.specificPokemonDetails?.name;
                    return ListTile(
                      leading: InkWell(
                          onTap: () {
                            AutoRouter.of(context).push(PkmnView(
                              id: pokemonResult?.specificPokemonDetails?.id ??
                                  0,
                              name:
                                  pokemonResult?.specificPokemonDetails?.name ??
                                      '',
                              officialArtworkSprite: pokemonResult
                                      ?.specificPokemonDetails
                                      ?.officialArtworkSprite ??
                                  '',
                              stats:
                                  pokemonResult!.specificPokemonDetails!.stats,
                              types:
                                  pokemonResult.specificPokemonDetails!.types,
                            ));
                          },
                          child: Hero(
                            tag: pokemonResult?.specificPokemonDetails?.id
                                    .toString() ??
                                '',
                            child: Image.network(
                              pokemonResult?.specificPokemonDetails
                                      ?.officialArtworkSprite ??
                                  '',
                              width: 100,
                              height: 100,
                            ),
                          )),
                      title: Text(name.toString().toCapitalized()),
                      trailing: Text(
                          'N° ${pokemonResult?.specificPokemonDetails?.order}'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(
                        child: hasMore
                            ? const CircularProgressIndicator()
                            : const Text('There are no more pokemons!'),
                      ),
                    );
                  }
                }),
              ),
            ),
    );
  }
}
