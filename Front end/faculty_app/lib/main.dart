// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:faculty_app/repository.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // For file picking
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
        faculty: _currentProposal['faculty'],
        timings: _currentProposal['timings'],
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
              child: const Text("Pick Date: "),
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

class ViewSubmissionsPage extends StatefulWidget {
  const ViewSubmissionsPage({super.key});

  @override
  _ViewSubmissionsPageState createState() => _ViewSubmissionsPageState();
}

class _ViewSubmissionsPageState extends State<ViewSubmissionsPage> {
  late Future<List<Map<String, dynamic>>> proposalsFuture;

  @override
  void initState() {
    super.initState();
    proposalsFuture = repository.fetchProposals(); // Initial data load
  }

  Future<void> _viewDocument(String base64PDF, String fileName) async {
    try {
      // Decode the Base64 string to bytes
      Uint8List bytes = base64Decode(base64PDF);

      // Get the Downloads directory
      final downloadsDir = await getDownloadsDirectory();
      if (downloadsDir == null) {
        throw 'Downloads directory not found';
      }

      // Create a file path in the Downloads directory
      final filePath = '${downloadsDir.path}/$fileName.pdf';

      // Write the bytes to a file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File saved to Downloads: $fileName.pdf')),
      );
    } catch (e) {
      debugPrint('Error viewing document: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving document: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Submissions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                proposalsFuture =
                    repository.fetchProposals(); // Reload the data
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: proposalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No submissions found.'));
          }

          final proposals = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: proposals.length,
            itemBuilder: (context, index) {
              final proposal = proposals[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Name: ${proposal['eventTitle'] ?? 'N/A'}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text("Event Type: ${proposal['eventType'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      Text("Faculty: ${proposal['faculty'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      Text("Venue: ${proposal['location'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      Text("Date: ${proposal['startDate'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      Text("Timings: ${proposal['timings'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      // Display a button for viewing the document
                      if (proposal['eventPDF'] != null)
                        TextButton(
                          onPressed: () {
                            final base64PDF = proposal['eventPDF'];
                            _viewDocument(base64PDF,
                                proposal['eventTitle'] ?? 'document');
                          },
                          child: const Text('Save Document to Downloads'),
                        )
                      else
                        const Text('Document not available'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isWindows) {
      return Directory('${Platform.environment['USERPROFILE']}\\Downloads');
    } else if (Platform.isLinux || Platform.isMacOS) {
      return Directory('${Platform.environment['HOME']}/Downloads');
    }
    return null;
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Settings"));
  }
}
