import 'package:flutter/material.dart';
import 'main.dart';
import 'My_Plants.dart';

void main() {
  runApp(MyApp());
}

class Plant_Wishlist extends StatelessWidget { //creates the Plant-Wishlist screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//positions an Appbar at the top of the screen
        title: Text('Plant Wish-list'), //puts a title into the Appbar
        backgroundColor: Colors.green,),
        body: Stack( //all objects in the screen will be positioned in a vertical stack
            children: <Widget>[
              Align(
                  alignment: Alignment(0,-0.1), //aligns the icon widget
                  child: Icon((Icons.local_florist),
                    size: 100,
                    color: Colors.grey,)
              ),
              Align(
                  alignment: Alignment(0,0.1), //aligns the text on the page
                  child: const Text('Press the green button to get started!',
                      style: TextStyle(color: Colors.grey))),
              Align(
                  alignment: Alignment(0.8,0.9), //aligns the button in the bottom left corner
                  child: FloatingActionButton(onPressed: () {navigateToSearchPage(context);
                  }, //navigates to the search page
                    child: Icon(Icons.add), //positions the icon onto the button
                    backgroundColor: Colors.green,
                  )
              ),
            ]
        )
    );
  }
}


