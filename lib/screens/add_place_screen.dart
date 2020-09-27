import 'package:flutter/material.dart';
import 'package:place_app/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
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
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                   SizedBox(height: 10,),
                   ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
              icon: Icon(Icons.add),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text('Add Place'),
              color: Theme.of(context).accentColor,
              onPressed: () {})
        ],
      ),
    );
  }
}
