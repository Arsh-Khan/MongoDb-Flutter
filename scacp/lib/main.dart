import 'package:flutter/material.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/constants.dart';
import 'package:scacp/dbHelper/mongodb.dart';
import 'package:scacp/delete.dart';
import 'package:scacp/display.dart';
import 'package:scacp/insert.dart';
import 'package:scacp/query.dart';
import 'package:scacp/update.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        insertRoute: (context) => const MongoDbInsert(),
        displayRoute: (context) => const MongoDbDisplay(),
        deleteRoute: (context) => const MongoDbDelete(),
        queryRoute: (context) => const QueryDatabase(),
        updateRoute: (context) => const MongoDbUpdate(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      heroTag: 'h1',
                      onPressed: () {
                        Navigator.pushNamed(context, insertRoute,
                            arguments: MongoDbModel(
                                id: M.ObjectId(),
                                firstName: 'Null',
                                lastName: 'Null',
                                address: 'null'));
                      },
                      child: Text("Insert Data"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      heroTag: 'h2',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            displayRoute, (route) => false);
                      },
                      child: Text("Display Data"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      heroTag: 'h3',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            deleteRoute, (route) => false);
                      },
                      child: const Text('Delete Data'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      heroTag: 'h4',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            updateRoute, (route) => false);
                      },
                      child: const Text('Update Data'),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      heroTag: 'h5',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            queryRoute, (route) => false);
                      },
                      child: const Text('Query Data'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:scacp/constants/routes.dart';
// import 'package:scacp/views/about_vjti_view.dart';
// import 'package:scacp/views/dashboard_view.dart';
// import 'package:scacp/views/login_view_vjti.dart';
// import 'package:scacp/views/sign_up_vjti.dart';
// import 'dart:developer' as devtools show log;

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//     home: HomeScreen(),
//     routes: {
//       loginVJTIRoute: (context) => const LoginViewVJTI(),
//       signUpVJTIRoute: (context) => const SignUpVJTI(),
//       dashBoardRoute: (context) => const DashBoardView(),
//       verifyEmailRoute: (context) => const VerifyEmailView(),
//       signUpNonVJTIRoute: (context) => const SignUpNonVJTI(),
//       aboutVJTIRoute: (context) => const AboutVJTIView()
//     },
//   ));
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     /*
//       FutureBuilder Widget is used to create widgets based on the latest snapshot of interaction with a Future
//       It also helps us  to execute some Asynchronous code and based upon that UI will update.
//       It has four states.
//     */
//     return FutureBuilder(
//         future: AuthService.firebase().initalize(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               AuthService.firebase().logOut();
//               final user = AuthService.firebase().currentUser;
//               if (user != null) {
//                 if (user.isEmailVerified) {
//                   devtools.log('User is Verified');
//                   return const DashBoardView();
//                 } else {
//                   AuthService.firebase().sendEmailVerification();
//                   return const VerifyEmailView();
//                 }
//               } else {
//                 return const LoginViewVJTI();
//               }
//             default:
//               return const CircularProgressIndicator();
//           }
//         });
//   }
// }
