import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter your email address to reset your password!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        controller: _emailController,
                        decoration: const InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: (() {}),
                  color: Colors.red,
                  child: const Text("Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
