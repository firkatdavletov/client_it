import 'package:client_it_product/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:client_it_product/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.userEntity}) : super(key: key);
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main screen'),
        actions: [
          IconButton(
              onPressed: () => context.read<AuthCubit>().getProfile(),
              icon: const Icon(Icons.refresh)
          ),
          IconButton(
              onPressed: () => context.read<AuthCubit>().logOut(),
              icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("username: ${userEntity.username}"),
          const SizedBox(height: 20.0,),
          Text("accessToken: ${userEntity.accessToken}"),
          const SizedBox(height: 20.0,),
          Text("refreshToken: ${userEntity.refreshToken}"),
        ],
      )
    );
  }
}
