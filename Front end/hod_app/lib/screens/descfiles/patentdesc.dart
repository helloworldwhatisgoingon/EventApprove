import 'package:flutter/material.dart';
import 'package:hod_app/screens/descfiles/wsdesc.dart';

class PatentDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const PatentDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patent Details"),
        backgroundColor: const Color(0xffcc9f1f),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            utility.buildDetailRow(
                "Application Number", details["applicationnumber"]!, context),
            utility.buildDetailRow(
                "Patent Number", details["patentnumber"]!, context),
            utility.buildDetailRow("Title", details["title"]!, context),
            utility.buildDetailRow(
                "Inventor(s)", details["inventors"]!, context),
            utility.buildDetailRow(
                "Patentee Name", details["patenteename"]!, context),
            utility.buildDetailRow(
                "Filing Date", details["filingdate"]!, context),
            utility.buildDetailRow("Status", details["status"]!, context),
            utility.buildDetailRow(
                "Patent Country", details["patentcountry"]!, context),
            utility.buildDetailRow("Publication/Granted Date",
                details["publicationdate"]!, context),
            utility.buildDetailRow("Abstract", details["abstract"]!, context),
            utility.buildDetailRow("Patent URL", details["url"]!, context),
            utility.buildDetailRow(
                "Attached Document", details["document"]!, context,
                isDocumentType: true, documentName: details['documentname']),
          ],
        ),
      ),
    );
  }
}
