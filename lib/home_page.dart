import 'package:attendance_manager/add_subject_page.dart';
import 'package:flutter/material.dart';

class Subject {
  String name;
  int present;
  int total;

  Subject(this.name, this.present, this.total);

  double get percentage => (total > 0) ? (present / total) * 100 : 0;

  // Method to increment present variable
  void incrementPresent() {
    present++;
  }

  // Method to increment total variable
  void incrementTotal() {
    total++;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Subject> subjects = [
    Subject("Mathematics", 10, 12),
    Subject("English", 8, 10),
    Subject("Science", 9, 11),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Manager'),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return ListTile(
            title: Text(subject.name),
            subtitle: Text('${subject.present}/${subject.total} classes'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    setState(() {
                      subject.incrementPresent();
                      subject.incrementTotal(); // Increment total as well
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      subject.incrementTotal();
                    });
                  },
                ),
                CircularPercentIndicator(subject.percentage),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectDetailPage(subject: subject),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final addedSubject = await Navigator.push<Subject>(
            context,
            MaterialPageRoute(
                builder: (context) => AddSubjectPage(
                      subjects: [],
                    )),
          );

          if (addedSubject != null) {
            setState(() {
              subjects.add(addedSubject);
            });
          }
        },
      ),
    );
  }
}

class CircularPercentIndicator extends StatelessWidget {
  final double percentage;

  const CircularPercentIndicator(this.percentage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        Text('${percentage.toStringAsFixed(1)}%'),
      ],
    );
  }
}

class SubjectDetailPage extends StatelessWidget {
  final Subject subject;

  const SubjectDetailPage({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Present: ${subject.present}'),
            Text('Total: ${subject.total}'),
            Text('Percentage: ${subject.percentage.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}
