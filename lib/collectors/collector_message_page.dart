// import 'package:flutter/material.dart';

// class CollectorMessage extends StatefulWidget {
//   const CollectorMessage({Key? key}) : super(key: key);

//   @override
//   State<CollectorMessage> createState() => _CollectorMessageState();
// }

// class _CollectorMessageState extends State<CollectorMessage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:esafi/mpesabackend/stk_push.dart';

class CollectorMessage extends StatefulWidget {
  const CollectorMessage({Key? key}) : super(key: key);

  static const routeName = '/requests_page';

  @override
  State<CollectorMessage> createState() => _CollectorMessageState();
}

class _CollectorMessageState extends State<CollectorMessage> {
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');
  String userId = "TafaTr9BW3TIRW3NwzaSMVPA4S32";
  // FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: SafeArea(
        child: Column(children: [
          SizedBox(height: 25),

          //white area
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[300],
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Requests received',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        // Icon(Icons.home, color: Colors.green),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.home, color: Colors.green))
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                isThreeLine: true,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                      padding: EdgeInsets.all(6),
                                      color: Colors.orange,
                                      child: Icon(Icons.date_range,
                                          size: 25, color: Colors.white)),
                                ),
                                title: FutureBuilder<DocumentSnapshot>(
                                  future: requests.doc(userId).get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.data == null) {
                                      return Text('No request received');
                                    }
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Text(
                                        'Date: ' +
                                            DateFormat.yMMMMd('en_US')
                                                .format(data['Date'].toDate()),
                                        // data['Date'].toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return Text("loading");
                                  },
                                ),
                                subtitle: FutureBuilder<DocumentSnapshot>(
                                  future: requests.doc(userId).get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.data == null) {
                                      return Text('No request received');
                                    }
                                    if (snapshot.hasError) {
                                      return Text("Something went wrong");
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Text( 'Location: '+
                                        data['Location'] +
                                            '\nBin level: ' +
                                            data['Bin level']
                                        // .toString() , '$data["Bin level"]'
                                        // '\nBin level: $data["Bin level"]'
                                        // +
                                        // "\nLocation: $data['Location']"
                                        ,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }

                                    return Text("loading");
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
