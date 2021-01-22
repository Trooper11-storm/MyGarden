import 'package:flutter/material.dart';
import 'Calendar.dart';
import 'Notifications.dart';
import 'Plant_Wishlist.dart';
import 'Profile.dart';
import 'My_Plants.dart';
import 'Weather.dart';

void main() {
  runApp(MyApp()); //this runs the entire program when the app opens
}

class MyApp extends StatelessWidget {
  final appTitle = 'MyGarden';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget { //the entire homepage is a widget
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(//the page is set as an inbuilt function 'Scaffold' so it is easy to position objects
      appBar: AppBar(//this positions the AppBar at the top of the page
        title: Text(title),//the title will be shown in the AppBar
        backgroundColor: Colors.green,),
      body: Stack(//I want a visual stack for the different buttons
        children: <Widget>[
          Align(
              alignment: Alignment(0,-0.75),
              child: IconButton(
                icon: Icon(Icons.local_florist),
                iconSize: 100,
                color: Colors.grey,
                onPressed: () {//when pressed it completes the function 'navigateToPlantPage'
                  navigateToPlantPage(context);
                },
              )
          ),
          Align(
              alignment: Alignment(0,-0.45),
              child: Text('Plants', style: TextStyle(fontSize:28,
                  fontWeight: FontWeight.bold),)),
          Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                iconSize: 100,
                color: Colors.grey,
                onPressed: () {
                  navigateToCalendar(context);
                },
              )
          ),
          Align(
              alignment: Alignment(0,0.2),
              child: Text('Calendar', style: TextStyle(fontSize:28,
                  fontWeight: FontWeight.bold))),
          Align(
              alignment: Alignment(0,0.75),
              child: IconButton(
                icon: Icon(Icons.notifications),
                iconSize: 100,
                color: Colors.grey,
                onPressed: () {
                  navigateToNotifications(context);
                },
              )
          ),
          Align(
              alignment: Alignment(0,0.85),
              child: Text('Notifications', style: TextStyle(fontSize:28,
                  fontWeight: FontWeight.bold))),
        ],
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Removes any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Stack(
                    children: <Widget>[
                      Align(
                          alignment:Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,//this is just a temporary solution until I properly
                            radius: 35,                  //configure the profile system
                          )
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text('User', style: TextStyle(color: Colors.white, fontSize:30)))
                    ]
                )
            ),
            ListTile(
              title: Text('My plants',  style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.local_florist, size: 40),
              onTap: () {
                navigateToMyPlants(context); //when pressed the function 'navigateToMyPlants' will be called
              },
            ),
            ListTile(
              title: Text('Plant wish-list', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.shopping_basket, size: 40),
              onTap: () {
                navigateToPlantWishlist(context);
              },
            ),
            ListTile(
              title: Text('Calendar', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.calendar_today, size: 40),
              onTap: () {
                navigateToCalendar(context);
              },
            ),
            ListTile(
              title: Text('Notifications', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.notifications, size: 40),
              onTap: () {
                navigateToNotifications(context);
              },
            ),
            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.account_circle, size: 40),
              onTap: () {
                navigateToProfile(context);
              },
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(fontSize: 15)),
              leading: Icon(Icons.exit_to_app, size: 40),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);//this will make the user return to the homepage
              },                      //again this is just a temporary solution until the login system
                                     //is properly configured
            ),
          ],
        ),
      ),
    );
  }
}






Future navigateToPlantPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => PlantPage()));
}

Future navigateToMyPlants(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => My_Plants()));
}

Future navigateToPlantWishlist(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Plant_Wishlist()));
}

Future navigateToCalendar(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()));
}

Future navigateToNotifications(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
}

Future navigateToProfile(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
}

Future navigateToWeather(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Weatherpage()));
}


class PlantPage extends StatelessWidget { //define PlantPage as a new screen

  @override
  Widget build(BuildContext context) {
    return Scaffold( //building page with Scaffold so I can structure the screen accordingly
      appBar: AppBar( //sets an Appbar at the top of the screen
        title: Text('Plants'), //places a title in the Appbar
        backgroundColor: Colors.green,),
      body: Stack( //all objects in the screen will be positioned in a vertical stack
        children: <Widget>[
          Align( //Aligning objects in the stack
              alignment: Alignment(0,-0.5),
              child: IconButton(
                icon: Icon(Icons.local_florist),
                iconSize: 100,
                color: Colors.grey,
                onPressed: () {
                  navigateToMyPlants(context); //when the icon is pressed the user
                },                            //is navigated to the 'MyPlants' screen
              )
          ),
          Align(
              alignment: Alignment(0,-0.25), //aligns the text
              child: Text('My Plants', style: TextStyle(fontSize:28,
                  fontWeight: FontWeight.bold),)),
          Align(
              alignment: Alignment(0,0.5), //aligns the icon
              child: IconButton(
                icon: Icon(Icons.shopping_basket),
                iconSize: 100,
                color: Colors.grey,
                onPressed: () {
                  navigateToWeather(context); //to be changed to Plant-Wishlist
                },
              )
          ),
          Align(
              alignment: Alignment(0,0.75),//aligns the text
              child: Text('Plant Wish-list', style: TextStyle(fontSize:28,
                  fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

