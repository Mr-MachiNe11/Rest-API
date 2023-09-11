import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/model/Product.dart';




class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  Future<ProductModel?> getProductApi() async {
    try {
      final response = await http.get(
        Uri.parse('https://webhook.site/e168656d-3836-4005-8fc9-2df3700c8b2c'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModel.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API request
      print('Error: $e');
      return null; // Return null to indicate an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Json'),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductModel?>(
        future: getProductApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            final productModel = snapshot.data!;
            return ListView.builder(
              itemCount: productModel.data?.length ?? 0,
              itemBuilder: (context, index) {
                final product = productModel.data![index];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images?.length ?? 0,
                        itemBuilder: (context, position) {
                          final imageUrl = product.images?[position].url;

                          return imageUrl != null
                              ? Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : Container(); // Return an empty container if image URL is null
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
