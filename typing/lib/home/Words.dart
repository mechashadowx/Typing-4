import 'package:flutter/material.dart';
import 'package:typing/helper.dart';

class Words extends StatelessWidget {
  final String bottomWord;
  final Widget topWord;

  Words({
    this.topWord,
    this.bottomWord,
  });

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            topWord,
            Container(
              child: Center(
                child: Text(
                  bottomWord,
                  style: TextStyle(
                    color: gray,
                    fontSize: data.size.width * 0.06,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
