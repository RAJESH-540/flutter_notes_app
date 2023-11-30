import 'package:flutter/material.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("https://t4.ftcdn.net/jpg/05/60/70/71/360_F_560707155_hwQ7Kzf5fic1eF2VMWTgZvBFlzXOihVA.jpg",
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "Hi Rajesh",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.menu, color: Colors.white,),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("My Notes",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold ,
                    fontSize: 42),)


            ],
          ),
        ),
      ),
    );
  }
}
