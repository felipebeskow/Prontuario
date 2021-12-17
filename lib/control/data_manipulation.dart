import 'package:flutter/material.dart';

class Data {
  static String mostraData(DateTime? data) {
    data ??= DateTime.now();
    return (((data.day<10) ? ('0' + data.day.toString()) : (data.day.toString())) + '/' +
        ((data.month<10) ? ('0' + data.month.toString()) : (data.month.toString()))
        + '/' + DateTime.now().year.toString());
  }
  static String mostraHora(TimeOfDay? hora) {
    hora ??= TimeOfDay.now();
    return (
        ((hora.hour<10) ? ('0' + hora.hour.toString()) : (hora.hour.toString())) + ':' + ((hora.minute<10) ? ('0' + hora.minute.toString()) : (hora.minute.toString()))
    );
  }
}