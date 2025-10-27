enum LoginState {
  loggedOut,
  loggedIn,
  loading,
  error,
}

enum AuthMethod {
  email,
  google,
  unknown,
}

enum UserRole {
  user,
  admin,
  guest,
}

class UserSession {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final AuthMethod authMethod;
  final UserRole role;
  final DateTime loginTime;
  final DateTime? lastActiveTime;

  const UserSession({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.authMethod,
    this.role = UserRole.user,
    required this.loginTime,
    this.lastActiveTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'authMethod': authMethod.name,
      'role': role.name,
      'loginTime': loginTime.toIso8601String(),
      'lastActiveTime': lastActiveTime?.toIso8601String(),
    };
  }

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      authMethod: AuthMethod.values.firstWhere(
        (e) => e.name == json['authMethod'],
        orElse: () => AuthMethod.unknown,
      ),
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.user,
      ),
      loginTime: DateTime.parse(json['loginTime'] as String),
      lastActiveTime: json['lastActiveTime'] != null
          ? DateTime.parse(json['lastActiveTime'] as String)
          : null,
    );
  }

  UserSession copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    AuthMethod? authMethod,
    UserRole? role,
    DateTime? loginTime,
    DateTime? lastActiveTime,
  }) {
    return UserSession(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      authMethod: authMethod ?? this.authMethod,
      role: role ?? this.role,
      loginTime: loginTime ?? this.loginTime,
      lastActiveTime: lastActiveTime ?? this.lastActiveTime,
    );
  }
}
