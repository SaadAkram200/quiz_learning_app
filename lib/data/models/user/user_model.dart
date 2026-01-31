import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String avatarUrl,
    required int rank,
    required int score,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static const UserModel testUser = UserModel(
    id: '5',
    name: 'Saad Akram',
    email: 'test@gmail.com',
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    rank: 5,
    score: 8200,
  );
}
