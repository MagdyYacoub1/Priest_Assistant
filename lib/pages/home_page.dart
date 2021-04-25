import 'package:flutter/material.dart';
import 'package:priest_assistant/widgets/appBar_Builder.dart';


import '../widgets/tile_widget_horizontal.dart';
import '../widgets/tile_widget.dart';
import '../entities/confessor.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Confessor> confessors = [
    Confessor(
        photo: "Null",
        name: 'Test1Test1Test15654651515156165165668465135165461',
        notes: 'testslndvljdnfjdfnkvsvnsnlvjsbjkvsndlvbsdkvnlskdjvlksnvjsndlkvnsdkvnlslvksnlsnvjnfdvklsndvjksbkdvlsdnvlsdvkjsnldkvsdnvlsnvj',
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
      appBar: CustomAppBar(),
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
