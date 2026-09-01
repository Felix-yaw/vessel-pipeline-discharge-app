import 'package:flutter/material.dart';

class NoOperation extends StatelessWidget {
  const NoOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'No Operation Selected',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
