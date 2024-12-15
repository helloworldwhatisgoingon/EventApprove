import 'package:flutter/material.dart';
import '../descfiles/seminardesc.dart';

class SeminarsView extends StatelessWidget {
  const SeminarsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample seminar data
    final List<Map<String, String>> seminars = [
      {
        "seminarTitle": "Sustainable Development Goals",
        "mode": "Offline",
        "brochure": "SDG_Seminar_Brochure.pdf",
        "date": "2024-05-01 to 2024-05-02",
        "numDays": "2",
        "gpsPhotos": "SDG_Seminar_Photos.zip",
        "report": "SDG_Seminar_Report.pdf",
        "organizers": "Dr. Green, Dr. Greenfield",
        "conveners": "Prof. Oak",
        "feedback": "SDG_Seminar_Feedback.pdf",
        "participantsList": "SDG_Seminar_Participants.pdf",
        "certificates": "SDG_Seminar_Certificates.zip",
        "amountSanctioned": "₹1,50,000",
        "facultyReceivingAmount": "Prof. Oak",
        "expenditureReport": "SDG_Seminar_Expenditure.pdf",
        "speakers": "Dr. John Eco, Dr. Lisa Bloom",
      },
      {
        "seminarTitle": "AI and Ethics",
        "mode": "Online",
        "brochure": "AI_Ethics_Seminar_Brochure.pdf",
        "date": "2024-06-10 to 2024-06-12",
        "numDays": "3",
        "gpsPhotos": "AI_Ethics_Seminar_Photos.zip",
        "report": "AI_Ethics_Seminar_Report.pdf",
        "organizers": "Dr. Doe, Dr. White",
        "conveners": "Prof. Black",
        "feedback": "AI_Ethics_Seminar_Feedback.pdf",
        "participantsList": "AI_Ethics_Seminar_Participants.pdf",
        "certificates": "AI_Ethics_Seminar_Certificates.zip",
        "amountSanctioned": "₹2,00,000",
        "facultyReceivingAmount": "Prof. Black",
        "expenditureReport": "AI_Ethics_Seminar_Expenditure.pdf",
        "speakers": "Dr. Alan Turing, Dr. Ada Lovelace",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seminars"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: seminars.length,
        itemBuilder: (context, index) {
          final seminar = seminars[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                seminar["seminarTitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Mode: ${seminar["mode"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeminarDesc(details: seminar),
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
