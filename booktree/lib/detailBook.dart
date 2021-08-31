import 'package:flutter/material.dart';

class DetailBook extends StatefulWidget {
  const DetailBook({ Key? key }) : super(key: key);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail (Temp)'),
      ),
      
    );
  }
}