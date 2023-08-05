import 'package:doctor_yab/app/theme/TextTheme.dart';
import 'package:flutter/material.dart';

class DotDotPagingNoMoreItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "...",
        style: AppTextTheme.h(18).copyWith(color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
