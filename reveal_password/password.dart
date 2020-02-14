import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput>
    with SingleTickerProviderStateMixin {
  bool isPasswordVisible = false;
  AnimationController animCtrl;
  Animation<double> tween;
  Animation<Color> lockColor;
  String passValue = "";
  final purple = Colors.deepPurpleAccent[100];

  @override
  void initState() {
    super.initState();
    animCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    lockColor = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(CurvedAnimation(curve: Interval(.8, 1), parent: animCtrl));
    tween = Tween(begin: 1.0, end: 0.0).animate(animCtrl);
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  void onPressVisibility() {
    if (isPasswordVisible) {
      animCtrl.reverse();
    } else {
      animCtrl.forward();
    }
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  onChangeText(String value) {
    setState(() {
      passValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(minHeight: 55),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey[900],
          ),
        ),
        TextField(
          onChanged: onChangeText,
          obscureText: true,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: purple),
            prefixIcon: SizedBox(width: 48),
          ),
          style: TextStyle(color: purple),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: animCtrl,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 20,
              ),
              color: Colors.white,
              child: Text(
                passValue,
                style: TextStyle(
                  fontSize: 15,
                  color: purple,
                ),
              ),
            ),
            builder: (_, child) => ClipPath(
              child: child,
              clipper: RevelClip(tween.value),
            ),
          ),
        ),
        Positioned(
          child: AnimatedBuilder(
            animation: animCtrl,
            builder: (_, __) => Icon(
              Icons.lock,
              color: lockColor.value,
            ),
          ),
          left: 11,
        ),
        Positioned(
          child: IconButton(
            onPressed: onPressVisibility,
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: purple,
            ),
          ),
          right: 0,
        )
      ],
    );
  }
}

class RevelClip extends CustomClipper<Path> {
  final double animValue;

  RevelClip(this.animValue);
  @override
  Path getClip(Size size) {
    Path path = Path();
    final left = (size.width - 39) * animValue;
    final top = 14 * animValue;
    final reveseAnim = (1 - animValue);
    final width = ((size.width - 30) * reveseAnim) + 30;
    final height = ((size.height - 30) * reveseAnim) + 30;
    final radius = ((15 - 10) * animValue) + 10;
    final rect = Rect.fromLTWH(left, top, width, height);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    path.addRRect(rrect);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(RevelClip oldClipper) {
    return oldClipper.animValue != animValue;
  }
}
