import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/auth/ui/auth_main.dart';
import '../bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignOutSuccessState) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthMain()),
                (route) => false,
              );
            }
          },
          listenWhen: (previous, current) => current is AuthActionState,
          buildWhen: (previous, current) => current is! AuthActionState,
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email: \n ${user.email}',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  user.uid != null ? Text("${user.uid}") : Container(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Sign Out'),
                    onPressed: () {
                      // Signing out the user
                      context.read<AuthBloc>().add(SignOutRequest());
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
