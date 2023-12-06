import 'package:flutter/material.dart';

class ModelsWiki extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Entity Wiki'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Overview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  'The Example Entity is a central component of our Flutter application. '
                  'It serves as a model for how data is structured and manipulated. '
                  'This entity is linked to various aspects of the application, such as...'
                  // More detailed explanation goes here.
                  ),
              SizedBox(height: 20),
              Text(
                'Relationships',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  'The Example Entity interacts with other components of the app in the following ways:...'
                  // Detailed explanation of relationships.
                  ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
