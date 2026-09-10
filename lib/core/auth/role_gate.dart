import 'package:tips_n_steps/feature/auth/data/auth_repository.dart';

/// Client-side role gating off the backend's single `role` string
/// (Parent|Doctor|Admin|SuperAdmin). The `/mobile/users/me` response also
/// returns an `overrides` array, but that is an audit log of permission
/// overrides, not a flat effective-permissions list — deliberately not used
/// here to avoid mis-deriving access from it.
bool canAccess(String? role, Set<String> allowed) {
  if (role == null || role.isEmpty) return false;
  return allowed.contains(role);
}

bool isDoctorOrAdmin(String? role) => canAccess(
      role,
      const {UserRoles.doctor, UserRoles.admin, UserRoles.superAdmin},
    );

bool isAdmin(String? role) => canAccess(
      role,
      const {UserRoles.admin, UserRoles.superAdmin},
    );
