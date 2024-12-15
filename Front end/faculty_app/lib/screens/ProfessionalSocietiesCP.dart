import 'package:flutter/material.dart';

class ProfessionalSocietiesCP extends StatelessWidget {
  const ProfessionalSocietiesCP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Societies Activities'),
      ),
      body: const Center(
        child: Text(
          'Professional Societies Activities Proposal Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
