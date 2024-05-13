import 'history.dart';

class User {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final String nickname;
  final String email;
  final DateTime? emailVerifiedAt;
  final String avatar;
  final String role;
  final int ban;
  final String? reasonBan;
  final int? categoryId;
  final List<dynamic>? history;
  final int? planId;
  final DateTime? startPlan;
  final DateTime? durationPlan;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.email,
    this.emailVerifiedAt,
    required this.avatar,
    required this.role,
    required this.ban,
    this.reasonBan,
    required this.categoryId,
    this.history,
    this.planId,
    this.startPlan,
    this.durationPlan,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      createdAt: DateTime.parse(json['data']['created_at']),
      updatedAt: DateTime.parse(json['data']['updated_at']),
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      nickname: json['data']['nickname'],
      email: json['data']['email'],
      emailVerifiedAt: json['data']['email_verified_at'] != null
          ? DateTime.parse(json['data']['email_verified_at'])
          : null,
      avatar: json['data']['avatar'],
      role: json['data']['role'],
      ban: int.parse(json['data']['ban']),
      reasonBan: json['data']['reason_ban'],
      categoryId: json['data']['category_id'],
      history: _parseHistory(json['data']['history']),
      planId: json['data']['plan_id'],
      startPlan: json['data']['start_plan'] != null
          ? DateTime.parse(json['data']['start_plan'])
          : null,
      durationPlan: json['data']['duration_plan'] != null
          ? DateTime.parse(json['data']['duration_plan'])
          : null,
    );
  }

  static List<dynamic>? _parseHistory(dynamic historyJson) {
    if (historyJson != null && historyJson is List) {
      return historyJson.map<dynamic>((item) {
        if (item['plan'] != null) {
          return HistoryPlan(
            title: item['plan']['title'],
            description: item['plan']['description'],
            addedAt: _parseDate(item['added_at']),
          );
        } else if (item['category'] != null) {
          return HistoryCategory(
            title: item['category']['title'],
            addedAt: _parseDate(item['added_at']),
          );
        } else {
          return HistoryGreeting(
            message: item['greeting'],
            addedAt: _parseDate(item['added_at']),
          );
        }
      }).toList();
    }
    return null;
  }

  static DateTime _parseDate(String dateString) {
    final parts = dateString.split('.');
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $dateString');
    }
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

}