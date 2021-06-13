import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_study/controller/users_controller.dart';

// const URL = 'http://3.140.165.103/';
const URL = 'http://localhost/';
http.Response response;
http.Dio dio = new http.Dio();

class UserTable{
  UsersController _usersController = Get.put(UsersController());

  Future<dynamic> getUser() async {
    var formData = http.FormData.fromMap({
      'table':'users',
      'crud_tp':'search'
    });
    response = await dio.post('$URL/crud/users_crud.php', data: formData);
    print('>>>>>>>>>>>>>>>>>>>>>>${response.data}');
    List<dynamic> users = jsonDecode(response.data);
    _usersController.setUsers(users);

    return jsonDecode(response.data);

  }

  //DB에 유저 등록 인자값 전달
  Future<void> addUser(String id, String name, String email, String pwd) async {

    var usrMap = {
      'id':id,
      'username':name,
      'email':email,
      'pwd':pwd,
      'age':43,
    };
    // var formData = http.FormData.fromMap({
    //   'table':'users',
    //   'crud_tp':'insert',
    //   'col1':'id'+'=>'+'${id}',
    //   'col2':'username'+ '=>'+'${name}',
    //   'col3':'email'+ '=>'+ '${email}',
    //   'col4':'pwd'+ '=>'+ '${pwd}',
    //   'col5':'age'+ '=>'+ '43'
    // });

    var formData = http.FormData.fromMap({
      'table':'users',
      'crud_tp':'insert',
      'user_info':usrMap,
    });

    // response = await dio.post('$URL/add.php', data: formData);
    response = await dio.post('$URL/crud/users_crud.php', data: formData);
  }

  Future<void> updateUser(String id, String name, String email, String pwd) async {
    var usrMap = {
      'username':name,
      'email':email,
      'pwd':pwd,
      'age':43,
    };
    var whereMap = {
      'id':id,
    };


    var formData = http.FormData.fromMap({
      'table':'users',
      'crud_tp':'update',
      'user_info':usrMap,
      'where_map':whereMap
    });

    response = await dio.post('$URL/crud/users_crud.php', data: formData);
  }

  Future<void> deleteUser(String id) async {
    var whereMap = {
      'id':id,
    };

    var formData = http.FormData.fromMap({
      'table':'users',
      'crud_tp':'delete',
      'user_info':'nothing',
      'where_map':whereMap
    });
    response = await dio.post('$URL/crud/users_crud.php', data: formData);

    //삭제된 후 리스트를 컨트롤러에 전달하여 업데이트함
    List<dynamic> users = jsonDecode(response.data);
    _usersController.setUsers(users);
  }
}

//다른 소스에서 바로 한수로 접근하게 하기 위해 이렇게 선언하네
UserTable userTable = UserTable();