import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/add_screen.dart';
import 'package:provider_test/providers/todos_model.dart';
import 'package:provider_test/widgets/all_tasks_tab.dart';
import 'package:provider_test/widgets/completed_tasks_tab.dart';
import 'package:provider_test/widgets/incomplete_tasks_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: "All Tasks"),
            Tab(text: "Compelete Tasks"),
            Tab(text: "Incomplete Tasks"),
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: [
        AllTasksTab(),
        CompletedTasksTab(),
        IncompleteTasksTab(),
      ]),
    );
  }
}
