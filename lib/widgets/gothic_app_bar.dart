import 'package:flutter/material.dart';

class GothicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GothicAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title, style: const TextStyle(fontFamily: "VampireFont")),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontFamily: "VampireFont"),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
