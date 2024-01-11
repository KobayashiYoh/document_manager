import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('1-1'),
          ),
          Divider(),
          ListTile(
            title: Text('1-2'),
          ),
          Divider(),
          ListTile(
            title: Text('1-3'),
          ),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
