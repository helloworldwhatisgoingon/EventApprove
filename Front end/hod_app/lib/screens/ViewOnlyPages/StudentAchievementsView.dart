import 'package:flutter/material.dart';
import '../descfiles/sadesc.dart';

class StudentAchievementsView extends StatelessWidget {
  const StudentAchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample student achievements data
    final List<Map<String, String>> studentAchievements = [
      {
        "studentNames": "Alice Johnson, Bob Smith",
        "usns": "1RV21CS001, 1RV21CS002",
        "yearOfStudy": "Third Year",
        "eventType": "Hackathon",
        "eventTitle": "AI Innovation Challenge",
        "dateOfAchievement": "2024-04-12",
        "companyOrganization": "Google",
        "recognition": "First Place",
        "certificateProof": "AIChallenge_Certificate.pdf",
        "gpsPhoto": "AIChallenge_GPSPhoto.jpg",
        "report": "AIChallenge_Report.pdf",
      },
      {
        "studentNames": "Emily Davis",
        "usns": "1RV21CS010",
        "yearOfStudy": "Final Year",
        "eventType": "Project Expo",
        "eventTitle": "Tech Vision 2024",
        "dateOfAchievement": "2024-06-05",
        "companyOrganization": "Microsoft",
        "recognition": "Second Place",
        "certificateProof": "TechVision_Certificate.pdf",
        "gpsPhoto": "TechVision_GPSPhoto.jpg",
        "report": "TechVision_Report.pdf",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Achievements"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: studentAchievements.length,
        itemBuilder: (context, index) {
          final achievement = studentAchievements[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                achievement["eventTitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "${achievement["eventType"]} (${achievement["dateOfAchievement"]})"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SADesc(details: achievement),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
