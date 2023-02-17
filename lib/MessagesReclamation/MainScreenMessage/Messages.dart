//import 'package:flutter_api/models/MessageModel.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/MessagesReclamation/MainScreenMessage/models/UserModel.dart';

import 'models/MessageModel.dart';


class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}




class _MessagesState extends State<Messages> {
  List<UserModel> massages = [];
  late BuildContext dialogContext;

  Future<void> getAllPosts() async {
    const postUrl = 'https://jsonplaceholder.typicode.com/users';
    Dio dio = Dio();

    try {
      final response = await dio.get(postUrl);

      if (response.statusCode == 200) {

        for(var message in response.data){
          setState(() {
            massages.add(UserModel.fromJson(message));
          });
        }

      } else {
        debugPrint('Error : ${response.data}');
      }
    } catch (e) {
      debugPrint('exception $e');
    }
  }





  @override
  void initState() {
    getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        body: massages.isEmpty
            ? const Center(child: Text("Loading..."))
            : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: massages.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text(massages[index].name.toString(),style: const TextStyle(fontWeight: FontWeight.bold),)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(massages[index].phone.toString(),overflow: TextOverflow.ellipsis,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      dialogContext = context;
                                      return  const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                );
                                // updatePost("new post title to update", posts[index].id);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      dialogContext = context;
                                      return  const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                );
                                // deletePost(posts[index].id);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
    );
  }
}
