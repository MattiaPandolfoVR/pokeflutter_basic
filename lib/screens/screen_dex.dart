import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_autoroute/routes/app_router.gr.dart';
import 'package:pokemon_autoroute/utils/string_extension.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/pkmn.dart';

@RoutePage()
class DexView extends StatelessWidget {
  const DexView({
    super.key,
    required this.pkmnItem,
  });

  final List<Pkmn> pkmnItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pkmnItem.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          (pkmnItem[index].name ?? "").toCapitalized(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: InkWell(
          onTap: () {
            AutoRouter.of(context)
                .push(PkmnView(id: pkmnItem[index].id.toString()));
          },
          child: Hero(
            tag: pkmnItem[index].id.toString(),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                pkmnItem[index].imageUrl.toString(),
              ),
              width: 100,
              height: 100,
            ),
          ),
        ),
        trailing: Text(
          'N° ${pkmnItem[index].id}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
