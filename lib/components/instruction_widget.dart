import 'package:flutter/material.dart';
import 'package:cocktailapp/constraints.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({required this.instructions});
  final String instructions;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Instructions",
            style: tableTextStyle,
          ),
          SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(instructions),
            ),
          ),
        ],
      ),
    );
  }
}