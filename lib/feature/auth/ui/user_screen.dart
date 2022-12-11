import 'package:client_it_product/app/domain/error_entity/error_entity.dart';
import 'package:client_it_product/app/ui/app_loader.dart';
import 'package:client_it_product/app/ui/components/app_elevated_button.dart';
import 'package:client_it_product/app/ui/components/app_snack_bar.dart';
import 'package:client_it_product/app/ui/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/auth_state/auth_cubit.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Личный кабинет'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().logOut();
              },
              icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(
                    context, ErrorEntity.fromException(userEntity.userState?.error));
              }
            }
          );
        },
        builder: (context, state) {
          final userEntity = state.whenOrNull(authorized: (userEntity) => userEntity);
          if (userEntity?.userState?.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(userEntity?.username.split("").first ?? "Отсутствует"),
                    ),
                    const SizedBox(width: 16.0,),
                    Column(
                      children: [
                        Text(userEntity?.username ?? ""),
                        Text(userEntity?.email ?? "")
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  TextButton(
                      onPressed: (){},
                      child: const Text("Обновить пароль")
                  ),
                  TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => const _UserUpdateDialog()
                        );
                      },
                      child: const Text("Обновить данные")
                  ),
                ],
                )
              ],
            ),
          );
        },
      )
    );
  }
}

class _UserUpdateDialog extends StatefulWidget {
  const _UserUpdateDialog({Key? key}) : super(key: key);

  @override
  State<_UserUpdateDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<_UserUpdateDialog> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                  controller: usernameController,
                  labelText: "Username"
              ),
              const SizedBox(height: 16.0,),
              AppTextField(
                  controller: emailController,
                  labelText: "Email"
              ),
              const SizedBox(height: 16.0,),
              AppElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    context.read<AuthCubit>().userUpdate(
                        username: usernameController.text,
                        email: emailController.text
                    );
                  },
                  text: "Применить"
              )
            ],
          ),
        )
      ],
    );
  }
}

