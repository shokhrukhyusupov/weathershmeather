import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_event.dart';
import 'package:weathershmeather/repository/auth_repository.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_state.dart';
import 'package:weathershmeather/bloc/auth_bloc/auth_status.dart';
import 'package:weathershmeather/pages/home_screen.dart';
import 'package:weathershmeather/pages/verify_sreen.dart';
import 'package:weathershmeather/styles.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthBloc(authRepo: context.read<AuthRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          final _formstatus = state.formStatus;
          if (_formstatus is SubmittionError) {
            _showSnackBar(context, _formstatus.error.toString());
          } else if (_formstatus is SubmittionSuccessForMail) {
            if (state.isLogin) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    email: _formstatus.user.email!,
                    uid: _formstatus.user.uid,
                    displayName: _formstatus.user.displayName!,
                    photoUrl: null,
                  ),
                ),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const VerifyScreen()),
                (route) => false,
              );
            }
          } else if (_formstatus is SubmittionSuccessForGoogle) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  email: _formstatus.signInAccount.email,
                  uid: _formstatus.signInAccount.id,
                  displayName: _formstatus.signInAccount.displayName!,
                  photoUrl: _formstatus.signInAccount.photoUrl!,
                ),
              ),
              (route) => false,
            );
          }
        }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return ScaleTransition(
            scale: const AlwaysStoppedAnimation(0.9),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  const EmailFormFiled(),
                  const SizedBox(height: 15),
                  const PasswordFormFiled(isConfirm: false),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state.isLogin) {
                        return Column(
                          children: [
                            const SizedBox(height: 25),
                            TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {},
                              child: const Text('Forgot your password?'),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: const [
                            SizedBox(height: 15),
                            PasswordFormFiled(isConfirm: true),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  ConfirimButton(formkey: _formKey),
                  const Spacer(flex: 1),
                  const Text(
                    'OR SIGN IN WITH A',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton.icon(
                            onPressed: state.buttonStatus
                                ? () {
                                    context.read<AuthBloc>().add(
                                        AuthButtonStatus(buttonStatus: false));
                                    context
                                        .read<AuthBloc>()
                                        .add(GoogleSubmit());
                                  }
                                : null,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              size: 50,
                              color: Colors.red[600],
                            ),
                            label: const Text('oogle',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            icon: FaIcon(
                              FontAwesomeIcons.facebookF,
                              size: 50,
                              color: Colors.blue[800],
                            ),
                            label: Text('acebook',
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        })),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: (Text(message)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class EmailFormFiled extends StatelessWidget {
  const EmailFormFiled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          onChanged: (value) => context
              .read<AuthBloc>()
              .add(AuthEmailChanged(email: value.toLowerCase())),
          validator: (value) => state.validateMail
              ? null
              : 'Такого почтового адреса не существует',
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.mail_outline_rounded),
            hintText: 'Enter email',
            hintStyle: kHintStyle,
            labelText: 'Email',
            labelStyle: kHintStyle,
            border: kOutlineBorder,
            focusedBorder: kOutlineFocusedBorder,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
          ),
        ),
      );
    });
  }
}

class PasswordFormFiled extends StatelessWidget {
  final bool isConfirm;
  const PasswordFormFiled({required this.isConfirm, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          onChanged: (value) => isConfirm
              ? context
                  .read<AuthBloc>()
                  .add(AuthPasswordConfirimChanged(password: value))
              : context
                  .read<AuthBloc>()
                  .add(AuthPasswordChanged(password: value)),
          validator: (value) => isConfirm
              ? (state.validateConfirimPassword ? null : 'Пароли не совпадают')
              : (state.validatePassword ? null : 'Минимальное кол-во знаков-6'),
          obscureText: state.isObscure,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            hintText: isConfirm ? 'Re-enter password' : 'Enter password',
            hintStyle: kHintStyle,
            labelText: isConfirm ? 'Confirm password' : 'Password',
            labelStyle: kHintStyle,
            border: kOutlineBorder,
            focusedBorder: kOutlineFocusedBorder,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            suffixIcon: InkWell(
              onTap: () {
                context
                    .read<AuthBloc>()
                    .add(AuthPasswordIsObscure(isObscure: !state.isObscure));
              },
              child: state.isObscure
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ),
      );
    });
  }
}

class ConfirimButton extends StatelessWidget {
  const ConfirimButton({Key? key, required this.formkey}) : super(key: key);

  final GlobalKey<FormState> formkey;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 6,
                  shadowColor: const Color(0x7841A0FF),
                  primary: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                state.isLogin ? 'Sign In' : 'Sign Up',
                style: const TextStyle(fontSize: 22),
              ),
              onPressed: state.buttonStatus
                  ? () {
                      if (formkey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(AuthButtonStatus(buttonStatus: false));
                        context.read<AuthBloc>().add(AuthSubmit());
                      }
                    }
                  : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.isLogin
                  ? "don't you have an account?"
                  : 'Do you already have an account?'),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(AuthChangeType(loginType: !state.isLogin));
                },
                child: Text(state.isLogin ? 'Create Account' : 'Sign In'),
              )
            ],
          )
        ],
      );
    });
  }
}
