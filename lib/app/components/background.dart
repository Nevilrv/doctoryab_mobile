import 'package:flutter/widgets.dart';

class Background extends StatelessWidget {
  const Background(
      {Key key,
      @required this.child,
      this.isSecond = false,
      this.isPrimary = false})
      : super(key: key);
  final Widget child;
  final bool isSecond;
  final bool isPrimary;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/png/bg${isPrimary ? '_blue' : ''}${isSecond ? 2 : 1}.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
