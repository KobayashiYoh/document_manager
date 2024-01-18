import 'package:flutter/material.dart';

/// パスワードの表示・非表示を切り替えるsuffixボタン
class PasswordSuffixIconButton extends StatelessWidget {
  const PasswordSuffixIconButton({
    Key? key,
    required this.onPressed,
    required this.obscureText,
  }) : super(key: key);

  final void Function()? onPressed;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
      onPressed: onPressed,
    );
  }
}
