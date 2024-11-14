import 'package:flutter/material.dart';

class textFieldModel extends StatelessWidget {
  const textFieldModel({
    super.key,
    required this.size,
    required this.arrowsUp, required this.title,
  });

  final String title;
  final Size size;
  final TextEditingController arrowsUp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            margin: EdgeInsets.only(top: size.height * 0.005),
            width: size.width * 0.9,
            height: size.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(
                  width: size.width * 0.003, color: const Color(0xff2D148F)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(

              controller: arrowsUp,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Escribe aqui...",
                hintStyle: TextStyle(
                  fontFamily: "mxlight",
                  fontSize: ((size.width + size.height) / 2 * 0.025),
                  color: const Color(0xff676565),
                  height: 1.5,
                ),
                contentPadding: const EdgeInsets.only(top: 6.0),
                isCollapsed: true,
                alignLabelWithHint: true,
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.03,
            bottom: size.height * 0.05,
            width: size.width * 0.34,
            height: size.height * 0.018,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              color: Colors.white,
              child: Text(
                title,
                style: TextStyle(
                    color: const Color(0xff2D148F),
                    fontSize: ((size.width + size.height) / 2) * 0.02,
                    fontFamily: 'mxlight'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
