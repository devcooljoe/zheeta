import 'package:injectable/injectable.dart';
import 'package:zheeta/profile/data/datasource/user_profile_boost_datasource.dart';
import 'package:zheeta/profile/data/request/create_profile_boost_request.dart';
import 'package:zheeta/profile/domain/entity/type.dart';
import 'package:zheeta/profile/domain/repository/user_profile_boost_repository.dart';

@prod
@LazySingleton(as: UserProfileBoostRepository)
class UserProfileBoostRepositoryImpl implements UserProfileBoostRepository {
  final UserProfileBoostDataSource _datasource;
  UserProfileBoostRepositoryImpl(this._datasource);

  @override
  createProfileBoostRepo(CreateProfileBoostRequest request) async {
    final result = await _datasource.createProfileBoost(request);
    return result.fold(
      (error) => throw new Exception(error),
      (value) => value,
    );
  }

  @override
  getBoostedProfileByAdminRepo(GetBoostedProfileByAdminRequest request) async {
    final result = await _datasource.getBoostedProfileByAdmin(request);
    return result.fold(
      (error) => throw new Exception(error),
      (value) => value,
    );
  }

  @override
  getMatchedProfileBoostRepo() async {
    final result = await _datasource.getMatchedProfileBoost();
    return result.fold(
      (error) => throw new Exception(error),
      (value) => value,
    );
  }
}
