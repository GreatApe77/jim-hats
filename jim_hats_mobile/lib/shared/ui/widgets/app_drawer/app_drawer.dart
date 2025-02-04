import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text('Username'),
          ),
          Divider(
            height: 32,
          ),
          ...List.generate(
            2,
            (index) => ListTile(
              title: Text('$index'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Create group'),
          ),
          ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text('Join group'),
          ),
          ListTile(
          
            leading: Icon(Icons.flag_outlined),
            title: Text('Completed challenges'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & feedback'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
