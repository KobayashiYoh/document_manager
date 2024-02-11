import 'package:document_manager/constants/app_colors.dart';
import 'package:document_manager/constants/styles.dart';
import 'package:flutter/material.dart';

class PostSearchBar extends StatelessWidget {
  const PostSearchBar({
    Key? key,
    required this.searchTextController,
    required this.onSubmitted,
    required this.onPressedClear,
  }) : super(key: key);

  final TextEditingController searchTextController;
  final void Function(String)? onSubmitted;
  final void Function()? onPressedClear;

  static const double height = 80.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: height,
      color: AppColors.main,
      child: TextField(
        controller: searchTextController,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8.0),
          prefixIcon: IconButton(
            onPressed: () => onSubmitted,
            icon: const Icon(Icons.search),
          ),
          suffix: IconButton(
            onPressed: onPressedClear,
            icon: const Icon(Icons.close),
          ),
          fillColor: Colors.white,
          filled: true,
          border: Styles.chatOutlineInputBorder,
          focusedBorder: Styles.chatOutlineInputBorder,
        ),
      ),
    );
  }
}
