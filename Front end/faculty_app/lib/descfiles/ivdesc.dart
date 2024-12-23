import 'package:flutter/material.dart';

class IVDesc extends StatelessWidget {
  final Map<String, String> details;

  const IVDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Industrial Visit Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Date of Visit", details["dateOfVisit"]!),
            _buildDetailRow("Location", details["location"]!),
            _buildDetailRow("Organizer", details["organizer"]!),
            _buildDetailRow("Participants List", details["participantsList"]!),
            _buildDetailRow("Purpose of Visit", details["purpose"]!),
            _buildDetailRow("Outcomes", details["outcomes"]!),
            _buildDetailRow("Photos/Videos", details["photosVideos"]!),
            _buildDetailRow("Report", details["report"]!),
            _buildDetailRow("Feedback from Participants", details["feedback"]!),
            _buildDetailRow("Reflection Notes", details["reflectionNotes"]!),
            _buildDetailRow("Key Topics Covered", details["keyTopicsCovered"]!),
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
