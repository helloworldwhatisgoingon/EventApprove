import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final Map<String, dynamic> eventDetails;

  EventScreen({
    required this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Event Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff2f3652),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Title
            Text(
              eventDetails["eventTitle"] ?? "Event Title",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),

            // Event Info Card
            Card(
              color: const Color(0xfff8f9fd),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Type", eventDetails["eventType"]),
                    _buildInfoRow("Faculty", eventDetails["faculty"]),
                    _buildInfoRow("Venue", eventDetails["location"]),
                    _buildInfoRow("Date", eventDetails["startDate"]),
                    _buildInfoRow("Time", eventDetails["timings"]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              eventDetails["description"] ?? "Currently Unavailable",
              style: const TextStyle(fontSize: 16, color: Color(0xff6c757d)),
            ),
            const SizedBox(height: 20),

            // Attachments Section
            const Text(
              "Attachments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),

            // Dynamically load attachments
            buildAttachments(eventDetails["eventPDF"] ?? []),
          ],
        ),
      ),
    );
  }

  Widget buildAttachments(dynamic eventPDFData) {
    List<Map<String, String>> attachments = [];

    if (eventPDFData is String) {
      // Convert Base64 string into a single attachment
      attachments = [
        {"base64PDF": eventPDFData, "eventTitle": "Attachment 1"}
      ];
    } else if (eventPDFData is List) {
      // Assume eventPDFData is already a list of maps
      attachments = List<Map<String, String>>.from(eventPDFData);
    }

    if (attachments.isEmpty) {
      return const Text(
        'No attachments available.',
        style: TextStyle(fontSize: 16, color: Color(0xff6c757d)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attachments.length,
      itemBuilder: (context, index) {
        final fileData = attachments[index];
        final fileName = fileData['eventTitle'] ?? 'Document';
        final base64PDF = fileData['base64PDF'];

        return Card(
          color: const Color(0xffe9ecef),
          elevation: 2,
          child: ListTile(
            leading: const Icon(Icons.attach_file, color: Color(0xff333a56)),
            title: Text(fileName),
            subtitle: const Text("PDF Document"),
            trailing: const Icon(Icons.download, color: Color(0xff2196F3)),
            onTap: () {
              if (base64PDF != null) {
                _viewDocument(base64PDF, fileName, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No document found.')),
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isWindows) {
      return Directory('${Platform.environment['USERPROFILE']}\\Downloads');
    } else if (Platform.isLinux || Platform.isMacOS) {
      return Directory('${Platform.environment['HOME']}/Downloads');
    }
    return null;
  }

  Future<void> _viewDocument(
      String base64PDF, String fileName, BuildContext context) async {
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

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff333a56),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: const TextStyle(color: Color(0xff6c757d)),
            ),
          ),
        ],
      ),
    );
  }
}
