import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/screens/register_screen.dart';
import 'package:quokka/utils/theme/theme_cubit.dart';
import '../../home/screens/main_screen.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Logging in...")));
        } else if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreen()),
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successful")));
          context.read<ThemeCubit>().loadTheme();
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
          print(state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Add login logic with token saving here
                  final email = emailController.text;
                  final password = passwordController.text;
                  context.read<AuthBloc>().add(
                    LoginRequested(email: email, password: password),
                  );
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
