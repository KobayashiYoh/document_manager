import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout),
          SizedBox(width: 8.0),
          Text('ログアウトする'),
        ],
      ),
    );
  }
}
