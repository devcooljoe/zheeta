import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zheeta/app/common/color.dart';
import 'package:zheeta/app/common/strings.dart';
import 'package:zheeta/app/common/text_style.dart';
import 'package:zheeta/app/router/app_router.dart';
import 'package:zheeta/app/router/app_router.gr.dart';
import 'package:zheeta/authentication/presentation/viewmodel/user_auth_viewmodel.dart';
import 'package:zheeta/widgets/input_field.dart';
import 'package:zheeta/widgets/primary_button.dart';

@RoutePage()
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool _isPasswordObscure = true;
  bool agree = false;
  final formKey = GlobalKey<FormState>();
  late UserAuthViewModel userAuthViewModel;

  @override
  void initState() {
    userAuthViewModel = ref.read(userAuthViewModelProvider.notifier);
    super.initState();
  }

  final validatorChange = ValueNotifier<dynamic>(null);

  @override
  Widget build(BuildContext context) {
    final userAuthState = ref.watch(userAuthViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Image.asset("assets/images/full-logo.png", height: 36),
                SizedBox(height: 40),
                Text(signupTitle, style: authTitleStyle),
                SizedBox(height: 5),
                GestureDetector(
                    onTap: () {
                      router.push(SignInRoute());
                    },
                    child: Text(signupSubtitle, style: authSubtitleStyle)),
                SizedBox(height: 32),
                InputField(
                  hintText: 'Username',
                  validator: (data) => userAuthViewModel.validateUsername(),
                  onChanged: (value) {
                    validatorChange.value = value;
                    userAuthViewModel.setUsername(value);
                  },
                ),
                InputField(
                  hintText: 'Password',
                  password: _isPasswordObscure,
                  validator: (data) => userAuthViewModel.validatePassword(),
                  onChanged: (value) {
                    validatorChange.value = value;
                    userAuthViewModel.setPassword(value);
                  },
                ),
                InputField(
                  hintText: 'Retype Password',
                  password: _isPasswordObscure,
                  validator: (data) =>
                      userAuthViewModel.validateRetypedPassword(),
                  onChanged: (value) {
                    validatorChange.value = value;
                    userAuthViewModel.setRetypePassword(value);
                  },
                ),
                SizedBox(height: 10),
                InputField(
                  hintText: 'Email Address',
                  validator: (data) => userAuthViewModel.validateEmail(),
                  onChanged: (value) {
                    validatorChange.value = value;
                    userAuthViewModel.setEmail(value);
                  },
                ),
                SizedBox(height: 10),
                IntlPhoneField(
                  disableLengthCheck: true,
                  decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.grey.withOpacity(0.5), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primaryDark, width: 1.0),
                      ),
                      border: const OutlineInputBorder(),
                      hintText: "Phone number",
                      hintStyle: TextStyle(
                          color: AppColors.grey.withOpacity(0.5), fontSize: 14),
                      errorStyle: const TextStyle(color: Colors.red)),
                  initialCountryCode:
                      userAuthViewModel.getPhoneNumber.countryCode,
                  validator: (phone) => userAuthViewModel.validatePhoneNumber(),
                  onChanged: (phone) {
                    validatorChange.value = phone;
                    userAuthViewModel.setPhoneNumber(phone);
                  },
                  onCountryChanged: (value) =>
                      userAuthViewModel.setCountryCode(value),
                  autovalidateMode: AutovalidateMode.disabled,
                ),
                SizedBox(height: 10),
                InputField(
                  hintText: 'Referral (Optional)',
                  onChanged: (value) => userAuthViewModel.setReferral(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 1.0, color: AppColors.primaryDark),
                      ),
                      value: agree,
                      onChanged: (value) {
                        validatorChange.value = value;
                        setState(() {
                          agree = value!;
                        });
                        userAuthViewModel.setAgree(agree);
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Agree to our',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: AppColors.black),
                        ),
                        GestureDetector(
                          child: Text(
                            ' terms?',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.primaryDark),
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ListenableBuilder(
                      listenable: validatorChange,
                      builder: (context, _) {
                        return PrimaryButton(
                          title: 'Sign Up',
                          disabled: userAuthViewModel.validateUsername() !=
                                  null ||
                              userAuthViewModel.validatePassword() != null ||
                              userAuthViewModel.validateRetypedPassword() !=
                                  null ||
                              userAuthViewModel.validateEmail() != null ||
                              userAuthViewModel.validatePhoneNumber() != null ||
                              !agree,
                          state: userAuthState.registerUserState.isLoading,
                          action: () async {
                            final isValid = formKey.currentState?.validate();
                            if (isValid ?? false) {
                              userAuthViewModel.registerUser();
                            }
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
