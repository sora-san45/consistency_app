import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class Tile extends StatelessWidget {
  final String name;
  final bool finished;
  Function(bool?)? onChanged;
  Function(BuildContext)? delete;
  Function(BuildContext)? edit;
   Tile({
    super.key,
    required this.name,
    required this.finished,
    required this.onChanged,
    required this.delete,
    required this.edit,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: edit,
                backgroundColor: Colors.grey.shade600,
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(15.0),


              ),
              SlidableAction(
                onPressed: delete,
                backgroundColor: Colors.red.shade500,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(15.0),

              ),
            ],
        ),
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Row(
            children: [
              Checkbox(
                  checkColor: Colors.yellow[200],
                  activeColor: Colors.grey[800],
                  value: finished,
                  onChanged: onChanged,
              ),
              Text(name,
              style: TextStyle(
                  decoration: finished? TextDecoration.lineThrough:TextDecoration.none,
                color: Colors.yellow[200],
              ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(5,5),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey.shade800,
                offset: Offset(-4,-4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
