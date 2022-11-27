import 'package:delivery_app/blocs/user/user_bloc.dart';
import 'package:delivery_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/custom_appbar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/signup';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Sign Up",
        action: Container(),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.authstatus == AuthStatus.unauthenticated) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    _buildTextFormField((value) {
                      context.read<AuthBloc>().add(AuthUserCreate(name: value));
                    }, context, 'Name'),
                    const SizedBox(height: 5),
                    _buildTextFormField((value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthUserCreate(email: value));
                    }, context, 'Email'),
                    const SizedBox(height: 5),
                    _buildTextFormField((value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthUserCreate(password: value));
                    }, context, 'Password'),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthSignUp(
                              email: state.email!, password: state.password!));
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You have an acount!",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String hintText,
  ) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 10),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ));
  }
}
