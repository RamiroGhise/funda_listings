import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    Key? key,
    required this.text,
    required this.maxLines,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        children: [
          Text(
            widget.text,
            overflow: TextOverflow.fade,
            maxLines: _isExpanded ? null : widget.maxLines,
          ),
          const SizedBox(height: 8.0),
          Text(!_isExpanded ? 'Read full description' : ''),
        ],
      ),
    );
  }
}
