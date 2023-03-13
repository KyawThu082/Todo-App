import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todos/models/user.dart';
import 'package:todos/utils/custom_snackbar.dart';
import 'package:todos/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../models/todo.dart';
import '../utils/baseurl.dart';



class TodoController extends GetxController{

  List<Todo> todos = [];
  List<Todo> filteredTodo = [];

  late TextEditingController titleController, descriptionContorller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMyTodos();

    titleController = TextEditingController();
    descriptionContorller = TextEditingController();

  }

  @override
  void onClose(){
    super.onClose();

    titleController.dispose();
    descriptionContorller.dispose();
  }

  fetchMyTodos() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'todos.php'), body: {"user_id": user.id});

    var res = await json.decode(response.body);

    if(res['success']){
      todos = AllTodos.fromJson(res).todo!;
      filteredTodo = AllTodos.fromJson(res).todo!;
      update();

    }else {
      customSnackbar("Error", "Failed to fetch todos", "error");

    }
  }

  search(String val){
    if(val.isEmpty){
      filteredTodo = todos;
      update();
      return;
    }

    filteredTodo = todos.where((todo){
      return todo.title!.toLowerCase().contains(val.toLowerCase());
    }).toList();

    update();
  }

  addTodo()async{
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'add_todo.php'), body: {
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionContorller.text,
    });

    var res = await json.decode(response.body);

    if(res['success']){
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionContorller.text = "";
      fetchMyTodos();

    }else {
      customSnackbar("Error", res['message'], "error");

    }
  }

  editTodo(id)async{
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'edit_todo.php'), body: {
      "id": id,
      "user_id": user.id,
      "title": titleController.text,
      "description": descriptionContorller.text,
    });

    var res = await json.decode(response.body);

    if(res['success']){
      customSnackbar("Success", res['message'], "success");
      titleController.text = "";
      descriptionContorller.text = "";
      fetchMyTodos();

    }else {
      customSnackbar("Error", res['message'], "error");

    }
  }

  deleteTodo(id)async{
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var response = await http.post(Uri.parse(baseurl + 'delete_todo.php'), body: {
      "user_id": user.id,
      "id": id,
    });

    var res = await json.decode(response.body);

    if(res['success']){
      customSnackbar("Success", res['message'], "success");
      fetchMyTodos();

    }else {
      customSnackbar("Error", res['message'], "error");

    }
  }
}