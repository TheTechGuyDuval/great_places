import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>  GreatPlaces() ,
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.light(
            primary: Colors.indigo,
            secondary: Colors.amber,
          )
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName :(ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName :(context) => PlaceDetailScreen(),          
        },
      ),
    );
  }
}

