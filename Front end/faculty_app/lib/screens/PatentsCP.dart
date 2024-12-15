import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PatentsCP extends StatefulWidget {
  const PatentsCP({super.key});

  @override
  _PatentsCPState createState() => _PatentsCPState();
}

class _PatentsCPState extends State<PatentsCP> {
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Application Number:",
    "Enter Patent Number:",
    "Enter Title:",
    "Enter Inventor(s):",
    "Enter Patentee Name (Dayananda Sagar University):",
    "Enter Filing Date:",
    "Select Published/Granted:",
    "Enter Patent Country:",
    "Enter Publication/Granted Date:",
    "Enter Abstract:",
    "Enter URL (Link to Patent Document):",
    "Attach Document:"
  ];

  final Map<String, dynamic> _currentPatentDetails = {
    "applicationNumber": "",
    "patentNumber": "",
    "title": "",
    "inventors": "",
    "patenteeName": "Dayananda Sagar University",
    "filingDate": "",
    "status": "",
    "patentCountry": "",
    "publicationDate": "",
    "abstract": "",
    "url": "",
    "document": null
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
        _currentPatentDetails[key] =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _currentPatentDetails['document'] = result.files.first.path;
      });
    }
  }

  Future<void> _submitPatentDetails() async {
    try {
      // Simulate submission
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Patent details submitted successfully!")),
      );

      setState(() {
        _currentStep = 0;
        _currentPatentDetails.clear();
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
          _currentPatentDetails[key] = value;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildRadioButtonField(String key, List<String> options) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: _currentPatentDetails[key],
            onChanged: (value) {
              setState(() {
                _currentPatentDetails[key] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    _resetTextController();

    switch (_currentStep) {
      case 0:
        return _buildInputField(
            "applicationNumber", "Enter Application Number");
      case 1:
        return _buildInputField("patentNumber", "Enter Patent Number");
      case 2:
        return _buildInputField("title", "Enter Title");
      case 3:
        return _buildInputField("inventors", "Enter Inventor(s)");
      case 4:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Patentee Name: Dayananda Sagar University",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDate(context, "filingDate"),
            child: const Text("Pick Filing Date"),
          ),
        );
      case 6:
        return _buildRadioButtonField("status", ["Published", "Granted"]);
      case 7:
        return _buildInputField("patentCountry", "Enter Patent Country");
      case 8:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDate(context, "publicationDate"),
            child: const Text("Pick Publication/Granted Date"),
          ),
        );
      case 9:
        return _buildInputField("abstract", "Enter Abstract");
      case 10:
        return _buildInputField("url", "Enter URL (Link to Patent Document)");
      case 11:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _pickDocument,
            child: const Text("Attach Document"),
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
        title: const Text('Patents'),
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
                'Patent Submission',
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
                  _submitPatentDetails();
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
        children: List.generate(12, (index) {
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
