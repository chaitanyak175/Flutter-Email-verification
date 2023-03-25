import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:lottie/lottie.dart';

class Verificatoin extends StatefulWidget {
  const Verificatoin({ Key? key }) : super(key: key);

  @override
  _VerificatoinState createState() => _VerificatoinState();
}

class _VerificatoinState extends State<Verificatoin> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) { 
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) { 
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3)
          _currentIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Lottie.asset('assets/otp verification.json')
                      ),
                  ]
                ),
              ),
              const SizedBox(height: 30,),
              const SizedBox(
                child: Text("Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
              const SizedBox(height: 30,),
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                child: Text("Please enter the 4 digit code sent to your phone number", 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade500, height: 1.5),),
              ),
              const SizedBox(height: 30,),

              // Verification Code Input
              SizedBox(
                child: VerificationCode(
                  length: 4,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  underlineColor: Colors.black,
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor: Colors.black,
                  onCompleted: (value) {
                    setState(() {
                      _code = value;
                    });
                  }, 
                  onEditing: (value) {},
                ),
              ),


              const SizedBox(height: 20,),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't receive the OTP?", style: TextStyle(fontSize: 14, color: Colors.grey.shade500),),
                    TextButton(
                      onPressed: () {
                        if (_isResendAgain) return;
                        resend();
                      }, 
                      child: Text(_isResendAgain ? "Try again in " + _start.toString() : "Resend", style: const TextStyle(color: Colors.blueAccent),)
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              SizedBox(
                child: MaterialButton(
                  elevation: 0,
                  onPressed: _code.length < 4 ? () => {} : () { verify(); },
                  color: const Color.fromARGB(255, 0, 0, 0),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: _isLoading ? Container(
                    width: 20,
                    height: 20,
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 3,
                      color: Colors.black,
                    ),
                  ) : _isVerified ? const Icon(Icons.check_circle, color: Colors.white, size: 30,) : const Text("Verify", style: TextStyle(color: Colors.white),),
                ),
              )
          ],)
        ),
      )
    );
  }
}