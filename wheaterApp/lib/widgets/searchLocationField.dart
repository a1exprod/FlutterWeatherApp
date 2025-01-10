import 'package:flutter/material.dart';

class SearchLocation extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;

  const SearchLocation({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          width: 200,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter City Name',
              border: OutlineInputBorder(),
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 10),


        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onSearch(controller.text);
            }
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
