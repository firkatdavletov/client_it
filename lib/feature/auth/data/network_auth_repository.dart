import 'package:client_it_product/app/domain/app_api.dart';
import 'package:client_it_product/feature/auth/data/dto/user_dto.dart';
import 'package:client_it_product/feature/auth/domain/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../domain/entities/user_entity/user_entity.dart';

@Injectable(as: AuthRepository)

class NetworkAuthRepository implements AuthRepository {
  final AppApi api;

  NetworkAuthRepository(this.api);

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await api.getProfile();
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch(_) {
      rethrow;
    }
  }

  @override
  Future passwordUpdate({required String oldPassword, required String newPassword}) {
    // TODO: implement passwordUpdate
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> refreshToken({String? refreshToken}) async {
    try {
      final response = await api.refreshToken(refreshToken: refreshToken);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch(_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn({required String password,
    required String username}) async {
    try {
      final response = await api.signIn(password: password, username: username);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch(_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp({required String password, required String username,
    required String email}) async {
    try {
      final response = await api.signUp(password: password, username: username, email: email);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch(_) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> userUpdate({String? username, String? email}) async {
    try {
      final response = await api.userUpdate(username: username, email: email);
      return UserDto.fromJson(response.data["data"]).toEntity();
    } catch(_) {
      rethrow;
    }
  }
  
}