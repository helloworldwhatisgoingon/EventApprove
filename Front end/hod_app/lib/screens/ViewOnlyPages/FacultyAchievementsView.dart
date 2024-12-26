import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/fadesc.dart';

class FacultyAchievementsView extends StatefulWidget {
  const FacultyAchievementsView({super.key});

  @override
  State<FacultyAchievementsView> createState() => _FacultyAchievementsViewState();
}

class _FacultyAchievementsViewState extends State<FacultyAchievementsView> {
   Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> facultyAchievements = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('faculty_achievements');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      facultyAchievements = filteredEvent;
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
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Achievements"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: facultyAchievements.length,
        itemBuilder: (context, index) {
          final achievement = facultyAchievements[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                achievement["facultyname"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "${achievement["recognition"]} (${achievement["achievementdate"]})"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(achievement['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(achievement['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove achievement)
                      deleteConference(achievement['master_id']);
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
                    builder: (context) => FADesc(details: achievement),
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
