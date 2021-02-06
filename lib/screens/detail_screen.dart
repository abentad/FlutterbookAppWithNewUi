import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  final Map selectedBook;
  DetailScreen({this.selectedBook});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    // final devWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.bookmark,
              color: Colors.black,
              size: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.ellipsisV,
              color: Colors.black,
              size: 20.0,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: devHeight * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 9),
                              blurRadius: 20,
                            )
                          ],
                          image: DecorationImage(
                            image: NetworkImage(
                                widget.selectedBook['posterImage']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        widget.selectedBook['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        widget.selectedBook['author'],
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      //implement rating
                    ],
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.selectedBook['description'],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/menu.svg',
                              height: 16.0),
                          SizedBox(width: 10.0),
                          Text('Preview')
                        ],
                      ),
                    ),
                    SizedBox(width: 40.0),
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.comment),
                          SizedBox(width: 10.0),
                          Text('Reviews')
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: MaterialButton(
                    color: Colors.deepPurple,
                    height: 50.0,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Buy Now For ${widget.selectedBook['price']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Hero(
//                 tag: widget.selectedBook['posterImage'],
//                 child: Container(
//                   height: 500.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         widget.selectedBook['posterImage'],
//                       ),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//                 child: Text(widget.selectedBook['title'],
//                     style:
//                         TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600)),
//               )
