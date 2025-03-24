import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class FireStoreServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser!.uid;

  get taskdoc => FirebaseFirestore.instance.collection('Users').doc(uid).collection('Tasks');

  //CREATE
  Future createTask(Map <String,dynamic> taskMap) async{
    
    // taskMap['id']= Taskdoc.id;
    //create document and write data to firebase
    await taskdoc.add(taskMap);
  }

  //READ
  Stream<QuerySnapshot> getTasks()  {
    final taskStream= taskdoc.orderBy("due").where("completed", isEqualTo: false).snapshots();  
    return  taskStream;
  }

  Stream<QuerySnapshot> getTasksbyTab(String tab)  {
    final taskStream= taskdoc.orderBy("due").where("completed", isEqualTo: false).where("list",isEqualTo: tab).snapshots();  
    return  taskStream;
  }


  //UPDATE
  Future<void> UpdateTask (String docID,Map <String,dynamic> newTaskMap) async{
    return await taskdoc.doc(docID).update(newTaskMap);
  }

  Future<void> TaskChecked(String docID) async{
    bool completed=true;
    return await taskdoc.doc(docID).update({"completed":true});
  }

  //DELETE
  Future<void> DeleteTask(String docID){
    return taskdoc.doc(docID).delete();
  }

    Stream<QuerySnapshot> getTasksForDay(DateTime day) {
    DateTime startOfDay = DateTime(day.year, day.month, day.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));
    return taskdoc
        .where('due', isGreaterThanOrEqualTo: startOfDay, isLessThan: endOfDay)
        .where('completed',isEqualTo: false)
        .snapshots();
  }

  int completedTasksCount = 0;
  int get completedtasks=>completedTasksCount;
  int pendingTasksCount = 0;
  int get pendingtasks => pendingTasksCount;

   Future<int> countCompletedTasks() async {
  QuerySnapshot querySnapshot =
      await taskdoc.where("completed", isEqualTo: true).get();
  return querySnapshot.size;
}


  Future<int> countPendingTasks() async {
  QuerySnapshot querySnapshot =
      await taskdoc.where("completed", isEqualTo: false).get();
  return querySnapshot.size;
}
}
  



//   Future<DateTime> getDueDate(String docID) async {
//   DocumentSnapshot snapshot = await taskdoc.doc(docID).get();
//   Timestamp timestamp = snapshot.get("due");
//   DateTime dueDate = timestamp.toDate();
//   return dueDate;
// }


  


