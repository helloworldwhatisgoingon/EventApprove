import 'package:flutter/material.dart';

class SADesc extends StatelessWidget {
  final Map<String, String> details;

  const SADesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Achievement Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Names of Students", details["studentNames"]!),
            _buildDetailRow("USNs", details["usns"]!),
            _buildDetailRow("Year of Study", details["yearOfStudy"]!),
            _buildDetailRow("Event Type", details["eventType"]!),
            _buildDetailRow("Event Title", details["eventTitle"]!),
            _buildDetailRow(
                "Date of Achievement", details["dateOfAchievement"]!),
            _buildDetailRow(
                "Company/Organization", details["companyOrganization"]!),
            _buildDetailRow("Recognition", details["recognition"]!),
            _buildDetailRow("Certificate Proof", details["certificateProof"]!),
            _buildDetailRow("GPS Photo", details["gpsPhoto"]!),
            _buildDetailRow("Report", details["report"]!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Attachments downloaded successfully!"),
                  ),
                );
              },
              child: const Text("Download Attachments"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
