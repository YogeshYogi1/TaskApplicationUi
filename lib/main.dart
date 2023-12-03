import 'package:challenge_one/ui/component/constants.dart';
import 'package:challenge_one/ui/view/home.dart';
import 'package:challenge_one/ui/view/mailPage.dart';
import 'package:challenge_one/ui/view/project.dart';
import 'package:challenge_one/ui/view/settingPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task ->',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const BasePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.title});
  final String title;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    changeColor(); // Initialize the icon colors
    super.initState();
  }

  // Method to change the color of icons based on the selected page
  changeColor() {
    _icons = [
      SizedBox(
          height: 50,
          width: 30,
          child: Icon(Icons.home,
              color: page == 0 ? kOnGoingColor : Colors.black)),
      Padding(
        padding:
        const EdgeInsets.only(right: 50, top: 15, left: 15, bottom: 15),
        child: Icon(Icons.note_add_rounded,
            color: page == 1 ? kOnGoingColor : Colors.black),
      ),
      Padding(
        padding:
        const EdgeInsets.only(right: 15, top: 15, left: 50, bottom: 15),
        child: Icon(Icons.mail, color: page == 2 ? kOnGoingColor : Colors.black),
      ),
      SizedBox(
          height: 50,
          width: 30,
          child: Icon(Icons.settings,
              color: page == 3 ? kOnGoingColor : Colors.black)),
    ];
  }

  final List<Widget> _pages = [
    const HomePage(),
    const ProjectPage(),
    const MailPage(),
    const SettingPage(),
  ];

  int page = 0; // Index of the currently selected page

  late List<Widget> _icons;

  // Generate a list of clickable icons
  List<Widget> generateTaskList() {
    return List.generate(
      _icons.length,
          (index) {
        return InkWell(
          onTap: () {
            setState(() {
              page = index; // Change the selected page on icon tap
              changeColor(); // Update icon colors
            });
          },
          child: _icons[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[page]), // Display the selected page
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kOnGoingColor,
        onPressed: () {},
        foregroundColor: kOnGoingColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        surfaceTintColor: kOnGoingColor,
        elevation: 50.0,
        shadowColor: kOnGoingColor,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: generateTaskList(), // Display the list of icons
          ),
        ),
      ),
    );
  }
}
