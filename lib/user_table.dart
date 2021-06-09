import 'dart:convert';

import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import 'package:flutter_study/controller/users_controller.dart';

const URL = 'http://localhost/';
http.Response response;
http.Dio dio = new http.Dio();

class UserTable{
  UsersController _usersController = Get.put(UsersController());

  Future<dynamic> getUser() async {

    response = await dio.get('$URL/search.php');
    print('>>>>>>>>>>>>>>>>>>>>>>${response.data}');
    List<dynamic> users = jsonDecode(response.data);
    _usersController.setUsers(users);

    return jsonDecode(response.data);

  }

  //DB에 유저 등록 인자값 전달
  Future<void> addUser(String id, String name, String email, String pwd) async {

    var formData = http.FormData.fromMap({
      'id': id,
      'username': name,
      'email': email,
      'pwd': pwd
    });
    response = await dio.post('$URL/add.php', data: formData);
  }

  Future<void> updateUser(String id, String name, String email, String pwd) async {
    var formData = http.FormData.fromMap({
      'id': id,
      'username': name,
      'email': email,
      'pwd': pwd
    });
    response = await dio.post('$URL/update.php', data: formData);
  }

  Future<void> deleteUser(String id) async {
    var formData = http.FormData.fromMap({
      'id': id
    });
    response = await dio.post('$URL/delete.php', data: formData);

    //삭제된 후 리스트를 컨트롤러에 전달하여 업데이트함
    List<dynamic> users = jsonDecode(response.data);
    _usersController.setUsers(users);
  }
}

//다른 소스에서 바로 한수로 접근하게 하기 위해 이렇게 선언하네
UserTable userTable = UserTable();