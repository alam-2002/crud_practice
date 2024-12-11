import 'package:crud_practice/common/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../common/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String studentName = '', studentID = '', studentProgramID = '';
  double studentCGPA = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'CRUD Demo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            TextFieldWidget(
              onChanged: (String name) {
                getStudentName(name);
              },
              hintText: 'Name',
            ),
            TextFieldWidget(
              onChanged: (String id) {
                getStudentID(id);
              },
              hintText: 'Student ID',
            ),
            TextFieldWidget(
              onChanged: (String programID) {
                getStudentProgramID(programID);
              },
              hintText: 'Stream',
            ),
            TextFieldWidget(
              onChanged: (String cgpa) {
                getStudentCGPA(cgpa);
              },
              hintText: 'CGPA',
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    createData();
                  },
                  color: Colors.green,
                  hintText: 'Create',
                ),
                CustomButton(
                  onPressed: () {
                    readData();
                  },
                  color: Colors.blue,
                  hintText: 'Read',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    updateData();
                  },
                  color: Colors.orange,
                  hintText: 'Update',
                ),
                CustomButton(
                  onPressed: () {
                    deleteData();
                  },
                  color: Colors.red,
                  hintText: 'Delete',
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Stream', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('CGPA', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('CrudStudents')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(documentSnapshot['studentName']),
                            Text(documentSnapshot['studentID']),
                            Text(documentSnapshot['studentProgramID']),
                            Text(documentSnapshot['studentCGPA'].toString()),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Functions/Methods

  void getStudentName(name) {
    studentName = name;
  }

  void getStudentID(id) {
    studentID = id;
  }

  void getStudentProgramID(programID) {
    studentProgramID = programID;
  }

  void getStudentCGPA(cgpa) {
    studentCGPA = double.parse(cgpa);
  }

  void createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('CrudStudents').doc(studentName);

    Map<String, dynamic> students = {
      'studentName': studentName,
      'studentID': studentID,
      'studentProgramID': studentProgramID,
      'studentCGPA': studentCGPA,
    };

    documentReference.set(students).whenComplete(() {
      print('$studentName created');
    });
  }

  void readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('CrudStudents').doc(studentName);

    documentReference.get().then((datasnapshot) {
      var data = datasnapshot.data() as Map<String, dynamic>;

      print('Name:- ${data['studentName']}');
      print('ID:- ${data['studentID']}');
      print('Strem:- ${data['studentProgramID']}');
      print('CGPA:- ${data['studentCGPA']}');
    });
  }

  void updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('CrudStudents').doc(studentName);

    Map<String, dynamic> students = {
      'studentName': studentName,
      'studentID': studentID,
      'studentProgramID': studentProgramID,
      'studentCGPA': studentCGPA,
    };

    documentReference.set(students).whenComplete(() {
      print('$studentName Updated');
    });
  }

  void deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('CrudStudents').doc(studentName);

    documentReference.delete().whenComplete(() {
      print('$studentName deleted');
    });
  }
}
