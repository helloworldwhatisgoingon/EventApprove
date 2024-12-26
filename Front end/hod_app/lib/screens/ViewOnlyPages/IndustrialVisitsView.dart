import 'package:flutter/material.dart';
import 'package:hod_app/screens/repository.dart';
import '../descfiles/ivdesc.dart';

class IndustrialVisitsView extends StatefulWidget {
  const IndustrialVisitsView({super.key});

  @override
  State<IndustrialVisitsView> createState() => _IndustrialVisitsViewState();
}

class _IndustrialVisitsViewState extends State<IndustrialVisitsView> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  List<Map<String, dynamic>> industrialVisits = [];

  Future<void> fetchEvent() async {
    final conf = await repository.fetchEvents('industrial_visit');

    // Filter the conferences where 'approval' is null
    final filteredEvent =
        conf.where((event) => event['approval'] == null).toList();

    setState(() {
      industrialVisits = filteredEvent;
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
        title: const Text("Industrial Visits"),
        backgroundColor: const Color(0xff2F4F6F),
      ),
      body: ListView.builder(
        itemCount: industrialVisits.length,
        itemBuilder: (context, index) {
          final visit = industrialVisits[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                visit["visittitle"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Date of Visit: ${visit["visitdate"]}"),
               trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      // Handle red cross action (e.g., mark as canceled)
                      updateConference(visit['master_id'], false);

                      print("Red cross pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      // Handle green tick action (e.g., mark as accepted)
                      updateConference(visit['master_id'], true);
                      print("Green tick pressed");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      // Handle delete action (e.g., remove visit)
                      deleteConference(visit['master_id']);
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
                    builder: (context) => IVDesc(details: visit),
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
