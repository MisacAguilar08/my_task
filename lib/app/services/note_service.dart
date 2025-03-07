import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

class NotesService {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');

  Future<bool> addNote(String id, String title, bool statusCheck, String date) async {
    try{
      await notesCollection.doc(id).set({
        'title': title,
        'done': statusCheck,
        'date': date
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<void> updateNoteDone(String id, bool done) async {
    await notesCollection.doc(id).update({"done": done});
  }

  Future<bool> deleteNote(String id) async {
    try{
      await notesCollection.doc(id).delete();
      return true;
    }catch(e){
      return false;
    }
  }

  Future<List<Task>> getNotes() async {
    try {
      QuerySnapshot snapshot = await notesCollection.get();
      return snapshot.docs.map((doc) {
        return Task.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>, // Agrega el contenido del documento
        });
      }).toList();
    } catch (e) {
      throw Exception("Error al obtener notas: $e");
    }
  }
}
