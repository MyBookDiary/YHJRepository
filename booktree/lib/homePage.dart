import 'package:booktree/addBook.dart';
import 'package:booktree/detailBook.dart';
import 'package:booktree/listBook.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailBook();
                })).then((value) => reloadData());
            }, 
            icon: Icon(Icons.menu)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ListBook();
                })).then((value) => reloadData());
              },
              child: Image.asset('images/logo.png',
              width: 300,
              height: 300,
              ),
            ),
            height: 500,
            width: 500,
          ),
        ]
      )
    );
  }

  void reloadData() {

  }


}