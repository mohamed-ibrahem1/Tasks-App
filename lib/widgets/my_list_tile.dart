import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes_application/screens/task_editor.dart';
import '../models/task_model.dart';


class MyListTile extends StatefulWidget {
  MyListTile(this.task, this.index, {Key? key}) : super(key: key);

  Task task;
  int index;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskEditor(
              task: widget.task,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        decoration: BoxDecoration(
          color: HexColor('292a35'),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.task.title!,
                    style: TextStyle(
                      color: HexColor('ececec'),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.task.delete();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: HexColor('ececec'),
                    size: 30,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20.0,
              thickness: 1.0,
              color: HexColor('#fee4db'),
            ),
            Text(
              widget.task.note!,
              style: TextStyle(
                color: HexColor('ececec'),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
