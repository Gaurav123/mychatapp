import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mychatapp/screens/auth_screen.dart';
import 'package:mychatapp/screens/chat_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'My Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.purple,
        accentColorBrightness: Brightness.dark,
          buttonTheme : ButtonTheme.of(context).copyWith(
        textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
        
      ),
      home:StreamBuilder(stream: FirebaseAuth.
      instance.authStateChanges(),
        builder:(ctx,userSnapShot) {
        if(userSnapShot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
        },)

    );
  }
}

