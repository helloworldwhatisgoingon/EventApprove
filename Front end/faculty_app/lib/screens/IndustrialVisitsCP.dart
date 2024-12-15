import 'package:flutter/material.dart';

class IndustrialVisitsCP extends StatelessWidget {
  const IndustrialVisitsCP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Industrial Visits'),
      ),
      body: const Center(
        child: Text(
          'Industrial Visits Proposal Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
