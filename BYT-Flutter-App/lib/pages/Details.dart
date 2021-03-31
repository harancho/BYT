/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		Details.dart
          * Functions: 		_onItemTapped(), _onBackPressed()
          * Global Variables:	_selectedIndex
*/

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

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

    // returning the widgit for details page with contains an appBar for heading, one bottom navigation bar with 4 icons
    // and 4 input field in the body part - name, age, about and gender

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: HexColor("#00AEC6"),
          title: Center(child: Text("Details"),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 90, 30, 0),
                child: TextField(
                  style: TextStyle(
                    color: HexColor("#00AEC6"),
                    fontSize: 20,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: HexColor("#00454F"),
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: TextField(
                  style: TextStyle(
                    color: HexColor("#00AEC6"),
                    fontSize: 20,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: HexColor("#00454F"),
                    hintText: "Age",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: TextField(
                  style: TextStyle(
                    color: HexColor("#00AEC6"),
                    fontSize: 20,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: HexColor("#00454F"),
                    hintText: "Gender",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: TextField(
                  style: TextStyle(
                    color: HexColor("#00AEC6"),
                    fontSize: 20,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: HexColor("#00454F"),
                    hintText: "About",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){

                      // functionality for register button
                      Navigator.popAndPushNamed(context, '/appointment');

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    textColor: Colors.white,
                    color: HexColor("#00454F"),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
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
