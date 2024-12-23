import 'package:flutter/material.dart';

class PatentDesc extends StatelessWidget {
  final Map<String, String> details;

  const PatentDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patent Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
                "Application Number", details["applicationNumber"]!),
            _buildDetailRow("Patent Number", details["patentNumber"]!),
            _buildDetailRow("Title", details["title"]!),
            _buildDetailRow("Inventor(s)", details["inventors"]!),
            _buildDetailRow("Patentee Name", details["patenteeName"]!),
            _buildDetailRow("Filing Date", details["filingDate"]!),
            _buildDetailRow("Status", details["status"]!),
            _buildDetailRow("Patent Country", details["patentCountry"]!),
            _buildDetailRow(
                "Publication/Granted Date", details["publicationDate"]!),
            _buildDetailRow("Abstract", details["abstract"]!),
            _buildDetailRow("Patent URL", details["url"]!),
            _buildDetailRow("Attached Document", details["document"]!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Document downloaded successfully!"),
                  ),
                );
              },
              child: const Text("Download Document"),
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
