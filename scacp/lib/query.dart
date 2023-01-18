import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/mongodb.dart';

class QueryDatabase extends StatefulWidget {
  const QueryDatabase({super.key});

  @override
  State<QueryDatabase> createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: MongoDatabase.getQueryData(),
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
                  return displayData(
                      MongoDbModel.fromJson(snapshot.data![index]));
                },
              );
            } else {
              return Center(
                child: Text("Data Not Found"),
              );
            }
          }
        },
      )),
    );
  }

  Widget displayData(MongoDbModel data) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("${data.firstName} ${data.lastName}"),
          SizedBox(height: 10,),
          Text("${data.address}")
        ]),
      ),
    );
  }
}
