import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychotherapy_chatbot/controllers/journal_controller.dart';

import '../constants/colors.dart';
import '../models/journal.dart';

class MoodChart extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const MoodChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MoodChartState();
}

class MoodChartState extends State<MoodChart> {
  JournalController journalController = Get.find<JournalController>();

  final Color barBackgroundColor = Colors.grey.shade200;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  Map<dynamic, double> moods = {
    Mood.EXCITED: 10,
    Mood.HAPPY: 9,
    Mood.SURPRISED: 7,
    Mood.NEUTRAL: 6,
    Mood.CONFUSED: 5,
    Mood.ANGRY: 4,
    Mood.SAD: 3,
    Mood.SCARED: 2,
    Mood.CRYING: 1,
  };

  Map<dynamic, dynamic> emojis = {
    Mood.HAPPY: Emoji('happy', '😀'),
    Mood.SAD: Emoji('sad', '😢'),
    Mood.ANGRY: Emoji('angry', '😡'),
    Mood.SURPRISED: Emoji('surprised', '😮'),
    Mood.SCARED: Emoji('scared', '😱'),
    Mood.NEUTRAL: Emoji('neutral', '😐'),
    Mood.CONFUSED: Emoji('confused', '😕'),
    Mood.CRYING: Emoji('crying', '😭'),
    Mood.EXCITED: Emoji('excited', '😄')
  };

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Mood Chart',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Keep track of your mood over time!',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = blue,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.amber : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.amber, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 10,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Mood? getDataByDay(String day) {
    Journal obj = journalController.journalData.firstWhere(
        (element) => DateFormat('EEEE').format(element.date!) == day,
        orElse: () => Journal());
    return obj.mood;
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            double y = moods[getDataByDay('Monday')] ?? 0;
            return makeGroupData(0, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 1:
            double y = moods[getDataByDay('Tuesday')] ?? 0;
            return makeGroupData(1, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 2:
            double y = moods[getDataByDay('Wednesday')] ?? 0;
            return makeGroupData(2, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 3:
            double y = moods[getDataByDay('Thursday')] ?? 0;
            return makeGroupData(3, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 4:
            double y = moods[getDataByDay('Friday')] ?? 0;
            return makeGroupData(4, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 5:
            double y = moods[getDataByDay('Saturday')] ?? 0;
            return makeGroupData(5, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          case 6:
            double y = moods[getDataByDay('Sunday')] ?? 0;
            return makeGroupData(6, y,
                isTouched: i == touchedIndex,
                barColor: y == 6
                    ? Colors.orange
                    : y > 6
                        ? Colors.green
                        : Colors.red);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = getDataByDay('Monday').toString().split('.').last;
                  break;
                case 1:
                  weekDay = getDataByDay('Tuesday').toString().split('.').last;
                  break;
                case 2:
                  weekDay =
                      getDataByDay('Wednesday').toString().split('.').last;
                  break;
                case 3:
                  weekDay = getDataByDay('Thursday').toString().split('.').last;
                  break;
                case 4:
                  weekDay = getDataByDay('Friday').toString().split('.').last;
                  break;
                case 5:
                  weekDay = getDataByDay('Saturday').toString().split('.').last;
                  break;
                case 6:
                  weekDay = getDataByDay('Sunday').toString().split('.').last;
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: topTitles,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget topTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Facundo',
    );
    Emoji text;
    switch (value.toInt()) {
      case 0:
        text = emojis[getDataByDay('Monday')] ?? Emoji('nothing', '');
        break;
      case 1:
        text = emojis[getDataByDay('Tuesday')] ?? Emoji('nothing', '');
        break;
      case 2:
        text = emojis[getDataByDay('Wednesday')] ?? Emoji('nothing', '');
        break;
      case 3:
        text = emojis[getDataByDay('Thursday')] ?? Emoji('nothing', '');
        break;
      case 4:
        text = emojis[getDataByDay('Friday')] ?? Emoji('nothing', '');
        break;
      case 5:
        text = emojis[getDataByDay('Saturday')] ?? Emoji('nothing', '');
        break;
      case 6:
        text = emojis[getDataByDay('Sunday')] ?? Emoji('nothing', '');
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      child: Text(text.code, style: style),
      axisSide: meta.axisSide,
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: 'Facundo',
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
