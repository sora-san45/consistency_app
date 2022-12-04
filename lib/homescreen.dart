import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
                "Hi,Mary!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Center(child: Text("Tasks")),
                ),
                SizedBox(width: 50),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: Center(child: Text("Habit Tracker")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
floatingActionButton: FloatingActionButton(
onPressed: newtask,
child: Icon(Icons.add),
backgroundColor: Colors.grey[200],
foregroundColor: Colors.black,
),


gradient: const LinearGradient(
colors: [Color(0xFFEF9A9A),Color(0xFFFFE082)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),