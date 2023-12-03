import 'package:challenge_one/ui/view/detailedView.dart';
import 'package:challenge_one/ui/view/project.dart';
import 'package:flutter/material.dart';
import '../component/constants.dart';
import '../component/utils.dart';
import '../component/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // CustomScrollView with slivers for the header and body
    return CustomScrollView(
      slivers: [
        sliverHeader(), // Sliver for the persistent header
        sliverBody(), // Sliver for the body content
      ],
    );
  }

  // Sliver for the body content
  SliverList sliverBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          // Container for the main content
          Container(
            color: Colors.white,
            child: Column(
              children: [
                gridSection(), // Grid section with cards
                // Section for Daily Task
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daily Task',
                        style: kHeadText.copyWith(fontSize: 20),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              'All Task',
                              style: kLightTaskText,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    ],
                  ),
                ),
                // List of tasks
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: generateTaskList().length * 85,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: generateTaskList(),
                  ),
                )
              ],
            ),
          ),
          kNegativeSpacing
        ],
      ),
    );
  }

  // Container for the grid of cards
  Container gridSection() {
    return Container(
      height: 270,
      padding: const EdgeInsets.only(left: 13, right: 13, top: 15),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 13.0,
          mainAxisSpacing: 13.0,
          mainAxisExtent: 120,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return CardView(
            icon: _progressCardContent[index].icon!,
            name: _progressCardContent[index].title!,
            overLayItem: _progressCardContent[index].positioned!,
            color: _progressCardContent[index].color!,
          );
        },
      ),
    );
  }

  // Sliver for the persistent header
  SliverPersistentHeader sliverHeader() {
    return SliverPersistentHeader(
      delegate: SliverDelegate(),
      pinned: true,
    );
  }

  // List of tasks with InkWell for tapping and navigating to details
  List<Widget> generateTaskList() {
    return List.generate(kColorsList!.length, (index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedView(
                detailedContentargument: DetailedContentArguments(
                  color: kColorsList![index],
                  teamList: kTeamImages,
                  deadLine: kDeadLine[index],
                  percentage: kTaskPercentages[index],
                  title: kTitle[index],
                  sub: kSub[index],
                ),
              ),
            ),
          );
        },
        child: ShadowContainer(
          child: ListTile(
            leading: (kTaskPercentages[index] == 100)
                ? const Icon(Icons.check_circle, color: kCompletedColor)
                : const Icon(
              Icons.check_circle_outline_sharp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kTitle[index],
                        style: kBoldTaskText,
                      ),
                      const SizedBox(height: 8),
                      // Linear progress indicator with animation
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .40,
                        height: 10,
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 800),
                          tween: Tween<double>(
                              begin: 0, end: kTaskPercentages[index] * 0.01),
                          builder: (context, double value, child) {
                            print(value);
                            return LinearProgressIndicator(
                              value: value,
                              color: kColorsList![index],
                              backgroundColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Team images and arrow icon
                  Row(
                    children: [
                      StackedImage(
                          images: kTeamImages,
                          isFinalAdd: false,
                          itemSize: 25,
                          totalWidth: 78,
                          position: 13),
                      const Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // Data for the grid cards
  final List<ProgressCardContent> _progressCardContent = [
    ProgressCardContent(
      title: 'In Progress',
      icon: Icons.access_time,
      color: kInProgressColor,
      positioned: Positioned(
        left: 30,
        top: -18,
        child: Shape.circle.getShapeContainer(
            height: 40, width: 40, color: kOverLayProgressColor),
      ),
    ),
    ProgressCardContent(
      title: 'On Going',
      icon: Icons.repeat,
      color: kOnGoingColor,
      positioned: Positioned(
        bottom: -24,
        left: 43,
        child: Shape.rectangle.getShapeContainer(
            bRadius: 15, height: 50, width: 50, color: kOverLayGoingColor),
      ),
    ),
    ProgressCardContent(
      title: 'Completed',
      icon: Icons.task,
      color: kCompletedColor,
      positioned: Positioned(
        left: -20,
        bottom: 30,
        child: Shape.circle.getShapeContainer(
          height: 40,
          width: 40,
          color: kOverLayCompletedColor,
        ),
      ),
    ),
    ProgressCardContent(
      title: 'Cancel',
      icon: Icons.free_cancellation,
      color: kCancelColor,
      positioned: Positioned(
        left: 30,
        top: -18,
        child: Shape.circle.getShapeContainer(
            bRadius: 15, height: 40, width: 40, color: kOverLayCancelColor),
      ),
    ),
  ];
}

// CardView widget for displaying a card with an overlay item
class CardView extends StatelessWidget {
  const CardView(
      {super.key,
      required this.overLayItem,
      required this.name,
      required this.icon,
      required this.color});

  final Positioned overLayItem;
  final String name;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shape.rectangle.getShapeContainer(
          height: 120,
          width: double.maxFinite,
          color: color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon),
                ),
                Text(name),
              ],
            ),
          ),
          bRadius: 15,
        ),
        overLayItem
      ],
    );
  }
}

class ProgressCardContent {
  final String? title;
  final IconData? icon;
  final Positioned? positioned;
  final Color? color;
  ProgressCardContent({this.title, this.icon, this.positioned, this.color});
}
