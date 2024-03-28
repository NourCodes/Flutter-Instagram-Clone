import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Column buildColumn(int num, String label) {
  return Column(
    children: [
      Text(
        num.toString(),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        margin: const EdgeInsets.only(
          top: 3.5,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ),
    ],
  );
}
