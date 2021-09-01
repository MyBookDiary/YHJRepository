import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for json

class SearchBook extends StatefulWidget {
  const SearchBook({Key? key}) : super(key: key);

  @override
  _SearchBookState createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
  String result = '';
  late List data;
  String search = '';

  TextEditingController textController = TextEditingController();
  late ScrollController _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = [];
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      //리스트의 마지막일 경우
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        page += 1;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  data.clear();
                  page = 1;
                  getJSONData();
                });
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        child: data.length == 0
            ? Text(
                "데이터가 없습니다.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              data[index]['thumbnail'] == ''
                                  ? 'https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F3401212%3Ftimestamp%3D20190220102153'
                                  : data[index]['thumbnail'],
                              height: 150,
                              width: 130,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['title'].length < 18
                                      ? data[index]['title']
                                      : data[index]['title']
                                          .toString()
                                          .replaceRange(
                                              18,
                                              data[index]['title']
                                                  .toString()
                                                  .length,
                                              "..."),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  data[index]['publisher'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  data[index]['authors'].toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                Text(
                                  data[index]['datetime'].length < 10
                                      ? data[index]['datetime']
                                      : data[index]['datetime']
                                          .toString()
                                          .substring(0, 4)
                                          .replaceRange(4, 4, '년'),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: data.length,
                controller: _scrollController,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            data.clear();
            page = 1;
            getJSONData();
          });
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    search = textController.text != '' ? textController.text : "플러터";
    var url = Uri.parse(
        'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=$search');

    var response = await http.get(url,
        headers: {"Authorization": "KakaoAK cc2b06bbe7a475f7910fd34d95c8ff82"});

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['documents'];
      data.addAll(result);
    });
    return "Success";
  }
}
