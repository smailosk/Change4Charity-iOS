import 'package:change4charity/ui/shared/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const BusyOverlay(
      {this.child, this.title = 'Please wait...', this.show = false});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
        child: Stack(children: <Widget>[
      child,
      IgnorePointer(
        ignoring: !show,
        child: Opacity(
            opacity: show ? 1.0 : 0.0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              alignment: Alignment.center,
              color: Color.fromARGB(100, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    radius: 20,
                  ),
                  SizeConfig.verticalSpacer(10),
                  Text(title,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            )),
      ),
    ]));
  }
}
