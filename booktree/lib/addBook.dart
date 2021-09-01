import 'package:booktree/searchBook.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // final BookImage = TextEditingController();
  final BookTitle = TextEditingController();
  final BookPublisher = TextEditingController();
  final BookAuthors = TextEditingController();
  final WriteDate = TextEditingController();
  final BookReview = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      WriteDate.text = '????-??-??';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("독후감 쓰기"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/bookimage.png"),
                    radius: 70.0,
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: TextField(
                      controller: BookTitle,
                      decoration: InputDecoration(labelText: "책 제목을 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 150,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchBook();
                          }));
                        },
                        child: Icon(Icons.search)),
                    padding: const EdgeInsets.all(10.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookPublisher,
                      decoration: InputDecoration(labelText: "출판사를 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookAuthors,
                      decoration: InputDecoration(labelText: "저자를 입력하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: WriteDate,
                      decoration: InputDecoration(labelText: "작성 날짜"),
                      keyboardType: TextInputType.text,
                      readOnly: true,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      controller: BookReview,
                      decoration: InputDecoration(labelText: "내용을 입력 하세요"),
                      keyboardType: TextInputType.text,
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (BookTitle.text.isEmpty ||
                      BookPublisher.text.isEmpty ||
                      BookAuthors.text.isEmpty ||
                      WriteDate.text.isEmpty ||
                      BookReview.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("빈 칸 없이 채워주세요!"),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              },
              child: Text("등록 하기"),
            ),
          ],
        ),
      ),
    );
  }
}
