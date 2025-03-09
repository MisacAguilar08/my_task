import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/task.dart';

class NotesService {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('task');

  Future<bool> addNote(String id, String title, bool statusCheck, String date) async {
    try{
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult[0] == ConnectivityResult.none) {
        print('Sin conexión a internet, no se hará ninguna llamada.');
        return false;
      }

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
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult[0] == ConnectivityResult.none) {
        print('Sin conexión a internet, no se hará ninguna llamada.');
        return false;
      }

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
