import 'package:client_it_product/feature/posts/domain/state/cubit/post_cubit.dart';
import 'package:client_it_product/feature/posts/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/ui/app_loader.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state.postList.isNotEmpty) {
            return ListView.builder(
                itemCount: state.postList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PostItem(postEntity: state.postList[index]);
                }
            );
          }

          if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }

          return const SizedBox.shrink();
        }
    );
  }
}
