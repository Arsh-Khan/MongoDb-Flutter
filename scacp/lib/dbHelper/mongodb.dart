import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/constants.dart';

class MongoDatabase {
  static var db, userCollection;

  // function to connect with database
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    // log(db.toString());
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // creating a function for fetching data from mongoDb inside our MongoDatabase file
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

  static Future<void> update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastName'] = data.lastName;
    result['address'] = data.address;

    var response = await userCollection.save(result);
    inspect(response);
  }

  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }

  // use for query
  static Future<List<Map<String, dynamic>>> getQueryData() async {
    final data =
        await userCollection.find(where.eq('firstName', 'name')).toList();
    return data;
  }

  //where.eq('age','43')  --> first will field name (column) second will be value --- this will return same age as value (matched value)
  //where.gt('age','43')  --> first will field name (column) second will be value --- this will return same age value greater than value
  // where.gt('age','30').lt('age','50') --> details of student between age 30 to 50
  // where.gt().eq()

}
