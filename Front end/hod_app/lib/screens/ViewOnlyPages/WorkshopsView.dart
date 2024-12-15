import 'package:flutter/material.dart';
import '../descfiles/wsdesc.dart';

class WorkshopsView extends StatelessWidget {
  const WorkshopsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample workshop data
    final List<Map<String, String>> workshops = [
      {
        "workshopTitle": "AI and Machine Learning Workshop",
        "mode": "Offline",
        "brochure": "AI_ML_Workshop_Brochure.pdf",
        "date": "2024-01-15 to 2024-01-17",
        "numDays": "3",
        "gpsPhotos": "AI_ML_Workshop_Photos.zip",
        "report": "AI_ML_Workshop_Report.pdf",
        "organizers": "Dr. A, Dr. B",
        "conveners": "Prof. X, Prof. Y",
        "feedback": "AI_ML_Workshop_Feedback.pdf",
        "participantsList": "AI_ML_Workshop_Participants.pdf",
        "certificates": "AI_ML_Workshop_Certificates.zip",
        "amountSanctioned": "₹1,50,000",
        "facultyReceivingAmount": "Prof. X",
        "expenditureReport": "AI_ML_Workshop_Expenditure.pdf",
        "speakers": "Dr. John Doe, Dr. Jane Smith",
      },
      {
        "workshopTitle": "Cybersecurity Essentials",
        "mode": "Online",
        "brochure": "Cybersecurity_Workshop_Brochure.pdf",
        "date": "2024-02-10",
        "numDays": "1",
        "gpsPhotos": "Cybersecurity_Workshop_Photos.zip",
        "report": "Cybersecurity_Workshop_Report.pdf",
        "organizers": "Dr. C, Dr. D",
        "conveners": "Prof. Z",
        "feedback": "Cybersecurity_Workshop_Feedback.pdf",
        "participantsList": "Cybersecurity_Workshop_Participants.pdf",
        "certificates": "Cybersecurity_Workshop_Certificates.zip",
        "amountSanctioned": "₹50,000",
        "facultyReceivingAmount": "Prof. Z",
        "expenditureReport": "Cybersecurity_Workshop_Expenditure.pdf",
        "speakers": "Dr. Alice, Dr. Bob",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshops"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final workshop = workshops[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                workshop["workshopTitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Mode: ${workshop["mode"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WSDesc(details: workshop),
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
