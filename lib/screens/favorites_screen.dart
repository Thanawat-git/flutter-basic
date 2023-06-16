import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites_model.dart';

class FavoritesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<FavoriteState>();
    print(appState.favorites);
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text("No favorites yet."),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("You have ${appState.favorites.length} favolites."),
        ),
        Expanded(
            child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400, childAspectRatio: 400 / 80),
          children: [
            for (var pair in appState.favorites)
              ListTile(
                leading: IconButton(
                    onPressed: () {},
                    color: theme.colorScheme.primary,
                    icon: Icon(
                      Icons.delete_outline,
                      semanticLabel: 'Delete',
                    )),
                title: Text(pair.asPascalCase),
              )
          ],
        ))
      ],
    );
  }
}
