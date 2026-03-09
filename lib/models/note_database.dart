import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:longtut/models/note_model.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteModelSchema], directory: dir.path);
  }

  final List<NoteModel> notes = [];

  Future<void> addNote(String text) async {
    final newNote = NoteModel()..text = text;
    isar.writeTxn(() => isar.noteModels.put(newNote));
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<NoteModel> notes = await isar.noteModels.where().findAll();
    this.notes.clear();
    this.notes.addAll(notes);
    notifyListeners();
  }

  Future<void> updateNote(int id, String newText) async {
    final note = await isar.noteModels.get(id);
    if (note != null) {
      note.text = newText;
      await isar.writeTxn(() => isar.noteModels.put(note));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchNotes();
  }
}
