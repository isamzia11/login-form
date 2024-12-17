import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_validation/bloc/auth_bloc.dart';
import 'package:login_form_validation/login_screen.dart';
import 'package:login_form_validation/pallette.dart';
import 'package:login_form_validation/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Pallete.gradient1,
                Pallete.gradient2,
                Pallete.gradient3,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(0.4),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                icon: const Icon(Icons.arrow_back)),
            backgroundColor: Colors.transparent, // Make AppBar transparent
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Home Screen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 0, // Elevation is handled by the Container's shadow
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (_) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const CircularProgressIndicator();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text((state as AuthSuccess).uid),
              ),
              GradientButton(onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              })
            ],
          );
        },
      ),
    );
  }
}
