// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextExpand extends StatefulWidget {
  String text;
  TextExpand({super.key, required this.text});

  @override
  State<TextExpand> createState() => _TextExpandState();
}

class _TextExpandState extends State<TextExpand> {
  late String firsthalf;
  String? secondhalf;
  bool check = false;
  @override
  void initState() {
    if (widget.text.length > 100) {
      firsthalf = widget.text.substring(0, 100);
      secondhalf = widget.text.substring(101, widget.text.length);
    } else {
      firsthalf = widget.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return secondhalf == null
        ? Text(widget.text)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              check ? Text(widget.text) : Text(firsthalf),
              TextButton(
                  onPressed: () {
                    setState(() {
                      check = !check;
                    });
                  },
                  child: check ? Text('Show less') : Text('Show more'))
            ],
          );
  }
}
