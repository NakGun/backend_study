import 'package:flutter/material.dart';
import 'package:flutter_study/controller/users_controller.dart';
import 'package:flutter_study/user_edit.dart';
import 'package:flutter_study/user_table.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  UsersController _usersController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    userTable.getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Php Mysql Crud'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.to(UserEdit(procTp: 'I', list: null, index: 0,));
          //Get.toNamed('/edit_page', arguments: User(name: "Nakun", age: 43));
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),

      //Obx라는 함수는 contrlloer의 변수값을 실시간으로 전달받는다
      //현재 users는 controller 내 함수에서 clear후 할당받기 때문에 2번 바뀌게 되어 화면이 2번 호드됨
      body: Obx((){
        if(_usersController.users.length > 0){
          return ListView.builder(
              itemCount: _usersController.users.length,//snapshot.data.length,
              itemBuilder: (context,index){
                List list = _usersController.users.toList();
                return ListTile(
                  leading: GestureDetector(child: Icon(Icons.edit),
                    onTap: (){
                      Get.to(UserEdit(procTp: 'U', list: list, index: index,),
                          arguments: User(name:'nakun', age:43));
                    },),
                  title: Text(list[index]['username']),
                  subtitle: Text(list[index]['email']),
                  trailing: GestureDetector(child: Icon(Icons.delete),
                    onTap: (){
                      userTable.deleteUser(list[index]['id']);

                    },),
                );
              }
          );
        }else{
          return CircularProgressIndicator();
        }

      }),
      // body: FutureBuilder(
      //   future: userTable.getUser(),
      //   builder: (context,snapshot){
      //     if(snapshot.hasError) print(snapshot.error);
      //     return snapshot.hasData
      //         ? ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (context,index){
      //           List list = snapshot.data;
      //           return ListTile(
      //             leading: GestureDetector(child: Icon(Icons.edit),
      //               onTap: (){
      //                 Get.to(UserEdit(procTp: 'U', list: list, index: index,),
      //                     arguments: User(name:'nakun', age:43));
      //               },),
      //             title: Text(list[index]['username']),
      //             subtitle: Text(list[index]['email']),
      //             trailing: GestureDetector(child: Icon(Icons.delete),
      //               onTap: (){
      //                 userTable.deleteUser(list[index]['id']);
      //
      //               },),
      //           );
      //         }
      //     )
      //         : CircularProgressIndicator();
      //   },
      // ),
    );
  }
}

class User{
  String name;
  int age;
  User({this.name, this.age});
}