import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'Search.dart';

void main() {
  runApp(MyApp());
}

class My_Plants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plants'),//title to go in Appbar
        backgroundColor: Colors.green,),
      body: Stack(//objects on page organised in a stack
        children: <Widget>[
          Align(//aligning the icon
            alignment: Alignment(0,-0.1),
            child: Icon((Icons.local_florist),
              size: 100,
              color: Colors.grey,)
          ),
          Align(//aligning text
            alignment: Alignment(0,0.1),
              child: const Text('Press the green button to get started!',
              style: TextStyle(color: Colors.grey))),
          Align(//aligning the floating button
            alignment: Alignment(0.8,0.9),
            child: FloatingActionButton(onPressed: () {navigateToPlantSearch(context);},//needs to be changed!!
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
          )
          ),
        ]
      )
    );
  }
}

Future navigateToPlantSearch(context) async {//function to navigate to search page
  Navigator.push(context, MaterialPageRoute(builder: (context) => JSONDemo()));
}

Future navigateToSearchPage(context) async {//function to navigate to search page
  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
}

class SearchPage extends StatelessWidget {
  // This widget is the root of the search page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Search(),
    );
  }
}

class Post {
  final String title;//defining the local variables of the class Post
  final String body;//title and body which are both strings

  Post(this.title, this.body);
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  //the functions that actually 'searches'


  Future<List<Post>> _getALlPosts(String text) async { //displays posts with their descriptions
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));//delays result to allow loading symbol

    var search = "$text";//saves the input from the search bar as 'search'
    print(search);


    List<Post> posts = [];

    var random = new Random();//displays 10 posts which will in the future contain plant data
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$search $i", "description"));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //sets an Appbar at the top of the screen
        title: Text('Search page'), //places a title in the Appbar
        backgroundColor: Colors.green,),
      body: SafeArea(
        child: SearchBar<Post>(//builds the search bar
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,//displays the 10 posts
          searchBarController: _searchBarController,//the search function
          placeHolder: Text("placeholder"),//when the screen is blank 'placeholder' is displayed
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          onCancelled: () {
            print("Cancelled triggered");//stops the search
          },
          mainAxisSpacing: 10, //spacing for the posts
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container( //Each post is in a container
              color: Colors.black12, //the post is green
              child: ListTile(
                title: Text(post.title),//title to the post
                isThreeLine: true,
                subtitle: Text(post.body),//description of the post
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },//when pressed navigate to 'Detail'
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {//'detail'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //sets an Appbar at the top of the screen
        title: Text('Detail'), //places a title in the Appbar
        backgroundColor: Colors.green,),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),//back button to go to previous page
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Plant data"),//contains description
          ],
        ),
      ),
    );
  }
}





