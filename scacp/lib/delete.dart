import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/mongodb.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({super.key});

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
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
              //Displaying data
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _dataCard(
                      MongoDbModel.fromJson(snapshot.data![index]));
                },
              );
            } else {
              return Text("No Data Found");
            }
          }
        },
      )),
    );
  }

  Widget _dataCard(MongoDbModel data) {
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
                onPressed: () async {
                  await MongoDatabase.delete(data);
                  setState(() {});
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
