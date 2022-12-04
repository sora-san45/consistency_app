
import 'package:google_fonts/google_fonts.dart';
import 'package:consistency_app/data/database.dart';
import 'package:consistency_app/tile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
        backgroundColor: Colors.grey[900],
        actions: [
          MaterialButton(
            onPressed:() => edited(index),
            child: Text(
                "Save",
              style: TextStyle(
                color: Colors.yellow[200],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(
                Icons.delete,
              color: Colors.yellow[200],
            ),
          ),
        ],

        content: Container(
          height: 70,
          child: Column(
            children: [
              TextField(
                controller: control,
                cursorColor: Colors.yellow[200],
                decoration: InputDecoration(
                  hintText: "Edit task",
                  hintStyle: TextStyle(
                    color: Colors.yellow[200],
                  ),
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
        backgroundColor: Colors.grey[900],
        actions: [
          MaterialButton(
            onPressed: savetask,
            child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.yellow[200],
                ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(
                Icons.delete,
              color: Colors.yellow[200],
            ),
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
                  hintStyle: TextStyle(
                    color: Colors.yellow[200],
                  ),
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[900],
      appBar:
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 100,
          title:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                  "T O   D O",
                style:GoogleFonts.amiko(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.grey[900],
                ),
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
              color: Colors.yellow[300],
            ),
          ),
        ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.yellow.shade200,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 350),
        onTap: (index){
          if(index==1){
            newtask();
          }
        },
        items: [
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.calendar_month),
      ],
      ),
      body: Column(
        children: [

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
