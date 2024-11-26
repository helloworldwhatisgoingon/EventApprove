// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
      {super.key, required this.label, required this.index, required this.onPressed});

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
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
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
  int _currentStep = 0;
  final List<String> _stepsQuestions = [
    "Enter Idea Title:",
    "Enter Idea Description:",
    "Upload Important Documents:",
    "Enter Faculty Involved:",
    "Provide Additional Information:",
  ];

  final Map<String, String> _currentProposal = {
    "title": "",
    "description": "",
    "documents": "",
    "faculty": "",
    "info": ""
  };

  static List<Map<String, String>> proposals = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
        if (_currentStep != 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _textController,
              onChanged: (value) {
                if (_currentStep == 0) _currentProposal['title'] = value;
                if (_currentStep == 1) _currentProposal['description'] = value;
                if (_currentStep == 3) _currentProposal['faculty'] = value;
                if (_currentStep == 4) _currentProposal['info'] = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your answer here',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        if (_currentStep == 2)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                _currentProposal['documents'] = "Document Uploaded";
                setState(() {});
              },
              child: const Text('Upload Document'),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (_currentStep < _stepsQuestions.length - 1) {
                  _currentStep++;
                  _textController.clear(); // Clear the text field
                } else {
                  proposals.add(Map.from(_currentProposal));
                  _currentStep = 0;
                  _currentProposal.clear();
                  _textController.clear();
                }
              });
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
        5,
        (index) => Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index <= currentStep ? Colors.green : const Color(0xff2F4F6F),
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
                Text("Title: ${proposal['title']}",
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Description: ${proposal['description']}"),
                const SizedBox(height: 8),
                Text("Faculty: ${proposal['faculty']}"),
                const SizedBox(height: 8),
                Text("Additional Info: ${proposal['info']}"),
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
