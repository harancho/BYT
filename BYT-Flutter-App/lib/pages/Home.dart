/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		home.dart
          * Functions: 		_onItemTapped(), _onBackPressed()
          * Global Variables:	_selectedIndex
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // returning the widgit for home page with contains an appBar for heading, one bottom navigation bar with 4 icons
    // and 3 buttons in the body part - make appointment, current appointment and previous appointment

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#00AEC6"),
          title: Center(child: Text("Home")),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  color: HexColor("#00454F"),
                  onPressed: (){
                    // move to hospitals page
                    Navigator.popAndPushNamed(context, '/hospitals');

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  )
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    color: HexColor("#00454F"),
                    onPressed: (){
                      //move to appointment page
                      Navigator.popAndPushNamed(context, '/appointment');

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Text(
                      "Current Appointment",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    )
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                    color: HexColor("#00454F"),
                    onPressed: (){
                      //move to previous Appointments page
                      Navigator.popAndPushNamed(context, '/previousAppointments');

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Text(
                      "Previous Appointment",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    )
                ),
              ),
            )
          ],
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
