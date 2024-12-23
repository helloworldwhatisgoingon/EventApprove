import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:faculty_app/accepted_or_rejected.dart';
import 'package:faculty_app/repository.dart';
import 'package:flutter/material.dart';
import 'screens/IAmarksCP.dart';
import 'screens/BookChapterCP.dart';
import 'screens/ClubActivitiesCP.dart';
import 'screens/ConferencesCP.dart';
import 'screens/EventsCP.dart';
import 'screens/FDCP.dart';
import 'screens/FacultyAchievementsCP.dart';
import 'screens/IndustrialVisitsCP.dart';
import 'screens/JournalsCP.dart';
import 'screens/PatentsCP.dart';
import 'screens/ProfessionalSocietiesCP.dart';
import 'screens/SeminarsCP.dart';
import 'screens/StudentAchievementsCP.dart';
import 'screens/UnknownEventPage.dart';
import 'screens/WorkshopCP.dart';
import 'screens/settings.dart';

Repository repository = Repository();

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSU-EventApprove',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xfff8f9fd),
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen with animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          child: Text(
            'Welcome to DSU-EventApprove!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 5,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: [
                    buildCategoryCard("IA Marks", Icons.school),
                    buildCategoryCard("Conferences", Icons.business),
                    buildCategoryCard("Journals", Icons.book),
                    buildCategoryCard(
                        "Book- chapter/Published", Icons.menu_book),
                    buildCategoryCard("Patents", Icons.lightbulb),
                    buildCategoryCard("Events", Icons.event),
                    buildCategoryCard("Workshops", Icons.work),
                    buildCategoryCard("FDP", Icons.people),
                    buildCategoryCard("Seminars/Webinars", Icons.web),
                    buildCategoryCard("Club Activities", Icons.group),
                    buildCategoryCard("Industrial Visits", Icons.factory),
                    buildCategoryCard("Faculty Major Achievements", Icons.star),
                    buildCategoryCard(
                        "Student Major Achievements", Icons.emoji_events),
                    buildCategoryCard("Professional Societies activities",
                        Icons.account_balance),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryCard(String label, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xff405375),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => getPageForEvent(label)),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPageForEvent(String eventType) {
    switch (eventType) {
      case "IA Marks":
        return const IAmarksCP();
      case "Conferences":
        return const ConferencesCP();
      case "Journals":
        return const JournalsCP();
      case "Book- chapter/Published":
        return const BookChapterCP();
      case "Patents":
        return const PatentsCP();
      case "Events":
        return const EventsCP();
      case "Workshops":
        return const WorkshopsCP();
      case "FDP":
        return const FDPCP();
      case "Seminars/Webinars":
        return const SeminarsCP();
      case "Club Activities":
        return const ClubActivitiesCP();
      case "Industrial Visits":
        return const IndustrialVisitsCP();
      case "Faculty Major Achievements":
        return const FacultyAchievementsCP();
      case "Student Major Achievements":
        return const StudentsAchievementsCP();
      case "Professional Societies activities":
        return const ProfessionalSocietiesCP();
      default:
        return const UnknownEventPage();
    }
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

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
              'DSU-EventApprove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SidebarButton(
            icon: Icons.dashboard,
            label: "Dashboard",
            onTap: () {},
          ),
          SidebarButton(
            icon: Icons.create,
            label: "Create Proposal",
            onTap: () {},
          ),
          SidebarButton(
            icon: Icons.list_alt,
            label: "View Submissions",
            onTap: () {
              print('tapped');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcceptedAndRejectedView(),
                ),
              );
            },
          ),
          SidebarButton(
            icon: Icons.settings,
            label: "Settings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SidebarButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff405375),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
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
    proposalsFuture = repository.fetchData(); // Initial data load
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
                      // Render all fields except eventPDF and document
                      ...proposal.entries
                          .where((entry) =>
                              entry.key != 'eventPDF' &&
                              entry.key != 'document')
                          .map((entry) {
                        final key = entry.key;
                        final value = entry.value ?? 'N/A';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("$key: $value"),
                        );
                      }),

                      const SizedBox(height: 8),

                      // Render eventPDF or document if available
                      if (proposal['eventPDF'] != null)
                        TextButton(
                          onPressed: () {
                            final base64PDF = proposal['eventPDF'];
                            _viewDocument(base64PDF,
                                proposal['eventTitle'] ?? 'document');
                          },
                          child: const Text('Save Event PDF to Downloads'),
                        )
                      else if (proposal['document'] != null)
                        TextButton(
                          onPressed: () {
                            final base64Document = proposal['document'];
                            _viewDocument(base64Document,
                                proposal['documentTitle'] ?? 'document');
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
