import 'package:flutter/material.dart';
import 'package:todo_app/model/todoModel.dart';

class TodoDetail extends StatefulWidget {
  final TodoModel? todo;

  const TodoDetail({super.key, this.todo});

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  var todos = <TodoModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${widget.todo!.date} - ${widget.todo!.time}',
              style: const TextStyle(fontSize: 18),
            ),
            const Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Description: ${widget.todo!.Description}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
