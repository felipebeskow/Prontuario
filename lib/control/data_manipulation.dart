import 'package:flutter/material.dart';

class Data {
  static String mostraData(DateTime? data) {
    if (data == null){
      data = DateTime.now();
    }
    return (((data.day<10) ? ('0' + data.day.toString()) : (data.day.toString())) + '/' +
        ((data.month<10) ? ('0' + data.month.toString()) : (data.month.toString()))
        + '/' + DateTime.now().year.toString());
  }
  static String mostraHora(TimeOfDay? hora) {
    if(hora == null){
      hora = TimeOfDay.now();
    }
    return (
      hora.hour.toString() + ':' + hora.minute.toString()
    );
  }
}