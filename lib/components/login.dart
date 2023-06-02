import 'package:emoraa/components/bull_bull.dart';
import 'package:flutter/material.dart';

// beautiful Flutter login and registration screen UI
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loginSelected = true;
  bool showPassword = false;
  bool showConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 40, 125, 237),
            Color.fromARGB(255, 242, 75, 33)
          ])),
          child: Stack(
            children: [
              const Positioned(top: 50, left: 100, child: BullBull(height:100, width: 100)),
              const Positioned(top: 50, right: 70, child: BullBull(width: 150, height: 150,)),
              const Positioned(
                top: 130,
                right: 150,
                child: BullBull(height: 100, width: 100,),
              ),
              const Positioned(
                bottom: 150,
                right: 150,
                child: BullBull(height: 50, width: 50,),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 250),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    emailField(),
                    passwordField(),
                    !loginSelected ? const SizedBox() : forgotPassword(),
                    loginSelected ? const SizedBox() : confirmPasswordField(),
                    !loginSelected
                        ? const SizedBox(
                            height: 40,
                          )
                        : const SizedBox(),
                    button(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 40, 125, 237),
                              Color.fromARGB(255, 242, 75, 33)
                            ])),
                        child: Row(
                          children: [
                            !loginSelected
                                ? Expanded(
                                    child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print('tap');
                                          loginSelected = true;
                                        });
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ))
                                : Expanded(
                                    child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 40, 125, 237),
                                          Color.fromARGB(255, 242, 75, 33)
                                        ])),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            loginSelected
                                ? Expanded(
                                    child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          print('tap');
                                          loginSelected = false;
                                        });
                                      },
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ))
                                : Expanded(
                                    child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        gradient: const LinearGradient(colors: [
                                          Colors.purple,
                                          Colors.orange
                                        ])),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: TextFormField(
        style: const TextStyle(color: Colors.white70, fontSize: 14),
        decoration: const InputDecoration(
          prefixIconConstraints: BoxConstraints(minWidth: 24),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.email,
              color: Colors.white70,
              size: 20,
            ),
          ),
          hintText: 'Enter email VALIDATE',
          hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white60, width: .4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70, width: .4),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          // Add email validation
          final isValidEmail =
              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
          if (!isValidEmail) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget passwordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
        child: TextField(
          obscureText: showPassword ? false : true,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
          decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(minWidth: 24),
              suffixIconConstraints: const BoxConstraints(minWidth: 24),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.lock,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ),
              hintText: 'Enter password',
              hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60, width: .4)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: .4))),
        ));
  }

  Widget confirmPasswordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
        child: TextField(
          obscureText: showConfirmPassword ? false : true,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
          decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(minWidth: 24),
              suffixIconConstraints: const BoxConstraints(minWidth: 24),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.lock,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                  child: Icon(
                    showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ),
              hintText: 'Confirm password',
              hintStyle: const TextStyle(color: Colors.white60, fontSize: 14),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60, width: .4)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70, width: .4))),
        ));
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 58, bottom: 30),
        child: InkWell(
          onTap: () {
            // navigate to other screen
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget button() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Login successful!'),
              action: SnackBarAction(
                label: 'Dismiss',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
              ),
            ),
          );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 60).copyWith(bottom: 15),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3, 3),
                  blurRadius: 4,
                  spreadRadius: 1,
                  color: Colors.black12.withOpacity(.08))
            ],
            borderRadius: BorderRadius.circular(50)
                .copyWith(topRight: const Radius.circular(0)),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 55, 83, 240),
              Color.fromARGB(255, 226, 145, 63),
            ])),
        child: Text(
          loginSelected ? 'Sign In' : 'Register',
          style: const TextStyle(
              color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
