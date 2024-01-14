import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  @JsonSerializable(explicitToJson: true)
  const factory UserProfileModel({
    UserModel? user,
    ProfileModel? profile,
    ResidentialAddressModel? residentialAddress,
    OriginAddressModel? originAddress,
    LocationModel? location,
    ProfileCounterModel? profileCounters,
    SubscriptionModel? subscription,
    WalletModel? wallet,
    List<InterestModel>? interests,
    BankAccountDetailModel? bankAccountDetails,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  @JsonSerializable()
  const factory UserModel({
    dynamic userId,
    dynamic isFullyVerified,
    dynamic userName,
    dynamic rolesCSV,
    dynamic createdDate,
    dynamic lastSeenDate,
    dynamic normalizedEmail,
    dynamic emailConfirmed,
    dynamic phoneCountryCode,
    dynamic phoneNumber,
    dynamic phoneNumberConfirmed,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class ProfileModel with _$ProfileModel {
  @JsonSerializable()
  const factory ProfileModel({
    dynamic firstName,
    dynamic lastName,
    dynamic dateOfBirth,
    dynamic gender,
    dynamic languageCSV,
    dynamic aboutMe,
    dynamic height,
    dynamic weight,
    dynamic bodyType,
    dynamic complexion,
    dynamic religion,
    dynamic tagline,
    dynamic occupation,
    dynamic profilePhotoURL,
    dynamic profileStatus,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

@freezed
class ResidentialAddressModel with _$ResidentialAddressModel {
  @JsonSerializable()
  const factory ResidentialAddressModel({
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic zipCode,
  }) = _ResidentialAddressModel;

  factory ResidentialAddressModel.fromJson(Map<String, dynamic> json) => _$ResidentialAddressModelFromJson(json);
}

@freezed
class OriginAddressModel with _$OriginAddressModel {
  @JsonSerializable()
  const factory OriginAddressModel({
    dynamic city,
    dynamic state,
    dynamic country,
    dynamic zipCode,
  }) = _OriginAddressModel;

  factory OriginAddressModel.fromJson(Map<String, dynamic> json) => _$OriginAddressModelFromJson(json);
}

@freezed
class LocationModel with _$LocationModel {
  @JsonSerializable()
  const factory LocationModel({
    dynamic latitude,
    dynamic longitude,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}

@freezed
class ProfileCounterModel with _$ProfileCounterModel {
  @JsonSerializable()
  const factory ProfileCounterModel({
    dynamic friendsCount,
    dynamic refereesCount,
    dynamic postCount,
  }) = _ProfileCounterModel;

  factory ProfileCounterModel.fromJson(Map<String, dynamic> json) => _$ProfileCounterModelFromJson(json);
}

@freezed
class SubscriptionModel with _$SubscriptionModel {
  @JsonSerializable()
  const factory SubscriptionModel({
    dynamic subscriptionId,
    dynamic name,
    dynamic amount,
    dynamic startdate,
    dynamic enddate,
    dynamic status,
    dynamic paymentmethod,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);
}

@freezed
class WalletModel with _$WalletModel {
  @JsonSerializable()
  const factory WalletModel({
    dynamic availableBalance,
    dynamic lastTransactionDate,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);
}

@freezed
class InterestModel with _$InterestModel {
  @JsonSerializable()
  const factory InterestModel({
    dynamic id,
    dynamic title,
  }) = _InterestModel;

  factory InterestModel.fromJson(Map<String, dynamic> json) => _$InterestModelFromJson(json);
}

@freezed
class BankAccountDetailModel with _$BankAccountDetailModel {
  @JsonSerializable()
  const factory BankAccountDetailModel({
    dynamic userId,
    dynamic firstName,
    dynamic lastName,
    dynamic country,
    dynamic payOutType,
    dynamic bankId,
    dynamic bankName,
    dynamic bankCode,
    dynamic branchCode,
    dynamic accountNumber,
    dynamic accountCurrency,
    dynamic routingNumber,
    dynamic swiftCode,
  }) = _BankAccountDetailModel;

  factory BankAccountDetailModel.fromJson(Map<String, dynamic> json) => _$BankAccountDetailModelFromJson(json);
}
