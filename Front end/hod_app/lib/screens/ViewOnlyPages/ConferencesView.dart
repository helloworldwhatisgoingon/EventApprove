import 'package:flutter/material.dart';
import 'package:hod_app/repository.dart';
import '../descfiles/confdesc.dart';

Repository repository = Repository();

class ConferencesView extends StatefulWidget {
  const ConferencesView({super.key});

  @override
  State<ConferencesView> createState() => _ConferencesViewState();
}

class _ConferencesViewState extends State<ConferencesView> {
  List<Map<String, dynamic>> conferences = [];

  @override
  void initState() {
    super.initState();
    fetchConference();
  }

  Future<void> fetchConference() async {
    final _conf = await repository.fetchConference();

    // Filter the conferences where 'approval' is null
    final filteredConferences =
        _conf.where((conference) => conference['approval'] == null).toList();

    setState(() {
      conferences = filteredConferences;
    });
  }

  Future<void> updateConference(int conferenceId, bool status) async {
    final _conf = await repository.updateConferenceStatus(conferenceId, status);
    fetchConference();
  }

  Future<void> deleteConference(int conferenceId) async {
    await repository.deleteConference(conferenceId);
    fetchConference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conferences"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: conferences.length,
        itemBuilder: (context, index) {
          final conference = conferences[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(
                conference["papertitle"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(conference["conferencename"]!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(conference['conference_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(conference['conference_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove conference)
                      deleteConference(conference['conference_id']);
                      print("Delete pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDesc(details: conference),
                        ),
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDesc(details: conference),
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