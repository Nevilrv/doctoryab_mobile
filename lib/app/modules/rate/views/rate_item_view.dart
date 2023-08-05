import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateItemView extends StatelessWidget {
  final String title;
  final double initStars;
  final void Function(double) onRate;

  const RateItemView(
      {Key key,
      @required this.title,
      @required this.initStars,
      @required this.onRate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('RateItemView'),
      //   centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          RatingBar.builder(
            ignoreGestures: false,
            itemSize: 30,
            initialRating: initStars,
            // minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              // size: 10,
            ),
            onRatingUpdate: onRate,
          ),
          Row()
        ],
      ),
    );
  }
}
