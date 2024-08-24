import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.email});

  // const CustomDrawer({super.key, required this.email, required this.username});
  final String email;
  // final String username;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.red,
                ],
              ),
            ),
            child: Column(
              // mainAxisAlignm,
              children: [
                const Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                Text(email),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('HomePage'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: ListTile(
              title: const Text('Sign Out'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
