import 'package:flutter/material.dart';
import '../descfiles/bcdesc.dart';

class BookChapterView extends StatelessWidget {
  const BookChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample book chapter data
    final List<Map<String, String>> bookChapters = [
      {
        "authors": "Author X, Author Y",
        "title": "Advances in Machine Learning",
        "abstract": "This chapter explores advanced ML techniques...",
        "journalName": "Machine Learning Journal",
        "publicationLevel": "International",
        "publicationDate": "October 2023",
        "publisher": "Springer",
        "doi": "10.1007/exampledoi",
        "document": "AdvancesInML.pdf",
        "proofLink": "https://scopus.com/example-proof",
        "scopusId": "112233",
      },
      {
        "authors": "Author A, Author B",
        "title": "Applications of AI in Healthcare",
        "abstract": "This chapter delves into AI applications in healthcare...",
        "journalName": "Healthcare AI Journal",
        "publicationLevel": "National",
        "publicationDate": "December 2022",
        "publisher": "IEEE",
        "doi": "10.5678/anotherdoi",
        "document": "AIHealthcare.pdf",
        "proofLink": "https://wos.com/another-proof",
        "scopusId": "445566",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Chapters"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: bookChapters.length,
        itemBuilder: (context, index) {
          final chapter = bookChapters[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                chapter["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Journal: ${chapter["journalName"]}"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BCDesc(details: chapter),
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
