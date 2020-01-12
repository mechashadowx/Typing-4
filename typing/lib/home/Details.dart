import 'package:flutter/material.dart';
import 'package:typing/helper.dart';

class Details extends StatelessWidget {
  final String speed, acc;

  Details({
    this.speed,
    this.acc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Info(
              number: speed,
              desc: 'WORDS/MIN',
            ),
            Info(
              number: acc,
              desc: '%ACCURACY',
            ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final String number, desc;

  Info({
    this.number,
    this.desc,
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
            Container(
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: gray,
                    fontSize: data.size.width * 0.15,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  desc,
                  style: TextStyle(
                    color: red,
                    fontSize: data.size.width * 0.04,
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
