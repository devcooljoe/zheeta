import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:zheeta/app/common/exceptions/custom_exception.dart';
import 'package:zheeta/app/common/mixins/validation_helper.dart';
import 'package:zheeta/app/common/notify/notify_user.dart';
import 'package:zheeta/app/common/storage/local_storage_impl.dart';
import 'package:zheeta/app/common/storage/storage_keys.dart';
import 'package:zheeta/app/injection/di.dart';
import 'package:zheeta/app/router/app_router.dart';
import 'package:zheeta/app/router/app_router.gr.dart';
import 'package:zheeta/authentication/data/request/login_request.dart';
import 'package:zheeta/authentication/data/request/register_user_request.dart';
import 'package:zheeta/authentication/data/request/reset_password_request.dart';
import 'package:zheeta/authentication/domain/usecase/user_auth_usecase.dart';
import 'package:zheeta/authentication/presentation/state/state.dart';
import 'package:zheeta/authentication/presentation/state/user_auth_state.dart';
import 'package:zheeta/authentication/presentation/viewmodel/user_otp_viewmodel.dart';

final userAuthViewModelProvider =
    StateNotifierProvider<UserAuthViewModel, UserAuthState>((ref) {
  final authUsecase = locator<UserAuthUseCase>();
  return UserAuthViewModel(authUsecase, ref);
});

