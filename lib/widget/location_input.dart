import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
   LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try{
         final locaData = await Location().getLocation();
    _showPreview(locaData.latitude!, locaData.longitude!);
    widget.onSelectPlace(locaData.latitude,locaData.longitude);
    }catch(error){
      return;

    }
 
  }

  Future<void> _selectOnMap() async {
    
   final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
    fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              isSelecting: true,
            )));
      if(selectedLocation == null ){
        return;
      }
      _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      widget.onSelectPlace(selectedLocation.latitude,selectedLocation.latitude);
      //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          width: double.infinity,
          height: 170,
          child: _previewImageUrl == null
              ? Text(
                  'No location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary)),
              icon: Icon(Icons.map),
              onPressed: _getCurrentUserLocation,
              label: Text('Current location'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary)),
              icon: Icon(Icons.location_on),
              onPressed: _selectOnMap,
              label: Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
