import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ClubActivitiesCP extends StatefulWidget {
  const ClubActivitiesCP({super.key});

  @override
  _ClubActivitiesCPState createState() => _ClubActivitiesCPState();
}

class _ClubActivitiesCPState extends State<ClubActivitiesCP> {
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Club Name",
    "Select Activity Type (Workshop/Bootcamp/Seminar/Quiz/Hackathon)",
    "Enter Title",
    "Pick Date",
    "Enter Number of Days",
    "Attach GPS Photos/Videos",
    "Enter Budget Sanctioned",
    "Attach Report",
    "Enter Organizers",
    "Enter Conveners",
    "Attach Feedback from Participants",
    "Attach Participants List with Signatures",
    "Attach Certificates (Soft Copy)",
    "Enter Speakers Details"
  ];

  final Map<String, dynamic> _currentConferenceDetails = {
    "clubName": "",
    "activityType": "",
    "title": "",
    "date": "",
    "numDays": "",
    "gpsMedia": null,
    "budget": "",
    "report": null,
    "organizers": "",
    "conveners": "",
    "feedback": null,
    "participantsList": null,
    "certificates": null,
    "speakersDetails": ""
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
        _currentConferenceDetails[key] =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickDocument(String key) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _currentConferenceDetails[key] = result.files.first.path;
      });
    }
  }

  Future<void> _submitConferenceDetails() async {
    try {
      // Simulate submission
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Conference details submitted successfully!")),
      );

      setState(() {
        _currentStep = 0;
        _currentConferenceDetails.clear();
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
          _currentConferenceDetails[key] = value;
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
        value: _currentConferenceDetails[key] == ""
            ? null
            : _currentConferenceDetails[key], // Ensure a non-null value
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _currentConferenceDetails[key] = value ?? "";
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
        return _buildInputField("clubName", "Enter Club Name");
      case 1:
        return _buildDropdownField("activityType",
            ['Workshop', 'Bootcamp', 'Seminar', 'Quiz', 'Hackathon']);
      case 2:
        return _buildInputField("title", "Enter Title");
      case 3:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDate(context, 'date'),
            child: const Text("Pick Date"),
          ),
        );
      case 4:
        return _buildInputField("numDays", "Enter Number of Days");
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('gpsMedia'),
            child: const Text("Attach GPS Photos/Videos"),
          ),
        );
      case 6:
        return _buildInputField("budget", "Enter Budget Sanctioned");
      case 7:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('report'),
            child: const Text("Attach Report"),
          ),
        );
      case 8:
        return _buildInputField("organizers", "Enter Organizers");
      case 9:
        return _buildInputField("conveners", "Enter Conveners");
      case 10:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('feedback'),
            child: const Text("Attach Feedback from Participants"),
          ),
        );
      case 11:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('participantsList'),
            child: const Text("Attach Participants List with Signatures"),
          ),
        );
      case 12:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument('certificates'),
            child: const Text("Attach Certificates (Soft Copy)"),
          ),
        );
      case 13:
        return _buildInputField("speakersDetails", "Enter Speakers Details");
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Activities'),
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
                'Club Activity Submission',
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
                  _submitConferenceDetails();
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
        children: List.generate(14, (index) {
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
