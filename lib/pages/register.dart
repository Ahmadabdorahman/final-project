// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, avoid_print, unused_local_variable, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/provider/GoogleSignInProvider.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isloading = false;
  bool visibility = true;
  final _formKey = GlobalKey<FormState>();
  //   textfield لالتقاط النص الذي بداخل
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UsernameController = TextEditingController();
  final AgeController = TextEditingController();
  final TitleController = TextEditingController();

  Future<void> registerUserWithGoogle() async {
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the current user
    final User? user = userCredential.user;

    // Check if the user is new or existing
    if (userCredential.additionalUserInfo!.isNewUser) {
      // If the user is new, create a new document in the 'USER' collection with the user data
      await FirebaseFirestore.instance.collection('USER').doc(user!.uid).set({
        'id': user.uid,
        'UserName': user.displayName,
        'Email': user.email,
      });
    }
  }

  register() async {
    setState(() {
      isloading = true;
    });
    //لانشاء حساب firebase هذا الكود مسؤول عن الاتصال بين التطبيق و
    try {
      final User = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // لارسال البيانات الى قاعده البيانات
      CollectionReference USERS = FirebaseFirestore.instance.collection('USER');
      USERS
          .doc(User.user!.uid) //الخاص به id لتخزين بيانات كل مستخدم حسب
          .set(
            {
              'UserName': UsernameController.text,
              'Age': AgeController.text,
              'Title': TitleController.text,
              'Email': emailController.text,
              'Password': passwordController.text,
              'id':User.user!.uid,
            },
          )
          .then((value) => print("user added"))
          .catchError((error) => print("Failed to merge data: $error"));
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for this email.");
      } else {
        showSnackBar(context, "Error - please try again later");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    UsernameController.dispose();
    AgeController.dispose();
    TitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 201, 198, 198),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 80),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(93, 64, 55, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                          controller: UsernameController,
                          keyboardType: TextInputType.text,
                          decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Username : ",
                            suffixIcon: Icon(Icons.person),
                          )),
                      const SizedBox(
                        height: 22,
                      ),
                      TextField(
                          controller: AgeController,
                          keyboardType: TextInputType.number,
                          decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Age : ",
                            suffixIcon: Icon(Icons.cake),
                          )),
                      const SizedBox(
                        height: 22,
                      ),
                      TextField(
                          controller: TitleController,
                          keyboardType: TextInputType.text,
                          decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Title : ",
                            suffixIcon: Icon(Icons.person_outline),
                          )),
                      const SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                          // ستكون ما يتم كتابته بحقل الادخال value قيمه
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? "Enter a valid email"
                                : null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email),
                          )),
                      const SizedBox(
                        height: 22,
                      ),
                      TextFormField(
                          // we return "null" when something is valid
                          validator: (Password) {
                            return Password!.length < 8
                                ? "Enter at least 8 characters"
                                : null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      const SizedBox(
                        height: 33,
                      ),
                      ElevatedButton(
                        // عند الضغط سيتم التحقق اذا تم ايفاء جميع الشروط سيتم تسجيل الحساب في قاعده البيانات
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await register();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          } else {
                            showSnackBar(context, 'ERROR');
                          }
                        },
                        child: isloading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 19, color: Colors.white),
                              ),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                          padding:
                              WidgetStateProperty.all(EdgeInsets.all(12)),
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
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
                            'Or Sign up with',
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
                                  await registerUserWithGoogle();
                                  await googleSignInProvider.googlelogin();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color: const Color.fromARGB(
                                              255, 8, 92, 160),
                                          size: 70,
                                        )),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?',
                              style: TextStyle(fontSize: 18)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text('Log in',
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
      ),
    );
  }
}
