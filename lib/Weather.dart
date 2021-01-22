import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:weather/weather.dart';

//have to press the button twice in order to get the weather and weather forecast
void main() {
  runApp(Weatherpage());
}
enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING } //the three different App states

class Weatherpage extends StatefulWidget {
  @override
  _WeatherpageState createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  String key = '598ab07809dd07c3e161975baa382ed1'; //my personal API key
  WeatherFactory ws; //instance of WeatherFactory (which gives the weather)
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED; //intially the App state is NOT_DOWNLOADED
  double lat, lon;//accepts latitude and longitude

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(key); //an instance of WeatherFactory is created using the API key.
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;//when querying the App state is DOWNLOADING
    });

    _saveLat();
    _saveLon();

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat, lon);//this takes longitude and latitude
                                                                          //to get 5 day weather forecast
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;//once queried the App state is FINISHED_DOWNLOADING
    });
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;//when querying the App state is DOWNLOADING
    });

    _saveLat();
    _saveLon();

    Weather weather = await ws.currentWeatherByLocation(lat, lon) as Weather;//this takes longitude and latitude
                                                                            //to get current weather
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;//once queried the App state is FINISHED_DOWNLOADING
    });

  }

  Widget contentFinishedDownload() {//this returns each weather update onto a new tile
    return Center(                   //this just makes it easier to read
      child: ListView.separated(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {//this is displayed whilst the data is being fetched
    return Container(
        margin: EdgeInsets.all(25),
        child: Column(children: [
          Text(
            'Fetching Weather...',
            style: TextStyle(fontSize: 20),
          ),
          Container(
              margin: EdgeInsets.only(top: 50),//loading symbol
              child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
        ]));
  }
  Widget contentNotDownloaded() {//this is displayed as the starting screen
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This is just to test the weather forecast works',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
      ? contentDownloading()
      : contentNotDownloaded();

  void _saveLat() async {
    var location = await _determinePosition(); //gets the location of the user from the geolocator
    lat = location.latitude; //gets the latitude from the string 'location'
    String latitude = lat.toString();//converts latitude from double to string
    int len = latitude.length;//gets the length of latitude
    for(var i = 0; i<len; i++) { //for i = o to length of latitude
      lat = double.tryParse(latitude.substring(0,i));//gets substring of latitude and converts to double
      print(lat);//returns latitude
    }
  }

  void _saveLon() async {
    var location = await _determinePosition(); //gets the location of the user from the geolocator
    lon = location.longitude; //gets the longitude from the string 'location'
    String longitude = lon.toString();//converts longitude from double to string
    int len = longitude.length;//gets the length of longitude
    for(var i = 0; i<len; i++) { //for i = o to length of longitude
      lon = double.tryParse(longitude.substring(0,i));//gets substring of longitude and converts to double
      print(lon);//returns longitude
    }

  }



  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          child: FlatButton(
            child: Text(
              'Fetch weather',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: queryWeather,
            color: Colors.green,
          ),
        ),
        Container(
            margin: EdgeInsets.all(5),
            child: FlatButton(
              child: Text(
                'Fetch forecast',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: queryForecast,
              color: Colors.green,
            ))
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Weather Test'),
            backgroundColor: Colors.green,),
          body: Column(
            children: <Widget>[
              _buttons(),
              Text(
                'Output:',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              Expanded(child: _resultView())
            ],
          )),
    );
  }
}



Future<Position> _determinePosition() async { //to find out latitude and longitude
  bool serviceEnabled;
  LocationPermission permission; //I need to have permission by the user to access their location
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) { //if services aren't enabled
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(//if services are denied
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error( //if services are denied whilst using app
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition(); //acquires position of user
}





//gets the location
//class Weather extends StatelessWidget{
  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: AppBar(
        //title: Text('My Plants'),
        //backgroundColor: Colors.green,),
      //body: FlatButton( //button to click and get the location of the user
        //child: Text('Run Locator'),
        //onPressed: () async {
          //var value = await _determinePosition();
          //print (value);
        //},
      //)
    //);
  //}
//}
