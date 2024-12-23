import 'package:flutter/material.dart';
import '../descfiles/wsdesc.dart';
import 'package:hod_app/screens/repository.dart';

Repository repository = Repository();

class WorkshopsView extends StatefulWidget {
  const WorkshopsView({super.key});

  @override
  State<WorkshopsView> createState() => _WorkshopsViewState();
}

class _WorkshopsViewState extends State<WorkshopsView> {
  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> workshops = [];

  Future<void> fetchEvent() async {
    final _conf = await repository.fetchEvents('workshop');

    // Filter the conferences where 'approval' is null
    final filteredWorkshop =
        _conf.where((workshop) => workshop['approval'] == null).toList();

    setState(() {
      workshops = filteredWorkshop;
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
    // Sample workshop data

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshops"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final workshop = workshops[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                workshop["workshoptitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Mode: ${workshop["mode"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(workshop['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(workshop['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove workshop)
                      deleteConference(workshop['master_id']);
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
                    builder: (context) => WSDesc(details: workshop),
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
