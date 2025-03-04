import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trials_of_valhalla/helpers/consts.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/validators.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';
import 'package:trials_of_valhalla/widgets/layout/background.dart';
import 'package:trials_of_valhalla/widgets/base_textfield.dart';
import 'package:trials_of_valhalla/widgets/layout/custom_progress_indicator.dart';
import 'package:trials_of_valhalla/widgets/popups/password_reset_popup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;
  bool _isProcessing = false;
  final _authInstance = FirebaseAuth.instance;

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      final email = _emailController.text.toLowerCase();
      final password = _passwordController.text;

      try {
        await savePrefs("music", true);
        await savePrefs("sfx", true);
        await savePrefs("shake", true);
        await savePrefs("threshold", baseThreshold);
        _isLogin
            ? await _authInstance.signInWithEmailAndPassword(
                email: email, password: password)
            : await _authInstance.createUserWithEmailAndPassword(
                email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (!mounted) return;
        setState(() {
          _isProcessing = false;
        });
        if (!mounted) return;
        await handleFirebaseError(e.code, context);
        return;
      } catch (_) {
        if (!mounted) return;
        await showInfoPopup(context, unknownError);
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              logoPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  overlayColor: accentColor),
                              onPressed: () {
                                _formKey.currentState!.reset();
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin ? noAccount : haveAccount,
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontFamily: defaultFontFamily,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BaseTextfield(
                            hint: "E-mail",
                            isEmail: true,
                            validator: emailValidator,
                            controller: _emailController,
                          ),
                          _isLogin
                              ? BaseTextfield(
                                  hint: password,
                                  isPassword: true,
                                  validator: basicValidator,
                                  controller: _passwordController,
                                )
                              : Column(
                                  children: [
                                    BaseTextfield(
                                      hint: password,
                                      isPassword: true,
                                      validator: createPasswordValidator(
                                          _confirmPasswordController),
                                      controller: _passwordController,
                                    ),
                                    BaseTextfield(
                                      hint: confirmPassword,
                                      isPassword: true,
                                      validator: createPasswordValidator(
                                          _passwordController),
                                      controller: _confirmPasswordController,
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (_isLogin)
                            ExcludeFocus(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    overlayColor: accentColor),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const PasswordResetPopup(),
                                  );
                                },
                                child: Text(
                                  passwordReset,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontFamily: defaultFontFamily,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    _isProcessing
                        ? const CustomProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: MainButton(
                              onPressed: _authenticate,
                              text: _isLogin ? login : register,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
