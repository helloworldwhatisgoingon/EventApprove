import 'package:flutter/material.dart';
import '../descfiles/PSdesc.dart';

class ProfessionalSocietiesView extends StatelessWidget {
  const ProfessionalSocietiesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample professional societies activity data
    final List<Map<String, String>> professionalSocieties = [
      {
        "societyName": "IEEE CS",
        "mode": "Offline",
        "activityType": "Workshop",
        "date": "2024-03-20",
        "numberOfDays": "2",
        "gpsPhotosVideos": "IEEEWorkshop_Photos.zip",
        "budgetSanctioned": "\$2000",
        "report": "IEEEWorkshop_Report.pdf",
        "organizers": "Prof. Alice Johnson, Dr. Bob Smith",
        "conveners": "Prof. John Doe, Prof. Emily Davis",
        "feedback": "IEEEWorkshop_Feedback.pdf",
        "participantsList": "IEEEWorkshop_ParticipantsList.pdf",
        "certificates": "IEEEWorkshop_Certificates.pdf",
        "speakersDetails": "Dr. Richard Brown, AI Specialist",
      },
      {
        "societyName": "ACM",
        "mode": "Online",
        "activityType": "Hackathon",
        "date": "2024-05-15",
        "numberOfDays": "3",
        "gpsPhotosVideos": "ACMHackathon_Photos.zip",
        "budgetSanctioned": "\$1500",
        "report": "ACMHackathon_Report.pdf",
        "organizers": "Dr. Sarah Lee, Prof. Mark Taylor",
        "conveners": "Prof. Linda Green",
        "feedback": "ACMHackathon_Feedback.pdf",
        "participantsList": "ACMHackathon_ParticipantsList.pdf",
        "certificates": "ACMHackathon_Certificates.pdf",
        "speakersDetails": "Mr. Alan Turing, Tech Consultant",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Professional Societies Activities"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: professionalSocieties.length,
        itemBuilder: (context, index) {
          final activity = professionalSocieties[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                activity["societyName"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("${activity["activityType"]} (${activity["date"]})"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PSDesc(details: activity),
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
