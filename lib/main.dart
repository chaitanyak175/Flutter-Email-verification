import 'package:flutter/material.dart';
import 'package:test/login.dart';
import 'package:test/otp_verification.dart';


void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Verificatoin(),
  )
);

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        color: const Color(0xff8186F0),
        child: const Center(child: LoginPage()),
      ),
    );
  }
}