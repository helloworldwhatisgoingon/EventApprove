import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hod_app/repository.dart';
import 'package:hod_app/screens/descfiles/confdesc.dart';
Repository repository = Repository();


class AcceptedAndRejectedView extends StatefulWidget {
  final bool state;
  const AcceptedAndRejectedView({super.key, required this.state});

  @override
  _AcceptedAndRejectedView createState() => _AcceptedAndRejectedView();
}

class _AcceptedAndRejectedView extends State<AcceptedAndRejectedView> {
  late Future<List<Map<String, dynamic>>> _futureData =
      Future.value([]); // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData to fetch the events.
  }

  Future<void> fetchData() async {
    try {
      // Fetch the data (this could be from an API or local repository)
      var data = await repository.fetchData();

      // Filter the data to include only those where 'approval' is true
      var filteredData =
          data.where((item) => item['approval'] == widget.state).toList();

      // Set the filtered data in the state
      setState(() {
        _futureData = Future.value(filteredData);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
      rethrow;
    }
  }

  // Function to generate cards based on submission type
  Widget generateCard(BuildContext context, Map<String, dynamic> event) {
    switch (event['submissionType']) {
      case 'proposal':
      case 'conference':
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              event["papertitle"]!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(event["conferencename"] ?? "No Conference Name"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDesc(details: event),
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
                  builder: (context) => EventDesc(details: event),
                ),
              );
            },
          ),
        );
      default:
        return SizedBox
            .shrink(); // If no valid submission type, return an empty widget.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accepted Events"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No accepted events available.'));
          }

          final events = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return generateCard(context,
                  event); // Use the function to generate the correct card
            },
          );
        },
      ),
    );
  }
}
