import 'package:flutter/material.dart';

class BaseTextfield extends StatefulWidget {
  const BaseTextfield({
    this.isEmail = false,
    this.isPassword = false,
    required this.validator,
    required this.hint,
    required this.controller,
    this.inputAction = TextInputAction.next,
    super.key,
  });

  final bool isEmail;
  final bool isPassword;
  final String hint;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputAction inputAction;

  @override
  State<BaseTextfield> createState() => _BaseTextfieldState();
}

class _BaseTextfieldState extends State<BaseTextfield> {
  late FocusNode _focusNode;
  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
        controller: widget.controller,
        textInputAction: widget.inputAction,
        obscureText: widget.isPassword ? _hidden : false,
        obscuringCharacter: "●",
        focusNode: _focusNode,
        validator: widget.validator,
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          filled: true,
          hintText: widget.hint,
          suffixIcon: widget.isPassword
              ? ExcludeFocus(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _hidden = !_hidden;
                      });
                    },
                    icon: _hidden
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
