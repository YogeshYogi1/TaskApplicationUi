import 'package:flutter/material.dart';

const TextStyle kHeadText = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);

const TextStyle kBoldTaskText = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: Color(0xff0a0a0a),
);

const TextStyle kLightTaskText = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Color(0xff858587),
);

List<String> kTitle = [
  "App Animation",
  "Dashboard Design",
  "UI/UX Design",
  "Game Development",
];

List<String> kSub = [
  'Today,Shared by - Unbox Digital',
  'Today,Shared by - UI',
  'Today,Shared by - Yogesh',
  'Today,Shared by - Unbox',
];

List<String> kDeadLine = [
  'June 5,2021 - June 22 2021',
  'June 15,2021 - June 30 2021',
  'June 12,2021 - June 22 2021',
  'June 15,2021 - June 22 2021',
];

List<String> kTeamImages = [
  'assets/1.jpg',
  'assets/2.jpg',
  'assets/3.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
];

List<double> kTaskPercentages = [65, 100, 30, 10];

List<Color>? kColorsList = [
  kOnGoingColor,
  kCompletedColor,
  kInProgressColor,
  kCancelColor,
];

const Widget kNegativeSpacing = SizedBox(height: 100);

const kInProgressColor = Color(0xfffec377);
const kOverLayProgressColor = Color(0xffff996e);
const kOnGoingColor = Color(0xff9297ff);
const kOverLayGoingColor = Color(0xff7880ff);
const kCompletedColor = Color(0xffc0ea94);
const kOverLayCompletedColor = Color(0xffb1d885);
const kCancelColor = Color(0xffff7648);
const kOverLayCancelColor = Color(0xfffec377);
