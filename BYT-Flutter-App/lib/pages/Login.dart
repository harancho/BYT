/*
          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha, Harshvardhan
          * Filename: 		Login.dart
          * Functions: 		_onBackPressed()
          * Global Variables:	None
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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

    // code for not allowing this app to be used in landscape mode or portrait down mode

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // returning the widgit for login page with contains 2 input field for username and pasword, one login button
    // one sign_up button and one forger pass button

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
                  padding: EdgeInsets.fromLTRB(30, 110, 30, 0),
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
                  padding: const EdgeInsets.fromLTRB(0,30,0,0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){

                        // functionality for login button
                        Navigator.popAndPushNamed(context, '/home');

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      textColor: Colors.white,
                      color: HexColor("#00454F"),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,30,0,0),
                  child: InkWell(
                    onTap: (){


                      // functionality for forgot password button

                    },
                    child: Text(
                      "Forgot Password!",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,30),
                  child: InkWell(
                    onTap: (){
                      Navigator.popAndPushNamed(context, "/register");
                    },
                    child: Text(
                      "Sign Up!",
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
