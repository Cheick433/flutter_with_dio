import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Utils.dart';

//import 'Utils.dart';

class AddMessage extends StatefulWidget {
  const AddMessage({Key? key}) : super(key: key);

  @override
  AddMesageState createState() => AddMesageState();
}

class AddMesageState extends State<AddMessage> {
  //TextEditingController titleController = TextEditingController();
  final titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late BuildContext dialogContext;

  var titre;

  void _updateText(val){
    titre = val;
  }



  Future<void> addMessages(title,body) async {
    const postUrl = 'https://jsonplaceholder.typicode.com/posts';
    Dio dio = Dio();
    final data = {
      "title": title,
      "body": body,
      "userId": 1,
    };

    dio.options.headers['Content-type'] = 'application/json; charset=UTF-8';

    try {
      final response = await dio.post(postUrl,data: data);
      // ignore: use_build_context_synchronously
      Navigator.pop(dialogContext);
      // ignore: use_build_context_synchronously
      buildShowSnackBar(context, "post added");
      debugPrint('post : ${response.data}');
      debugPrint('post : ${response.statusMessage}');
    } catch (e) {
      debugPrint('exception $e');
    }
  }




  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Post"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [

              TextFormField(
        //         onChanged: (val){
        //           _updateText(val);
        // },
          controller: titleController,

          decoration: const InputDecoration(
                  labelText: 'titre de la message',
                  prefixIcon: Icon(Icons.verified_outlined),
                  border: OutlineInputBorder()
                ),
              ),
              const Text("Titre de la message"),
              TextFormField(
                controller: bodyController,

                decoration: const InputDecoration(
                    labelText: 'description',
                    prefixIcon: Icon(Icons.verified_outlined),
                    border: OutlineInputBorder()
                ),
              ),

              Padding(
                padding:  const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        onPressed: () {
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
                          if(titleController.text.isEmpty || bodyController.text.isEmpty){
                            buildShowSnackBar(context, "please check your info.");
                          }else {
                            addMessages(titleController.text, bodyController.text);
                          }
                        },
                        child: const Text(
                          'Add Post',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),


            ],
          ),

        )

      ),
    );
  }


}



// ListView(
//   scrollDirection: Axis.vertical,
//   children:  [
//     Padding(
//       padding:  const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//       child: Row(
//
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//             child: TextField(
//               //controller: titleController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter a search term',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//             child: TextFormField(
//               controller: bodyController,
//
//               decoration: const InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: 'Enter your username',
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     Padding(
//       padding:  const EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.indigoAccent,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: TextButton(
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       dialogContext = context;
//                       return  const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                 );
//                 if(titleController.text.isEmpty || bodyController.text.isEmpty){
//                   buildShowSnackBar(context, "please check your info.");
//                 }else {
//                   addMessages(titleController.text, bodyController.text);
//                 }
//               },
//               child: const Text(
//                 'Add Message',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     ),
//
//   ],
// ),