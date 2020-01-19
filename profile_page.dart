import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomPaint(
                    painter: ArcPainter(type: PaintType.left),
                    child: Icon(Icons.keyboard_arrow_left)),
                CustomPaint(
                  painter: ArcPainter(type: PaintType.right),
                  child: Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Moments",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 35),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    height: 100,
                    width: 100,
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFE7227),
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xffFE7227), Color(0xffFEA120)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffFE7227),
                                offset: Offset(0, 10),
                                blurRadius: 20)
                          ]),
                    ),
                  ),
                  Positioned(
                    height: 100,
                    width: 100,
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xffB767FC), Color(0xffD765FB)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffB767FC),
                                offset: Offset(0, 10),
                                blurRadius: 20)
                          ]),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [Color(0xff3DD92E), Color(0xff8BFB6B)]),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 30),
                            color: Color(0xFF3DD92E).withAlpha(100),
                            blurRadius: 40)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 4),
                                    color: Colors.black38,
                                    blurRadius: 5)
                              ]),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/mario.png",
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          "Mario Hero",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    height: 35,
                    width: 35,
                    top: 40,
                    left: 40,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xff0894FF), Color(0xff05BFFA)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff0894FF),
                                offset: Offset(0, 5),
                                blurRadius: 10)
                          ]),
                    ),
                  ),
                  Positioned(
                    height: 15,
                    width: 15,
                    bottom: 40,
                    right: 40,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF3443),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffFF3443),
                                offset: Offset(0, 2),
                                blurRadius: 5)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum PaintType { left, right }

class ArcPainter extends CustomPainter {
  final PaintType type;
  ArcPainter({this.type});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xffFFC300)
      ..style = PaintingStyle.fill;

    if (type == PaintType.right) {
      paint.color = Color(0xffA562FF);
      canvas.drawCircle(Offset(20, 0), 60, paint);
    } else {
      canvas.drawCircle(Offset(-10, -10), 130, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
