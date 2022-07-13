import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../main.dart';

import 'task_editor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List displayList = List.from(box.values);

  void updateList(String value) {
    setState(() {
      displayList = box.values
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('141318'),
      appBar: AppBar(
        backgroundColor: HexColor('#fee4db'),
        iconTheme: IconThemeData(
          color: HexColor('292a35'),
        ),
        title: Align(
          alignment: Alignment(-1.30, 0),
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: HexColor('292a35'),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///////////////////////////////////// TextField ////////////////////////////////////////////
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(
                color: HexColor('ececec'),
              ),
              decoration: InputDecoration(
                hoverColor: HexColor('ececec'),
                fillColor: HexColor('292a35'),
                hintStyle: TextStyle(
                  color: HexColor('ececec'),
                ),
                hintText: 'Search here . . . .',
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor('ececec'),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            /////////////////////////////////////////////////////////************************************
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: displayList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  tileColor: HexColor('292a35'),
                  textColor: HexColor('ececec'),
                  contentPadding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(
                    displayList[index].title,
                    style: TextStyle(
                      color: HexColor('ececec'),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  subtitle: Text(
                    displayList[index].note,
                    style: TextStyle(
                      color: HexColor('ececec').withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskEditor(
                          task: displayList[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
