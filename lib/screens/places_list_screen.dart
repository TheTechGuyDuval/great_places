import 'package:flutter/material.dart';
import '../provider/great_places.dart';
import '../screens/add_place_screen.dart';
import '../screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: Text('Got no places yet start adding some!'),
                  builder: (context, greatPlaces, ch) =>
                      greatPlaces.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                subtitle: Text(greatPlaces.items[index].location!.address!),
                                onTap: () {
                                  Navigator.of(context).pushNamed(PlaceDetailScreen.routeName,arguments: {greatPlaces.items[index].id});
                                  //go to detail page...
                                },
                              ),
                            ),
                ),
        ));
  }
}
