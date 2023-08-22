import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/auth/ui/forgot_password.dart';
import 'package:movie_app/feature/auth/ui/sign_up.dart';
import '../../google_navbar.dart';
import '../bloc/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all the fields'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      context.read<AuthBloc>().add(SignInRequest(
            email: _emailController.text,
            password: _passwordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignInSuccessState) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const GNavBar()));
                _emailController.clear();
                _passwordController.clear();
              }
              if (state is SignInFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is SignUpNavigateState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              }
              if (state is ForgotPasswordNavigateState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassWordScreen()));
              }
            },
            listenWhen: (previous, current) => current is AuthActionState,
            buildWhen: (previous, current) => current is! AuthActionState,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                      child: Icon(
                    Icons.movie,
                    size: 100,
                    color: Colors.red,
                  )),
                  Text(
                    'Movie App',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.red,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Enjoy the world of movies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),

                  // Email TextField
                  const SizedBox(height: 32),
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
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

                  // Password TextField
                  const SizedBox(height: 16),
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
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Icon(
                                Icons.password,
                                color: Colors.white,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // forgot password
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(ForgotPasswordNavigateEvent());
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            )),
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),

                  // Sign In Button
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            SignInRequest(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Not a member text
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignUpNavigateEvent());
                        },
                        child: const Text("Sign Up Now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            )),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
