import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/journaldesc.dart';

class JournalsView extends StatefulWidget {
  const JournalsView({super.key});

  @override
  State<JournalsView> createState() => _JournalsViewState();
}

Repository repository = Repository();

class _JournalsViewState extends State<JournalsView> {
  @override
  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<dynamic> journalData = [];

  Future<void> fetchEvent() async {
    final _conf = await repository.fetchEvents('journals');

    // Filter the Journals where 'approval' is null
    final filteredJournals =
        _conf.where((journal) => journal['approval'] == null).toList();

    setState(() {
      journalData = filteredJournals;
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

  Widget build(BuildContext context) {
    // Sample journal data

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
                journal["papertitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Journal: ${journal["journalname"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(journal['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(journal['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove journal)
                      deleteConference(journal['master_id']);
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
