import 'package:flutter/material.dart';
import 'package:my_dictionary/constant/strings/strings.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.labelText,
    this.inputActionIsNext = false,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String labelText;
  final bool inputActionIsNext;
  @override
  State<PasswordFormField> createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  bool isVisible = true;
  void changeVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: isVisible,
      textInputAction: widget.inputActionIsNext ? TextInputAction.next : TextInputAction.done,
      obscuringCharacter: ProjectStrings.obsecureChar,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password_outlined),
        label: Text(widget.labelText),
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        suffixIcon: IconButton(
            onPressed: () {
              changeVisible();
            },
            icon: isVisible ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_rounded)),
      ),
    );
  }
}
