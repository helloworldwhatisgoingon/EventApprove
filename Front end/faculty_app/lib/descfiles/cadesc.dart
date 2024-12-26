import 'package:flutter/material.dart';
import 'package:faculty_app/utility.dart';


Utility utility = Utility();

class CADesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const CADesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Activity Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow("Club Name", details["clubname"], context),
            utility.buildDetailRow(
                "Activity Type", details["activitytype"], context),
            utility.buildDetailRow("Title", details["title"], context),
            utility.buildDetailRow("Date", details["activitydate"], context),
            utility.buildDetailRow(
                "Number of Days", details["numdays"].toString(), context),
            utility.buildDetailRow(
                "GPS Photos/Videos", details["gpsmedia"], context,
                isDocumentType: true),
            utility.buildDetailRow(
                "Budget Sanctioned", details["budget"].toString(), context),
            utility.buildDetailRow("Report", details["report"], context,
                isDocumentType: true),
            utility.buildDetailRow(
                "Organizers", details["organizers"], context),
            utility.buildDetailRow("Conveners", details["conveners"], context),
            utility.buildDetailRow("Feedback", details["feedback"], context,
                isDocumentType: true),
            utility.buildDetailRow(
                "Participants List", details["participantslist"], context,
                isDocumentType: true),
            utility.buildDetailRow(
                "Certificates", details["certificates"], context,
                isDocumentType: true),
            utility.buildDetailRow(
                "Speakers Details", details["speakersdetails"], context),
          ],
        ),
      ),
    );
  }
}
