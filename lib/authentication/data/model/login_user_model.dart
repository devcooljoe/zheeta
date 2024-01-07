import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zheeta/authentication/domain/entity/types.dart';

part 'login_user_model.freezed.dart';
part 'login_user_model.g.dart';

@freezed
class LoginUserModel with _$LoginUserModel {
  @JsonSerializable(explicitToJson: true)
  const factory LoginUserModel({
    required dynamic token,
    required dynamic username,
  }) = _LoginUserModel;

  factory LoginUserModel.fromJson(MappedResponse json) => _$LoginUserModelFromJson(json);
}