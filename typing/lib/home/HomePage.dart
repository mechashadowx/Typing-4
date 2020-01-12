import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:typing/helper.dart';
import 'Details.dart';
import 'TimerText.dart';
import 'TypingForm.dart';
import 'Words.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final numberOfWords = 500;
  final words = allWords;

  int now, speed;
  double acc, allTypedChar, correctTypedChar;
  String currentWord, nextWord, input, url;
  bool again;

  Timer timer;

  @override
  void initState() {
    super.initState();
    now = 0;
    reset();
  }

  String getWord() {
    int rand = Random().nextInt(numberOfWords);
    return words[rand];
  }

  click() {
    if (again) {
      reset();
    } else {
      start();
    }
  }

  reset() {
    if (now != 0) return;
    setState(() {
      acc = allTypedChar = correctTypedChar = 0.0;
      speed = 0;
      input = '';
      currentWord = 'Are you';
      nextWord = 'ready?';
      again = false;
      now = 60;
    });
  }

  start() {
    setState(() {
      again = true;
      currentWord = getWord();
      nextWord = getWord();
    });
    startTimer();
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          now--;
          if (now == 0) {
            timer.cancel();
          }
        },
      ),
    );
  }

  getTypedWord(String typed) {
    if (now == 0) return;
    if (typed.length == 0) {
      setState(() {
        input = typed;
        return;
      });
    }
    print('call');
    bool backspace = false;
    if (typed.length <= input.length) {
      backspace = true;
    }
    setState(() {
      if (!backspace) {
        allTypedChar++;
      }
      input = typed;
      if (input.length <= currentWord.length && !backspace) {
        if (input[input.length - 1] == currentWord[input.length - 1]) {
          correctTypedChar++;
        }
      }
      if (allTypedChar != 0) {
        acc = (correctTypedChar / allTypedChar) * 100;
      }
    });
  }

  Widget toRow(String word, double size, String input) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: split(word, size),
    );
  }

  List<Widget> split(String word, double size) {
    List<Widget> rowWord = List();
    int goodTo = getGoodTo();
    print(goodTo);
    for (int i = 0; i < word.length; i++) {
      rowWord.add(
        Text(
          word[i],
          style: TextStyle(
            color: i < goodTo ? lightGray : gray,
            fontSize: size,
          ),
        ),
      );
    }
    if (goodTo == currentWord.length) {
      setState(() {
        currentWord = nextWord;
        nextWord = getWord();
        input = '';
        speed++;
      });
      return split(currentWord, size);
    }
    return rowWord;
  }

  int getGoodTo() {
    for (int i = 0; i < input.length; i++) {
      if (currentWord[i] != input[i]) return i;
    }
    return input.length;
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: data.size.height * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: data.size.height * 0.6,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TimerText(
                        seconds: now.toString(),
                      ),
                      Words(
                        topWord:
                            toRow(currentWord, data.size.width * 0.15, input),
                        bottomWord: nextWord,
                      ),
                      TypingForm(
                        getTypedWord: getTypedWord,
                        word: currentWord,
                        active: again,
                      ),
                      Details(
                        speed: speed.toString(),
                        acc: acc.toInt().toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: IndexedStack(
                    index: again ? 1 : 0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: click,
                        child: Image(
                          height: data.size.width * 0.18,
                          width: data.size.width * 0.18,
                          image: AssetImage('assets/start.png'),
                        ),
                      ),
                      GestureDetector(
                        onTap: click,
                        child: Image(
                          height: data.size.width * 0.18,
                          width: data.size.width * 0.18,
                          image: AssetImage('assets/reset.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
