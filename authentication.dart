import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>
    with SingleTickerProviderStateMixin {
  final colors = [
    Color(0xFF615CD2),
    Color(0xffCC76FD),
  ];

  final highLightColor = Color(0xffCC76FD);
  AnimationController _animationController;
  Animation<Offset> _signInanimation;
  Animation<Offset> _signUpanimation;
  bool isSignup = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _signInanimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _signUpanimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  toggleAuthView() {
    setState(() {
      isSignup = !isSignup;
    });
    if (isSignup) {
      _animationController.forward();
    } else
      _animationController.reverse();
  }

  void onPressGoogle() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.topRight),
      ),
      child: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Auth",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 50,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildButtons(),
                Expanded(
                    child: Stack(
                  children: <Widget>[
                    buildInputs(),
                    buildSignupInputs(),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SlideTransition(
            position: _signInanimation,
            child: Container(
              child: CustomPaint(
                painter: FormPainter(PaintTypes.SIGN_IN),
                child: Padding(
                  padding: EdgeInsets.only(left: 50, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      buildTitle("Login"),
                      SizedBox(height: 70),
                      buildLabelAndIcon("Email", Icons.email),
                      buildTextField(),
                      SizedBox(height: 20),
                      buildLabelAndIcon("Password", Icons.vpn_key),
                      buildTextField(),
                      SizedBox(height: 20),
                      Text("Forget Password"),
                      SizedBox(height: 70),
                      Center(
                        child: buildRaisedButton("Login"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSignupInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SlideTransition(
            position: _signUpanimation,
            child: Container(
              child: CustomPaint(
                painter: FormPainter(PaintTypes.SIGN_UP),
                child: Padding(
                  padding: EdgeInsets.only(left: 50, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      buildTitle("Sign up"),
                      SizedBox(height: 30),
                      buildLabelAndIcon("Name", Icons.account_circle),
                      buildTextField(),
                      SizedBox(height: 20),
                      buildLabelAndIcon("Email", Icons.email),
                      buildTextField(),
                      SizedBox(height: 20),
                      buildLabelAndIcon("Password", Icons.vpn_key),
                      buildTextField(),
                      SizedBox(height: 30),
                      Center(
                        child: buildRaisedButton("Sign up"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 50, fontWeight: FontWeight.w300),
    );
  }

  RaisedButton buildRaisedButton(String label) {
    return RaisedButton(
      elevation: 0,
      textColor: highLightColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 25),
      ),
      color: Colors.white,
      onPressed: () {},
    );
  }

  Row buildLabelAndIcon(String name, IconData icon) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(name),
        ),
        Icon(icon),
      ],
    );
  }

  TextField buildTextField() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white12,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.white12, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.white12, width: 0.0),
        ),
      ),
    );
  }

  Column buildButtons() {
    return Column(
      children: <Widget>[
        SizedBox(height: 100),
        RaisedButton(
          animationDuration: Duration(milliseconds: 0),
          textColor: Colors.white,
          color: isSignup ? Colors.transparent : highLightColor,
          elevation: isSignup ? 0 : 10,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: toggleAuthView,
        ),
        SizedBox(height: 30),
        RaisedButton(
          animationDuration: Duration(milliseconds: 0),
          textColor: Colors.white,
          color: isSignup ? highLightColor : Colors.transparent,
          elevation: isSignup ? 10 : 0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            "Sign up",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: toggleAuthView,
        ),
        SizedBox(height: 30),
        buildSocialIcon("assets/images/google.png"),
        SizedBox(height: 10),
        buildSocialIcon("assets/images/facebook.png"),
        SizedBox(height: 10),
        buildSocialIcon("assets/images/twitter.png"),
      ],
    );
  }

  Container buildSocialIcon(String imagePath) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)]),
      child: Image.asset(
        imagePath,
        height: 50,
        width: 50,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

enum PaintTypes { SIGN_IN, SIGN_UP }

class FormPainter extends CustomPainter {
  final PaintTypes place;
  FormPainter(this.place);

  @override
  void paint(Canvas canvas, Size size) {
    Gradient shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Color(0xff4CE0BC), Color(0xffCC76FD)],
    );

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint paint = new Paint()
      ..shader = shader.createShader(rect)
      ..style = PaintingStyle.fill;
    Path path = Path();
    RRect rRect = RRect.fromLTRBAndCorners(30, 0, size.width, size.height - 20,
        topLeft: Radius.circular(30), bottomLeft: Radius.circular(30));
    path.addRRect(rRect);

    double arrowPoint;
    if (place == PaintTypes.SIGN_UP) {
      arrowPoint = 175;
    } else
      arrowPoint = 100;

    path.moveTo(30, arrowPoint);
    path.lineTo(5, arrowPoint + 25);
    path.lineTo(30, arrowPoint + 25 * 2);
    canvas.drawShadow(path, Colors.black, 10, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = new Path();
    double topWidth = size.width * .8;
    double topControlPoint = size.width * .6;
    path.lineTo(0, topControlPoint);
    path.quadraticBezierTo(topControlPoint, topControlPoint, topWidth, 0);

    double bottomHeight = size.height - size.width * .6;
    double bottomCtrlPoint = size.width * .2;
    path.moveTo(size.width, bottomHeight);
    path.quadraticBezierTo(
        size.width * .4, bottomHeight, bottomCtrlPoint, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
