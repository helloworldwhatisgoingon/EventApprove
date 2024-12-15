import 'package:flutter/material.dart';
import '../descfiles/ivdesc.dart';

class IndustrialVisitsView extends StatelessWidget {
  const IndustrialVisitsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample industrial visits data
    final List<Map<String, String>> industrialVisits = [
      {
        "dateOfVisit": "2024-05-10",
        "location": "Bangalore, Karnataka",
        "organizer": "Prof. John Doe",
        "participantsList": "Visit_Participants.pdf",
        "purpose": "Learn about industrial automation in manufacturing.",
        "outcomes": "Gained insights into automated systems and workflows.",
        "photosVideos": "IndustrialVisit_Photos.zip",
        "report": "IndustrialVisit_Report.pdf",
        "feedback": "IndustrialVisit_Feedback.pdf",
        "reflectionNotes": "Discussed improvements in workflow systems.",
        "keyTopicsCovered": "Automation, Robotics, Workflow Efficiency",
      },
      {
        "dateOfVisit": "2024-07-15",
        "location": "Hyderabad, Telangana",
        "organizer": "Dr. Smith",
        "participantsList": "HyderabadVisit_Participants.pdf",
        "purpose": "Understand pharmaceutical manufacturing processes.",
        "outcomes": "Learned key steps in drug formulation and testing.",
        "photosVideos": "PharmaVisit_Photos.zip",
        "report": "PharmaVisit_Report.pdf",
        "feedback": "PharmaVisit_Feedback.pdf",
        "reflectionNotes": "Explored career opportunities in pharmaceuticals.",
        "keyTopicsCovered": "Formulation, Quality Control, R&D",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Industrial Visits"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: industrialVisits.length,
        itemBuilder: (context, index) {
          final visit = industrialVisits[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                visit["location"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Date of Visit: ${visit["dateOfVisit"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IVDesc(details: visit),
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
