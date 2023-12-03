import 'package:challenge_one/ui/view/project.dart';
import 'package:flutter/material.dart';
import '../component/constants.dart';
import '../component/widgets/widgets.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key, this.detailedContentargument});
  final DetailedContentArguments? detailedContentargument;

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafc),
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project details with progress section
            projectDetailWProgress(),
            // Project progress checklist
            SizedBox(
              height: 50,
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Project Progress',
                    style: kHeadText.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
            projectProgress(),
            // Project overview with LineChartView
            SizedBox(
              height: 50,
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Project Overview',
                    style: kHeadText.copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
            projectOverview(),
            // Negative spacing for better visual separation
            kNegativeSpacing
          ],
        ),
      ),
    );
  }

  // Widget for the LineChartView in the project overview
  ShadowContainer projectOverview() {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 13, bottom: 13, right: 13),
        child: LineChartView(
          color: widget.detailedContentargument!.color!,
        ),
      ),
    );
  }

  // Container for displaying project details along with progress
  Container projectDetailWProgress() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30, left: 13, right: 13),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project title
          Text(
            widget.detailedContentargument!.title!,
            style: kHeadText.copyWith(fontSize: 23),
          ),
          const SizedBox(height: 16),
          // Project subtitle
          Text(
            widget.detailedContentargument!.sub!,
            style: kLightTaskText.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 30),
          // Row displaying team, deadline, and progress
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // Animated progress with percentage
                    AnimtedProgressWithPercentage(
                      color: widget.detailedContentargument!.color!,
                      value: widget.detailedContentargument!.percentage!,
                      size: 90,
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Team', style: kBoldTaskText.copyWith(fontSize: 14)),
                    const SizedBox(height: 13),
                    // StackedImage displaying team members
                    StackedImage(
                      images: widget.detailedContentargument!.teamList!,
                      isFinalAdd: true,
                    ),
                    const SizedBox(height: 18),
                    Text('Deadline',
                        style: kBoldTaskText.copyWith(fontSize: 14)),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.calendar_month,
                            color: Color(0xff858587),
                          ),
                        ),
                        Text(widget.detailedContentargument!.deadLine!,
                            style: kLightTaskText),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ShadowContainer for displaying project progress checklist
  ShadowContainer projectProgress() {
    return ShadowContainer(
      child: Column(
        children: [
          // Checklist items with checkboxes
          ListTile(
            leading: Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            title: Text(
              'Create User flow',
              style: kBoldTaskText.copyWith(fontSize: 15),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            title: Text(
              'Create wireframe',
              style: kBoldTaskText.copyWith(fontSize: 15),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: false,
              checkColor: Colors.grey,
              onChanged: (value) {},
            ),
            title: Text(
              'Transform to visual design',
              style: kBoldTaskText.copyWith(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  // AppBar for the detailed view screen
  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
      actions: const [
        Icon(
          Icons.more_vert_sharp,
          color: Colors.black,
        ),
      ],
    );
  }
}
