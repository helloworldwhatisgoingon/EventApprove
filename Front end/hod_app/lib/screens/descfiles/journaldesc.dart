import 'package:flutter/material.dart';

class JournalDesc extends StatelessWidget {
  final Map<String, String> details;

  const JournalDesc({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Journal Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Authors with Affiliations", details["authors"]!),
            _buildDetailRow("Paper Title", details["title"]!),
            _buildDetailRow("Abstract", details["abstract"]!),
            _buildDetailRow("Journal Name", details["journalName"]!),
            _buildDetailRow("Publication Level", details["publicationLevel"]!),
            _buildDetailRow("Publication Date", details["publicationDate"]!),
            _buildDetailRow("Publisher", details["publisher"]!),
            _buildDetailRow("DOI, ISBN", details["doi"]!),
            _buildDetailRow("Attached Document", details["document"]!),
            _buildDetailRow("Proof Link", details["proofLink"]!),
            _buildDetailRow("Scopus ID/WoS ID/ORCID ID", details["scopusId"]!),
            _buildDetailRow("Impact Factor", details["impactFactor"]!),
            _buildDetailRow("Quartile", details["quartile"]!),
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
