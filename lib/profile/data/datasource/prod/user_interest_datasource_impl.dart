import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zheeta/app/api/api_manager.dart';
import 'package:zheeta/app/common/storage/local_storage_impl.dart';
import 'package:zheeta/app/common/storage/storage_keys.dart';
import 'package:zheeta/authentication/domain/entity/types.dart';
import 'package:zheeta/profile/data/datasource/user_interest_datasource.dart';
import 'package:zheeta/profile/data/request/update_user_interest_request.dart';

@prod
@Singleton(as: UserInterestDataSource)
class UserInterestDataSourceImpl implements UserInterestDataSource {
  final ApiManager _apiManager;
  late final String? _authToken;
  UserInterestDataSourceImpl(this._apiManager) {
    _getAuthToken();
  }

  _getAuthToken() async {
    _authToken = (await sessionManager.get(SessionManagerKeys.authTokenString)) as String?;
  }

  @override
  Future<Either<ErrorResponse, MappedResponse>> updateUserInterest(UpdateUserUnterestRequest request) async {
    final response = await _apiManager.putHttp('/user/add-update-user-interests', request.toJson(), token: _authToken);
    if (response.success) {
      return Right(response.data);
    } else {
      return Left(
        ErrorResponse(message: response.message, data: response.data),
      );
    }
  }

  @override
  Future<Either<ErrorResponse, MappedResponse>> getInterests() async {
    final response = await _apiManager.getHttp('/admin-settings/interests', token: _authToken);
    if (response.success) {
      return Right(response.data);
    } else {
      return Left(
        ErrorResponse(message: response.message, data: response.data),
      );
    }
  }
}
