import 'package:flutter/material.dart';

class SearchTransporter extends StatefulWidget {
  const SearchTransporter({super.key});

  @override
  State<SearchTransporter> createState() => _SearchTransporterState();
}

class _SearchTransporterState extends State<SearchTransporter> {
  final TextEditingController _searchTransporterText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 181, 135),
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: 345.0,
            child: TextField(
              textAlign: TextAlign.start,
              controller: _searchTransporterText,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: Colors.black45,
              style: TextStyle(color: Colors.black.withOpacity(0.9)),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search_rounded,
                  ),
                ),
                labelText: "Search",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
              keyboardType: true
                  ? TextInputType.visiblePassword
                  : TextInputType.emailAddress,
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
