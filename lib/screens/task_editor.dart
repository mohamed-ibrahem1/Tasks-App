import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_application/main.dart';
import '../models/task_model.dart';

class TaskEditor extends StatefulWidget {
  TaskEditor({this.task, Key? key}) : super(key: key);

  Task? task;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController? _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: HexColor('141318'),
      appBar: AppBar(
        backgroundColor: HexColor('#fee4db'),
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: HexColor('292a35'),
        ),
        title: Text(
          widget.task == null ? 'New task' : 'Update task',
          style: TextStyle(
            color: HexColor('292a35'),
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      //عملنا الويدجيت الغريبة دي عشان نقدر نكتب تاسك كبير براحتنا عشان ميطلعش الايرور بتاع الطول
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Task's Title",
                    style: TextStyle(
                      color: HexColor('ececec'),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextField(
                    controller: _taskTitle,
                    style: TextStyle(
                      color: HexColor('ececec'),
                    ),
                    decoration: InputDecoration(
                      fillColor: HexColor('292a35'),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Your Task',
                      hintStyle: TextStyle(
                        color: HexColor('ececec'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    "Your Task's Note",
                    style: TextStyle(
                      color: HexColor('ececec'),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 25,
                    controller: _taskNote,
                    style: TextStyle(
                      color: HexColor('ececec'),
                    ),
                    decoration: InputDecoration(
                      fillColor: HexColor('292a35'),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Write some notes',
                      hintStyle: TextStyle(
                        color: HexColor('ececec'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () async {
                            var newTask = Task(
                              title: _taskTitle.text,
                              note: _taskNote.text,
                              creationDate: DateTime.now(),
                              done: false,
                            );
                            Box<Task> taskBox = Hive.box<Task>('tasks');
                            // to update the task
                            //********************** */
                            if (widget.task != null) {
                              widget.task!.title = newTask.title;
                              widget.task!.note = newTask.note;
                              widget.task!.save();
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              // to add a new task
                              await taskBox.add(newTask);
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          },
                          fillColor: HexColor('#fee4db'),
                          child: Text(
                            widget.task == null
                                ? 'Add new task'
                                : 'Update task',
                            style: TextStyle(
                              color: HexColor('292a35'),
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
