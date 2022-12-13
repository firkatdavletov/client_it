import 'package:client_it_product/app/di/init_di.dart';
import 'package:client_it_product/app/domain/error_entity/error_entity.dart';
import 'package:client_it_product/app/ui/app_loader.dart';
import 'package:client_it_product/app/ui/components/app_snack_bar.dart';
import 'package:client_it_product/feature/posts/domain/post_repo.dart';
import 'package:client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:client_it_product/feature/posts/domain/state/detail_post/detail_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entity/post/post_entity.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailPostCubit(locator.get<PostRepo>(), id)..fetchPost(),
      child: const _DeatailPostView(),
    );
  }
}

class _DeatailPostView extends StatelessWidget {
  const _DeatailPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Detail post screen'),
        actions: [
          IconButton(
            onPressed: (){
              context.read<DetailPostCubit>().deletePost().then((_) {
                context.read<PostCubit>().fetchPosts();
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: BlocConsumer<DetailPostCubit, DetailPostState>(
        builder: (context, state) {
          if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          if (state.postEntity != null) {
            return _DetailPostItem(postEntity: state.postEntity!);
          }
          return const Center(
            child: Text("Ошибка данных"),
          );
        },
        listener: (context, state) {
          if (state.asyncSnapshot.hasData) {
            AppSnackBar.showSnackBarWithMessage(
                context,
                state.asyncSnapshot.data.toString()
            );
          }
          if (state.asyncSnapshot.hasError) {
            AppSnackBar.showSnackBarWithError(
                context,
                ErrorEntity.fromException(state.asyncSnapshot.error)
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class _DetailPostItem extends StatelessWidget {
  const _DetailPostItem({required this.postEntity});
  final PostEntity postEntity;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Name: ${postEntity.name}"),
        Text("Content: ${postEntity.content}"),
      ],
    );
  }
}


