// ignore_for_file: prefer_const_constructors

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:to_do_list/services/firestore.dart';


class Task {
  
  final String title;
  final String description;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;
  final DateTime? due;
  final String? repetition;
  final String? list;
  final bool isTaskCompleted=false;

  Task({
    
    required this.title,
    required this.description,
    this.dueDate,
    this.dueTime,
    this.due,
    this.repetition,
    this.list,
  });

  Map<String , dynamic> toJson()=>{
    
    'title':title,
    'description':description,
    'dueDate':dueDate,
    'dueTime':dueTime,
    'repitiion':repetition,
    'list':list,
  };
}



class AddTask extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState(duedate: duedate);

  DateTime duedate;

  AddTask({required this.duedate});

}



class _AddTaskScreenState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime= TimeOfDay(hour: 23, minute: 59);
  String? _selectedRepetition="None";
  String? _selectedList="Default";
  final bool isTaskCompleted=false;

  _AddTaskScreenState({required DateTime duedate}) {
    _selectedDate = duedate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //for title textfield
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(), // Add border to text field
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(), // Add border to text field
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Due Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _selectedDate = selectedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Due Time: ${_selectedTime?.format(context) ?? "Not set"}'),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _selectedTime = selectedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedRepetition,
                onChanged: (value) {
                  setState(() {
                    _selectedRepetition = value;
                  });
                },
                items: ["None", "Daily", "Weekly", "Monthly"]
                    .map((repetition) => DropdownMenuItem(
                          value: repetition,
                          child: Text(repetition),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Repetition',
                  border: OutlineInputBorder(), // Add border to dropdown
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedList,
                onChanged: (value) {
                  setState(() {
                    _selectedList = value;
                  });
                },
                items: ["Default", "Personal", "Wishlist", "Work"]
                    .map((list) => DropdownMenuItem(
                          value: list,
                          child: Text(list),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Add to List',
                  border: OutlineInputBorder(), // Add border to dropdown
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text;
                  final description = _descriptionController.text;
                  if (title.isNotEmpty) {
                    Map<String,dynamic> taskMap = {
                        
                        'title': title,
                        'description': description,
                        'due': DateTime(_selectedDate!.year,_selectedDate!.month,_selectedDate!.day,_selectedTime!.hour,_selectedTime!.minute),
                        'repetition': _selectedRepetition,
                        'list': _selectedList,
                        'completed': isTaskCompleted,
                  };
                      FireStoreServices().createTask(taskMap).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Added Successfully"),
    ),
  );
});
                      Navigator.pop(context);
                    
                  }
                  
                },
                child: Text('Add Task'), 
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}