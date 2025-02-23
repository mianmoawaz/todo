import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String docId;
  String userId;
  String title;
  String description;
  DateTime? createdAt;

  TodoModel({
    required this.docId,
    required this.userId,
    required this.title,
    required this.description,
    this.createdAt,
  });

  // Convert Firestore Document to TodoModel
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      docId: data['docId'] ?? '',
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert TodoModel to Firestore Document
  Map<String, dynamic> toFirestore() {
    return {
      'docId': docId,
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
