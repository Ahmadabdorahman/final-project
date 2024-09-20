// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, unused_local_variable, curly_braces_in_flow_control_structures, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/provider/GoogleSignInProvider.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isloading = false;
  bool visibility = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    setState(() {
      isloading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Navigate to the home page after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'ERROR : ${e.code}');
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 201, 198, 198),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 80),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(93, 64, 55, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello!',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.mail))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: visibility ? true : false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Password : ",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                                icon: visibility
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)))),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot your password?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await login();
                      },
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            ),
                      style: ButtonStyle(
                        fixedSize:
                            const WidgetStatePropertyAll(Size(170, 50)),
                        backgroundColor:
                            WidgetStateProperty.all(Colors.black),
                        padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Or Login With',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.black,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () async {
                              await googleSignInProvider.googlelogin();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/google.svg",
                                  height: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.facebook_outlined,
                                      color:
                                          const Color.fromARGB(255, 8, 92, 160),
                                      size: 70,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()),
                              );
                            },
                            child: Text('Sign up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
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
