import 'package:flutter/material.dart';

class PSDesc extends StatelessWidget {
  final Map<String, String> details;

  const PSDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Professional Society Activity Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Society Name", details["societyName"]!),
            _buildDetailRow("Mode", details["mode"]!),
            _buildDetailRow("Activity Type", details["activityType"]!),
            _buildDetailRow("Date", details["date"]!),
            _buildDetailRow("Number of Days", details["numberOfDays"]!),
            _buildDetailRow("GPS Photos/Videos", details["gpsPhotosVideos"]!),
            _buildDetailRow("Budget Sanctioned", details["budgetSanctioned"]!),
            _buildDetailRow("Report", details["report"]!),
            _buildDetailRow("Organizers", details["organizers"]!),
            _buildDetailRow("Conveners", details["conveners"]!),
            _buildDetailRow("Feedback", details["feedback"]!),
            _buildDetailRow("Participants List", details["participantsList"]!),
            _buildDetailRow("Certificates", details["certificates"]!),
            _buildDetailRow("Speakers Details", details["speakersDetails"]!),
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
