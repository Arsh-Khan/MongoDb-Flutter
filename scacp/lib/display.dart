import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/mongodb.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({super.key});

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                var totalData =
                    snapshot.data!.length; //getting total length of data

                print('Total Data' + totalData.toString());
                // return Text('Data Found');
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return displayCard(
                        MongoDbModel.fromJson(snapshot.data![index]));
                  },
                );
              } else {
                return Center(
                  child: Text("No data Available"),
                );
              }
            }
          },
        ),
      )),
    );
  }

  // Displaying all data
  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ),
    );
  }
}
