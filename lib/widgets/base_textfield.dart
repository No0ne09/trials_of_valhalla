import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

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
        cursorColor: accentColor,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
        controller: widget.controller,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontFamily: defaultFontFamily,
            ),
        textInputAction: widget.inputAction,
        obscureText: widget.isPassword ? _hidden : false,
        obscuringCharacter: "●",
        focusNode: _focusNode,
        validator: widget.validator,
        onTapOutside: (event) {
          _focusNode.unfocus();
        },
        decoration: InputDecoration(
          errorBorder: getTextFieldBorder(color: accentColor),
          errorStyle: const TextStyle(
            color: accentColor,
            fontFamily: defaultFontFamily,
            fontSize: 16,
          ),
          filled: true,
          hintText: widget.hint,
          iconColor: accentColor,
          suffixIcon: widget.isPassword
              ? ExcludeFocus(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidden = !_hidden;
                        });
                      },
                      icon: Icon(
                        _hidden ? Icons.visibility_off : Icons.visibility,
                        color: accentColor,
                      )),
                )
              : null,
          enabledBorder: getTextFieldBorder(),
          focusedBorder: getTextFieldBorder(),
          border: getTextFieldBorder(),
        ),
      ),
    );
  }
}
