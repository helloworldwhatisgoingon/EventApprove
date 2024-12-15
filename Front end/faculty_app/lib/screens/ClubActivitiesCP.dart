import 'package:flutter/material.dart';

class ClubActivitiesCP extends StatelessWidget {
  const ClubActivitiesCP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Activities'),
      ),
      body: const Center(
        child: Text(
          'Club Activities Proposal Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
