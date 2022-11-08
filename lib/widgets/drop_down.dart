import 'package:flutter/material.dart';

GestureDetector drawerDropDown({name, onCalled, context}) {
  return GestureDetector(
      child: ListTile(title: Text(name, 
      style: Theme.of(context).textTheme.headline2,
      
      )), onTap: () => onCalled());
}