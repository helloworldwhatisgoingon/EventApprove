import 'package:flutter/material.dart';

class FADesc extends StatelessWidget {
  final Map<String, String> details;

  const FADesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievement Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Faculty Name", details["facultyName"]!),
            _buildDetailRow("Designation", details["designation"]!),
            _buildDetailRow(
                "Date of Achievement", details["dateOfAchievement"]!),
            _buildDetailRow("Recognition", details["recognition"]!),
            _buildDetailRow("Event Name", details["eventName"]!),
            _buildDetailRow("Award Name", details["awardName"]!),
            _buildDetailRow(
                "Awarding Organization", details["awardingOrganization"]!),
            _buildDetailRow("GPS Photo", details["gpsPhoto"]!),
            _buildDetailRow("Report", details["report"]!),
            _buildDetailRow("Proof", details["proof"]!),
            _buildDetailRow("Certificates", details["certificates"]!),
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
