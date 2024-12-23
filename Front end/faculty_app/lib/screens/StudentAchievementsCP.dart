import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class StudentsAchievementsCP extends StatefulWidget {
  const StudentsAchievementsCP({super.key});

  @override
  _StudentsAchievementsCPState createState() => _StudentsAchievementsCPState();
}

class _StudentsAchievementsCPState extends State<StudentsAchievementsCP> {
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Student Names",
    "Enter USNs",
    "Enter Year of Study",
    "Select Event Type (Workshop/Hackathon/Bootcamp/Conference/Project Expo)",
    "Enter Event Title",
    "Pick Date of Achievement",
    "Enter Company/Organization",
    "Enter Recognition or Place/Prize (First/Second/Third)",
    "Attach Certificate Proof",
    "Attach GPS Photo",
    "Attach Report"
  ];

  final Map<String, dynamic> _currentAchievementDetails = {
    "studentNames": "",
    "usns": "",
    "yearOfStudy": "",
    "eventType": "",
    "eventTitle": "",
    "achievementDate": "",
    "companyOrganization": "",
    "recognition": "",
    "certificateProof": null,
    "gpsPhoto": null,
    "report": null
  };

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _resetTextController() {
    _textController.clear();
  }

  Future<void> _pickDate(BuildContext context, String key) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _currentAchievementDetails[key] =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickDocument(String key) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _currentAchievementDetails[key] = result.files.first.path;
      });
    }
  }

  Future<void> _submitAchievementDetails() async {
    try {
      // Simulate submission
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Achievement details submitted successfully!")),
      );

      setState(() {
        _currentStep = 0;
        _currentAchievementDetails.clear();
        _resetTextController();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  Widget _buildInputField(String key, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _textController,
        onChanged: (value) {
          _currentAchievementDetails[key] = value;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String key, List<String> options) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: _currentAchievementDetails[key] == ""
            ? null
            : _currentAchievementDetails[key], // Ensure a non-null value
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _currentAchievementDetails[key] = value ?? "";
          });
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Select $key',
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    _resetTextController();

    switch (_currentStep) {
      case 0:
        return _buildInputField("studentNames", "Enter Student Names");
      case 1:
        return _buildInputField("usns", "Enter USNs");
      case 2:
        return _buildInputField("yearOfStudy", "Enter Year of Study");
      case 3:
        return _buildDropdownField("eventType", 
            ['Workshop', 'Hackathon', 'Bootcamp', 'Conference', 'Project Expo']);
      case 4:
        return _buildInputField("eventTitle", "Enter Event Title");
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDate(context, 'achievementDate'),
            child: const Text("Pick Date of Achievement"),
          ),
        );
      case 6:
        return _buildInputField("companyOrganization", "Enter Company/Organization");
      case 7:
        return _buildInputField("recognition", "Enter Recognition or Place/Prize (First/Second/Third)");
      case 8:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('certificateProof'),
            child: const Text("Attach Certificate Proof"),
          ),
        );
      case 9:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('gpsPhoto'),
            child: const Text("Attach GPS Photo"),
          ),
        );
      case 10:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('report'),
            child: const Text("Attach Report"),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Achievements'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'Student Achievement Submission',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ProposalStepsWidget(currentStep: _currentStep),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _stepsQuestions[_currentStep],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff2F4F6F),
              ),
            ),
          ),
          Expanded(child: _buildCurrentStepContent()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < _stepsQuestions.length - 1) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  _submitAchievementDetails();
                }
              },
              child: Text(_currentStep < _stepsQuestions.length - 1
                  ? 'Next Step'
                  : 'Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProposalStepsWidget extends StatelessWidget {
  final int currentStep;

  const ProposalStepsWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(11, (index) {
          return Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      currentStep == index ? Colors.blue : Colors.grey,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'Step ${index + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
