import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoriesShimmer extends StatelessWidget {
  const StoriesShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        separatorBuilder: (_, __) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) => CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 32,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 40,
      ),
    );
  }
}
// Row(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   // mainAxisSize: MainAxisSize.max,
        //   children: () {
        //     var _list = <Widget>[];
        //     var _storyRadius = 32;
        //     var _storyPadding = 4.0;
        //     var _storyCount = (MediaQuery.of(context).size.width -
        //             25 * 2 -
        //             _storyPadding * 2) /
        //         ((_storyRadius * 2 + _storyPadding * 2) + 0);
        //     for (var i = 0; i < _storyCount.ceil(); i++) {
        //       _list.add(
        //         CircleAvatar(
        //           backgroundColor: Colors.grey[300],
        //           radius: 30,
        //         ).paddingAll(_storyPadding),
        //       );
        //     }
        //     return _list;
        //   }(),
        // ).paddingHorizontal(25),