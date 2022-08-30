import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo/database/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/pages/info_screen.dart';
import 'package:todo/widgets/custom_search_delegate.dart';
import 'package:todo/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _tasks;
  late LocalStorage _localStorage;
  @override
  void initState() {
    _localStorage = locator<LocalStorage>();
    super.initState();
    _tasks = <Task>[];
    _getAllTaskFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        appBar: AppBar(
          leading: Container(
            child: MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoScreen()));
              },
              child: Icon(Icons.info_sharp),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              _addTask();
            },
            child: const Text(
              'To Do',
              style: TextStyle(color: Colors.black),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                _showSearch();
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                _addTask();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: _tasks.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var _currentListItems = _tasks[index];
                  return Dismissible(
                      background: Row(
                        children: [
                          Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          Text('Görev başarılı ile silindi'),
                        ],
                      ),
                      key: Key(_currentListItems.id),
                      onDismissed: (direction) async {
                        _tasks.removeAt(index);
                        await _localStorage.deleteTask(task: _currentListItems);
                        setState(() {});
                      },
                      child: TaskItem(
                        task: _currentListItems,
                      ));
                },
                itemCount: _tasks.length,
              )
            : Center(
                child: Text(
                  'Bütün işlerinizi hallettiniz',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ));
  }

  void _addTask() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              onSubmitted: (value) {
                Navigator.of(context).pop();
                if (value.length > 5) {
                  DatePicker.showTime12hPicker(context,
                      onConfirm: (time) async {
                    var newAddTask =
                        Task.create(name: value, createdTask: time);
                    _tasks.add(newAddTask);
                    await _localStorage.addTask(task: newAddTask);
                    setState(() {});
                  });
                }
              },
              style: const TextStyle(
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                  hintText: 'Ne Yapacaksın', border: InputBorder.none),
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskFromDB() async {
    _tasks = await _localStorage.getAllTask();
    setState(() {});
  }

  void _showSearch() async {
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allTask: _tasks));
    _getAllTaskFromDB();
  }
}
