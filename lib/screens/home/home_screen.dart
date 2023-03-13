import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todos/controllers/todo_controller.dart';
import 'package:todos/routes.dart';
import 'package:todos/utils/shared_prefs.dart';
import 'package:todos/widgets/Loader.dart';
import 'package:todos/widgets/custom_button.dart';
import 'package:todos/widgets/custom_search.dart';
import 'package:todos/widgets/custom_textfield.dart';

import '../../models/todo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO',
          style: TextStyle(
            fontFamily: 'Popins',
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context)=>Dialog(
                  child: ManipulateTodo(),
                ));
              },
              icon: const FaIcon(FontAwesomeIcons.plus),
              color: Colors.black,
          ),

          IconButton(
            onPressed: (){
              showDialog(context: context, builder: (context)=>AlertDialog(
                title: Text("Logout?"),
                content: Text("Are you sure want to logout?"),
                actions: [
                  ElevatedButton(
                    onPressed: (){Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                  ElevatedButton(onPressed: ()async{
                    await SharedPrefs().removeUser();
                    Get.offAllNamed(GetRoutes.login);
                  },
                      child: Text("Confirm")),
                ],
              ),);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
            color: Colors.black,
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<TodoController>(
          builder: (controller) {
            return Column(
              children: [
                CustomSearch(onChanged: (val){
                  controller.search(val);
                }),

                SizedBox(height: 30,),

                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: controller.filteredTodo.map((todo) => Slidable(
                                    child: TodoTile(todo: todo),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context){
                                            controller.titleController.text = todo.title!;
                                            controller.descriptionContorller.text = todo.description!;
                                            controller.update();
                                            showDialog(context: context,
                                                builder: (context) => Dialog(
                                                  child: ManipulateTodo(
                                                      edit:true, id: todo.id!,
                                                  ),
                                                ));
                                          },
                                          backgroundColor: Color(0xff8394FF),
                                          foregroundColor: Colors.white,
                                          icon: FontAwesomeIcons.pencil,
                                          label: "Edit",
                                    ),
                                        SlidableAction(
                                          onPressed: (context){
                                            showDialog(context: context, builder: (context) => AlertDialog(
                                              title: Text("Delete Todo?"),
                                              content: Text("Are you sure want to delete this todo?"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: (){Navigator.pop(context);
                                                      },
                                                    child: Text("Cancel"),
                                                  style: ElevatedButton.styleFrom(primary: Colors.red),
                                                ),
                                                ElevatedButton(onPressed: ()async{
                                                  await Get.showOverlay(
                                                      asyncFunction: ()=>controller.deleteTodo(todo.id!),
                                                      loadingWidget: const Loader());
                                                    Navigator.pop(context);
                                                },
                                                    child: Text("Confirm")),
                                              ],
                                            ));
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: FontAwesomeIcons.trash,
                                          label: "Delete",
                                        ),
                                  ],),
                                )).toList(),
                      ),
                    ))
              ],
            );
          }
        ),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [BoxShadow(
          color: const Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 12,
        ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            todo.date!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            todo.description!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xff949494),
            ),
          )
        ],
      ),
    );
  }
}

class ManipulateTodo extends StatelessWidget {
  const ManipulateTodo({Key? key, this.edit = false, this.id = ""}) : super(key: key);

  final bool edit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GetBuilder<TodoController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${edit ? "Edit" : "Add"} Todo",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20,),

              CustomTextField(hint: "Title",
                controller: controller.titleController,),

              const SizedBox(height: 10,),

              CustomTextField(hint: "Description",
                maxLines: 4,
                controller: controller.descriptionContorller,),

              const SizedBox(height: 30,),

              CustomButton(label: edit ? "Edit" : "Add",
                  onPressed: ()async{
                if(!edit){
                  await Get.showOverlay(
                      asyncFunction: ()=>controller.addTodo(),
                      loadingWidget: const Loader());
                }
                else {
                  await Get.showOverlay(
                      asyncFunction: ()=>controller.editTodo(id),
                      loadingWidget: const Loader());
                }
                Navigator.pop(context);
              }),
            ],
          );
        }
      ),
    );
  }
}


