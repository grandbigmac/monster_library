import 'package:flutter/material.dart';

InputDecoration listSearchDecoration(BuildContext context) {
  return InputDecoration(
      border: const UnderlineInputBorder(),
      hintText: 'Enter a monster\'s name...',
      hintTextDirection: TextDirection.ltr,
      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
      prefixIcon: Icon(
        Icons.search,
        size: MediaQuery.sizeOf(context).shortestSide * 0.05,
        color: Colors.grey,
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: MediaQuery.sizeOf(context).shortestSide * 0.055,
      )
  );
}