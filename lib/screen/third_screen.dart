import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/model/UserModel.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Json'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getUserApi(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'Name',
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusableRow(
                                  title: 'UserName',
                                  value: snapshot.data![index].username
                                      .toString()),
                              ReusableRow(
                                title: 'Email',
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusableRow(
                                  title: 'Address',
                                  value: snapshot.data![index].address!.city
                                          .toString() +
                                      ", " +
                                      snapshot.data![index].address!.street
                                          .toString()),
                              ReusableRow(
                                  title: 'More Address',
                                  value: snapshot.data![index].address!.geo!.lat.toString() +
                                      ", " +
                                      snapshot.data![index].address!.geo!.lng
                                          .toString()),
                              ReusableRow(
                                  title: 'More Address',
                                  value: snapshot.data![index].address!.geo!.lat.toString() +
                                      ", " +
                                      snapshot.data![index].address!.geo!.lng
                                          .toString()),
                              ReusableRow(
                                  title: 'Company',
                                  value: snapshot.data![index].company!.name.toString() +
                                      ", " +
                                      snapshot.data![index].company!.bs
                                          .toString()),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
class AddressInfo extends StatelessWidget {
  final List<String> addressInfo;

  const AddressInfo({super.key, required this.addressInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: addressInfo.map((info) {
        return Text(info);
      }).toList(),
    );
  }
}

