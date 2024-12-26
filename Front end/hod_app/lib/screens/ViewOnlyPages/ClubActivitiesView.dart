import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/cadesc.dart'; // Correct path for cadesc.dart

class ClubActivitiesView extends StatefulWidget {
  const ClubActivitiesView({super.key});

  @override
  State<ClubActivitiesView> createState() => _ClubActivitiesViewState();
}

class _ClubActivitiesViewState extends State<ClubActivitiesView> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> clubActivities = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('clubactivity');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      clubActivities = filteredEvent;
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
        title: const Text("Club Activities"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: clubActivities.length,
        itemBuilder: (context, index) {
          final activity = clubActivities[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                activity["title"] ?? "No Title",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text("Activity Type: ${activity["activitytype"] ?? "N/A"}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(activity['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(activity['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove activity)
                      deleteConference(activity['master_id']);
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
                    builder: (context) => CADesc(details: activity),
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
