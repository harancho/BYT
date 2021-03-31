/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		Navigate.dart
          * Functions: 		_onItemTapped(), _onBackPressed(), makePostRequest(), myFunction()
          * Global Variables:	_selectedIndex , _streamRanging , beacon_list , start , end , path
*/

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:http/http.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {

  int _selectedIndex = 0;

  /*
                * Function Name:	_onItemTapped
                * Input:		num_elements -> index of the tapped icon in the bottom navigation bar
                * Output:		navigates to the corresponding page after icon selection
                * Logic:		using if statements to move to respective pages(activities)
                * Example Call:		_onItemTapped(2);

  */

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      if(index == 0)
        {
          //move to home page
          _streamRanging.cancel();
          Navigator.popAndPushNamed(context, '/home');
        }
      if(index == 1)
      {
        //move to profile page
        //Navigator.popAndPushNamed(context, '/profile');
      }
      if(index == 2)
      {
        //move to about page of app
        //Navigator.popAndPushNamed(context, '/about');
      }
      if(index == 3)
      {
        //move to settings page
        //Navigator.popAndPushNamed(context, '/settings');
      }
    });
  }

  /*
                * Function Name:	_onBackPressed
                * Input:		function is called when back button is pressed
                * Output:		either closes the app or remains on the same page
                * Logic:		a alert dialog box appears with 2 options yes and no...if yes than close otherwise stay
                * Example Call:		_onBackPressed();

  */

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Are you sure you want to close this app?"),
        actions: [
          TextButton(
            child: Text("No"),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text("Yes"),
            onPressed: (){
              _streamRanging.cancel();
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  //for beacons
  StreamSubscription<RangingResult> _streamRanging;
  List beacons_list = [];
  List path = [];

  List start = [];
  List end = [];

  // to start myFunction() as soon as you reach this page
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFunction();
  }

  /*
                * Function Name:	makePostRequest()
                * Input:		None
                * Output:	  Gives the path for the user to follow to reach their destination
                * Logic:		makes http request to the server along with the uuids of currently active beacon in order to get the path
                *           start and end location of the patient
                * Example Call:		makePostRequest();

  */

  makePostRequest() async {

    String url = "https://byt-server.siddharthg123.repl.co/predict";
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await post(url, headers: headers, body: jsonEncode({'uuids' : beacons_list}));

    // print(response.body);
    final decoded = jsonDecode(response.body) as Map;
    path = decoded['path'];

    start = path[path.length - 1];
    end = path[0];
  }

  /*
                * Function Name:	myFunction()
                * Input:		None
                * Output:		gives the list of currently active beacons and store then in beacon_list variable
                * Logic:		detects the currently active beacons by using flutter_beacon library
                * Example Call:		_onBackPressed();

  */

  void myFunction() async {
    try {
      await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch (e) {
      print("error found!!");
      print(e);
    }

    final regions = <Region>[];
    regions.add(Region(identifier: null, proximityUUID: null));

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) async {
          if(await FlutterBlue.instance.isOn) {

          }
          else{
            _streamRanging.cancel();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Bluetooth is off! Please turn it on and try again"),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: (){
                      Navigator.of(ctx).pop();
                      Navigator.popAndPushNamed(context, '/appointment');
                    },
                  )
                ],
              ),
            );
          }

          if (result.beacons.isNotEmpty) {
            beacons_list.removeRange(0, beacons_list.length);
            for (var i = 0; i < result.beacons.length; i++) {
              beacons_list.add(result.beacons[i].proximityUUID);
            }

            await makePostRequest();

            if(this.mounted) {
              setState(() {

              });
            }
          }
          else
          {
            beacons_list.removeRange(0, beacons_list.length);
            setState(() {

            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    // returning the widgit for Navigate page with contains an appBar for heading, one bottom navigation bar with 4 icons
    // a map of cse department is displayed and the stack widgit is used to show movement over that

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#00AEC6"),
          title: Center(child: Text("Navigate"),),
        ),
        body: Center(
          child: Stack(
            children: [
              Image(
                image: AssetImage("lib/assets/images/cse_map.jpg"),
                height: 56.6 * 6.0,
                width: 62.6 * 6.0,
              ),
              for(var index = 0;index<path.length;index++)
                Padding(
                  padding: EdgeInsets.fromLTRB(path[index][0] * (6.0/5.0), path[index][1] * (6.0/5.0),0, 0),
                  child: Icon(
                    Icons.circle,
                    size: 7,
                    color: Colors.blue,
                  ),
                ),
              if(start.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(start[0] * (6.0/5.0) - 10, start[1] * (6.0/5.0) - 15, 0, 0),
                  child: Icon(
                    Icons.directions_walk,
                    size: 25,
                    color: Colors.red,
                  ),
                ),
              if(end.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(end[0] * (6.0/5.0) - 10, end[1] * (6.0/5.0) - 15, 0, 0),
                  child: Icon(
                    Icons.edit_location,
                    size: 25,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.pink,
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'About',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
