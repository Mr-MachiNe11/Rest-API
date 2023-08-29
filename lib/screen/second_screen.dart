import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhotoApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(
            id: i['id'], title: i['title'], thumbnailUrl: i['thumbnailUrl']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api2'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data![index].thumbnailUrl.toString()),
                      ),
                      title: Text('Id: ${snapshot.data![index].id}'),
                      subtitle: Text(snapshot.data![index].title.toString()),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Photos {
  int id;
  String title, thumbnailUrl;

  Photos({required this.id, required this.title, required this.thumbnailUrl});
}
