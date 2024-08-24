import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/helper/show_message.dart';
import 'package:movie_app/views/register_view.dart';
import 'package:movie_app/views/start_view.dart';
import 'package:movie_app/views/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;
  bool isLoading = false;
  bool isPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff0F335E),
                    Colors.black,
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Hello\nSign in!',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 270.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18,
                    top: 100,
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        // Removed const from here
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            icon: Icons.email,
                            hintText: 'Email',
                            obscureText: false, // Added this parameter
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            icon: isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            hintText: 'Password',
                            onIconPressed: () {
                              setState(
                                () => isPasswordVisible = !isPasswordVisible,
                              );
                            },
                            obscureText: !isPasswordVisible,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          const SizedBox(height: 50),
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await loginUser();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StartView(
                                              email: email!,
                                            )),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    showSnackBar(context, 'No user found');
                                  } else if (e.code == 'wrong-password') {
                                    showSnackBar(context, 'Wrong password');
                                  }
                                } catch (ex) {
                                  showSnackBar(context, 'There was an error');
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 41, 88, 147),
                                  Color(0xff0F335E),
                                ]),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterView()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xff0F335E),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0F335E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
