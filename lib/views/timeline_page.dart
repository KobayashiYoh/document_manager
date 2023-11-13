import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('timeline'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('戻る'),
        ),
      ),
    );
  }
}
