import 'package:cloud_firestore/cloud_firestore.dart';

class NotesService {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String date, String title, bool statusCheck) async {
    await notesCollection.add({
      'title': title,
      'done': statusCheck,
      'date': date
    });
  }

  Future<void> updateNote(String idTask, String title, bool statusCheck) async {
    // await notesCollection.doc("").update(data)
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    try {
      QuerySnapshot snapshot = await notesCollection.get();
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>, // Agrega el contenido del documento
        };
      }).toList();
    } catch (e) {
      throw Exception("Error al obtener notas: $e");
    }
  }
}
