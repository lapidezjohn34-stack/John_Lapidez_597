// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/users_model.dart';


// class UsersScreen extends StatefulWidget {
//   const UsersScreen({super.key});

//   @override
//   State<UsersScreen> createState() => _UsersScreenState();
// }

// class _UsersScreenState extends State<UsersScreen> {
//   List<User> users = [];
//   bool isLoading = false;

//   Future<void> fetchUsers()async{
//     setState(() {
//       isLoading = true;
//     });

//     final response = await 
//     http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));
    
//     //404
//     //505
//     //200
//     if(response.statusCode == 200) {
//       List<dynamic> jsonData = json.decode(response.body);
//       setState(() {
//         users = jsonData.map((json) => User.fromJson(json)).toList();
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     fetchUsers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: 
//       isLoading 
//       ? Center(child: CircularProgressIndicator())
//       : ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           User user = users[index];
      
//           return ListTile(
//             title: Text(user.name),
//             subtitle: Text(user.email
//             )
//           );
//         }
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modelhandler/controller/users_controller.dart';
import 'package:modelhandler/model/users_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final controller = UserController();
  List<User> users = [];
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  //fetch the user from your supabase
  void loaduser()async{
    final userdata = await controller.getUsers();
    setState(() {
      users = userdata;
    });
  }
  
  //add user to supabase
  void addUser()async{
    if(nameController.text.isEmpty || emailController.text.isEmpty) {
      return;
    }else{
      final user = User(name: nameController.text, email: emailController.text);
      await controller.addUser(user);
      nameController.clear();
      emailController.clear();
      loaduser();
    }
  }

  //delete user from supabase
  void deleteUser(int id)async{
    await controller.deleteUser(id);
    loaduser();
  }

  @override
  void initState() {
    super.initState();
    loaduser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // form
          TextField(controller: nameController,decoration: InputDecoration(label: Text('Enter your name')),
          ),
          TextField(controller: emailController,decoration: InputDecoration(label: Text('Enter your email')),
          ),
          ElevatedButton(onPressed: (){
            addUser();
          }, child: Text('Add User')),

          Expanded(child: 
          ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(onPressed: (){
                  deleteUser(user.id!);
                }, icon: Icon(Icons.delete)),
              );
            })
            ),
        ],
      ),
    );
  }
}