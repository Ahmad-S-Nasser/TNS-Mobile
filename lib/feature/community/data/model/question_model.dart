/// Arabic month names for a lightweight client-side date formatter — no
/// `intl` package is a direct dependency in this project yet, and one
/// backend timestamp doesn't warrant adding it.
const List<String> _arabicMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];

String _formatArabicDate(DateTime? date) {
  if (date == null) return '';
  return '${date.day} ${_arabicMonths[date.month - 1]} ${date.year}';
}

/// Mirrors the backend's nested `Answer` value object
/// (`{doctorId, answerText, answeredAt}`).
class AnswerModel {
  final String doctorId;
  final String answerText;
  final DateTime? answeredAt;

  const AnswerModel({
    required this.doctorId,
    required this.answerText,
    this.answeredAt,
  });

  String get displayAnsweredAt => _formatArabicDate(answeredAt);

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        doctorId: json['doctorId']?.toString() ?? '',
        answerText: json['answerText']?.toString() ?? '',
        answeredAt: DateTime.tryParse(json['answeredAt']?.toString() ?? ''),
      );
}

/// Mirrors the real `Question` entity returned by `GET /mobile/qa/questions`:
/// `{id,parentId,assignedDoctorId?,category,questionTextAr,questionTextEn?,
/// isAnonymous,status,answer?{doctorId,answerText,answeredAt},submittedAt,
/// answeredAt?}`. `status` is one of `Pending`/`Answered`/`Closed`.
class QuestionModel {
  final String id;
  final String parentId;
  final String? assignedDoctorId;
  final String category;
  final String questionTextAr;
  final String? questionTextEn;
  final bool isAnonymous;
  final String status;
  final AnswerModel? answer;
  final DateTime? submittedAt;
  final DateTime? answeredAt;

  const QuestionModel({
    required this.id,
    required this.parentId,
    this.assignedDoctorId,
    required this.category,
    required this.questionTextAr,
    this.questionTextEn,
    this.isAnonymous = false,
    required this.status,
    this.answer,
    this.submittedAt,
    this.answeredAt,
  });

  /// Primary display text — the app is Arabic-first/RTL.
  String get text => questionTextAr;

  /// The English translation, if any, shown as a secondary line where the
  /// old hardcoded UI had a free-form "description" field.
  String? get description =>
      questionTextEn?.isNotEmpty == true ? questionTextEn : null;

  /// Generic display name for the asker. Deliberately not a per-question
  /// `/users/{id}` lookup (would be N+1 calls for a question list) — an
  /// explicit decision from the rebuild plan. Anonymous questions get a
  /// distinct label so the two cases still read differently in the UI.
  String get displayAuthor => isAnonymous ? 'أم مجهولة' : 'مستخدم';

  String get displayDate => _formatArabicDate(submittedAt);

  bool get isAnswered => status == 'Answered' || answer != null;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json['id']?.toString() ?? '',
        parentId: json['parentId']?.toString() ?? '',
        assignedDoctorId: json['assignedDoctorId']?.toString(),
        category: json['category']?.toString() ?? '',
        questionTextAr: json['questionTextAr']?.toString() ?? '',
        questionTextEn: json['questionTextEn']?.toString(),
        isAnonymous: json['isAnonymous'] == true,
        status: json['status']?.toString() ?? 'Pending',
        answer: json['answer'] is Map
            ? AnswerModel.fromJson(
                Map<String, dynamic>.from(json['answer'] as Map))
            : null,
        submittedAt: DateTime.tryParse(json['submittedAt']?.toString() ?? ''),
        answeredAt: DateTime.tryParse(json['answeredAt']?.toString() ?? ''),
      );
}
