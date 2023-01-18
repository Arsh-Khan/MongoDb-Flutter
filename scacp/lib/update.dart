import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/mongodb.dart';
import 'package:scacp/insert.dart';
import 'display.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({super.key});

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return displayCard(
                            MongoDbModel.fromJson(snapshot.data![index]));
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No Data Found"),
                    );
                  }
                }
              })),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${data.id.$oid}"),
              SizedBox(
                height: 5,
              ),
              Text("${data.firstName}"),
              SizedBox(
                height: 5,
              ),
              Text("${data.lastName}"),
              SizedBox(
                height: 5,
              ),
              Text("${data.address}"),
            ]),
            IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return MongoDbInsert();
                              },
                              settings: RouteSettings(arguments: data)))
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
