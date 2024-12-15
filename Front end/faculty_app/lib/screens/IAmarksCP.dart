import 'package:flutter/material.dart';

class IAmarksCP extends StatelessWidget {
  const IAmarksCP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IA Marks'),
      ),
      body: const Center(
        child: Text(
          'IA Marks Proposal Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
