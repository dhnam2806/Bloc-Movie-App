import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/auth/ui/sign_in.dart';
import '../bloc/auth_bloc.dart';

class ForgotPassWordScreen extends StatelessWidget {
  const ForgotPassWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen())),
            child: const Icon(Icons.arrow_back, size: 24, color: Colors.red)),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state is ForgotPasswordFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
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
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      controller: _emailController,
                      onEditingComplete: () {
                        BlocProvider.of<AuthBloc>(context).add(
                            ForgotPasswordRequestEvent(
                                email: _emailController.text));
                      },
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
                    borderRadius: BorderRadius.circular(8)),
                onPressed: (() {
                  BlocProvider.of<AuthBloc>(context).add(
                      ForgotPasswordRequestEvent(email: _emailController.text));
                }),
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
    );
  }
}
