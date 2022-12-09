import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/ui/components/app_elevated_button.dart';
import '../../../app/ui/components/app_text_field.dart';
import '../domain/auth_state/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final controllerLogin = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPassword2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register screen'),
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
                    controller: controllerEmail,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 16.0,),
                  AppTextField(
                    obscureText: true,
                    controller: controllerPassword,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 16.0,),
                  AppTextField(
                    obscureText: true,
                    controller: controllerPassword2,
                    labelText: 'Repeat Password',
                  ),

                  const SizedBox(height: 16.0,),
                  AppElevatedButton(
                    backgroundColor: Colors.blueGrey,
                    text: 'Регистрация',
                    onPressed: () {
                      if (formKey.currentState?.validate() != true) {
                        return;
                      }
                      if (controllerPassword2.text != controllerPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Пароли не совпадают')
                        ));
                      } else {
                        _onTapToSignUp(context.read<AuthCubit>());
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  _onTapToSignUp(AuthCubit authCubit) => authCubit.signUp(
      username: controllerLogin.text, password: controllerPassword.text, email: controllerEmail.text);
}
