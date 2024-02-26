import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/pkmn.dart';

const pokeapiURL = "https://pokeapi.co/api/v2/";
//const pokeApidomain = 'pokeapi.co';

// // mi serve come Future una lista di pokemon, dio future
// Future<List<Pkmn>> fetchListOfPokemon(int pageIndex) async {
//   final queryParameters = {
//     'limit': '1302',
//     'offset': (pageIndex * 14).toString()
//   };

//   final response = await http
//       .get(Uri.https(pokeApidomain, '/api/v2/pokemon', queryParameters));
//   //await http.get(Uri.parse('${pokeapiURL}pokemon?limit=50&offset=0'));
//   // la documentazione flutter dice di usare sta roba dello statusCode https://docs.flutter.dev/cookbook/networking/fetch-data
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = jsonDecode(response.body);
//     final List<dynamic> results = data['results'];
//     List<Pkmn> pkmnList = [];
//     for (Map result in results) {
//       final pokemonResponse = await http.get(Uri.parse(result['url']));
//       if (pokemonResponse.statusCode == 200) {
//         final Map<String, dynamic> pkmnData = jsonDecode(pokemonResponse.body);
//         pkmnList.add(Pkmn.fromJson(pkmnData));
//       }
//     }
//     return pkmnList;
//   } else {
//     throw Exception('Failed to load the Pokemon list');
//   }
// }

const pokeApidomain = 'pokeapi.co';

// mi serve come Future una lista di pokemon, dio future
Future<List<Pkmn>> fetchListOfPokemon(int pageIndex) async {
  // qya prendo l'url con http facendo in modo che me ne carichi solo 14 per volta, ovvero quelli che lo schermo mi vede
  // Devo usare await dato che sono in un async
  final response = await http.get(Uri.https(pokeApidomain, '/api/v2/pokemon',
      {'limit': '1302', 'offset': (pageIndex * 14).toString()}));

  // i pokemon in pokeapi sono in dei json nel campo results, quindi li converto in una Lista di diverso tipi
  var pkmnJson = jsonDecode(response.body)['results'] as List<dynamic>;
  // la documentazione flutter dice di usare sta roba dello statusCode == 200 https://docs.flutter.dev/cookbook/networking/fetch-data
  if (response.statusCode == 200) {
    // mi ritorno una lista (di tipo Pkmn) mappata, con i campi che mi interessa mostrare nella lista dei diversi pokemon
    // ovvero: nome, id, immaginina. L'order posso ricavarmelo dall'id che tanto è ugualq. Per l'immagine devo passargli
    return pkmnJson.map((pkmnJson) {
      // definisco per primo l'url perchè mi servirà per l'id, dato che è fatto così:
      final url = pkmnJson['url'].toString();
      // https://pokeapi.co/api/v2/pokemon/1 <- id del pokemon che mi serve tirarmi fuori.
      // quindi, mi estraggo con split i campi (uguale allo split in R) e tengo il sesto
      final id = int.parse(url.split('/')[6]);
      final name = pkmnJson['name'];
      // immagine per l'iconcina nel ListView, userò l'artwork. Preferivo lo sprite ma poi l'animazione sarebbe una merda credo
      final imageURL =
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png"; // <- url degli ARTWORKS
      // final imageURL =
      //     'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'; // <- url degli SPRITES

      return Pkmn(
        id: id,
        name: name,
        url: url,
        imageUrl: imageURL,
      );
    }).toList();
  }
  throw Exception('Failed to load the pokemon list!');
}

