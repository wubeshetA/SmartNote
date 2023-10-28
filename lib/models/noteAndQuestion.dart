
class DataNote {
  final dynamic
      id; // I noticed it was a String in your example, make sure   final intthis is the right type
  final String notes;
  final String questions;
  final String title;
  final String created_at;

  DataNote({
    required this.id,
    required this.notes,
    required this.questions,
    required this.title,
    required this.created_at,
  });

  factory DataNote.fromMap(Map<String, dynamic> map) {
    return DataNote(
      id: map['id'],
      notes: map['notes'],
      questions: map['questions'],
      title: map['title'],
      created_at: map['created_at'],
    );
  }
}
