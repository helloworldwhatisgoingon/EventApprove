import 'package:flutter/material.dart';
import '../descfiles/patentdesc.dart';

class PatentsView extends StatelessWidget {
  const PatentsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample patent data
    final List<Map<String, String>> patents = [
      {
        "applicationNumber": "12345",
        "patentNumber": "US987654321",
        "title": "AI-Based Traffic Management System",
        "inventors": "Dr. X, Dr. Y",
        "patenteeName": "Dayananda Sagar University",
        "filingDate": "2023-01-10",
        "status": "Granted",
        "patentCountry": "USA",
        "publicationDate": "2023-06-15",
        "abstract":
            "An AI-powered traffic management system to optimize flow and reduce congestion.",
        "url": "https://patents.example.com/US987654321",
        "document": "TrafficAI_Patent.pdf",
      },
      {
        "applicationNumber": "67890",
        "patentNumber": "IN87654321",
        "title": "Solar-Powered Water Purification Device",
        "inventors": "Prof. A, Prof. B",
        "patenteeName": "Dayananda Sagar University",
        "filingDate": "2022-03-05",
        "status": "Published",
        "patentCountry": "India",
        "publicationDate": "2022-12-01",
        "abstract":
            "A portable solar-powered device designed to purify water in remote areas.",
        "url": "https://patents.example.com/IN87654321",
        "document": "SolarWaterPurifier_Patent.pdf",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patents"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: patents.length,
        itemBuilder: (context, index) {
          final patent = patents[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                patent["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Application No: ${patent["applicationNumber"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatentDesc(details: patent),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
