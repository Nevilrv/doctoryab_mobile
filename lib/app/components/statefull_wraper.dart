import 'package:flutter/material.dart';

class EmptyStateFullWraper extends StatefulWidget {
  final Widget child;
  EmptyStateFullWraper(this.child);
  @override
  _EmptyStateFullWraperState createState() => _EmptyStateFullWraperState();
}

class _EmptyStateFullWraperState extends State<EmptyStateFullWraper> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
