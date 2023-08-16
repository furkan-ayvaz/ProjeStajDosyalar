import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/border/custom_border.dart';

class WordTextField extends StatefulWidget {
  const WordTextField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.labelText,
  }) : super(key: key);
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String labelText;

  @override
  State<WordTextField> createState() => _WordTextFieldState();
}

class _WordTextFieldState extends State<WordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          label: Text(widget.labelText),
          prefixIcon: const Icon(Icons.draw_outlined),
          border: const OutlineInputBorder(borderRadius: ProjectBorder.wordTextFieldBorderRadius),
        ));
  }
}
