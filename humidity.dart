import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;

class Humidity extends StatefulWidget {
  @override
  _HumidityState createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Row(
        children: <Widget>[
          HumidCtrl(),
          HumidityDetails(),
        ],
      ),
    ));
  }
}

class HumidityDetails extends StatelessWidget {
  const HumidityDetails({
    Key key,
  }) : super(key: key);

  SizedBox buildSizedBox([double size = 1]) {
    return SizedBox(
      height: 20 * size,
    );
  }

  Widget buildtitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.blueGrey[200],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildValue(String text, [double size = 1]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30 * size,
        color: Colors.indigo[900],
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildtitle("RETURN TEMPERATURE"),
          buildSizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildValue('20'),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'o',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              buildValue("C"),
            ],
          ),
          buildSizedBox(3),
          buildtitle("CURRENT HUMIDITY"),
          buildSizedBox(),
          buildValue("37%", 2),
          buildSizedBox(2),
          buildtitle("ABSOLUTE HUMIDITY"),
          buildSizedBox(),
          buildValue("4gr/ft3")
        ],
      ),
    );
  }
}

class HumidCtrl extends StatefulWidget {
  @override
  _HumidCtrlState createState() => _HumidCtrlState();
}

class _HumidCtrlState extends State<HumidCtrl> {
  ValueNotifier<double> humidity = ValueNotifier(100);

  void onChangeDegree(double value) {
    humidity.value += value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: humidity,
            builder: (_, double value, child) {
              return ClipPath(
                clipper: CurveClipper(value),
                child: child,
              );
            },
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.indigo,
                    Colors.red,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withAlpha(100),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DegreeBuilder(
              humidity: humidity,
            ),
          ),
          Positioned(
            right: 50,
            top: 0,
            bottom: 0,
            child: ReadingLines(
              humidity: humidity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white10,
                  Colors.white10,
                  Colors.white10,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          DragWidget(
            onChangeDegree: onChangeDegree,
            humidityPosition: humidity,
          ),
        ],
      ),
    );
  }
}

class DragWidget extends StatelessWidget {
  const DragWidget({
    Key key,
    @required this.onChangeDegree,
    @required this.humidityPosition,
  }) : super(key: key);

  final ValueNotifier<double> humidityPosition;
  final ValueChanged<double> onChangeDegree;

  void onVerticalDragUpdate(DragUpdateDetails details) {
    onChangeDegree(details.delta.dy);
  }

  Widget buildButton() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.indigo[300],
            spreadRadius: .2,
          ),
        ],
      ),
      child: GestureDetector(
        onPanUpdate: onVerticalDragUpdate,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 5,
              child: Icon(
                Icons.arrow_drop_up,
                size: 35,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 5,
              child: Icon(
                Icons.arrow_drop_down,
                size: 35,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: humidityPosition,
      builder: (_, double position, child) {
        return Positioned(
          top: position,
          left: 120,
          child: child,
        );
      },
      child: buildButton(),
    );
  }
}

class DegreeBuilder extends StatefulWidget {
  const DegreeBuilder({
    Key key,
    @required this.humidity,
  }) : super(key: key);

  final ValueListenable<double> humidity;

  @override
  _DegreeBuilderState createState() => _DegreeBuilderState();
}

double calcPosition(int index, double screenHeight) =>
    (index * .777) * screenHeight / (10 * .789) - 2;

