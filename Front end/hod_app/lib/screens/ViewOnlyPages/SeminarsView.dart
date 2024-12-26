import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/seminardesc.dart';

class SeminarsView extends StatefulWidget {
  const SeminarsView({super.key});

  @override
  State<SeminarsView> createState() => _SeminarsViewState();
}

class _SeminarsViewState extends State<SeminarsView> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> seminars = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('seminar');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      seminars = filteredEvent;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seminars"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: seminars.length,
        itemBuilder: (context, index) {
          final seminar = seminars[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                seminar["seminartitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Mode: ${seminar["mode"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(seminar['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(seminar['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove seminar)
                      deleteConference(seminar['master_id']);
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
                    builder: (context) => SeminarDesc(details: seminar),
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
