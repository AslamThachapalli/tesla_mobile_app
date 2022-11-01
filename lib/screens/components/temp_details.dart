import 'package:flutter/material.dart';
import 'package:tesla_animation_app/screens/components/temp_btn.dart';

import '../../constants.dart';
import '../../home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Row(
              children: [
                TempBtn(
                  svgImage: 'assets/icons/coolShape.svg',
                  text: 'cool',
                  isActive: _controller.isCoolBtnSelected,
                  onPress: _controller.updateCoolBtnSelection,
                ),
                const SizedBox(width: defaultPadding),
                TempBtn(
                  svgImage: 'assets/icons/heatShape.svg',
                  text: 'heat',
                  isActive: !_controller.isCoolBtnSelected,
                  onPress: _controller.updateCoolBtnSelection,
                  activeColor: redColor,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: _controller.incrementTemp,
                icon: const Icon(
                  Icons.arrow_drop_up,
                  size: 48,
                ),
              ),
              Text(
                "${_controller.currentTemp}" "\u2103",
                style: const TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: _controller.decrementTemp,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 48,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "Current Temperature".toUpperCase(),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'inside'.toUpperCase(),
                  ),
                  Text(
                    "22" "\u2103",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                children: [
                  Text(
                    'outside'.toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "36" "\u2103",
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
