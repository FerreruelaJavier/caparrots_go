import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FireBase extends ChangeNotifier {
  getCaparrots() async {
    var url = Uri.https(
        "https://caparrots-ed3ff-default-rtdb.europe-west1.firebasedatabase.app/Caparrots.json");

    final result = await http.get(url);
  }
}
