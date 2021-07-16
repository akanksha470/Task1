import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:task1/services/newsModel.dart';

import '../utilities.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}


class _NewsPageState extends State<NewsPage> {
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    setState(() {
      isLoading = true;
    });
    postsList = List<Post>();
    http.Response response =  await http.get(Uri.parse('https://api.first.org/data/v1/news'));
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception();
    }

    var jsonDecoded = await jsonDecode(response.body);
    List<dynamic> jsonlist = jsonDecoded['data'];
    postsList = jsonlist.map((i) => Post.fromJson(i)).toList();

    setState(() {
      isLoading = false;
    });
    return postsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : ListView.builder(
            itemCount: postsList.length,
            itemBuilder: (context, index) {
              if (postsList.length == 0)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 20),
                    child: Card(
                        elevation: 5,
                        child: Container(
                          child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 22),
                                  child: GestureDetector(
                                    child: postsList[index].marked == 1 ? Icon(
                                        Icons.favorite, color: Colors.red,
                                        size: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.05)
                                        : Icon(
                                      Icons.favorite_border,
                                      size: MediaQuery
                                          .of(context)
                                          .size
                                          .height *
                                          0.05,
                                    ),
                                    onTap: () {
                                      int value = postsList[index].marked;
                                      (value == 1) ?
                                      postsList[index].marked = 0 :
                                      postsList[index].marked = 1;

                                      setState(() {

                                      });
                                    },),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(postsList[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02,
                                      ),
                                      Text(
                                        postsList[index].summary,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.02,
                                      ),
                                      Text(
                                        postsList[index].published,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        )
                    ))
              ]);
            })
    );
  }
}