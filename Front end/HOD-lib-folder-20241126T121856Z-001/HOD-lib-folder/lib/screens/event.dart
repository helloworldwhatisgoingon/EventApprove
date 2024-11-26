// screens/event.dart
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final Map<String, String> eventDetails;

  EventScreen({
    required this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff2f3652),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Title
            Text(
              eventDetails["title"] ?? "Event Title",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            SizedBox(height: 10),

            // Event Info Card
            Card(
              color: Color(0xfff8f9fd),
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Type", eventDetails["type"]),
                    _buildInfoRow("Faculty", eventDetails["faculty"]),
                    _buildInfoRow("Venue", eventDetails["venue"]),
                    _buildInfoRow("Date", eventDetails["date"]),
                    _buildInfoRow("Time", eventDetails["time"]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Description Section
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            SizedBox(height: 10),
            Text(
              eventDetails["description"] ??
                  "This is a detailed description of the event. Here you can explain what the event is about, the agenda, and any other relevant information attendees need to know.",
              style: TextStyle(fontSize: 16, color: Color(0xff6c757d)),
            ),
            SizedBox(height: 20),

            // Attachments Section
            Text(
              "Attachments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            SizedBox(height: 10),
            // Attached files placeholder
            Card(
              color: Color(0xffe9ecef),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.attach_file, color: Color(0xff333a56)),
                title: Text("File1.pdf"),
                subtitle: Text("PDF Document"),
                trailing: Icon(Icons.download, color: Color(0xff2196F3)),
                onTap: () {
                  // Placeholder for file download or view action
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Color(0xffe9ecef),
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.attach_file, color: Color(0xff333a56)),
                title: Text("Image.png"),
                subtitle: Text("Image File"),
                trailing: Icon(Icons.download, color: Color(0xff2196F3)),
                onTap: () {
                  // Placeholder for file download or view action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff333a56),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(color: Color(0xff6c757d)),
            ),
          ),
        ],
      ),
    );
  }
}
