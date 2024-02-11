import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage file where Subject is defined

class AddSubjectPage extends StatefulWidget {
  final List<Subject> subjects; // Pass the subjects list as a parameter

  AddSubjectPage({required this.subjects});

  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {
  final nameController = TextEditingController();
  final presentController = TextEditingController();
  final totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subject'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Subject Name'),
            ),
            TextField(
              controller: presentController,
              decoration: InputDecoration(labelText: 'Present Classes'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: totalController,
              decoration: InputDecoration(labelText: 'Total Classes'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                addSubject();
              },
            ),
          ],
        ),
      ),
    );
  }

  void addSubject() {
    final String name = nameController.text;
    final int present = int.tryParse(presentController.text) ?? 0;
    final int total = int.tryParse(totalController.text) ?? 0;

    if (name.isNotEmpty && total > 0) {
      // Create a new Subject object
      Subject newSubject = Subject(name, present, total);

      // Pass the new Subject object back to the HomePage
      Navigator.pop(context, newSubject);
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    nameController.dispose();
    presentController.dispose();
    totalController.dispose();
    super.dispose();
  }
}
