import 'package:flutter/material.dart';

class LostConnectionDialog extends StatelessWidget {
  const LostConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Connection Lost'),
    );
  }
}
