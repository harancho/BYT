/*

          * Project Name: 	Be You There
          * Author List: 		Siddhart Golecha
          * Filename: 		main.dart
          * Functions: 		declaration of routes for all activities
          * Global Variables:	NONE
*/

import 'package:flutter/material.dart';
import 'pages/Login.dart';
import 'pages/Register.dart';
import 'pages/Home.dart';
import 'pages/Hospitals.dart';
import 'pages/Appointment.dart';
import 'pages/PreviousAppointments.dart';
import 'pages/Details.dart';
import 'pages/Navigate.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login' : (context) => Login(),
      '/register' : (context) => Register(),
      '/home' : (context) => Home(),
      '/hospitals' : (context) => Hospitals(),
      '/appointment' : (context) => Appointment(),
      '/previousAppointments' : (context) => PreviousAppointments(),
      '/details' : (context) => Details(),
      '/navigate' : (context) => Navigate()
    },
  ));
}