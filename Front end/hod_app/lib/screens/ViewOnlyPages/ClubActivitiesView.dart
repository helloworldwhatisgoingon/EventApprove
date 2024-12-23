import 'package:flutter/material.dart';
import '../descfiles/cadesc.dart'; // Correct path for cadesc.dart

class ClubActivitiesView extends StatelessWidget {
  const ClubActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> clubActivities = [
      {
        "clubName": "AI Enthusiasts Club",
        "activityType": "Workshop",
        "title": "Introduction to AI",
        "date": "2024-07-01 to 2024-07-02",
        "numDays": "2",
        "gpsPhotos": "AI_Workshop_Photos.zip",
        "budgetSanctioned": "₹50,000",
        "report": "AI_Workshop_Report.pdf",
        "organizers": "Dr. Techno, Prof. Logic",
        "conveners": "Prof. Neural",
        "feedback": "AI_Workshop_Feedback.pdf",
        "participantsList": "AI_Workshop_Participants.pdf",
        "certificates": "AI_Workshop_Certificates.zip",
        "speakers": "Dr. Alan AI, Dr. Ada Data",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Activities"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: clubActivities.length,
        itemBuilder: (context, index) {
          final activity = clubActivities[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                activity["title"] ?? "No Title",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("Activity Type: ${activity["activityType"] ?? "N/A"}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CADesc(details: activity),
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
