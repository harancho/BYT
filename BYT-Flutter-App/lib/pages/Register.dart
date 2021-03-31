/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		Register.dart
          * Functions: 		_onBackPressed()
          * Global Variables:	None
*/

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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

    // returning the widgit for Register page with contains 3 input field for username, password and confirm password,
    // one register button and one sign_in button

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: HexColor("#00AEC6"),
        // appBar: AppBar(
        //   title: Text("Register Page"),
        // ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Image(
                    image: AssetImage("lib/assets/images/logo.png"),
                    height: 300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 90, 30, 0),
                  child: TextField(
                    style: TextStyle(
                      color: HexColor("#00AEC6"),
                      fontSize: 20,
                    ),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                      filled: true,
                      fillColor: HexColor("#00454F"),
                      hintText: "Username",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextField(
                    style: TextStyle(
                        color: HexColor("#00AEC6"),
                        fontSize: 20,
                    ),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hoverColor: Colors.red,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        size: 25,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: HexColor("#00454F"),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20,
                        color: HexColor("#00AEC6"),
                    ),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hoverColor: Colors.red,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        size: 25,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: HexColor("#00454F"),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    obscureText: true,
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
                        Navigator.popAndPushNamed(context, '/login');

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      textColor: Colors.white,
                      color: HexColor("#00454F"),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,0,30),
                  child: InkWell(
                    onTap: (){
                      Navigator.popAndPushNamed(context, "/login");
                    },
                    child: Text(
                      "Sign In!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
