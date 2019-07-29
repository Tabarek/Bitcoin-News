import 'package:bitcoin_news/Screens/description.dart';
import 'package:bitcoin_news/Services/news_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<String, dynamic> results;

class News extends StatelessWidget {
  News({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    //provider
    final newsResponse = Provider.of<NewsRequest>(context);
    //Screen's Center
    double height = MediaQuery.of(context).size.height / 5;

    // success request
    Widget titlesList() {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '   Latest \n' + '       News',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: ListView.builder(
                itemCount: newsResponse.getNews['articles'].length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Discription(index: index,)));
                    },
                    child: new Container(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 350,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white24,
                                    offset: Offset(20, 10),
                                    blurRadius: 10)
                              ],
                              color: Color(0XFF141E30),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.only(left: 50),
                            padding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 60),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Wrap(children: <Widget>[
                                  Text(
                                    newsResponse.result['response'][index]
                                            ['title'] ??
                                        '',
                                    style:
                                        TextStyle(color: Colors.blueGrey[200]),
                                  ),
                                ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Wrap(
                                      children: <Widget>[
                                        Text(
                                          
                                          newsResponse.result['response'][index]
                                                  ['author'.length<100] ??
                                              '',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Icon(
                                        Icons.launch,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Hero(
                            tag: 'hero$index',
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                newsResponse.result['response'][index]
                                        ["urlToImage"] ??
                                    '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    // fail request
    Widget tryAgainTitls() {
      return Center(
          child: Container(
        height: height,
        child: Column(
          children: <Widget>[
            Text(
              'Something went wrong!!!',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              'try again',
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              child: Icon(
                Icons.refresh,
                color: Colors.orange,
              ),
              onPressed: () async {
                results = await newsResponse.fetchData();
                if (results['statusCode'] == 200) {
                  titlesList();
                } else {
                  Container(
                    height: height,
                    child: Text('OOOOPS!!!!'),
                  );
                }
              },
            )
          ],
        ),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey[200],
            ),
          ),
          centerTitle: true,
        ),
        body: newsResponse.isFetching
            ? Center(
                child: CircularProgressIndicator(),
              )
            : newsResponse.getNewsData() != null
                ? titlesList()
                : tryAgainTitls());
  }
}
