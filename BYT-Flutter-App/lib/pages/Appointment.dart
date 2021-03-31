/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		appointment.dart
          * Functions: 		_onItemTapped(), _onBackPressed(), displaySize(), displayWidth() , displayHeight
          * Global Variables:	_selectedIndex
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

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

  /*
                * Function Name:	displaySize()
                * Input:		analysis the size of screen
                * Output:		gives the size of screen
                * Logic:		MediaQuery used
                * Example Call:		_displaySize();

  */

  Size displaySize(BuildContext context) {
    // debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  /*
                * Function Name:	displayWidth()
                * Input:		analysis the size of screen
                * Output:		gives the width of screen
                * Logic:		MediaQuery used
                * Example Call:		_displayWidth();

  */

  double displayWidth(BuildContext context) {
    // debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  /*
                * Function Name:	displayHeight()
                * Input:		analysis the size of screen
                * Output:		gives the height of screen
                * Logic:		MediaQuery used
                * Example Call:		_displayHeight();

  */

  double displayHeight(BuildContext context) {
    // debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  @override
  Widget build(BuildContext context) {

    // returning the widgit for appointment page with contains an appBar for heading, one bottom navigation bar with 4 icons
    // and 3 buttons in the body part - navigate, appointment details and prescription

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#00AEC6"),
          title: Center(child: Text("Appointment")),
        ),
        body: Column(
          children: [
            Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(displayHeight(context) * 0.05),
                    child: RaisedButton(
                      color: HexColor("#00454F"),
                      onPressed: () async{

                        //move to navigate page
                        if(await FlutterBlue.instance.isOn)
                        {
                          Navigator.popAndPushNamed(context, "/navigate");
                        }
                        else
                        {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Bluetooth is off! Please turn it on"),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: (){
                                    Navigator.of(ctx).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        }

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_location,
                            size: displayHeight(context) * 0.14,
                            color: Colors.white,
                          ),
                          Text(
                            "Navigation",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(displayHeight(context) * 0.05),
                    child: RaisedButton(
                      color: HexColor("#00454F"),
                      onPressed: (){



                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wheelchair_pickup_rounded,
                            size: displayHeight(context) * 0.14,
                            color: Colors.white,
                          ),
                          Text(
                            "Appointment Details",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(displayHeight(context) * 0.05),
                    child: RaisedButton(
                      color: HexColor("#00454F"),
                      onPressed: (){



                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: displayHeight(context) * 0.14,
                            color: Colors.white,
                          ),
                          Text(
                            "Prescription",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
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
