import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  static Future getData() async {
    http.Response response =
        await http.get('https://ab-books-api.vercel.app/books');
    var data = jsonDecode(response.body);
    List booksList = data;
    print(booksList);
  }
}

void main() {
  Networking.getData();
}
