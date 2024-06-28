import 'package:doctor_yab/app/theme/AppColors.dart';
import 'package:doctor_yab/app/theme/AppImages.dart';
import 'package:flutter/material.dart';

class AskRatingScreen extends StatefulWidget {
  const AskRatingScreen({Key? key}) : super(key: key);

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
            padding: EdgeInsets.only(top: h * 0.1, left: w * 0.05, right: w * 0.05, bottom: h * 0.04),
            child: Image.asset(AppImages.askRating),
          ),
          SizedBox(
            width: w * 0.7,
            child: Center(
              child: Text(
                'Please, tell us about your experience using Doctoryab app ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: h * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(h * 0.018),
                        child: Image.asset(
                          AppImages.thumbsUp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Text('Perfect')
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      AppImages.laterFeedback,
                      height: h * 0.085,
                      color: Color(0xffED8226),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Text('Remind Later.')
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: h * 0.005,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.all(h * 0.018),
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(
                            AppImages.thumbsUp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Text('I didn’t like it')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
