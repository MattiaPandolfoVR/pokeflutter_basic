//Schermata di home con il titolo "Pokedex di mattia" e con una ListView di pokemon sotto, come nel pokedex di blu e rosso
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_autoroute/routes/app_router.gr.dart';
import '../model/pkmn.dart';

@RoutePage()
class DexView extends StatelessWidget {
  const DexView({
    super.key,
    required this.pkmnItem,
  });

  // qui creo la variabile lista con cui passo il nome, l'url, l'id e l'immagine
  final List<Pkmn> pkmnItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pkmnItem.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          // che porcata dio madonna
          '${pkmnItem[index].name![0].toUpperCase()}${pkmnItem[index].name!.substring(1).toLowerCase()}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: InkWell(
            onTap: () {
              AutoRouter.of(context).push(PkmnView(
                  id: pkmnItem[index]
                      .id
                      .toString())); //PageRouteInfo(pkmnItem[index].id.toString()));
            },
            child: Image.network(
              pkmnItem[index].imageUrl.toString(),
              width: 100,
              height: 100,
            )),
        trailing: Text(
          'N° ${pkmnItem[index].id}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
