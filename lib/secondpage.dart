import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  String payload;
  SecondPage(this.payload, {super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.payload)),
    );
  }
}
