import 'package:flutter/material.dart';
import 'package:frontend/Componentes/Pantallas/RegContent.dart';
import 'sidebar_profile.dart';

class CustomDrawer extends StatelessWidget {
  final Function(Widget) onSelectContent;

  const CustomDrawer({super.key, required this.onSelectContent});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 31, 122, 201),
            ),
            child: ProfileWidget(
              imageUrl:
                  'https://cdn.com.do/wp-content/uploads/2022/05/mozart-la-para-6272e269a17a6.jpg',
              name: 'Jose Gonzalez',
              role: 'Software Developer',
            ),
          ),
          ListTile(
            title: const Text('RegContent'),
            onTap: () {
              onSelectContent(RegContent(
                title: 'RegContent Title',
                institutions: const [
                  'Institución 1',
                  'Institución 2,',
                  'Institución 3',
                  'Institución 4,',
                  'Institución 5',
                  'Institución 6,',
                  'Institución 7',
                  'Institución 8,',
                  'Institución 9',
                  'Institución 10,'
                ],
                key: const ValueKey('reglkgContent'),
              ));
            },
          ),
          ListTile(
            title: const Text('RegConteasdnt'),
            onTap: () {
              onSelectContent(
                RegContent(
                  title: 'RegContesdasnt Title',
                  institutions: const [
                    'Institución 1',
                    'Institución 2,',
                    'Institución 3',
                    'Institución 4,',
                  ],
                  key: const ValueKey('regContent'),
                ),
              );
            },
          )
          // ... otros ListTiles para diferentes contenidos ...
        ],
      ),
    );
  }
}
