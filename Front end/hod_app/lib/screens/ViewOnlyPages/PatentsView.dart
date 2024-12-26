import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/patentdesc.dart';

class PatentsView extends StatefulWidget {
  const PatentsView({super.key});

  @override
  State<PatentsView> createState() => _PatentsViewState();
}

class _PatentsViewState extends State<PatentsView> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> patents = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('patents');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      patents = filteredEvent;
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
    // Sample patent data
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
              subtitle: Text("Application No: ${patent["applicationnumber"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(patent['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(patent['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove patent)
                      deleteConference(patent['master_id']);
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
