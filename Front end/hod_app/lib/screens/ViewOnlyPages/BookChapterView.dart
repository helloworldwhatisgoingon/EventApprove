import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/bcdesc.dart';

Repository repository = Repository();

class BookChapterView extends StatefulWidget {
  const BookChapterView({super.key});

  @override
  State<BookChapterView> createState() => _BookChapterViewState();
}

class _BookChapterViewState extends State<BookChapterView> {
  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> bookChapters = [];

  Future<void> fetchEvent() async {
    final _conf = await repository.fetchEvents('bookchapter');

    // Filter the conferences where 'approval' is null
    final filteredBookChapter =
        _conf.where((bookChapter) => bookChapter['approval'] == null).toList();

    setState(() {
      bookChapters = filteredBookChapter;
    });
  }

  Future<void> updateConference(int conferenceId, bool status) async {
    await repository.updateEventApproval(conferenceId, status);
    fetchEvent();
  }

  Future<void> deleteConference(int masterId) async {
    await repository.deleteEvent(masterId);
    fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    // Sample book chapter data

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
                chapter["papertitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Journal: ${chapter["journalname"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(chapter['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(chapter['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove chapter)
                      deleteConference(chapter['master_id']);
                      print("Delete pressed");
                    },
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
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
