import 'package:flutter/material.dart';

import '../../constanins.dart';
import '../../models/TyrePsi.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  }) : super(key: key);

  final bool isBottomTwoTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: tyrePsi.isLowPressure ? redColor : primaryColor, width: 2)),
      child: isBottomTwoTyre
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tyrePsi.isLowPressure ? lowPressureText(context) : const SizedBox.shrink(),
                const Spacer(),
                psiText(context, psi: tyrePsi.psi.toString()),
                const SizedBox(height: defaultPadding),
                Text(
                  "${tyrePsi.temp}\u2103",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                psiText(context, psi: tyrePsi.psi.toString()),
                const SizedBox(height: defaultPadding),
                Text(
                  "${tyrePsi.temp}\u2103",
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                tyrePsi.isLowPressure ? lowPressureText(context) : const SizedBox.shrink(),
              ],
            ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "low".toUpperCase(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          "pressure".toUpperCase(),
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
      TextSpan(
          text: psi,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
          children: const [
            TextSpan(
              text: "psi",
              style: TextStyle(fontSize: 24),
            )
          ]),
    );
  }
}
