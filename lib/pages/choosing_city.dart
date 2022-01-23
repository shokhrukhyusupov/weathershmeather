import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_bloc.dart';
import 'package:weathershmeather/bloc/maps_bloc/maps_event.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weathershmeather/bloc/weather_bloc/weather_event.dart';

class ChoosingCity extends StatelessWidget {
  const ChoosingCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot<Map<String, dynamic>>> places = FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .collection('address')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              color: Colors.black54,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text('Сhoosing a city',
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal)),
          elevation: 1),
      body: Column(children: [
        StreamBuilder<QuerySnapshot>(
          stream: places,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final verifyData = FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .collection('address');
              final data = snapshot.requireData;
              var listData = [];
              for (var i = 0; i < data.size; i++) {
                if (listData.contains(data.docs[i]['formattedAddress'])) {
                  verifyData.doc(data.docs[i].id).delete();
                } else {
                  listData.add(data.docs[i]['formattedAddress']);
                }
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: data.size + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          ListTile(
                              leading: const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(Icons.my_location_rounded,
                                      color: Colors.white, size: 16)),
                              title: Row(children: const [
                                Text('Auto-detection',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                Icon(Icons.location_on,
                                    color: Colors.red, size: 16)
                              ]),
                              trailing:
                                  Switch(value: true, onChanged: (value) {})),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(data.docs[index - 1]['formattedAddress']),
                      onTap: () {
                        BlocProvider.of<MapsBloc>(context).add(
                            SelectedLocationRequested(
                                data.docs[index - 1]['formattedAddress']));
                        BlocProvider.of<WeatherBloc>(context).add(
                            WeatherCurrentPositionRequested(
                                data.docs[index - 1]['lat'].toString(),
                                data.docs[index - 1]['lng'].toString()));
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}
