import 'package:flutter/material.dart';
import '../descfiles/fddesc.dart';

class FDView extends StatelessWidget {
  const FDView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample FDP data
    final List<Map<String, String>> fdps = [
      {
        "fdpTitle": "Advanced AI Techniques",
        "mode": "Offline",
        "brochure": "AI_FDP_Brochure.pdf",
        "date": "2024-03-10 to 2024-03-15",
        "numDays": "5",
        "gpsPhotos": "AI_FDP_Photos.zip",
        "report": "AI_FDP_Report.pdf",
        "organizers": "Dr. A, Dr. B",
        "conveners": "Prof. X",
        "feedback": "AI_FDP_Feedback.pdf",
        "participantsList": "AI_FDP_Participants.pdf",
        "certificates": "AI_FDP_Certificates.zip",
        "amountSanctioned": "₹2,00,000",
        "facultyReceivingAmount": "Prof. X",
        "expenditureReport": "AI_FDP_Expenditure.pdf",
        "speakers": "Dr. John Doe, Dr. Jane Smith",
        "sponsorship": "TechCorp Inc.",
      },
      {
        "fdpTitle": "Cybersecurity Essentials",
        "mode": "Online",
        "brochure": "Cybersecurity_FDP_Brochure.pdf",
        "date": "2024-04-01 to 2024-04-02",
        "numDays": "2",
        "gpsPhotos": "Cybersecurity_FDP_Photos.zip",
        "report": "Cybersecurity_FDP_Report.pdf",
        "organizers": "Dr. C, Dr. D",
        "conveners": "Prof. Y",
        "feedback": "Cybersecurity_FDP_Feedback.pdf",
        "participantsList": "Cybersecurity_FDP_Participants.pdf",
        "certificates": "Cybersecurity_FDP_Certificates.zip",
        "amountSanctioned": "₹1,00,000",
        "facultyReceivingAmount": "Prof. Y",
        "expenditureReport": "Cybersecurity_FDP_Expenditure.pdf",
        "speakers": "Dr. Alice, Dr. Bob",
        "sponsorship": "SecureNet Pvt. Ltd.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Development Programs"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: fdps.length,
        itemBuilder: (context, index) {
          final fdp = fdps[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                fdp["fdpTitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Mode: ${fdp["mode"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FDDesc(details: fdp),
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
