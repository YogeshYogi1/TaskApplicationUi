import 'dart:math';
import 'package:flutter/material.dart';
import '../component/constants.dart';
import '../component/utils.dart';
import '../component/widgets/widgets.dart';
import 'detailedView.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List pages = [const All(), const OnGoing(), const Completed()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with profile image and search icon
            const Padding(
              padding: EdgeInsets.only(top: 13, left: 13, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    minRadius: 40,
                    maxRadius: 40,
                    backgroundColor: Color(0xffe7e6f6),
                    backgroundImage: AssetImage('assets/2.jpg'),
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                  )
                ],
              ),
            ),
            // Title for the project section
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
              child: Text(
                'Project',
                style: kHeadText.copyWith(fontSize: 20),
              ),
            ),
            // TabBar for switching between All, Ongoing, and Completed tabs
            ShadowContainer(
              radius: 30,
              child: TabBar(
                indicator: BoxDecoration(
                    color: kOnGoingColor,
                    borderRadius: BorderRadius.circular(50)),
                tabs: [
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'All',
                        style: kBoldTaskText.copyWith(
                            color: selectedIndex == 0
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Text(
                    'Ongoing',
                    style: kBoldTaskText.copyWith(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                  Text(
                    'Completed',
                    style: kBoldTaskText.copyWith(
                        color: selectedIndex == 2 ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ],
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // Body content based on the selected tab
            Expanded(child: pages[selectedIndex]),
          ],
        ),
      ),
    );
  }
}

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    // List of projects in All tab
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ProjectCard(index: index);
        },
        itemCount: kColorsList!.length,
      ),
    );
  }
}

class OnGoing extends StatefulWidget {
  const OnGoing({super.key});

  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  @override
  Widget build(BuildContext context) {
    // Placeholder content for the Ongoing tab
    return Shape.rectangle.getShapeContainer(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Under Construction',
              style: kHeadText,
            ),
            Shape.rectangle.getShapeContainer(
              width: 300,
              height: 300,
              bRadius: 30,
              color: Colors.white,
              child: Image.asset(
                'assets/6.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    // Placeholder content for the Completed tab
    return Shape.rectangle.getShapeContainer(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Under Construction',
              style: kHeadText,
            ),
            Shape.rectangle.getShapeContainer(
              width: 300,
              height: 300,
              bRadius: 30,
              color: Colors.white,
              child: Image.asset(
                'assets/6.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.index});

  final int index;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  List<DetailedContentArguments>? dashBoardContent;

  @override
  void initState() {
    // Initialize project details for each card
    dashBoardContent = List.generate(
      kColorsList!.length,
          (index) => DetailedContentArguments(
        title: kTitle[index],
        sub: kSub[index],
        teamList: kTeamImages,
        deadLine: kDeadLine[index],
        percentage: kTaskPercentages[index],
        color: kColorsList![index],
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // InkWell for tapping and navigating to detailed view
    return InkWell(
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedView(
              detailedContentargument: DetailedContentArguments(
                title: dashBoardContent![widget.index].title!,
                color: dashBoardContent![widget.index].color!,
                percentage: dashBoardContent![widget.index].percentage!,
                deadLine: dashBoardContent![widget.index].deadLine!,
                teamList: dashBoardContent![widget.index].teamList!,
                sub: dashBoardContent![widget.index].sub!,
              ),
            ),
          ),
        );
      },
      child: ShadowContainer(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 13, right: 13, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dashBoardContent![widget.index].title!,
                    style: kBoldTaskText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(dashBoardContent![widget.index].sub!,
                      style: kLightTaskText),
                  const SizedBox(height: 15),
                  Text('Team', style: kBoldTaskText.copyWith(fontSize: 14)),
                  const SizedBox(height: 15),
                  StackedImage(
                    images: dashBoardContent![widget.index].teamList!,
                    isFinalAdd: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.calendar_month,
                          color: Color(0xff858587),
                        ),
                      ),
                      Text(dashBoardContent![widget.index].deadLine!,
                          style: kLightTaskText),
                    ],
                  ),
                ],
              ),
              AnimtedProgressWithPercentage(
                  value: dashBoardContent![widget.index].percentage!,
                  color: dashBoardContent![widget.index].color!),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateTaskList() {
    Random random = Random();
    List<Color> color = [
      kInProgressColor,
      kCancelColor,
      kCompletedColor,
      kOnGoingColor,
    ];

    List text = ['App Animation', 'Dashboard Design', 'Ui/Ux Design'];

    return List.generate(8, (index) {
      int randomNumber = random.nextInt(8) + 1;
      int randomNumber1 = random.nextInt(3);
      print(randomNumber);
      return Container(
        width: 200,
        height: 200,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 400),
          tween: Tween<double>(begin: 0, end: randomNumber * 0.13),
          builder: (context, double value, child) {
            return CircularProgressIndicator(
              value: value,
              color: color[randomNumber1],
              backgroundColor: Colors.transparent,
            );

            /* LinearProgressIndicator(
                  value: value,
                  color: _color[randomNumber1],
                  backgroundColor: Colors.transparent,
                //  borderRadius: BorderRadius.circular(15),
                );*/
          },
        ),
      );
    });
  }
}

class DetailedContentArguments {
  final String? title;
  final String? sub;
  final List<String>? teamList;
  final String? deadLine;
  final double? percentage;
  final Color? color;

  DetailedContentArguments(
      {this.title,
      this.sub,
      this.teamList,
      this.deadLine,
      this.percentage,
      this.color});
}
