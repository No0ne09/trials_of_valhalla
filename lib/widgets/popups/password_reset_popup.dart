import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';

import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/validators.dart';
import 'package:trials_of_valhalla/widgets/auth_button.dart';
import 'package:trials_of_valhalla/widgets/base_textfield.dart';

class PasswordResetPopup extends StatefulWidget {
  const PasswordResetPopup({super.key});

  @override
  State<PasswordResetPopup> createState() => _PasswordResetPopupState();
}

class _PasswordResetPopupState extends State<PasswordResetPopup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text.toLowerCase();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        await handleFirebaseError(e.code, context);
        return;
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            checkInbox,
            style: TextStyle(
              fontSize: 16,
              fontFamily: defaultFontFamily,
            ),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Spacer(),
                CloseButton(),
              ],
            ),
            Text(
              passwordResetting,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontFamily: defaultFontFamily,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              emailInfo,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontFamily: defaultFontFamily,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseTextfield(
                  validator: emailValidator,
                  hint: "E-mail",
                  controller: _emailController,
                  isEmail: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AuthButton(
                        onPressed: _resetPassword,
                        text: sendMail,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
