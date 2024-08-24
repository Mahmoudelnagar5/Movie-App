import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/helper/show_message.dart';
import 'package:movie_app/views/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;
  String? password;
  String? confirmPassword;
  String? username;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            onChanged: (data) {
                              username = data;
                            },
                            icon: Icons.person,
                            hintText: 'Username',
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            onChanged: (data) {
                              email = data;
                            },
                            icon: Icons.email,
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            icon: isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            hintText: 'Password',
                            onIconPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            obscureText: !isPasswordVisible,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            icon: isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            hintText: 'Confirm Password',
                            onIconPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            obscureText: !isConfirmPasswordVisible,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                          ),
                          const SizedBox(height: 40),
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                setState(() {
                                  isLoading = true;
                                });
                                if (password != confirmPassword) {
                                  showSnackBar(
                                      context, 'Passwords do not match');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }
                                try {
                                  await createAccount();
                                  showSnackBar(
                                      context, 'Account created successfully');
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(context, 'Password too weak');
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(
                                        context, 'Account already exists');
                                  }
                                } catch (e) {
                                  showSnackBar(context, 'Something went wrong');
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                showSnackBar(
                                    context, 'Please fill all the fields');
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
                                  'Sign Up',
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
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xff0F335E),
                                ),
                                child: const Text(
                                  'Login',
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

  Future<void> createAccount() async {
    // ignore: unused_local_variable
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
