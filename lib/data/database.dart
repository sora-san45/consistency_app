import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{
  List toDo=[];
  final my_box = Hive.box("mybox");
  void defaulttask(){
    toDo=[["Sample task",false]];
  }
  void load(){
    toDo = my_box.get("todo");
  }
  void update(){
    my_box.put("todo",toDo);
  }
}