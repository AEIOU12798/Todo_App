import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/ui/todo_detail.dart';
import 'add_todo.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageSTF();
  }
}

class HomePageSTF extends StatefulWidget {
  const HomePageSTF({super.key});

  @override
  State<HomePageSTF> createState() => _HomePageSTFState();
}

class _HomePageSTFState extends State<HomePageSTF> {
  var todos = <TodoModel>[];
  late var todosData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todosData = DbHelper.instance.getAll().then((value) {
      setState(() {
        todos.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black38,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TodoPage()));

          setState(() {
            if (todo != null) {
              todos.add(todo);
            }
          });
        },
        backgroundColor: Colors.black38,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: todosData,
            builder: (context, snap) {
              if (snap.hasData) {
              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    String formattedDate =
                        DateFormat.yMMMEd().format(DateTime.now());
                    todo.date = formattedDate;

                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Colors.black12, width: 15.0),
                                top: BorderSide(
                                    color: Colors.black38, width: 10.0),
                                right: BorderSide(
                                    color: Colors.black54, width: 12.0),
                                bottom: BorderSide(
                                    color: Colors.black26, width: 10.0),
                              ),
                            ),
                            child: SizedBox(
                              height: 80.0,
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TodoDetail(todo: todo)));
                                  },
                                  leading: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: const Icon(
                                        Icons.note_alt,
                                        color: Colors.white,
                                      )),
                                  //(math.Random().nextDouble()* 0xFFFFFF).toInt()).withOpacity(1.0),size: 30.0,),
                                  title: Text(todo.Title.toUpperCase()),
                                  //subtitle: Text(todo.date),
                                  trailing: SizedBox(
                                    width: 100.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: IconButton(
                                              onPressed: () async {
                                                await DbHelper.instance
                                                    .delete(todo.id);
                                                setState(() {
                                                  todos.removeWhere((element) =>
                                                      element.id == todo.id);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: IconButton(
                                              onPressed: () async {
                                                final gotTodo = await Navigator
                                                        .of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            TodoPage(
                                                                todoModel:
                                                                    todo)));
                                                setState(() {
                                                  if (gotTodo != null) {
                                                    final todoIndex =
                                                        todos.indexWhere((e) =>
                                                            e.id == gotTodo.id);
                                                    todos.removeAt(todoIndex);
                                                    todos.insert(
                                                        todoIndex, gotTodo);
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 25.0,
                          width: 130.0,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(60),
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 30.0, top: 10.0),
                          child: Center(
                              child: Text(
                            todo.date,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                        Container(
                          height: 25.0,
                          width: 80.0,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(60),
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 250.0, top: 10.0),
                          child: Center(
                              child: Text(
                            todo.time,
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                      ],
                    );
                  });
              }
              else{
                return const Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('No Task',style: TextStyle(fontSize: 20.0),),
                     SizedBox(height: 20.0,),
                     Text('Tap + buttom to Add Task'),
                  ],
                ),);
              }
            }),
      ),
    );
  }
}
