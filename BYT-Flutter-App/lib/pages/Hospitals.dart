/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		Hospitals.dart
          * Functions: 		_onItemTapped(), _onBackPressed()
          * Global Variables:	_selectedIndex
*/

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Hospitals extends StatefulWidget {
  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {

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
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // returning the widgit for hospitals page with contains an appBar for heading, one bottom navigation bar with 4 icons
    // and the body contails list of hospitals in our application which can be selected by clicking

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#00AEC6"),
          title: Center(child: Text("Hospitals")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,30,10,0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: RaisedButton(
                      onPressed: (){

                        // move to details
                        Navigator.popAndPushNamed(context, '/details');

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      textColor: Colors.white,
                      color: HexColor("#00454F"),
                      child: Text(
                        "Hospital A",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: RaisedButton(
                      onPressed: (){

                        // move to details
                        // Navigator.popAndPushNamed(context, '/details');

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      textColor: Colors.white,
                      color: HexColor("#00454F"),
                      child: Text(
                        "Hospital B",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: RaisedButton(
                      onPressed: (){

                        // move to details
                        // Navigator.popAndPushNamed(context, '/details');

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      textColor: Colors.white,
                      color: HexColor("#00454F"),
                      child: Text(
                        "Hospital C",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
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
