import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RevealDrawer extends StatefulWidget {
  @override
  _RevealDrawerState createState() => _RevealDrawerState();
}

class _RevealDrawerState extends State<RevealDrawer>
    with SingleTickerProviderStateMixin {
  String selectedItem = "Home";
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 10)
                        ]),
                    margin: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        "assets/images/color_street.jpg",
                        height: 160,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  buildListItem("Home"),
                  buildListItem("Auth"),
                  buildListItem("Settings"),
                  buildListItem("About us")
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.bounceOut,
            duration: Duration(milliseconds: 900),
            left: isDrawerOpen ? 200 : 0,
            bottom: isDrawerOpen ? 30 : 0,
            top: isDrawerOpen ? 60 : 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black45, blurRadius: 20)
              ]),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppBar(
                    title: Text("Home"),
                    leading: IconButton(
                        onPressed: this.toggleDrawer, icon: Icon(Icons.menu)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  onPressDrawerItem(String text) {
    setState(() {
      selectedItem = text;
    });
  }

  buildListItem(String text) {
    final bool isSelectedItem = selectedItem == text;
    final Color color = isSelectedItem ? Colors.purple : Colors.black;
    return FlatButton(
      onPressed: () => onPressDrawerItem(text),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Expanded(
            child: Divider(
              color: color,
              height: 40.0,
            ),
          )
        ],
      ),
    );
  }
}
