import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:newUi/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List booksList;
  bool isConnectedToInternet = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    checkConnection();
    if (isConnectedToInternet = true) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      //home tab
      booksList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildAppbar(),
                      SizedBox(height: 30.0),
                      buildPopularNow(),
                      Divider(),
                      SizedBox(height: 30.0),
                      buildBestSeller()
                    ],
                  ),
                ),
              ),
            ),
      //settings tab
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildAppbar(),
              SizedBox(height: 30.0),
              Text('setting'),
            ],
          ),
        ),
      ),
      //carts tab
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildAppbar(),
              SizedBox(height: 30.0),
              Text('Carts'),
            ],
          ),
        ),
      )
    ];
    // final devHeight = MediaQuery.of(context).size.height;
    // final devWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: buildDrawer(),
      bottomNavigationBar: booksList == null
          ? null
          : BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Colors.deepOrange,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.slidersH), label: "Setting"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.cartPlus), label: "Cart"),
              ],
              onTap: (tappedIndex) {
                setState(() {
                  _currentIndex = tappedIndex;
                });
              },
            ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: tabs[_currentIndex],
    );
  }

//
//
//
//
//
//
//

  Future getData() async {
    http.Response response =
        await http.get('https://ab-books-api.vercel.app/books');
    var data = jsonDecode(response.body);
    setState(() {
      booksList = data;
    });
  }

  String formatDate(String date) {
    return DateFormat('yMMMMd').format(
      DateTime.parse(date),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnectedToInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.none) {
      showInSnackBar(bgColor: Colors.red, value: "No Internet");
      setState(() {
        isConnectedToInternet = false;
      });
    }
  }

  void showInSnackBar({String value, Color bgColor}) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(value,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: bgColor,
        duration: Duration(seconds: 5),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text('UserName'),
          ),
        ],
      ),
    );
  }

  Container buildPopularNow() {
    return Container(
      height: 280.0,
      // color: Colors.orange,
      width: double.infinity,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Now',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Show all',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: booksList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(selectedBook: booksList[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: index == 0
                          ? EdgeInsets.only(left: 10.0, right: 5.0)
                          : EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: booksList[index]['posterImage'],
                            child: Container(
                              height: 200.0,
                              width: 150,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.grey[300],
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      booksList[index]['posterImage']),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              booksList[index]['title'],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              formatDate(booksList[index]['postDate']),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBestSeller() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 280.0,
      // color: Colors.orange,
      width: double.infinity,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bestseller',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: booksList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200.0,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.grey[300],
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            image: DecorationImage(
                              image:
                                  NetworkImage(booksList[index]['posterImage']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            booksList[index]['title'],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            formatDate(booksList[index]['postDate']),
                            style:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildAppbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          // color: Colors.red,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: SvgPicture.asset(
              "assets/images/menu.svg",
              height: 30.0,
              width: 30.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
