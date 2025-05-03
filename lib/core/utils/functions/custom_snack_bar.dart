import 'package:flutter/material.dart';

showSnackBar(context, {required String message, required Color color}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
