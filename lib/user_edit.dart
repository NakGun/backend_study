import 'package:flutter/material.dart';
import 'package:flutter_study/user_table.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'main.dart';

class UserEdit extends StatelessWidget {

  final List list;
  final int index;
  final String procTp;
  UserEdit({this.list,this.index,this.procTp});

  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(editMode ? 'Update' :'Add Data'),),
      appBar: AppBar(title: procTp == 'I' ? Text('입력') : Text('수정'),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: id..text= procTp == 'U' ? list[index]['id'] : '',
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name..text=procTp == 'U' ? list[index]['username'] : '',
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email..text=procTp == 'U' ? list[index]['email'] : '',
              decoration: InputDecoration(
                labelText: 'email',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pwd..text=procTp == 'U' ? list[index]['pwd'] : '',
              decoration: InputDecoration(
                labelText: 'pwd',
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                print(procTp);
                if(procTp == 'I'){
                  await userTable.addUser(id.text, name.text, email.text, pwd.text);
                }else{
                  await userTable.updateUser(id.text, name.text, email.text, pwd.text);
                }
                //Get.back();
                Get.offAll(Home());
              },
              child: Text('Save',style: TextStyle(color: Colors.white),),
            ),
          ),

          //아래는 Get을 통해 전달된 class argument를 표현했다
          // Padding(padding: EdgeInsets.all(8),
          //   child: Text('${(Get.arguments as User).name} : ${(Get.arguments as User).age}'),
          //   ),
        ],
      ),
    );
  }
}
