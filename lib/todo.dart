import 'dart:ffi';

import 'package:consistency_app/data/database.dart';
import 'package:consistency_app/tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'homescreen.dart',

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final my_box = Hive.box("mybox");
  final control=TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if(my_box.get("todo")==null){
      db.defaulttask();
    }
    else{
      db.load();
    }

    super.initState();
  }
  void change(bool? val, int index){
    setState((){
      db.toDo[index][1]=!db.toDo[index][1];
    }
    );
    db.update();
  }
  void savetask(){
    setState(() {
      db.toDo.add([control.text,false]);
      control.clear();
    });
    Navigator.of(context).pop();
    db.update();
  }
  void deletetask(int index){
    setState(() {
      db.toDo.removeAt(index);
    });
    db.update();
  }
  void edited(int index){
    setState((){
      db.toDo[index][0]=control.text;
    });
    Navigator.pop(context);
    db.update();
  }
  void edittask(int index){
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        backgroundColor: Colors.grey[300],
        actions: [
          MaterialButton(
            onPressed:() => edited(index),
            child: Text(
                "Save"
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.delete),
          ),
        ],

        content: Container(
          height: 70,
          child: Column(
            children: [
              TextField(
                controller: control,
                decoration: InputDecoration(
                  hintText: "Edit task",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
  void newtask(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.grey[300],
        actions: [
          MaterialButton(
            onPressed: savetask,
            child: Text(
                "Save"
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.delete),
          ),
        ],

        content: Container(
          height: 70,
          child: Column(
            children:[
              TextField(
                controller: control,
                decoration: InputDecoration(
                  hintText: "Create new task",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar:
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 100,
          title:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "Your Tasks",
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.grey[100],
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.black12,
                offset: const Offset(0.0, 0.0),
                blurRadius: 5.0,
                spreadRadius: 5.0,
              ),],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              gradient: const LinearGradient(
                  colors: [Color(0xFFEF9A9A),Color(0xFFFFE082)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: newtask,
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              "Your Tasks",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: db.toDo.length,
              itemBuilder: (context,index){
                return Tile(
                  name: db.toDo[index][0],
                  finished: db.toDo[index][1],
                  onChanged: (val) => change(val,index),
                  delete: (context) => deletetask(index),
                  edit: (context) => edittask(index),
                );
              }

            ),
          ),
        ],
      ),
    );
  }
}
