import 'package:injectable/injectable.dart';
import 'package:zheeta/profile/data/datasource/user_search_datasource.dart';
import 'package:zheeta/profile/data/model/search_user_by_admin_model.dart';
import 'package:zheeta/profile/data/model/search_user_by_customer_model.dart';
import 'package:zheeta/profile/domain/repository/user_search_repository.dart';

@prod
@LazySingleton(as: UserSearchRepository)
class UserSearchRepositorImpl implements UserSearchRepository {
  final UserSearchDataSource _datasource;
  UserSearchRepositorImpl(this._datasource);

  @override
  Future<SearchUserByAdminListModel> findUserByAdminEmailRepo({required String email, required int pageNumber, required int pageSize}) async {
    final result = await _datasource.findUserByAdminEmail(
      email: email,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return result.fold(
      (error) => throw new Exception(error.message),
      (value) => SearchUserByAdminListModel.fromJson(value),
    );
  }

  @override
  Future<SearchUserByAdminListModel> findUserByAdminUsernameRepo({required String username, required int pageNumber, required int pageSize}) async {
    final result = await _datasource.findUserByAdminUsername(
      username: username,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return result.fold(
      (error) => throw new Exception(error.message),
      (value) => SearchUserByAdminListModel.fromJson(value),
    );
  }

  @override
  Future<SearchUserByCustomerListModel> searchUserByCustomerRepo({required String username, required int pageNumber, required int pageSize}) async {
    final result = await _datasource.searchUserByCustomer(
      username: username,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return result.fold(
      (error) => throw new Exception(error.message),
      (value) => SearchUserByCustomerListModel.fromJson(value),
    );
  }
}
