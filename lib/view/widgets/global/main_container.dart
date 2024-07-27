import 'package:flutter/material.dart';
import 'package:teleprac/core/const/decoration.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    super.key,
    required this.children,
    this.scrollPhysics =
        const BouncingScrollPhysics(parent: PageScrollPhysics()),
  });
  final List<Widget> children;
  final ScrollPhysics? scrollPhysics;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppDecoration.bg_0),
          fit: BoxFit.fill,
        ),
      ),
      child: ListView(
        physics: scrollPhysics,
        children: children,
      ),
    );
  }
}
