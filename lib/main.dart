// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/forgot_password.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/signup.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   return firebaseApp;
  // }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen()
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

// Suggested code may be subject to a license. Learn more: ~LicenseLog:3674146120.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1664702927.
String errormessage = '';
Future<User?> loginUsingEmailPassword(
  {required String email,
   required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:269091667.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3849404716.
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1627229995.
    if (e.code == 'user-not-found') {
      log('No user found for that email.');
      errormessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errormessage = 'Wrong password provided for that user.';
      
    }
  }

  return user;
}

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold( 
       appBar: AppBar(
        title: const Text("Expense Tracker",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("LogIn to your Account",
          style: TextStyle(
            color:Colors.black,
            fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 34.0
          ),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const  InputDecoration(
              hintText: "Enter Email",
              prefixIcon: Icon(Icons.mail, color:Colors.black),
            ),
          ),
          const SizedBox(
            height: 26.0
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Enter Password",
              prefixIcon: Icon(Icons.lock, color:Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> const ForgotPasswordPage()));
              },
              child: const Text("Forgot Your Password?",
                style: TextStyle(
                  color: Colors.grey),
                  )
            )
            ),
          const SizedBox(
            height: 50.0
          ),
          if (errormessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  errormessage ,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.green,
              elevation: 5.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () async {
                User? user = await loginUsingEmailPassword(
                  email: emailController.text,
                   password: passwordController.text,
                   context: context
                   );

                   if(user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=> const HomeScreen()));
                   }
              },
              child: const Text("Login",
               style: TextStyle(
                color: Colors.white),
                )
              ),
          ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=> const SignUpScreen()));
              },
              child: const Text("Don't have an Account? SignUp",
                style: TextStyle(
                  color: Colors.black),
                  )
            )
          )
        ]
      )
    )
    );
  }
}


