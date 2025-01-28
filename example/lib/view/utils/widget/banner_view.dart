import 'package:flutter/material.dart';

class BannerView extends StatefulWidget {
  final String image;

  const BannerView({Key? key, required this.image})
      : super(key: key);

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.fill,
                scale: 1.0,
                alignment: Alignment(-0.3, -1))),
      ),
    );
  }
}
