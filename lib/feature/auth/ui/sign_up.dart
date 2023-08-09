import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/feature/auth/ui/sign_in.dart';
import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignUpSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
                _nameController.clear();
                _emailController.clear();
                _passwordController.clear();
                _confirmPasswordController.clear();
              }
              if (state is SignUpFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is SignInNavigateState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
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
                        fontSize: 20,
                      )),

                  // First Name TextField
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          controller: _nameController,
                          decoration: const InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Email TextField
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
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
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

                  // Confirm Password TextField
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
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Icon(
                                Icons.password,
                                color: Colors.white,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Sign Up Button
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_confirmPasswordController !=
                              _passwordController) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password doesn't match"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            BlocProvider.of<AuthBloc>(context).add(
                              SignUpRequest(
                                username: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Already have an account
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            SignInNavigateEvent(),
                          );
                        },
                        child: const Text("Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
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
    ));
  }
}