class UserAuthViewModel extends StateNotifier<UserAuthState>
    with ValidationHelperMixin {
  final UserAuthUseCase _authUsecase;
  final Ref ref;
  UserAuthViewModel(this._authUsecase, this.ref)
      : super(
          UserAuthState(
            registerUserState: State.init(),
            loginUserState: State.init(),
            registerStaffState: State.init(),
            changePasswordState: State.init(),
            resetPasswordState: State.init(),
            loginOAuthState: State.init(),
          ),
        );

  String _username = '';
  String _password = '';
  String _retypePassword = '';
  String _email = '';
  PhoneNumber _phoneNumber =
      PhoneNumber(countryISOCode: '+234', countryCode: 'NG', number: '');
  String? _referral = null;
  bool _agree = false;
  String _userDeviceToken =
      '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
  String _otp = '';
  String _newPassword = '';

  setUsername(String value) => _username = value;
  setPassword(String value) => _password = value;
  setRetypePassword(String value) => _retypePassword = value;
  setEmail(String value) => _email = value;
  setPhoneNumber(PhoneNumber value) => _phoneNumber = value;
  setCountryCode(Country value) =>
      _phoneNumber.countryCode = '+${value.dialCode}';
  setReferral(String value) =>
      value.isEmpty ? _referral = null : _referral = value;
  setAgree(bool value) => _agree = value;
  setUserDeviceToken(String value) => _userDeviceToken = value;
  setOtp(String value) => _otp = value;
  setNewPassword(String value) => _newPassword = value;

  PhoneNumber get getPhoneNumber => _phoneNumber;
  String get getEmail => _email;

  String? validateUsername() => this.isValidInput(_username);
  String? validatePassword([bool isLoginField = false]) {
    if (isLoginField) {
      return this.isValidInput(_password);
    } else {
      return this.isValidPassword(_password);
    }
  }

  String? validateRetypedPassword() =>
      _password == _retypePassword ? null : 'Password does not match';
  String? validateEmail() => this.isValidEmail(_email);
  String? validatePhoneNumber() =>
      this.isValidPhoneNumber(_phoneNumber.completeNumber);
  String? validateOtp() => this.isValidNumber(_otp, minLength: 6);
  String? validateNewPassword() => this.isValidPassword(_newPassword);

  Future<bool> registerUser() async {
    state = state.setRegisterUserState(State.loading());

    final retypedPasswordIsMatchOrMessage = validateRetypedPassword();
    if (retypedPasswordIsMatchOrMessage != null) {
      NotifyUser.showSnackbar(retypedPasswordIsMatchOrMessage);
      state = state.setRegisterUserState(
          State.error(Exception(retypedPasswordIsMatchOrMessage)));
      return false;
    }

    if (_agree && retypedPasswordIsMatchOrMessage == null) {
      try {
        final data = RegisterUserRequest(
          userName: _username,
          password: _password,
          email: _email,
          phoneNumber: _phoneNumber.number,
          phoneCountryCode: _phoneNumber.countryCode,
          referralCode: _referral,
        );
        final result = await _authUsecase.registerUserUsecase(data);
        state = state.setRegisterUserState(State.success(result));

        // Navigate to verification screen
        router.popAndPush(VerificationRoute(
            isPhoneNumber: true,
            phoneNumber: _phoneNumber.number,
            countryCode: _phoneNumber.countryCode,
            email: _email));
        return true;
      } on DuplicateRegisterParamException catch (e) {
        state = state.setRegisterUserState(State.error(e));
        if (e.usernameException != null) {
          NotifyUser.showSnackbar(e.usernameException!);
        }
        if (e.emailException != null) {
          NotifyUser.showSnackbar(e.emailException!);
        }
        if (e.phoneException != null) {
          NotifyUser.showSnackbar(e.phoneException!);
        }
        state = state.setRegisterUserState(State.error(e));
        return false;
      } on Exception catch (e) {
        state = state.setRegisterUserState(State.error(e));
        NotifyUser.showSnackbar(e.toString());
        return false;
      }
    } else {
      NotifyUser.showSnackbar('Please agree to the terms and conditions');
      state = state.setRegisterUserState(State.init());
      return false;
    }
  }

  Future<bool> loginUser() async {
    state = state.setLoginUserState(State.loading());
    try {
      final data = LoginRequest(
          email: _email,
          password: _password,
          userDeviceToken: _userDeviceToken,
          platform: 'APNS');
      final result = await _authUsecase.loginUsecase(data);
      state = state.setLoginUserState(State.success(result));

      final Map<String, dynamic> jwtToken = Jwt.parseJwt(result.token);

      await sessionManager.set(SessionManagerKeys.isLoggedInBool, true);
      await sessionManager.set(
          SessionManagerKeys.authTokenString, result.token);

      await sessionManager.set(
          SessionManagerKeys.authUserIdString, jwtToken['nameid']);
      await sessionManager.set(
          SessionManagerKeys.authUserEmailString, jwtToken['email']);

      // Navigate to dashboard screen
      router.pushAndPopUntil(WelcomeRoute(), predicate: (route) => false);
      return true;
    } on UserNotFoundException catch (e) {
      state = state.setLoginUserState(State.error(e));
      NotifyUser.showSnackbar(e.toString());

      return false;
    } on EmailNotVerifiedException catch (e) {
      state = state.setLoginUserState(State.error(e));

      final _userOtpViewModel = ref.read(userOtpViewModelProvider.notifier);
      _userOtpViewModel.setPhoneNumberOrEmail(
          isPhoneNumber: false,
          phoneNumber: _phoneNumber.number,
          countryCode: _phoneNumber.countryCode,
          email: _email);
      await _userOtpViewModel.sendEmailVerifyOtp();

      router.push(VerificationRoute(
          isPhoneNumber: false,
          phoneNumber: _phoneNumber.number,
          countryCode: _phoneNumber.countryCode,
          email: _email));
      return false;
    } on Exception catch (e) {
      state = state.setLoginUserState(State.error(e));
      NotifyUser.showSnackbar(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword() async {
    state = state.setResetPasswordState(State.loading());
    try {
      final retypePasswordIsMatchOrMessage = validateRetypedPassword();
      if (retypePasswordIsMatchOrMessage != null) {
        NotifyUser.showSnackbar(retypePasswordIsMatchOrMessage);
        state = state.setResetPasswordState(
            State.error(Exception(retypePasswordIsMatchOrMessage)));
        return false;
      } else {
        final data = ResetPasswordRequest(
            email: _email, otp: _otp, newPassword: _password);
        final result = await _authUsecase.resetPasswordUsecase(data);
        state = state.setResetPasswordState(State.success(result));

        // Navigate to dashboard screen
        router.pushAndPopUntil(SignInRoute(), predicate: (route) => false);
      }
      return true;
    } on Exception catch (e) {
      state = state.setResetPasswordState(State.error(e));
      NotifyUser.showSnackbar(e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    _username = '';
    _password = '';
    _retypePassword = '';
    _email = '';
    _phoneNumber =
        PhoneNumber(countryISOCode: '+234', countryCode: 'NG', number: '');
    _referral = '';
    _agree = false;
    _userDeviceToken = '';
    _otp = '';
    _newPassword = '';
    super.dispose();
  }
}
