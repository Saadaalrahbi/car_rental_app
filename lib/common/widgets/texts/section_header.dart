import 'package:flutter/material.dart';

class SectionHeadings extends StatelessWidget {
  const SectionHeadings(
      {super.key,
      this.onPressed,
      this.textColor,
      this.showActionButton = true,
      required this.title,
      this.buttonTitle = 'View all'});

  ///to reuse this on different location, the following is required
  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,   ///for putting space btn the title & the view all button
      children: [
        ///section heading - using ellipsis if the text is long it will show half name with dots ....
        Text(title,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        if (showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
