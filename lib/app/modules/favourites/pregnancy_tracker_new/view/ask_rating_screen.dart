import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';

class AskRatingScreen extends StatefulWidget {
  const AskRatingScreen({Key key}) : super(key: key);

  @override
  State<AskRatingScreen> createState() => _AskRatingScreenState();
}

class _AskRatingScreenState extends State<AskRatingScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: h * 0.1,
                left: w * 0.05,
                right: w * 0.05,
                bottom: h * 0.04),
            child: Image.asset(AppImages.askRating),
          ),
          Text(
            'What do you about Doctoryab App”?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.08, top: h * 0.02),
            child: Row(
              children: [
                Image.asset(
                  AppImages.excellentStar,
                  height: h * 0.12,
                ),
                SizedBox(width: w * 0.03),
                Text(
                  'Excellent',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.11, top: h * 0.01),
            child: Row(
              children: [
                Image.asset(
                  AppImages.angry,
                  height: h * 0.11,
                ),
                SizedBox(width: w * 0.03),
                Text(
                  'Bad',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.13, top: h * 0.02),
            child: Row(
              children: [
                Image.asset(
                  AppImages.laterFeedback,
                  height: h * 0.11,
                ),
                SizedBox(width: w * 0.03),
                Text(
                  'I will give feedback later',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