// con questo metodo, voglio fare una richiesta all'API per il dettaglio dei singoli pokemon
// la logica è che, quando viene chiamata la pagina del pokemon, viene passato un'id, che passo
// a questa chiamata. con l'id, posso usare l'url
Future<Pkmn> fetchPokemonDetails(String id) async {
  final response = await http.get(Uri.parse('${pokeapiURL}pokemon/$id'));

  if (response.statusCode == 200) {
    final pkmnID = jsonDecode(response.body)['id'] as int;
    final pkmnName = jsonDecode(response.body)['name'] as String;
    final pkmnType1 =
        jsonDecode(response.body)['types'][0]['type']['name'] as String;
    // jsonDecode(response.body)['types'][0]['type']['name'] as String;
    // if (jsonDecode(response.body)['types'][1]['type']['name']) {
    //   final pkmnType2 =
    //       jsonDecode(response.body)['types'][1]['type']['name'] as String;
    //   print(pkmnType2);
    //   return Pkmn(type2: pkmnType2);
    // }
    //List<dynamic>; //['type']['name'] as List<dynamic>;
    print(pkmnType1);

    final pkmnImage =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pkmnID.png"; // artworks
    // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/$pkmnID.png'; // back sprites
    // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pkmnID.png'; // front sprites
    final pkmnHP = jsonDecode(response.body)['stats'][0]['base_stat'] as int;
    final pkmnAttack =
        jsonDecode(response.body)['stats'][1]['base_stat'] as int;
    final pkmnDefense =
        jsonDecode(response.body)['stats'][2]['base_stat'] as int;
    final pkmnSpAttack =
        jsonDecode(response.body)['stats'][3]['base_stat'] as int;
    final pkmnSpDefense =
        jsonDecode(response.body)['stats'][4]['base_stat'] as int;
    final pkmnSpeed = jsonDecode(response.body)['stats'][5]['base_stat'] as int;
    // //print(pkmnType);

// Devo capire la logica del dirgli se ha un tipo solo o due, l'api è fatta così
/*
Bulbasaur
  "types": [
    {
      "slot": 1,
      "type": {
        "name": "grass",
        "url": "https://pokeapi.co/api/v2/type/12/"
      }
    },
    {
      "slot": 2,
      "type": {
        "name": "poison",
        "url": "https://pokeapi.co/api/v2/type/4/"
      }
    }
  ]
Charmander
   "types": [
    {
      "slot": 1,
      "type": {
        "name": "fire",
        "url": "https://pokeapi.co/api/v2/type/10/"
      }
    }
  ],
*/
    //final pkmnType = jsonDecode(response.body)['types'] as List<String>;
    // final pkmnType2 = jsonDecode(response.body)['types'][1]
    //     ? jsonDecode(response.body)['types'][1]['type']['name'] as String
    //     : null;

    return Pkmn(
      id: pkmnID,
      name: pkmnName,
      imageUrl: pkmnImage,
      type1: pkmnType1,
      //type2: pkmnType2,
      hp: pkmnHP,
      attack: pkmnAttack,
      defense: pkmnDefense,
      spAttack: pkmnSpAttack,
      spDefense: pkmnSpDefense,
      speed: pkmnSpeed,
    );
  }
  throw Exception('Failed to load the pokemon!');
}

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:pokeapp2/model/pkmn.dart';

// const pokeapiURL = "https://pokeapi.co/api/v2/";
// const pokeApidomain = 'pokeapi.co';

// // mi serve come Future una lista di pokemon, dio future
// Future<List<Pkmn>> fetchListOfPokemon(int pageIndex) async {
//   final queryParameters = {
//     'limit': '1302',
//     'offset': (pageIndex * 14).toString()
//   };

//   final response = await http
//       .get(Uri.https(pokeApidomain, '/api/v2/pokemon', queryParameters));
//   //await http.get(Uri.parse('${pokeapiURL}pokemon?limit=50&offset=0'));
//   // la documentazione flutter dice di usare sta roba dello statusCode https://docs.flutter.dev/cookbook/networking/fetch-data
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = jsonDecode(response.body);
//     final List<dynamic> results = data['results'];
//     List<Pkmn> pkmnList = [];
//     for (Map result in results) {
//       final pokemonResponse = await http.get(Uri.parse(result['url']));
//       if (pokemonResponse.statusCode == 200) {
//         final Map<String, dynamic> pkmnData = jsonDecode(pokemonResponse.body);
//         pkmnList.add(Pkmn.fromJson(pkmnData));
//       }
//     }
//     return pkmnList;
//   } else {
//     throw Exception('Failed to load the Pokemon list');
//   }
// }

// const pokeApidomain = 'pokeapi.co';

// // mi serve come Future una lista di pokemon, dio future
// Future<List<Pkmn>> fetchListOfPokemon(int pageIndex) async {
//   // qya prendo l'url con http facendo in modo che me ne carichi solo 14 per volta, ovvero quelli che lo schermo mi vede
//   // Devo usare await dato che sono in un async
//   final response = await http.get(Uri.https(pokeApidomain, '/api/v2/pokemon',
//       {'limit': '1302', 'offset': (pageIndex * 14).toString()}));

//   // i pokemon in pokeapi sono in dei json nel campo results, quindi li converto in una Lista di diverso tipi
//   var pkmnJson = jsonDecode(response.body)['results'] as List<dynamic>;
//   // la documentazione flutter dice di usare sta roba dello statusCode == 200 https://docs.flutter.dev/cookbook/networking/fetch-data
//   if (response.statusCode == 200) {
//     // mi ritorno una lista (di tipo Pkmn) mappata, con i campi che mi interessa mostrare nella lista dei diversi pokemon
//     // ovvero: nome, id, immaginina. L'order posso ricavarmelo dall'id che tanto è ugualq. Per l'immagine devo passargli
//     return pkmnJson.map((pkmnJson) {
//       // definisco per primo l'url perchè mi servirà per l'id, dato che è fatto così:
//       final url = pkmnJson['url'].toString();
//       // https://pokeapi.co/api/v2/pokemon/1 <- id del pokemon che mi serve tirarmi fuori.
//       // quindi, mi estraggo con split i campi (uguale allo split in R) e tengo il sesto
//       final id = int.parse(url.split('/')[6]);
//       final name = pkmnJson['name'];
//       // immagine per l'iconcina nel ListView, userò l'artwork. Preferivo lo sprite ma poi l'animazione sarebbe una merda credo
//       final imageURL =
//           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png"; // <- url degli ARTWORKS
//       // final imageURL =
//       //     'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png'; // <- url degli SPRITES

