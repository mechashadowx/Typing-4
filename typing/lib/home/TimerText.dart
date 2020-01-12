import 'package:flutter/material.dart';
import 'package:typing/helper.dart';

class TimerText extends StatelessWidget {
  final String seconds;

  TimerText({
    this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              seconds,
              style: TextStyle(
                color: red,
                fontSize: data.size.width * 0.1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                'sec',
                style: TextStyle(
                  color: red,
                  fontSize: data.size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
