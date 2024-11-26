import 'package:flutter/material.dart';
import 'package:hod_app/repository.dart';
import 'screens/event.dart';
import 'screens/history.dart';

void main() {
  runApp(const DashboardApp());
}

Repository repository = Repository();

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSU-QuickApprove',
      theme: ThemeData(
        primaryColor: const Color(0xff2f3652),
        scaffoldBackgroundColor: const Color(0xfff8f9fd),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  Future<List<Map<String, dynamic>>>? _futureRequests;

  @override
  void initState() {
    super.initState();
    _futureRequests = repository.fetchProposals();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refreshRequests() {
    setState(() {
      _futureRequests = repository.fetchProposals();
    });
  }

  void _navigateToHistoryScreen(
      BuildContext context, List<Map<String, dynamic>> requests) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(events: requests),
      ),
    );
  }

  Future<void> acceptOrReject(int eventID, bool status) async {
    try {
      // Call the API function to update the request status
      await repository.updateRequestStatus(eventID, status);

      // Refresh the page after successful status update
      _refreshRequests();
    } catch (e) {
      // Handle any errors during the update
      debugPrint('Error updating request status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  void _acceptRequest(
      Map<String, dynamic> request,
      List<Map<String, dynamic>> currentRequests,
      List<Map<String, dynamic>> acceptedRequests) {
    setState(() {
      currentRequests.remove(request);
      acceptedRequests.add(request);
    });
  }

  void _rejectRequest(
      Map<String, dynamic> request,
      List<Map<String, dynamic>> currentRequests,
      List<Map<String, dynamic>> rejectedRequests) {
    setState(() {
      currentRequests.remove(request);
      rejectedRequests.add(request);
    });
  }

  void _deleteRequest(
      Map<String, dynamic> request, List<Map<String, dynamic>> targetList) {
    setState(() {
      targetList.remove(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No requests available.'));
          } else {
            // All requests
            final List<Map<String, dynamic>> requests = snapshot.data!;

            // Filtered requests based on approval status
            final List<Map<String, dynamic>> acceptedRequests = requests
                .where((request) => request['approval'] == true)
                .toList();

            final List<Map<String, dynamic>> rejectedRequests = requests
                .where((request) => request['approval'] == false)
                .toList();

            final List<Map<String, dynamic>> neutralRequests = requests
                .where((request) => request['approval'] == null)
                .toList();

            // Determine the current view based on the selected index
            List<Map<String, dynamic>> currentRequests;
            switch (_selectedIndex) {
              case 1: // Accepted Requests
                currentRequests = acceptedRequests;
                break;
              case 2: // Rejected Requests
                currentRequests = rejectedRequests;
                break;
              default: // Inbox (Unfiltered)
                currentRequests = neutralRequests;
            }

            return Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  color: const Color(0xff2f3652),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'DSU-QuickApprove',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          children: [
                            SidebarButton(
                                text: 'Inbox',
                                onPressed: () => _onItemTapped(0)),
                            SidebarButton(
                                text: 'Accepted',
                                onPressed: () => _onItemTapped(1)),
                            SidebarButton(
                                text: 'Rejected',
                                onPressed: () => _onItemTapped(2)),
                            SidebarButton(
                              text: 'Calendar',
                              onPressed: () =>
                                  _navigateToHistoryScreen(context, requests),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _refreshRequests,
                              child: const Text('Refresh'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: currentRequests.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: currentRequests.length,
                          itemBuilder: (context, index) {
                            final request = currentRequests[index];
                            return TaskCard(
                              request: request,
                              onAccept: () async {
                                await acceptOrReject(
                                  request['eventID'],
                                  true,
                                );
                              },
                              onReject: () async {
                                await acceptOrReject(
                                  request['eventID'],
                                  false,
                                );
                              },
                              onDelete: () {
                                _deleteRequest(request, currentRequests);
                              },
                              isInbox: _selectedIndex == 0,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            _selectedIndex == 1
                                ? 'No accepted requests.'
                                : _selectedIndex == 2
                                    ? 'No rejected requests.'
                                    : 'No new requests.',
                          ),
                        ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SidebarButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: onPressed,
    );
  }
}

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onDelete;
  final bool isInbox;

  const TaskCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
    required this.onDelete,
    required this.isInbox,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request["eventTitle"] ?? 'N/A',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Type: ${request['eventType']}\n"
              "Faculty: ${request['faculty']}\n"
              "Venue: ${request['location']}\n"
              "Date: ${request['startDate']}\n"
              "Time: ${request['timings']}",
              style: const TextStyle(fontSize: 14, color: Color(0xff9da6c4)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventScreen(
                          eventDetails: request,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2196F3),
                  ),
                  child: const Text("More Info"),
                ),
                const SizedBox(width: 8),
                if (isInbox) ...[
                  ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4CAF50),
                    ),
                    child: const Text("Accept"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onReject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff44336),
                    ),
                    child: const Text("Reject"),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff44336),
                    ),
                    child: const Text("Delete"),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
