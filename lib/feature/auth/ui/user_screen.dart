import 'package:client_it_product/app/domain/error_entity/error_entity.dart';
import 'package:client_it_product/app/ui/app_loader.dart';
import 'package:client_it_product/app/ui/components/app_elevated_button.dart';
import 'package:client_it_product/app/ui/components/app_snack_bar.dart';
import 'package:client_it_product/app/ui/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/ui/components/app_dialog.dart';
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
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AppDialog(
                              val1: "Old password",
                              val2: "New password",
                              onPressed: (v1, v2) {
                                context.read<AuthCubit>().passwordUpdate(
                                    oldPassword: v1,
                                    newPassword: v2
                                );
                              },
                            )
                        );
                      },
                      child: const Text("Обновить пароль")
                  ),
                  TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) => AppDialog(
                              val1: "Username",
                              val2: "Email",
                              onPressed: (v1, v2) {
                                context.read<AuthCubit>().userUpdate(
                                    username: v1,
                                    email: v2
                                );
                              },
                            )
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

