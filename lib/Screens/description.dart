import 'package:bitcoin_news/Services/news_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Discription extends StatelessWidget {
  const Discription({Key key, @required this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    final newsResponse = Provider.of<NewsRequest>(context);

//display news posts
Widget posts(){
  return Container(
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: 'hero$index',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              image: NetworkImage(
                                newsResponse.result['response'][index]
                                        ["urlToImage"] ??
                                    "",
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              newsResponse.result['response'][index]['title'] ??
                                  '',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 15,
                            indent: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              newsResponse.result['response'][index]
                                      ['content'] ??
                                  '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
}


    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FlatButton.icon(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
                label: Container()),
          ),
        ],
        title: Text('NEWS'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: newsResponse.isFetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : newsResponse.getNewsData() != null
              ? posts()
              : Navigator.pushReplacementNamed(context, '/news'),
      backgroundColor: Colors.grey[100],
    );
  }
}
