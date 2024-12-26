import 'package:faculty_app/repository.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Repository repository = Repository();

class ConferencesCP extends StatefulWidget {
  const ConferencesCP({super.key});

  @override
  _ConferencesCPState createState() => _ConferencesCPState();
}

class _ConferencesCPState extends State<ConferencesCP> {
  int _currentStep = 0;

  final List<String> _stepsQuestions = [
    "Enter Paper Title:",
    "Enter Abstract:",
    "Enter Conference Name:",
    "Select Publication Level:",
    "Enter Publication Month and Year:",
    "Enter Publisher Name:",
    "Enter DOI/ISBN:",
    "Attach Document:",
    "Enter Link for Proof (Scopus/WoS):",
    "Enter Scopus ID / WoS ID / ORCID ID:"
  ];

  final Map<String, dynamic> _currentConferenceDetails = {
    "paperTitle": "",
    "abstract": "",
    "conferenceName": "",
    "publicationLevel": "",
    "publicationDate": "",
    "publisher": "",
    "doiIsbn": "",
    "document": null,
    "proofLink": "",
    "identifier": "",
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

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
        // type: FileType.custom,
        // allowedExtensions: ['pdf'], // Restrict to only PDF files
        );

    if (result != null) {
      setState(() {
        _currentConferenceDetails['document'] = result.files.first.path;
      });
    }
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
        _currentConferenceDetails['publicationDate'] =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _submitConferenceDetails() async {
    try {
      // Simulate submission
      final conferenceData = await repository.createConferenceData(
          paperTitle: _currentConferenceDetails["paperTitle"],
          abstract: _currentConferenceDetails["abstract"],
          conferenceName: _currentConferenceDetails["conferenceName"],
          publicationLevel: _currentConferenceDetails["publicationLevel"],
          publicationDate: _currentConferenceDetails["publicationDate"],
          publisher: _currentConferenceDetails["publisher"],
          doiIsbn: _currentConferenceDetails["doiIsbn"],
          documentPath: _currentConferenceDetails["document"],
          identifier: _currentConferenceDetails["identifier"] ?? "",
          proofLink: _currentConferenceDetails["proofLink"]);

      await repository.sendEvent(
        eventType: "conference",
        eventName: _currentConferenceDetails["paperTitle"],
        additionalData: conferenceData,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Conference details submitted successfully!")),
      );
      print('$_currentConferenceDetails');
      print('skaodfpjrfiweoouytw4ire8otyhtgjdbs,gstujghrgujkbsdfgs');

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

  Widget _buildCurrentStepContent() {
    // Clear text controller when switching to a new step
    _resetTextController();

    switch (_currentStep) {
      case 0:
        return _buildInputField("paperTitle", "Enter Paper Title");
      case 1:
        return _buildInputField("abstract", "Enter Abstract");
      case 2:
        return _buildInputField("conferenceName", "Enter Conference Name");
      case 3:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['National', 'International'].map((level) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentConferenceDetails['publicationLevel'] = level;
                  });
                },
                child: Text(level),
              );
            }).toList(),
          ),
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _pickDate(context),
            child: const Text("Pick Publication Date"),
          ),
        );
      case 5:
        return _buildInputField("publisher", "Enter Publisher Name");
      case 6:
        return _buildInputField("doiIsbn", "Enter DOI/ISBN");
      case 7:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _pickDocument,
            child: const Text("Attach Document"),
          ),
        );
      case 8:
        return _buildInputField("proofLink", "Enter Link for Proof");
      case 9:
        return _buildInputField(
            "identifier", "Enter Scopus ID / WoS ID / ORCID ID");
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conferences'),
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
                'Conference Submission',
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
                print(';sdaodk');
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
        children: List.generate(10, (index) {
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
