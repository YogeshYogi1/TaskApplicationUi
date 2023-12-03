import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ShadowContainer extends StatelessWidget {
  ShadowContainer({super.key, required this.child, this.radius = 15.0});
  Widget child;
  double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, right: 13, left: 13, top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
              color: Color(0xffefeef3), offset: Offset(-5, 5), blurRadius: 5),
          BoxShadow(
              color: Color(0xffefeef3), offset: Offset(5, -5), blurRadius: 5),
          BoxShadow(
              color: Color(0xffefeef3), offset: Offset(-5, -5), blurRadius: 5),
          BoxShadow(
              color: Color(0xffefeef3), offset: Offset(5, 5), blurRadius: 5),
        ],
      ),
      child: child,
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final profileAvatarAlignTween = AlignmentTween(
        begin: const Alignment(-0.65, 0.75), end: const Alignment(-0.75, 0.4));

    var myProgress = shrinkOffset / (minExtent);
    myProgress = myProgress > 0 ? myProgress : 0;
    myProgress = myProgress > 1 ? 1 : myProgress;

    var progress = shrinkOffset / (maxExtent - (minExtent + 20));
    progress = progress > 0 ? progress : 0;
    progress = progress > 1 ? 1 : progress;

    var progress1 = shrinkOffset / (maxExtent - (minExtent + 50));
    progress1 = progress1 > 0 ? progress1 : 0;
    progress1 = progress1 > 1 ? 1 : progress1;

    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          color: Colors.white,
        ),
        const Align(
          alignment:
              //profileAvatarAlignTween.lerp(myProgress),
              Alignment(-0.92, -0.3),
          child: CircleAvatar(
            minRadius: 40,
            maxRadius: 40,
            backgroundColor: Color(0xffe7e6f6),
            backgroundImage:AssetImage(
                'assets/2.jpg',
            ),
          ),
        ),
        Opacity(
          opacity: 1.0 - progress1,
          child:  Align(
            alignment: const Alignment(-0.9, 0.6),
            child: Text(
              'Hello',
              style: kBoldTaskText.copyWith(fontSize: 16),
            ),
          ),
        ),
        Opacity(
          opacity: 1.0 - progress,
          child: const Align(
            alignment: Alignment(-0.9, 1),
            child: Text(
              'Invincible __',
              style: kHeadText,
            ),
          ),
        ),
        Opacity(
          opacity: progress,
          child:  Align(
            alignment:const Alignment(0, 0),
            child: Text('Invincible __',style: kHeadText.copyWith(fontSize: 20,color: Colors.grey.shade800),),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class AnimtedProgressWithPercentage extends StatelessWidget {
  const AnimtedProgressWithPercentage({
    super.key,
    required this.value,
    required this.color,
    this.size = 80,
  });

  final double value;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: value*0.01
                //randomNumber! * 0.13,
                ),
            builder: (context, double value, child) {
              return CircularProgressIndicator(
                value: value,
                strokeWidth: 10,
                color: color,
                backgroundColor: Colors.transparent,
              );
            },
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: Text('${(value )} %'),
          )
        ],
      ),
    );
  }
}

class StackedImage extends StatelessWidget {
  const StackedImage(
      {super.key,
      required this.images,
      required this.isFinalAdd,
      this.itemSize = 35,
      this.position = 25,
      this.totalWidth = 160});

  final List images;
  final bool isFinalAdd;
  final double itemSize;
  final double position;
  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemSize,
      width: totalWidth,
      child: Stack(
        children: [
          ...List.generate(
            5,
            (index) => Positioned(
              left: index * position,
              child: Container(
                height: itemSize,
                width: itemSize,
                decoration: BoxDecoration(
                  color:
                      (isFinalAdd && (index == 4)) ? Colors.black : Colors.blue,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ClipOval(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LineChartView extends StatelessWidget {
  LineChartView({super.key, required this.color});
  final Color color;

  final List<FlSpot> spots = const [
    FlSpot(0,0),
    FlSpot(20.39, 39.20),
    FlSpot(55.23, 86.94),
    FlSpot(81.43, 68.43),
    FlSpot(118.52, 57.60),
  ];

  final leftTitle = {0: '0', 33: '2', 66: '5', 100: '10'};
  final bottomTitle = {
    0: 'Sun',
    18: 'Mon',
    35: 'Tue',
    58: 'Wed',
    75: 'Thu',
    88: 'Fri',
    100: 'Sat',
  };


  @override
  Widget build(BuildContext context) {
    List<Color> gradientColor =[
    color.withOpacity(0.5),
    color.withOpacity(0.1),
    // Colors.transparent
  ];

  return Container(
      padding: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: AspectRatio(
        aspectRatio: 
        9 / 4,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return bottomTitle[value.toInt()] != null
                        ? SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 10,
                      child: Text(
                        bottomTitle[value.toInt()].toString(),
                        style: kLightTaskText.copyWith(fontSize: 16),
                      ),
                    )
                        : const SizedBox();
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return leftTitle[value.toInt()] != null
                        ? Text(
                      leftTitle[value.toInt()].toString(),
                      style: kLightTaskText.copyWith(fontSize: 16),
                    )
                        : const SizedBox();
                  },
                  showTitles: true,
                  interval: 1,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                  isCurved: true,
                  curveSmoothness: 0.5,
                  color: color,
                  barWidth: 2.5,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: gradientColor,
                    ),
                    show: true,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  dotData: const FlDotData(show: false),
                  spots: spots)
            ],
            minX: 0,
            maxX: 120,
            maxY: 105,
            minY: -5,
          ),
          // swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