class _DegreeBuilderState extends State<DegreeBuilder> {
  int controlIndex = 1;
  double screenHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        screenHeight = constraints.maxHeight;
        return Stack(
          children: List.generate(
            9,
            (int i) {
              final index = i + 1;
              return ValueListenableBuilder(
                valueListenable: widget.humidity,
                builder: (_, double value, child) {
                  double top = calcPosition(index, screenHeight);

                  final rangeTop = top - 10;
                  final rangeBottom = top;

                  if (value >= rangeTop && value <= rangeBottom) {
                    controlIndex = index;
                  }

                  bool isSelected = false;
                  if (controlIndex == index) {
                    isSelected = true;
                    top = value;
                  }

                  return DegreeValue(
                    isSelected: isSelected,
                    degreeNumber: value,
                    position: top,
                    index: index,
                    screenHeight: screenHeight,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class DegreeValue extends StatefulWidget {
  final double degreeNumber;
  final bool isSelected;
  final double position;
  final int index;
  final double screenHeight;

  const DegreeValue({
    Key key,
    this.degreeNumber,
    this.isSelected,
    this.position,
    this.index,
    this.screenHeight,
  }) : super(key: key);
  @override
  _DegreeValueState createState() => _DegreeValueState();
}

class _DegreeValueState extends State<DegreeValue>
    with SingleTickerProviderStateMixin {
  int degreeValue;
  double position;
  Color color = Colors.indigo;
  double fontSize = 15;
  bool isAnimating = false;
  AnimationController animCtrl;
  IntTween numberTween;
  Tween<double> positionTween;
  Tween<double> fontTween;
  ColorTween colorTween;
  Animation<double> positionAnim;
  Animation<int> numberAnim;
  Animation<double> fontAnim;
  Animation<Color> colorAnim;

  double topPosition = 0;
  double initialPosition = 0;
  double bottomPosition = 0;

  int initialDegreeValue = 0;

  int calculateDegreeValue() =>
      100 - (widget.degreeNumber * 100 ~/ widget.screenHeight) - 2;

  @override
  void didUpdateWidget(DegreeValue oldWidget) {
    if (widget.isSelected) {
      final widgetPos = widget.position;

      if ((widgetPos > initialPosition && widgetPos < bottomPosition) ||
          (widgetPos < initialPosition && widgetPos > topPosition)) {
        position = widgetPos;
        degreeValue = calculateDegreeValue();
        isAnimating = true;
        fontSize = 18;
        color = Colors.blue;
      } else
        resetData();
    } else if (isAnimating) resetData();
    super.didUpdateWidget(oldWidget);
  }

  void resetData() {
    isAnimating = false;
    numberTween.begin = degreeValue;
    positionTween.begin = position;

    animCtrl.reset();
    numberTween.end = initialDegreeValue;
    positionTween.end = initialPosition;

    animCtrl.forward();
  }

  @override
  void initState() {
    final index = widget.index;
    degreeValue = initialDegreeValue = 100 - index * 10;

    if (widget.isSelected) {
      degreeValue = calculateDegreeValue();
      isAnimating = true;
      color = Colors.blue;
    }
    position = widget.position;
    initialPosition = calcPosition(index, widget.screenHeight);
    topPosition = calcPosition(index - 1, widget.screenHeight) + 10;
    bottomPosition = calcPosition(index + 1, widget.screenHeight) - 15;

    animCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {
          degreeValue = numberAnim.value;
          position = positionAnim.value;
          color = colorAnim.value;
          fontSize = fontAnim.value;
        });
      });
    numberTween = IntTween(begin: 0, end: 0);
    positionTween = Tween(begin: widget.position, end: widget.position);
    colorTween = ColorTween(begin: Colors.blue, end: Colors.indigo);
    fontTween = Tween(begin: 18, end: 15);

    fontAnim = fontTween.animate(animCtrl);
    colorAnim = colorTween.animate(animCtrl);
    positionAnim = positionTween.animate(animCtrl);
    numberAnim = numberTween.animate(animCtrl);

    super.initState();
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      top: position,
      child: Text(
        "$degreeValue%",
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class ReadingLines extends StatelessWidget {
  const ReadingLines({
    Key key,
    @required this.humidity,
  }) : super(key: key);

  final ValueNotifier<double> humidity;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, contstrain) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          HorizontalLines(
              humidity: humidity, screenHeight: contstrain.maxHeight),
          VerticalLine(
            humicity: humidity,
          ),
        ],
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({
    Key key,
    @required this.humicity,
  }) : super(key: key);

  final humicity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: double.infinity,
      child: ValueListenableBuilder(
        valueListenable: humicity,
        builder: (_, value, child) => CustomPaint(
          painter: HorizontalPaint(value),
        ),
      ),
    );
  }
}

Path getPathForCurve(Size size, double humidity) {
  final width = size.width;
  final height = size.height;
  final curvePoint = humidity - 47;

  final qx1 = width;
  final qy1 = curvePoint + 15;
  final qx2 = width - 15;
  final qy2 = curvePoint + 30;
  final q1x1 = width - 40;
  final q1y1 = curvePoint + 60;
  final q1x2 = width - 15;
  final q1y2 = curvePoint + 90;
  final q2x1 = width;
  final q2y1 = curvePoint + 105;
  final q2x2 = width;
  final q2y2 = curvePoint + 125;

  final l1x = width;
  final l1y = curvePoint;
  final l2x = width;
  final l2y = height;
  return Path()
    ..lineTo(width, 0)
    ..lineTo(l1x, l1y)
    ..quadraticBezierTo(qx1, qy1, qx2, qy2)
    ..quadraticBezierTo(q1x1, q1y1, q1x2, q1y2)
    ..quadraticBezierTo(q2x1, q2y1, q2x2, q2y2)

    // ..cubicTo(sx1, sy1, sx2, sy2, sx3, sy3)
    // ..cubicTo(ex1, ey1, ex2, ey2, ex3, ey3)
    ..lineTo(l2x, l2y)
    ..lineTo(width, height)
    ..lineTo(0, height);
}

class CurveClipper extends CustomClipper<Path> {
  CurveClipper(this.humidity);

  final double humidity;

  @override
  Path getClip(Size size) {
    return getPathForCurve(size, humidity);
  }

  @override
  bool shouldReclip(CurveClipper oldClipper) {
    return oldClipper.humidity != humidity;
  }
}

class HorizontalPaint extends CustomPainter {
  HorizontalPaint(this.humidityPosition);

  final double humidityPosition;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        Colors.red,
        Colors.indigo,
        Colors.red,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    );

    final width = size.width;
    final height = size.height;
    final rect = Rect.fromLTWH(0, 0, width, height);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..shader = gradient.createShader(rect);
    final path = getPathForCurve(size, humidityPosition);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HorizontalPaint oldDelegate) =>
      oldDelegate.humidityPosition != humidityPosition;
}

class HorizontalLines extends StatelessWidget {
  const HorizontalLines({
    Key key,
    @required this.humidity,
    this.screenHeight,
  }) : super(key: key);

