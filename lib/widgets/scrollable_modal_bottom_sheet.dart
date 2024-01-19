import 'package:flutter/material.dart';

const _borderRadius = BorderRadius.vertical(
  top: Radius.circular(16.0),
);

void showScrollableModalBottomSheet({
  required BuildContext context,
  required String headerText,
  required Widget child,
}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: _borderRadius),
    builder: (context) {
      return ScrollableModalBottomSheet(
        headerText: headerText,
        child: child,
      );
    },
  );
}

class ScrollableModalBottomSheet extends StatelessWidget {
  const ScrollableModalBottomSheet({
    Key? key,
    required this.headerText,
    required this.child,
  }) : super(key: key);

  final String headerText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 48.0,
              decoration: const BoxDecoration(
                borderRadius: _borderRadius,
              ),
              child: Text(
                headerText,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            Expanded(
              child: child,
            ),
          ],
        );
      },
    );
  }
}
