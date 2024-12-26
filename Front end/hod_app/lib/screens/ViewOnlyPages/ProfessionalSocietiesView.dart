import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/PSdesc.dart';

class ProfessionalSocietiesView extends StatefulWidget {
  const ProfessionalSocietiesView({super.key});

  @override
  State<ProfessionalSocietiesView> createState() =>
      _ProfessionalSocietiesViewState();
}

class _ProfessionalSocietiesViewState extends State<ProfessionalSocietiesView> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> professionalSocieties = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('professional_societies');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      professionalSocieties = filteredEvent;
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
        title: const Text("Professional Societies Activities"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: professionalSocieties.length,
        itemBuilder: (context, index) {
          final activity = professionalSocieties[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                activity["societyname"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "${activity["activitytype"]} (${activity["activitydate"]})"),
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
                    builder: (context) => PSDesc(details: activity),
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