  final double screenHeight;
  final ValueNotifier<double> humidity;

  Widget buildHorizontalLine(int index) {
    return ValueListenableBuilder(
      valueListenable: humidity,
      builder: (_, double value, child) {
        return SizedBox(
          width: 40,
          height: 5,
          child: CustomPaint(
            painter: HorizontalLinePaint(index, value, screenHeight),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        100,
        (int index) => buildHorizontalLine(index),
      ),
    );
  }
}

class HorizontalLinePaint extends CustomPainter {
  HorizontalLinePaint(this.index, this.humidity, this.screenHeight);

  final int index;
  final double humidity;
  final double screenHeight;

  double getSubVal(double rval) {
    double b = rval * .1;
    final abs = b.abs();
    if (abs >= .1 && abs <= .2) {
      b -= .05;
    } else if (abs >= .2 && abs <= .3) {
      b -= .08;
    } else if (abs >= .3 && abs <= .4) {
      b -= .070;
    } else if (abs >= .4 && abs <= .5) {
      b -= .080;
    } else if (abs >= .5 && abs <= .6) {
      b -= .016;
    } else if (abs >= .6 && abs <= .7) {
      b += .060;
    }
    return 30 - b * 37;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double sintent = size.width - 5;
    double eintent = size.width * .5;
    if (index % 10 == 0) {
      eintent -= 10;
    }
    // final hval = (index * .777) * screenHeight / (10 * .789) - 2;

    final hval = humidity * 100 / screenHeight + 1.5;
    double subv = 0;
    final si = index + 7;
    final ei = index - 7;
    double rval = 0;
    if (hval <= si && hval >= index) {
      rval = hval - index;
      subv = getSubVal(rval);
    } else if (hval >= ei && hval <= index) {
      rval = index - hval;
      subv = getSubVal(rval);
    }

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final p1 = Offset(sintent - subv, 0);
    final p2 = Offset(eintent - subv, 0);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(HorizontalLinePaint oldDelegate) {
    final startIndex = index - 1;
    final endIndex = index + 1;
    return humidity >= startIndex && humidity <= endIndex;
  }
}
