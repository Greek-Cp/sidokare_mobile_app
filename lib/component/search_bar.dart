import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Masukan Anumu",
            hintStyle: TextStyle(fontSize: 12.0),
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(Icons.search),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
    ;
  }
}
