import 'package:flutter/material.dart';
import 'package:notes_app/custom_widget/circle_button.dart';
import 'package:notes_app/custom_widget/radiotile.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
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
                        backgroundColor: Color(0xff1A1A1A),
                        radius: 25,
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
                    fontSize: 42),),
              SizedBox(height: 10,),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleContainer(text: "All (20)", bgColor: Colors.white,textColor: Colors.black,),
                  CircleContainer(text: "Important",textColor: Colors.grey,),
                  CircleContainer(text: "BookMarked",textColor: Colors.grey,),
                ],
              ),
               SizedBox(height: 30,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    height: 220,
                    width: 170,
                    decoration: BoxDecoration(
                       color: Color(0xffFCA590),
                      borderRadius: BorderRadius.circular(24)
                        
                    ),
                    child: Center(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Buy Honey\n100% original", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text("Buy the new brand\nhoney for my family \nhere's is the pic"),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Image.asset("assets/images/viha.webp",
                               fit: BoxFit.contain,height: 80,
                               width: 100,),
                             ],
                           )

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    width: 170,
                    // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                       color: Color(0xffFFFFA0),
                        borderRadius: BorderRadius.circular(24)
                    ),
                     child: const Center(
                       child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text("Plane for the\ntoday", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                             SizedBox(height: 5,),
                             RadioTile(text: "text", title: "Buy Food",),
                             SizedBox(height: 5,),
                             RadioTile(text: "text", title: "GYM",),
                             SizedBox(height: 5,),
                             RadioTile(text: "text", title: "Meeting",)
                           ],
                         ),
                       ),
                     ),
                  ),


                ],
              ),
           SizedBox(height: 28,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
           margin: EdgeInsets.symmetric(horizontal: 12),
          height: 150,
          width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
             color: Color(0xffCDEFF1),
              borderRadius: BorderRadius.circular(24)
           ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Tax payment before the end  of march", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                 Text(
                     "This is remanider note, so as  not to forget to pay\ntaxes before the end of march. Don't miss it.you could be fined.\nList of assets must be reported"),


               ],
             ),
         
          )

            ],
          ),
        ),
      ),
    );
  }
}
