import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/model/todoModel.dart';

class TodoPage extends StatefulWidget {
  final TodoModel? todoModel;

  const TodoPage({super.key, this.todoModel});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController descriptionCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //DateTime now = DateTime.now(
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm:a').format(DateTime.now());
    timeController.text = formattedTime;
    dateController.text = formattedDate;

    if (widget.todoModel == null) {
      titleCont = TextEditingController();
      descriptionCont = TextEditingController();
      timeController.text = formattedTime;
      dateController.text = formattedDate;
    } else {
      titleCont = TextEditingController(text: widget.todoModel!.Title);
      descriptionCont =
          TextEditingController(text: widget.todoModel!.Description);
      timeController = TextEditingController(text: widget.todoModel!.time);
      dateController = TextEditingController(text: widget.todoModel!.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Text(
          widget.todoModel == null ? 'Add Todo' : 'Update Todo',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                            //label: Text('Date '),
                            // border: OutlineInputBorder(),
                            ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                        controller: timeController,
                        decoration: const InputDecoration(
                            // label: Text('Time '),
                            //border: OutlineInputBorder(),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: titleCont,
                decoration: const InputDecoration(
                  label: Text('Enter Title here'),
                  //border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: descriptionCont,
                decoration: const InputDecoration(
                  label: Text('Enter Description here '),
                  //border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.black38),
                  ),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;

                    TodoModel todo;
                    if (widget.todoModel == null) {
                      todo = TodoModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        Title: titleCont.text.trim(),
                        Description: descriptionCont.text.trim(),
                        //isCompleted: false,
                        date: dateController.text.trim(),
                        time: timeController.text.trim(),
                      );
                      await DbHelper.instance.insert(todo);
                    } else {
                      todo = TodoModel(
                        id: widget.todoModel!.id,
                        Title: titleCont.text.trim(),
                        Description: descriptionCont.text.trim(),
                        //isCompleted: widget.todoModel!.isCompleted,
                        date: dateController.text,
                        time: timeController.text,
                      );
                      await DbHelper.instance.update(todo);
                    }
                    Navigator.pop(context, todo);
                  },
                  child: Text(
                    widget.todoModel == null ? 'Add Todo' : 'Update Todo',
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
