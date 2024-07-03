import 'package:flutter/material.dart';
import 'package:notesapp/components/drawer_tile.dart';
import 'package:notesapp/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide.none
              ),
            ),
            child: Icon(Icons.note),
          ),
          const SizedBox(height: 25,),
          //notes file
            DrawerTile(title: 'Notes', leading: const Icon(Icons.notes), onTap: () {
              Navigator.pop(context);
            }),

            //settings file
          DrawerTile(title: 'Settings', leading: const Icon(Icons.settings), onTap: () {
            //pop the menu draw
            Navigator.pop(context);
            //move to settings file
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => SettingsPage(),
            ),
            );
          }),
        ],
      )
    );
  }
}
