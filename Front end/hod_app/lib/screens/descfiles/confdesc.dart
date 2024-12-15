import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class EventDesc extends StatefulWidget {
  final Map<String, dynamic> details;

  const EventDesc({super.key, required this.details});

  @override
  State<EventDesc> createState() => _EventDescState();
}

class _EventDescState extends State<EventDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conference Details"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Paper Title", widget.details["papertitle"]!),
            _buildDetailRow("Abstract", widget.details["abstract"]!),
            _buildDetailRow(
                "Conference Name", widget.details["conferencename"]!),
            _buildDetailRow(
                "Publication Level", widget.details["publicationlevel"]!),
            _buildDetailRow(
                "Publication Date", widget.details["publicationdate"]!),
            _buildDetailRow("Publisher", widget.details["publisher"]!),
            _buildDetailRow("DOI, ISBN", widget.details["doiisbn"]!),
            _buildDetailRow("Proof Link", widget.details["prooflink"]!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final base64Document = widget.details[
                    "document"]!; // Assuming it's a base64 string or document URL
                _viewDocument(
                    base64Document,
                    widget.details["papertitle"] ??
                        'Document'); // Handle document viewing or downloading
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

  Future<void> _viewDocument(String base64PDF, String fileName) async {
    try {
      // Decode the Base64 string to bytes
      Uint8List bytes = base64Decode(base64PDF);

      // Get the Downloads directory
      final downloadsDir = await getDownloadsDirectory();
      if (downloadsDir == null) {
        throw 'Downloads directory not found';
      }

      // Create a file path in the Downloads directory
      final filePath = '${downloadsDir.path}/$fileName.pdf';

      // Write the bytes to a file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File saved to Downloads: $fileName.pdf')),
      );
    } catch (e) {
      debugPrint('Error viewing document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving document: $e')),
      );
    }
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isWindows) {
      return Directory('${Platform.environment['USERPROFILE']}\\Downloads');
    } else if (Platform.isLinux || Platform.isMacOS) {
      return Directory('${Platform.environment['HOME']}/Downloads');
    }
    return null;
  }
}
