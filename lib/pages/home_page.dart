import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController dialogText = TextEditingController();
  final FireStoreService fireStoreService = FireStoreService();

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  void addNote() async {
    fireStoreService.add(dialogText.text);
    dialogText.clear();
  }

  void showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          children: [
            TextField(controller: dialogText),
            ElevatedButton(onPressed: addNote, child: Text("Save")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: StreamBuilder(
        stream: fireStoreService.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;

            return ListView.builder(
              itemBuilder: (context, index) {
                Text(data[index].get("note"));
              },
              itemCount: data.length,
            );
          } else {
            return Text("No data");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
