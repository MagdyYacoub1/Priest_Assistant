import 'package:flutter/material.dart';
import './widgets/custom_drawer.dart';
import './widgets/tile_widget_horizontal.dart';
import './widgets/tile_widget.dart';
import './entities/confessor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(
        'Priest Assistant',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.language,
            size: 30,
            color: Colors.white,
          ),
        )
      ],
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: () => CustomDrawer.of(context).toggle(),
          );
        },
      ),
    );
    Widget child = HomePage(appBar: appBar);
    child = CustomDrawer(child: child);
    return MaterialApp(
      title: 'Priest Assistant',
      home: child,
    );
  }
}

class HomePage extends StatefulWidget {
  final AppBar appBar;

  HomePage({Key key, @required this.appBar}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Confessor> confessors = [
    Confessor(
        photo: "Null",
        name: 'Test1Test1Test1566',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test2',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test3',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test4',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test5',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test6',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test7',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test8',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
    Confessor(
        photo: "Null",
        name: 'Test9',
        notes: 'test',
        phone: '02165952956',
        address: 'test',
        lastConfessDate: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TileWidgetHorizontal(confessors, index);
                },
                itemCount: confessors.length,
              ),
            ),
            Flexible(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TileWidget(confessors, index);
                },
                itemCount: confessors.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
