import 'package:client_it_product/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:client_it_product/feature/auth/ui/user_screen.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const  UserScreen()));
              },
              icon: const Icon(Icons.account_box)
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
        ],
      )
    );
  }
}
