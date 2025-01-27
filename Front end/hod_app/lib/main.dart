import 'package:flutter/material.dart';
import 'package:hod_app/login.dart';
import 'package:hod_app/screens/accepted_or_rejected.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import all the necessary pages
import 'screens/ViewOnlyPages/IAmarksView.dart';
import 'screens/ViewOnlyPages/ConferencesView.dart';
import 'screens/ViewOnlyPages/JournalsView.dart';
import 'screens/ViewOnlyPages/BookChapterView.dart';
import 'screens/ViewOnlyPages/PatentsView.dart';
import 'screens/ViewOnlyPages/EventsView.dart';
import 'screens/ViewOnlyPages/WorkshopsView.dart';
import 'screens/ViewOnlyPages/FDView.dart';
import 'screens/ViewOnlyPages/SeminarsView.dart';
import 'screens/ViewOnlyPages/ClubActivitiesView.dart'; // Import the ClubActivitiesView
import 'screens/ViewOnlyPages/IndustrialVisitsView.dart';
import 'screens/ViewOnlyPages/FacultyAchievementsView.dart';
import 'screens/ViewOnlyPages/StudentAchievementsView.dart';
import 'screens/ViewOnlyPages/ProfessionalSocietiesView.dart';
import 'screens/ViewOnlyPages/UnknownEventPage.dart';
import 'screens/settings.dart';

void main() {
  runApp(const HODDashboardApp());
}

class HODDashboardApp extends StatelessWidget {
  const HODDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSU-HOD Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xfff8f9fd),
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2F4F6F),
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(seconds: 2),
          child: const Text(
            'Welcome to DSU-HOD Dashboard!',
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

// HomePage for HOD
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.username});
  final String? username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(), // Sidebar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  buildCategoryCard("IA Marks", Icons.school),
                  buildCategoryCard("Conferences", Icons.business),
                  buildCategoryCard("Journals", Icons.book),
                  buildCategoryCard("Book- chapter/Published", Icons.menu_book),
                  buildCategoryCard("Patents", Icons.lightbulb),
                  // buildCategoryCard("Events", Icons.event),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Category card builder
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

  // Function to get the page based on the event type
  Widget getPageForEvent(String eventType) {
    switch (eventType) {
      case "IA Marks":
        return const IAmarksView();
      case "Conferences":
        return const ConferencesView();
      case "Journals":
        return const JournalsView();
      case "Book- chapter/Published":
        return const BookChapterView();
      case "Patents":
        return const PatentsView();
      case "Events":
        return const EventsView();
      case "Workshops":
        return const WorkshopsView();
      case "FDP":
        return const FDView();
      case "Seminars/Webinars":
        return const SeminarsView();
      case "Club Activities":
        return const ClubActivitiesView(); // Added Club Activities Page
      case "Industrial Visits":
        return const IndustrialVisitsView();
      case "Faculty Major Achievements":
        return const FacultyAchievementsView();
      case "Student Major Achievements":
        return const StudentAchievementsView();
      case "Professional Societies activities":
        return const ProfessionalSocietiesView();
      default:
        return const UnknownEventPage();
    }
  }
}

// Sidebar with buttons for Accepted and Rejected
class Sidebar extends StatelessWidget {
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
              'DSU-HOD Dashboard',
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
            icon: Icons.list_alt,
            label: "View Reports",
            onTap: () {},
          ),
          SidebarButton(
            icon: Icons.check_circle,
            label: "Accepted", // "Accepted" button
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcceptedAndRejectedView(
                    state: true,
                  ),
                ),
              );
            },
          ),
          SidebarButton(
            icon: Icons.cancel,
            label: "Rejected", // "Rejected" button
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcceptedAndRejectedView(
                    state: false,
                  ),
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
          SidebarButton(
            icon: Icons.logout_outlined,
            label: "Logout",
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('hod');
              await prefs.setBool('isLogged', false);

              // Navigate back to login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Sidebar button widget
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
