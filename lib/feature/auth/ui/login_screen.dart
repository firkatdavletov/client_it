import 'package:client_it_product/feature/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/ui/components/app_elevated_button.dart';
import '../../../app/ui/components/app_text_field.dart';
import '../domain/auth_state/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login screen'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: controllerLogin,
                    labelText: 'Login',
                  ),
                  const SizedBox(height: 16.0,),
                  AppTextField(
                    obscureText: true,
                    controller: controllerPassword,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 16.0,),
                  AppElevatedButton(
                    text: 'Войти',
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        _onTapToSignIn(context.read<AuthCubit>());
                      }
                    },
                  ),
                  const SizedBox(height: 16.0,),
                  AppElevatedButton(
                    backgroundColor: Colors.blueGrey,
                    text: 'Регистрация',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterScreen()
                      ));
                    },
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  _onTapToSignIn(AuthCubit authCubit) => authCubit.signIn(
      username: controllerLogin.text, password: controllerPassword.text);
}
