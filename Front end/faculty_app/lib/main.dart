// ignore_for_file: library_private_types_in_public_api

import 'package:faculty_app/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:file_picker/file_picker.dart'; // For file picking

void main() {
  runApp(const DashboardApp());
}

Repository repository = Repository();

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSU-QuickApprove',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xfff8f9fd),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const CreateProposalPage(),
    const ViewSubmissionsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(onSelectedIndexChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final ValueChanged<int> onSelectedIndexChanged;

  const Sidebar({super.key, required this.onSelectedIndexChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xff2F4F6F),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'DSU-QuickApprove',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SidebarButton(
              label: "Home", index: 0, onPressed: onSelectedIndexChanged),
          SidebarButton(
              label: "Create Proposal",
              index: 1,
              onPressed: onSelectedIndexChanged),
          SidebarButton(
              label: "View Submissions",
              index: 2,
              onPressed: onSelectedIndexChanged),
          SidebarButton(
              label: "Settings", index: 3, onPressed: onSelectedIndexChanged),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String label;
  final int index;
  final ValueChanged<int> onPressed;

  const SidebarButton(
      {super.key,
      required this.label,
      required this.index,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff405375),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(label,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Welcome to DSU-QuickApprove!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CreateProposalPage extends StatefulWidget {
  const CreateProposalPage({super.key});

  @override
  _CreateProposalPageState createState() => _CreateProposalPageState();
}

class _CreateProposalPageState extends State<CreateProposalPage> {
  static List<Map<String, dynamic>> proposals = [];
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Event Name:",
    "Enter Event Type:",
    "Enter Faculty Involved:",
    "Enter Venue:",
    "Enter Date:",
    "Enter Timings:",
    "Upload Documents:"
  ];

  final Map<String, dynamic> _currentProposal = {
    "eventName": "",
    "eventType": "",
    "faculty": "",
    "venue": "",
    "date": "",
    "timings": "",
    "document": null // Storing the file object here
  };

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _currentProposal['date'] = picked.toIso8601String().split('T')[0];
      });
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _currentProposal['document'] = result.files.single.path; // Storing path
      });
    }
  }

  Future<void> _submitProposal() async {
    try {
      await repository.submitProposal(
        eventName: _currentProposal['eventName'] ?? "",
        eventType: _currentProposal['eventType'] ?? "",
        startDate: _currentProposal['date'] ?? "",
        endDate: _currentProposal['date'] ?? "",
        location: _currentProposal['venue'] ?? "",
        approval: false,
        documentPath: _currentProposal['document'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Proposal submitted successfully!")),
      );

      setState(() {
        _currentStep = 0;
        _currentProposal.clear();
        _textController.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProposalStepsWidget(currentStep: _currentStep),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _stepsQuestions[_currentStep],
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff2F4F6F)),
          ),
        ),
        if (_currentStep < 4)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _textController,
              onChanged: (value) {
                if (_currentStep == 0) _currentProposal['eventName'] = value;
                if (_currentStep == 1) _currentProposal['eventType'] = value;
                if (_currentStep == 2) _currentProposal['faculty'] = value;
                if (_currentStep == 3) _currentProposal['venue'] = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your answer here',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        if (_currentStep == 4)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _pickDate(context),
              child: const Text("Pick Date"),
            ),
          ),
        if (_currentStep == 5) // Timings step
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _textController,
              onChanged: (value) {
                _currentProposal['timings'] = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText:
                    'Enter event timings here (e.g., 10:00 AM - 12:00 PM)',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        if (_currentStep == 6)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _pickDocument,
              child: const Text("Upload Document"),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              if (_currentStep < _stepsQuestions.length - 1) {
                setState(() {
                  _currentStep++;
                  _textController.clear();
                });
              } else {
                _submitProposal();
              }
            },
            child: Text(
                _currentStep == _stepsQuestions.length - 1 ? 'Submit' : 'Next'),
          ),
        ),
      ],
    );
  }
}

class ProposalStepsWidget extends StatelessWidget {
  final int currentStep;
  const ProposalStepsWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        7,
        (index) => Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                index <= currentStep ? Colors.green : const Color(0xff2F4F6F),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ViewSubmissionsPage extends StatelessWidget {
  const ViewSubmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _CreateProposalPageState.proposals.map((proposal) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Event Name: ${proposal['eventName']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Event Type: ${proposal['eventType']}"),
                const SizedBox(height: 8),
                Text("Faculty: ${proposal['faculty']}"),
                const SizedBox(height: 8),
                Text("Venue: ${proposal['venue']}"),
                const SizedBox(height: 8),
                Text("Date: ${proposal['date']}"),
                const SizedBox(height: 8),
                Text("Timings: ${proposal['timings']}"),
                const SizedBox(height: 8),
                Text("Documents: ${proposal['documents']}"),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Settings"));
  }
}
