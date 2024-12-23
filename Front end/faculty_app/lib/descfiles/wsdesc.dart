import 'package:faculty_app/utility.dart';
import 'package:flutter/material.dart';

Utility utility = Utility();

class WSDesc extends StatelessWidget {
  final Map<String, dynamic> details;

  const WSDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshop Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDetailRow(
                "Workshop Title",
                details["workshoptitle"] ?? "Not provided",
                context,
              ),
              _buildDetailRow(
                "Mode",
                details["mode"] ?? "Not provided",
                context,
              ),
              if (details["brochure"] != null)
                _buildDetailRow(
                  "Brochure",
                  details["brochure"]!,
                  context,
                ),
              _buildDetailRow(
                "Date",
                details["dates"] ?? "Not provided",
                context,
              ),
              _buildDetailRow(
                "Number of Days",
                details["days"] ?? "Not provided",
                context,
              ),
              if (details["gpsmedia"] != null)
                _buildDetailRow(
                  "GPS Photos",
                  details["gpsmedia"]!,
                  context,
                ),
              if (details["report"] != null)
                _buildDetailRow(
                  "Report",
                  details["report"]!,
                  context,
                ),
              _buildDetailRow(
                "Organizers",
                details["organizers"] ?? "Not provided",
                context,
              ),
              _buildDetailRow(
                "Conveners",
                details["conveners"] ?? "Not provided",
                context,
              ),
              if (details["feedback"] != null)
                _buildDetailRow(
                  "Feedback",
                  details["feedback"]!,
                  context,
                ),
              if (details["participantslist"] != null)
                _buildDetailRow(
                  "Participants List",
                  details["participantslist"]!,
                  context,
                ),
              if (details["certificates"] != null)
                _buildDetailRow(
                  "Certificates",
                  details["certificates"]!,
                  context,
                ),
              _buildDetailRow(
                "Amount Sanctioned",
                details["sanctionedamount"] ?? "Not provided",
                context,
              ),
              _buildDetailRow(
                "Faculty Receiving Sanctioned Amount",
                details["facultyreceivingamount"] ?? "Not provided",
                context,
              ),
              if (details["expenditurereport"] != null)
                _buildDetailRow(
                  "Expenditure Report with Receipts",
                  details["expenditurereport"]!,
                  context,
                ),
              _buildDetailRow(
                "Details of Speakers/Resource Persons",
                details["speakersdetails"] ?? "Not provided",
                context,
              ),
            ],
          )),
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Visibility(
              visible: label != 'Brochure' &&
                  label != 'GPS Photos' &&
                  label != 'Report' &&
                  label != 'Feedback' &&
                  label != 'Participants List' &&
                  label != 'Certificates' &&
                  label != 'Expenditure Report with Receipts',
              replacement: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    utility.viewDocument(
                      value,
                      label,
                      context,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Document downloaded successfully!"),
                      ),
                    );
                  },
                  child: const Text("Download Attachment"),
                ),
              ),
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
