import 'package:flutter/material.dart';
import '../screens/favorites_screen.dart';
import '../screens/generator_screen.dart';

class MyAppLayout extends StatefulWidget {
  @override
  State<MyAppLayout> createState() => _MyAppLayoutState();
}

class _MyAppLayoutState extends State<MyAppLayout> {
  var selectedIndex = 0; // default selectedIndex value.

  void onDestinationSelected(value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorScreen();
        break;
      case 1:
        page = FavoritesListScreen();
        break;
      default:
        throw UnimplementedError("no widget for $selectedIndex");
    }

    var colorScheme = Theme.of(context).colorScheme;

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200), // animation when change the page
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // BottomNavigationBar for mobile
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                    child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favorites"),
                  ],
                  currentIndex: selectedIndex,
                  onTap: onDestinationSelected,
                ))
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                    child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                        icon: Icon(Icons.home), label: Text("Home")),
                    NavigationRailDestination(
                        icon: Icon(Icons.favorite), label: Text("Favorites")),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                )),
                Expanded(child: mainArea)
              ],
            );
          }
        },
      ),
    );

    // return LayoutBuilder(builder: (context, constraints) {
    //   return Scaffold(
    //       body: Row(
    //     children: [
    //       SafeArea(
    //           child: NavigationRail(
    //         extended: constraints.maxWidth >=
    //             600, // like media query -> check screen size.
    //         destinations: [
    //           NavigationRailDestination(
    //               icon: Icon(Icons.home), label: Text("Home")),
    //           NavigationRailDestination(
    //             icon: Icon(Icons.favorite),
    //             label: Text("Favorites"),
    //           ),
    //         ],
    //         selectedIndex: selectedIndex,
    //         onDestinationSelected: onDestinationSelected,
    //       )),
    //       Expanded(
    //           child: Container(
    //         color: Theme.of(context).colorScheme.primaryContainer,
    //         child: page,
    //       ))
    //     ],
    //   ));
    // });
  }
}
