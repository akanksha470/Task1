import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task1/services/newsModel.dart';

import '../utilities.dart';

class FavouritePage extends StatefulWidget {
 // FavouritePage({List<Post> posts}) : this.posts = posts ?? [];
  //final List<String> posts;

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Post> favList = List<Post>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getFav();
  }

  getFav() {
    setState(() {
      isLoading = true;
    });
    favList = List<Post>();

    postsList.forEach((p) {
      if (p.marked == 1) favList.add(p);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: favList.length,
                itemBuilder: (context, index) {
                  if (favList.length == 0){
                    print(favList.length);
                    return Center();
                  }
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
                                        child: Icon(Icons.favorite,
                                            color: Colors.red,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05)),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(favList[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            favList[index].summary,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          Text(
                                            favList[index].published,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            )))
                  ]);
                }));
  }
}
