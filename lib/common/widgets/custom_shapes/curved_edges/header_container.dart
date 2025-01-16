

import 'package:flutter/material.dart';

import '../../../../utility/constants/colors.dart';
import '../containers/circular_container.dart';
import 'curved_edge_widgets.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: RColors.darkP,

             child: Stack(

       children: [
            ///background custom shapes
            Positioned(top: -150, right: -250, child:  CircularContainer(backgroundColor: RColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: CircularContainer(backgroundColor: RColors.textWhite.withOpacity(0.1))),
         child,
          ],
        ),
      ),
    );
  }
}

