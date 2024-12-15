import 'package:flutter/material.dart';

class StudentAchievementsCP extends StatelessWidget {
  const StudentAchievementsCP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Major Achievements'),
      ),
      body: const Center(
        child: Text(
          'Student Major Achievements Proposal Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
