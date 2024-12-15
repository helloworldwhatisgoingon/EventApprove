import 'package:flutter/material.dart';

class IAmarksView extends StatelessWidget {
  const IAmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IA Marks")),
      body: const Center(
        child: Text(
          "This is the IA Marks View File",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
