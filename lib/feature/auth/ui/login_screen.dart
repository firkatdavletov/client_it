import 'package:flutter/material.dart';

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
                  TextFormField(
                    validator: emptyValidator,
                    maxLines: 1,
                    controller: controllerLogin,
                    decoration: const InputDecoration(
                        labelText: 'Login',
                        border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 16.0,),
                  TextFormField(
                    validator: emptyValidator,
                    maxLines: 1,
                    controller: controllerPassword,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 16.0,),
                  ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(double.maxFinite, 40)
                        )
                    ),
                    child: const Text('Войти'),
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        print('OK');
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

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "Обязательное поле";
    }
    return null;
  }
}
