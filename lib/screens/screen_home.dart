import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_autoroute/model/pkmn.dart';
import 'package:pokemon_autoroute/routes/app_router.gr.dart';
import 'package:pokemon_autoroute/utils/string_extension.dart';
//import 'package:transparent_image/transparent_image.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

const pokeApidomain = 'pokeapi.co';

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();
  List<PokemonResults> pokemonResults = [];
  int pageIndex = 0;

  bool isLoading = false;

  @override
  void initState() {
    getPokemons(pageIndex);
    super.initState();
    scrollController.addListener(loadMorePokemon);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMorePokemon() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      pageIndex++;
      getPokemons(pageIndex);
      //print(pokemonResults);
    }
  }

  Future refresh() async {
    setState(() {
      getPokemons(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 238, 21, 21),
        title: Text(
          'Pokedex\nPull to refresh',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color.fromARGB(255, 240, 240, 240)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          controller: scrollController,
          itemCount: pokemonResults.length,
          itemBuilder: (context, index) {
            final pokemonResult = pokemonResults[index];
            return Column(
              children: [
                ListTile(
                  leading: InkWell(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(PkmnView(id: pokemonResult.name));
                    },
                    child: Container(
                      color: Colors.white,
                      width: 100,
                      height: 100,
                      child: const Center(
                          child: Text('Click here')), //provvisional
                    ),
                    // child: Hero(
                    //   tag: pokemonResult.name,
                    //   child: FadeInImage(
                    //     placeholder: MemoryImage(kTransparentImage),
                    //     image: NetworkImage(
                    //       pokemonResult.,
                    //     ),
                    //     width: 100,
                    //     height: 100,
                    //   ),
                    // ),
                  ),
                  title: Text(pokemonResult.name.toCapitalized()),
                  trailing: Text('N° ${index + 1}'),
                ),
                if (index == pokemonResults.length - 1 && isLoading)
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> getPokemons(int pageIndex) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.https(
          pokeApidomain,
          '/api/v2/pokemon',
          {'limit': '20', 'offset': (pageIndex * 20).toString()}));
      final List results = json.decode(response.body)['results'];
      final List<PokemonResults> newPokemonResult =
          results.map((p) => PokemonResults.fromJson(p)).toList();
      //print(newPokemonResult);
      setState(() {
        isLoading = false;
        pokemonResults.addAll(newPokemonResult);
      });
    } catch (e) {
      print(e);
    }
  }
}

//   //Future<void> getPokemons(int pageIndex) async {
//   //   try {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//   //     final response = await http.get(Uri.https(
//   //         pokeApidomain,
//   //         '/api/v2/pokemon',
//   //         {'limit': '20', 'offset': (pageIndex * 20).toString()}));
//   //     final List results = json.decode(response.body)['results'];
//   //     final List<PokemonResults> newPokemonResult =
//   //         results.map((p) => PokemonResults.fromJson(p)).toList();
//   //     //print(newPokemonResult);
//   //     setState(() {
//   //       isLoading = false;
//   //       pokemonResults.addAll(newPokemonResult);
//   //     });
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
// }


// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:pokemon_autoroute/model/pokemon.dart';

// //import 'package:pokemon_autoroute/model/pokemon.dart';
// import 'package:pokemon_autoroute/routes/app_router.gr.dart';
// import 'package:pokemon_autoroute/utils/fetch_pokemon.dart';
// import 'package:pokemon_autoroute/utils/string_extension.dart';
// //import 'package:transparent_image/transparent_image.dart';

// @RoutePage()
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// const pokeApidomain = 'pokeapi.co';

// class _HomeViewState extends State<HomeView> {
//   late final ScrollController _controller;
//   int page = 0;
//   List<PokemonResults> data = [];

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _loadMoreData() async {
//     page++;
//     final res = await fetchPokemonsList(page);
//     data = [...data, ...res];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = ScrollController();
//     _controller.addListener(() {
//       final hasReachedEnd =
//           _controller.offset >= _controller.position.maxScrollExtent &&
//               !_controller.position.outOfRange;
//       if (!hasReachedEnd) return;
//       _loadMoreData();
//     });
//   }

//   Future refresh() async {
//     setState(() {
//       fetchPokemonsList(page);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 240, 240),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 238, 21, 21),
//         title: Text(
//           'Pokedex di mattia', //\n Pull to refresh',
//           style: Theme.of(context)
//               .textTheme
//               .titleLarge!
//               .copyWith(color: const Color.fromARGB(255, 240, 240, 240)),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: refresh,
//         child: ListView.builder(
//           physics: const AlwaysScrollableScrollPhysics(),
//           shrinkWrap: false,
//           controller: _controller,
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             final pokemonResult = data[index];
//             return Column(
//               children: [
//                 ListTile(
//                   leading: InkWell(
//                     onTap: () {
//                       AutoRouter.of(context)
//                           .push(PkmnView(id: pokemonResult.name ?? ''));
//                     },
//                     child: Container(
//                       color: Colors.amber,
//                       width: 100,
//                       height: 100,
//                     ),
//                     // child: Hero(
//                     //   tag: pokemonResult.name,
//                     //   child: FadeInImage(
//                     //     placeholder: MemoryImage(kTransparentImage),
//                     //     image: NetworkImage(
//                     //       pokemonResult.,
//                     //     ),
//                     //     width: 100,
//                     //     height: 100,
//                     //   ),
//                     // ),
//                   ),
//                   title: Text(pokemonResult.name ?? ''.toCapitalized()),
//                   trailing: Text('N° ${index + 1}'),
//                 ),
//                 if (index == data.length - 1)
//                   const Padding(
//                     padding: EdgeInsets.all(10),
//                     child: CircularProgressIndicator(),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   //Future<void> getPokemons(int pageIndex) async {
//   //   try {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//   //     final response = await http.get(Uri.https(
//   //         pokeApidomain,
//   //         '/api/v2/pokemon',
//   //         {'limit': '20', 'offset': (pageIndex * 20).toString()}));
//   //     final List results = json.decode(response.body)['results'];
//   //     final List<PokemonResults> newPokemonResult =
//   //         results.map((p) => PokemonResults.fromJson(p)).toList();
//   //     //print(newPokemonResult);
//   //     setState(() {
//   //       isLoading = false;
//   //       pokemonResults.addAll(newPokemonResult);
//   //     });
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }
// }
