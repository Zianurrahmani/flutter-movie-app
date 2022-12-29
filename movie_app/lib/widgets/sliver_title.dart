import 'package:flutter/material.dart';

class SliverTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const SliverTitle({super.key, required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: onPressed,
                child: const Text(
                  "MORE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      );
}
