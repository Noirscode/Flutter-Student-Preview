import 'package:flutter/material.dart';
import 'package:flutter_studentapp/models/student.dart';
import 'package:flutter_studentapp/screens/student_add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> students = [];

  Student selectedStudent = Student.withId(0, "Hiç Kimse", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Öğrenci Takip Sistemi")),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        "${students[index].firstName} ${students[index].lastName}"),
                    subtitle: Text(
                        "Sınavdan Aldığı Not : ${students[index].grade.toString()} [${students[index].getStatus}]"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://digitalage.com.tr/wp-content/uploads/2014/05/Yandexin-g%C3%B6rsel-ile-g%C3%B6rsel-arama-%C3%B6zelli%C4%9Fi-hizmetinizde.jpg"),
                    ),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: () {
                      setState(() {
                        this.selectedStudent = students[index];
                      });
                    },
                    onLongPress: () {
                      print(index);
                    },
                  );
                })),
        Text(
            "Seçili Öğrenci : ${students.isEmpty ? "Hiç Kimse" : selectedStudent.firstName}"),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.greenAccent,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentAdd(students)))
                      .then((value) => setState(() {}));
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Yeni Öğrenci")
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.black12,
                onPressed: () {
                  // ignore: unrelated_type_equality_checks
                  students.remove(selectedStudent);
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentAdd(students)))
                      .then((value) => setState(() {}));
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.settings),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Güncelle")
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Colors.amberAccent,
                onPressed: () {
                  setState(() {
                    // ignore: unrelated_type_equality_checks
                    if (selectedStudent != "Hiç Kimse")
                      students.remove(selectedStudent);
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Sil")
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

Widget buildStatusIcon(int grade) {
  if (grade >= 50) {
    return Icon(
      Icons.done,
      color: Colors.green,
    );
  } else if (grade >= 40) {
    return Icon(Icons.album, color: Colors.grey);
  } else {
    return Icon(Icons.clear, color: Colors.red);
  }
}
