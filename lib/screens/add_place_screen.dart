
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../models/place.dart';
import '../provider/great_places.dart';
import '../widget/image_input.dart';
import '../widget/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _placeLocation;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;

  }

  void _selectPlace(double lat,double lng){
    _placeLocation = PlaceLocation(latitude: lat, longitude: lng);

  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null || _placeLocation == null){
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage!,_placeLocation!);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                   TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title'
                    ),
                    
                   ),
                   SizedBox(height: 10,),
                   ImageInput(_selectImage),
                   SizedBox(height: 10,),
                   LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondary
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: MaterialStatePropertyAll(
                0
              ),
            ),
          )
        ],
      ),
    );
  }
}
