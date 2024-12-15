import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SeminarsCP extends StatefulWidget {
  const SeminarsCP({super.key});

  @override
  _SeminarsCPState createState() => _SeminarsCPState();
}

class _SeminarsCPState extends State<SeminarsCP> {
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Seminar Title:",
    "Select Mode of Seminar:",
    "Attach Brochure:",
    "Select Dates (From - To):",
    "Enter Number of Days:",
    "Attach GPS Photos/Videos with Captions:",
    "Attach Report:",
    "Enter Organizers' Details:",
    "Enter Conveners' Details:",
    "Attach Feedback from Participants:",
    "Attach Participants List with Signatures:",
    "Attach Certificates (Soft Copy):",
    "Enter Amount Sanctioned:",
    "Enter Faculty Receiving Sanctioned Amount:",
    "Attach Expenditure Report with Receipts:",
    "Enter Details of Speakers/Resource Persons:",
  ];

  final Map<String, dynamic> _seminarDetails = {
    "seminarTitle": "",
    "mode": "",
    "brochure": null,
    "dates": {"from": "", "to": ""},
    "days": "",
    "gpsMedia": null,
    "report": null,
    "organizers": "",
    "conveners": "",
    "feedback": null,
    "participantsList": null,
    "certificates": null,
    "sanctionedAmount": "",
    "facultyReceivingAmount": "",
    "expenditureReport": null,
    "speakersDetails": "",
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
        _seminarDetails[key] = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _pickDocument(String key) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _seminarDetails[key] = result.files.first.path;
      });
    }
  }

  Future<void> _submitSeminarDetails() async {
    try {
      // Simulate submission
      await Future.delayed(const Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Seminar details submitted successfully!")),
      );

      setState(() {
        _currentStep = 0;
        _seminarDetails.clear();
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
          _seminarDetails[key] = value;
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
            groupValue: _seminarDetails[key],
            onChanged: (value) {
              setState(() {
                _seminarDetails[key] = value;
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
        return _buildInputField("seminarTitle", "Enter Seminar Title");
      case 1:
        return _buildRadioButtonField("mode", ["Online", "Offline"]);
      case 2:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("brochure"),
            child: const Text("Attach Brochure"),
          ),
        );
      case 3:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => _pickDate(context, "dates.from"),
                child: const Text("Pick Start Date"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => _pickDate(context, "dates.to"),
                child: const Text("Pick End Date"),
              ),
            ),
          ],
        );
      case 4:
        return _buildInputField("days", "Enter Number of Days");
      case 5:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("gpsMedia"),
            child: const Text("Attach GPS Photos/Videos"),
          ),
        );
      case 6:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("report"),
            child: const Text("Attach Report"),
          ),
        );
      case 7:
        return _buildInputField("organizers", "Enter Organizers' Details");
      case 8:
        return _buildInputField("conveners", "Enter Conveners' Details");
      case 9:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("feedback"),
            child: const Text("Attach Feedback from Participants"),
          ),
        );
      case 10:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("participantsList"),
            child: const Text("Attach Participants List with Signatures"),
          ),
        );
      case 11:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("certificates"),
            child: const Text("Attach Certificates (Soft Copy)"),
          ),
        );
      case 12:
        return _buildInputField("sanctionedAmount", "Enter Amount Sanctioned");
      case 13:
        return _buildInputField("facultyReceivingAmount",
            "Enter Faculty Receiving Sanctioned Amount");
      case 14:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDocument("expenditureReport"),
            child: const Text("Attach Expenditure Report with Receipts"),
          ),
        );
      case 15:
        return _buildInputField(
            "speakersDetails", "Enter Details of Speakers/Resource Persons");
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seminars/Webinars'),
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
                'Seminar Submission',
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
                  _submitSeminarDetails();
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
        children: List.generate(16, (index) {
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
