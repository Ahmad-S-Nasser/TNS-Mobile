class QuestionModel {
  final String text;
  final String? description;
  final String author;
  final String date;
  final String status;
  final String? adminReply;
  final String? adminName;

  QuestionModel({
    required this.text,
    this.description,
    required this.author,
    required this.date,
    required this.status,
    this.adminReply,
    this.adminName,
  });
}
