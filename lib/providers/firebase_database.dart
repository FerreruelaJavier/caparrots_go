// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List caparrots = [];

  Future getCaparrots() async {
    CollectionReference collectionCaparrots = db.collection("Caparrots");

    QuerySnapshot queryCaparrots = await collectionCaparrots.get();

    queryCaparrots.docs.forEach((element) {
      caparrots.add(element.data());
    });

    notifyListeners();
  }
}
