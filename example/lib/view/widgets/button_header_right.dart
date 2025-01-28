import 'package:flutter/material.dart';

class ButtonHeaderRight extends StatelessWidget {
  final String? title;
  final String? button;
  final Function()? onTapBtn;
  const ButtonHeaderRight({super.key, this.title, this.button, this.onTapBtn});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8), // Thiết lập BorderRadius
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTapBtn ?? () {},
              child: Text(
                title ?? "",
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Quicksand",
                    fontSize: (14),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }
}
