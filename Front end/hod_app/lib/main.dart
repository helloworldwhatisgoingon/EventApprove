import 'package:flutter/material.dart';
import 'screens/event.dart';
import 'screens/history.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  final List<Map<String, String>> _requests = [
    {
      "title": "Event 1",
      "type": "Workshop",
      "faculty": "Dr. Smith",
      "venue": "Room A",
      "date": "2024-09-30",
      "time": "10:00 AM"
    },
    {
      "title": "Event 2",
      "type": "Seminar",
      "faculty": "Dr. Johnson",
      "venue": "Room B",
      "date": "2024-10-05",
      "time": "2:00 PM"
    },
    {
      "title": "Event 3",
      "type": "Conference",
      "faculty": "Dr. Lee",
      "venue": "Room C",
      "date": "2024-10-15",
      "time": "9:00 AM"
    },
    {
      "title": "Event 4",
      "type": "Lecture",
      "faculty": "Dr. Evans",
      "venue": "Room D",
      "date": "2024-10-18",
      "time": "11:00 AM"
    },
    {
      "title": "Event 5",
      "type": "Workshop",
      "faculty": "Prof. Robinson",
      "venue": "Room E",
      "date": "2024-10-20",
      "time": "3:00 PM"
    },
    {
      "title": "Event 6",
      "type": "Meeting",
      "faculty": "Dr. Kim",
      "venue": "Room F",
      "date": "2024-10-25",
      "time": "10:00 AM"
    },
    {
      "title": "Event 7",
      "type": "Seminar",
      "faculty": "Dr. Brown",
      "venue": "Room G",
      "date": "2024-10-28",
      "time": "1:00 PM"
    },
    {
      "title": "Event 8",
      "type": "Panel Discussion",
      "faculty": "Prof. Garcia",
      "venue": "Room H",
      "date": "2024-11-01",
      "time": "4:00 PM"
    },
    {
      "title": "Event 9",
      "type": "Lecture",
      "faculty": "Dr. Wilson",
      "venue": "Room I",
      "date": "2024-11-03",
      "time": "11:30 AM"
    },
    {
      "title": "Event 10",
      "type": "Conference",
      "faculty": "Dr. Martinez",
      "venue": "Room J",
      "date": "2024-11-07",
      "time": "9:30 AM"
    },
    {
      "title": "Event 11",
      "type": "Workshop",
      "faculty": "Prof. Clark",
      "venue": "Room K",
      "date": "2024-11-10",
      "time": "2:30 PM"
    },
    {
      "title": "Event 12",
      "type": "Seminar",
      "faculty": "Dr. Lewis",
      "venue": "Room L",
      "date": "2024-11-12",
      "time": "10:00 AM"
    },
    {
      "title": "Event 13",
      "type": "Panel Discussion",
      "faculty": "Prof. Young",
      "venue": "Room M",
      "date": "2024-11-15",
      "time": "5:00 PM"
    },
    {
      "title": "Event 14",
      "type": "Lecture",
      "faculty": "Dr. King",
      "venue": "Room N",
      "date": "2024-11-18",
      "time": "12:00 PM"
    },
    {
      "title": "Event 15",
      "type": "Workshop",
      "faculty": "Prof. Wright",
      "venue": "Room O",
      "date": "2024-11-20",
      "time": "3:00 PM"
    },
    {
      "title": "Event 16",
      "type": "Meeting",
      "faculty": "Dr. Lopez",
      "venue": "Room P",
      "date": "2024-11-22",
      "time": "10:30 AM"
    },
    {
      "title": "Event 17",
      "type": "Seminar",
      "faculty": "Dr. Hill",
      "venue": "Room Q",
      "date": "2024-11-25",
      "time": "1:30 PM"
    },
    {
      "title": "Event 18",
      "type": "Conference",
      "faculty": "Prof. Scott",
      "venue": "Room R",
      "date": "2024-11-28",
      "time": "9:00 AM"
    },
    {
      "title": "Event 19",
      "type": "Lecture",
      "faculty": "Dr. Green",
      "venue": "Room S",
      "date": "2024-11-30",
      "time": "11:15 AM"
    },
    {
      "title": "Event 20",
      "type": "Workshop",
      "faculty": "Prof. Adams",
      "venue": "Room T",
      "date": "2024-12-02",
      "time": "4:00 PM"
    }
  ];

  void _navigateToHistoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(events: _requests),
      ),
    );
  }

  final List<Map<String, String>> _acceptedRequests = [];
  final List<Map<String, String>> _rejectedRequests = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showCalendar(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (selectedDate != null) {
      print("Selected date: ${selectedDate.toLocal()}");
    }
  }

  void _acceptRequest(Map<String, String> request) {
    setState(() {
      _requests.remove(request);
      _acceptedRequests.add(request);
    });
  }

  void _rejectRequest(Map<String, String> request) {
    setState(() {
      _requests.remove(request);
      _rejectedRequests.add(request);
    });
  }

  void _deleteRequest(Map<String, String> request, int tab) {
    setState(() {
      if (tab == 1) {
        _acceptedRequests.remove(request);
      } else if (tab == 2) {
        _rejectedRequests.remove(request);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentRequests;
    switch (_selectedIndex) {
      case 1:
        currentRequests = _acceptedRequests;
        break;
      case 2:
        currentRequests = _rejectedRequests;
        break;
      default:
        currentRequests = _requests;
    }

    return Scaffold(
      body: Row(
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
                          text: 'Inbox', onPressed: () => _onItemTapped(0)),
                      SidebarButton(
                          text: 'Accepted', onPressed: () => _onItemTapped(1)),
                      SidebarButton(
                          text: 'Rejected', onPressed: () => _onItemTapped(2)),
                      SidebarButton(
                        text: 'Calendar',
                        onPressed: () => _navigateToHistoryScreen(context),
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
                        onAccept: () => _acceptRequest(request),
                        onReject: () => _rejectRequest(request),
                        onDelete: () => _deleteRequest(request, _selectedIndex),
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
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  SidebarButton({super.key, required this.text, required this.onPressed});

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
  final Map<String, String> request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onDelete;
  final bool isInbox;

  TaskCard({super.key, 
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
              request["title"]!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff333a56),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Type: ${request['type']}\n"
              "Faculty: ${request['faculty']}\n"
              "Venue: ${request['venue']}\n"
              "Date: ${request['date']}\n"
              "Time: ${request['time']}",
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
