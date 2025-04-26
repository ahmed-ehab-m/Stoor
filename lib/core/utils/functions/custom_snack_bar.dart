import 'package:flutter/material.dart';

void chstomSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Could not launch URL'),
    ),
  );
}
