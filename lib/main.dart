import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_application/models/task_model.dart';
import 'package:notes_application/screens/search_screen.dart';
import 'package:notes_application/widgets/my_list_tile.dart';
import 'screens/task_editor.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>('tasks');
  // الحتة دي عشان تبدأ بتاسك تعريفية من الاول
  //////////////////*************************/////////////////////////
  // box.add(
  //   Task(
  //     title: 'This is the first Task',
  //     note: 'This is the first Task made with the app',
  //     creationDate: DateTime.now(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({this.task, Key? key}) : super(key: key);
  Task? task;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('141318'),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('#fee4db'),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: HexColor('292a35'),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: HexColor('#fee4db'),
                size: 25,
              ),
            ),
          ),
        ],
        backgroundColor: HexColor('#fee4db'),
        elevation: 0.0,
        title: Text(
          'Tasks',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: HexColor('292a35')),
        ),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>('Tasks').listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // خلي بالك معلومة مهمة جدا
                //ال Expanded
                //لو كان ابن لازم يكون ابت للي جي دة و بس عشان ميعملش معاك ايرور
                //Row(), Column(), Flex()
                //ودول بيتسموا
                // Parent Widget
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return MyListTile(currentTask, index);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            largeSizeConstraints: BoxConstraints.tightFor(
              width: 70,
              height: 70,
            ),
          ),
        ),
        child: FloatingActionButton.large(
          backgroundColor: HexColor('#fee4db'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskEditor(
                  task: widget.task,
                ),
              ),
            );
          },
          child: const Icon(
            FontAwesomeIcons.plus,
            size: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
