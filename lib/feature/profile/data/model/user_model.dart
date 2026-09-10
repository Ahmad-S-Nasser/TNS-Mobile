/// Mirrors the real `GET /mobile/users/me` response. Note `overrides` is an
/// audit-style list of permission-override records, not a flat effective
/// permissions array — kept as raw dynamic data and deliberately not used
/// for role gating (see lib/core/auth/role_gate.dart, which gates off the
/// single `role` string instead).
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String role;
  final String? roleCategory;
  final String accountStatus;
  final String? governorateCode;
  final String preferredLanguage;
  final bool isActive;
  final bool isVerified;
  final DateTime? createdAt;
  final DateTime? lastActive;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.role,
    this.roleCategory,
    required this.accountStatus,
    this.governorateCode,
    required this.preferredLanguage,
    required this.isActive,
    required this.isVerified,
    this.createdAt,
    this.lastActive,
  });

  String get fullName => '$firstName $lastName'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        firstName: json['firstName']?.toString() ?? '',
        lastName: json['lastName']?.toString() ?? '',
        phoneNumber: json['phoneNumber']?.toString(),
        role: json['role']?.toString() ?? '',
        roleCategory: json['roleCategory']?.toString(),
        accountStatus: json['accountStatus']?.toString() ?? '',
        governorateCode: json['governorateCode']?.toString(),
        preferredLanguage: json['preferredLanguage']?.toString() ?? 'ar',
        isActive: json['isActive'] == true,
        isVerified: json['isVerified'] == true,
        createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
        lastActive: DateTime.tryParse(json['lastActive']?.toString() ?? ''),
      );
}
