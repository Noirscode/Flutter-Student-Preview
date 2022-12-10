import 'package:flutter/material.dart';
import 'package:flutter_studentapp/models/student.dart';

class StudentAdd extends StatefulWidget {
  final List<Student> students;
  StudentAdd(this.students);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State<StudentAdd> {
  var formKey = GlobalKey<FormState>();
  Student student = Student("", "", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  buildFirstNameField(),
                  buildLastNameField(),
                  buildGradeField(),
                  buildSubmitButton()
                ],
              )),
        ),
      ),
    );
  }

  buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Taha"),
      onSaved: (value) {
        student.firstName = value!;
      },
    );
  }

  buildLastNameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Kaçmaz"),
      onSaved: (value) {
        student.lastName = value!;
      },
    );
  }

  buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı Not", hintText: "100"),
      onSaved: (value) {
        student.grade = int.parse(value!);
      },
    );
  }

  buildSubmitButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: () {
        formKey.currentState!.save();
        widget.students.add(student);
        setState(() {
          Navigator.pop(context);
        });
      },
      child: Text("Kaydet"),
    );
  }
}
