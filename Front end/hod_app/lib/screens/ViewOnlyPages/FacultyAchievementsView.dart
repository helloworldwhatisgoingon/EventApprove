import 'package:flutter/material.dart';
import '../descfiles/fadesc.dart';

class FacultyAchievementsView extends StatelessWidget {
  const FacultyAchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample faculty achievements data
    final List<Map<String, String>> facultyAchievements = [
      {
        "facultyName": "Dr. Jane Doe",
        "designation": "Professor",
        "dateOfAchievement": "2024-03-15",
        "recognition": "Best Paper Presentation",
        "eventName": "International Conference on AI",
        "awardName": "Best Research Paper",
        "awardingOrganization": "IEEE",
        "gpsPhoto": "JaneDoe_GPSPhoto.jpg",
        "report": "JaneDoe_Report.pdf",
        "proof": "JaneDoe_Proof.pdf",
        "certificates": "JaneDoe_Certificates.pdf",
      },
      {
        "facultyName": "Dr. John Smith",
        "designation": "Assistant Professor",
        "dateOfAchievement": "2023-12-10",
        "recognition": "Keynote Speaker",
        "eventName": "Tech Symposium 2023",
        "awardName": "Speaker of the Year",
        "awardingOrganization": "Tech Council",
        "gpsPhoto": "JohnSmith_GPSPhoto.jpg",
        "report": "JohnSmith_Report.pdf",
        "proof": "JohnSmith_Proof.pdf",
        "certificates": "JohnSmith_Certificates.pdf",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Achievements"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: facultyAchievements.length,
        itemBuilder: (context, index) {
          final achievement = facultyAchievements[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                achievement["facultyName"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "${achievement["recognition"]} (${achievement["dateOfAchievement"]})"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FADesc(details: achievement),
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
