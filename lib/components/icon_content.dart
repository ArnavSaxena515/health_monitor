import 'package:flutter/cupertino.dart';

import '../constants.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label, this.animation, this.animationController});

  final IconData icon;
  final String label;
  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: animation.value,
              child: Icon(
                icon,
                size: 50.0,
                //70
              ),
            );
          },
        ),
        SizedBox(
          height: 10.0,
          //15
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
