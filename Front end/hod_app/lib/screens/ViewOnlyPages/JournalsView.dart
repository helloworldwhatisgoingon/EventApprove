import 'package:flutter/material.dart';
import '../descfiles/journaldesc.dart';

class JournalsView extends StatelessWidget {
  const JournalsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample journal data
    final List<Map<String, String>> journalData = [
      {
        "authors": "Author A, Author B",
        "title": "Research on AI",
        "abstract": "This study focuses on AI and its impact...",
        "journalName": "AI Journal",
        "publicationLevel": "International",
        "publicationDate": "July 2024",
        "publisher": "Springer",
        "doi": "10.1234/exampledoi",
        "document": "AI_Research.pdf",
        "proofLink": "https://scopus.com/example-proof",
        "scopusId": "12345",
        "impactFactor": "5.2",
        "quartile": "Q1",
      },
      {
        "authors": "Author C, Author D",
        "title": "Deep Learning Advances",
        "abstract": "This paper explores deep learning techniques...",
        "journalName": "Deep Learning Journal",
        "publicationLevel": "National",
        "publicationDate": "August 2023",
        "publisher": "IEEE",
        "doi": "10.5678/exampledoi",
        "document": "DeepLearning.pdf",
        "proofLink": "https://wos.com/example-proof",
        "scopusId": "67890",
        "impactFactor": "3.8",
        "quartile": "Q2",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Journals"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: journalData.length,
        itemBuilder: (context, index) {
          final journal = journalData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                journal["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Journal: ${journal["journalName"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JournalDesc(details: journal),
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
