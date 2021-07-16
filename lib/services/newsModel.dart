class Post {
  final String title, published, link;
  var summary, marked;
  final int id;
  Post({
    this.title,
    this.id,
    this.published,
    this.link,
    this.summary,
    this.marked
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        id: json['id'],
        title: json['title'].toString(),
        summary: json['summary'] == null ? "" : json["summary"].toString(),
        link: json["link"].toString(),
        published: json["published"].toString(),
        marked: 0
    );
  }
}

//class Favs{
//  var id;
//  var marked;
//
//  Favs({
//    this.id,
//    this.marked,
//  });
//
//  FavMap() {
//    var mapping = Map<String, dynamic>();
//    mapping['id'] = id;
//    mapping['marked'] = marked;
//  }
//}