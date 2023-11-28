import 'package:flutter/material.dart';
import 'package:frontend/Content.dart';
import 'sidebar_profile.dart';

class CustomDrawer extends StatelessWidget {
  final Function(Widget) onSelectContent;

  CustomDrawer({required this.onSelectContent});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        color: Colors.grey, // Aplica el color a todo el Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ProfileWidget(
                imageUrl:
                    'https://cdn.com.do/wp-content/uploads/2022/05/mozart-la-para-6272e269a17a6.jpg',
                name: 'Jose Gonzalez',
                role: 'Software Developer',
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 122, 201),
              ),
            ),
            ListTile(
              title: Text('Instituciones'),
              onTap: () {
                onSelectContent(ContentWidgetOne());
              },
            ),
            ListTile(
              title: Text('Modelos Predictivos'),
              onTap: () {
                onSelectContent(ContentWidgetTwo());
              },
            ),
            ListTile(
              title: Text('Reportes'),
              onTap: () {
                onSelectContent(ContentWidgetThree());
              },
            ),

            // Añade más ítems aquí
          ],
        ),
      ),
    );
  }
}
