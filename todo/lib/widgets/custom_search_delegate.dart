import 'package:flutter/material.dart';
import 'package:todo/database/local_storage.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/task_list_item.dart';


class CustomSearchDelegate extends SearchDelegate{
  final List<Task> allTask;
  CustomSearchDelegate({required this.allTask});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query.isNotEmpty ? null : query = '';
      }, icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: (){
          close(context, null);
        },
        child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 24,));
  }

  @override
  Widget buildResults(BuildContext context) {
    var filteredList = allTask.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.length > 0 ? ListView.builder(
      itemBuilder: (context, index) {
        var _currentListItems = filteredList[index];
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
              filteredList.removeAt(index);
              await locator<LocalStorage>().deleteTask(task: _currentListItems);
            },
            child: TaskItem(
              task: _currentListItems,
            ));
      },
      itemCount: filteredList.length,
    ): Center(child: Text('Aradığınızı bulamadım.'),);

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}