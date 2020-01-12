import 'package:flutter/material.dart';
import 'package:typing/helper.dart';

class TypingForm extends StatefulWidget {
  final Function getTypedWord;
  final String word;
  final bool active;

  TypingForm({
    this.getTypedWord,
    this.word,
    this.active,
  });

  @override
  _TypingFormState createState() => _TypingFormState();
}

class _TypingFormState extends State<TypingForm> {
  final formKey = GlobalKey<FormState>();

  done() {
    formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: data.size.width * 0.1),
      child: Center(
        child: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: red,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(data.size.width * 0.05),
            ),
            child: Center(
              child: TextFormField(
                enabled: widget.active,
                onChanged: (text) {
                  widget.getTypedWord(text.toString());
                  if (text == widget.word) {
                    done();
                  }
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: red,
                  fontSize: data.size.width * 0.06,
                  fontWeight: FontWeight.w600,
                ),
                cursorColor: gray,
                maxLines: 1,
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: widget.active ? 'GO' : 'type here',
                  hintStyle: TextStyle(
                    color: lightGray,
                    fontSize: data.size.width * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