//       return Pkmn(
//         id: id,
//         name: name,
//         url: url,
//         imageUrl: imageURL,
//       );
//     }).toList();
//   }
//   throw Exception('Failed to load the pokemon list!');
// }

// // con questo metodo, voglio fare una richiesta all'API per il dettaglio dei singoli pokemon
// // la logica è che, quando viene chiamata la pagina del pokemon, viene passato un'id, che passo
// // a questa chiamata. con l'id, posso usare l'url
// Future<Pkmn> fetchPokemonDetails(String id) async {
//   final response = await http.get(Uri.parse('${pokeapiURL}pokemon/$id'));
// //  final bool checkTypes = await http.get(Uri.parse('${pokeapiURL}pokemon/$id')).checkTypes;

//   if (response.statusCode == 200) {
//     if (jsonDecode(response.body)['types'][1]) {
//       final pkmnID = jsonDecode(response.body)['id'] as int;
//       final pkmnName = jsonDecode(response.body)['name'] as String;
//       final pkmnType1 = [
//         jsonDecode(response.body)['types'][0]['type']['name'],
//         jsonDecode(response.body)['types'][1]['type']['name']
//       ];
//       print(pkmnType1);
//       final pkmnImage =
//           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pkmnID.png"; // artworks
//       // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/$pkmnID.png'; // back sprites
//       // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pkmnID.png'; // front sprites
//       final pkmnHP = jsonDecode(response.body)['stats'][0]['base_stat'] as int;
//       final pkmnAttack =
//           jsonDecode(response.body)['stats'][1]['base_stat'] as int;
//       final pkmnDefense =
//           jsonDecode(response.body)['stats'][2]['base_stat'] as int;
//       final pkmnSpAttack =
//           jsonDecode(response.body)['stats'][3]['base_stat'] as int;
//       final pkmnSpDefense =
//           jsonDecode(response.body)['stats'][4]['base_stat'] as int;
//       final pkmnSpeed =
//           jsonDecode(response.body)['stats'][5]['base_stat'] as int;

//       return Pkmn(
//         id: pkmnID,
//         name: pkmnName,
//         imageUrl: pkmnImage,
//         type1: pkmnType1,
//         //type2: pkmnType2,
//         hp: pkmnHP,
//         attack: pkmnAttack,
//         defense: pkmnDefense,
//         spAttack: pkmnSpAttack,
//         spDefense: pkmnSpDefense,
//         speed: pkmnSpeed,
//       );
//     } else {
//       final pkmnID = jsonDecode(response.body)['id'] as int;
//       final pkmnName = jsonDecode(response.body)['name'] as String;
//       final pkmnType1 = [
//         jsonDecode(response.body)['types'][0]['type']['name'] as String,
//       ];
//       print(pkmnType1);
//       final pkmnImage =
//           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pkmnID.png"; // artworks
//       // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/back/$pkmnID.png'; // back sprites
//       // // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pkmnID.png'; // front sprites
//       final pkmnHP = jsonDecode(response.body)['stats'][0]['base_stat'] as int;
//       final pkmnAttack =
//           jsonDecode(response.body)['stats'][1]['base_stat'] as int;
//       final pkmnDefense =
//           jsonDecode(response.body)['stats'][2]['base_stat'] as int;
//       final pkmnSpAttack =
//           jsonDecode(response.body)['stats'][3]['base_stat'] as int;
//       final pkmnSpDefense =
//           jsonDecode(response.body)['stats'][4]['base_stat'] as int;
//       final pkmnSpeed =
//           jsonDecode(response.body)['stats'][5]['base_stat'] as int;

//       return Pkmn(
//         id: pkmnID,
//         name: pkmnName,
//         imageUrl: pkmnImage,
//         type1: pkmnType1,
//         //type2: pkmnType2,
//         hp: pkmnHP,
//         attack: pkmnAttack,
//         defense: pkmnDefense,
//         spAttack: pkmnSpAttack,
//         spDefense: pkmnSpDefense,
//         speed: pkmnSpeed,
//       );
//     }

//     // //print(pkmnType);

// // Devo capire la logica del dirgli se ha un tipo solo o due, l'api è fatta così
// /*
// Bulbasaur
//   "types": [
//     {
//       "slot": 1,
//       "type": {
//         "name": "grass",
//         "url": "https://pokeapi.co/api/v2/type/12/"
//       }
//     },
//     {
//       "slot": 2,
//       "type": {
//         "name": "poison",
//         "url": "https://pokeapi.co/api/v2/type/4/"
//       }
//     }
//   ]
// Charmander
//    "types": [
//     {
//       "slot": 1,
//       "type": {
//         "name": "fire",
//         "url": "https://pokeapi.co/api/v2/type/10/"
//       }
//     }
//   ],
// */
//     //final pkmnType = jsonDecode(response.body)['types'] as List<String>;
//     // final pkmnType2 = jsonDecode(response.body)['types'][1]
//     //     ? jsonDecode(response.body)['types'][1]['type']['name'] as String
//     //     : null;
//   }
//   throw Exception('Failed to load the pokemon!');
// }
