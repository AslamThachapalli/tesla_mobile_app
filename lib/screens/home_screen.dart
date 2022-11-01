import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../constants.dart';
import '../home_controller.dart';
import '../models/TyrePsi.dart';
import 'components/components.dart';
import 'enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AnimationMixin {
  final HomeController _controller = HomeController();

  //current index = 1
  late AnimationController _batteryAnimationController;
  late Animation<Movie> _animationBatteryStatusScreen;

  //current index = 2
  late AnimationController _tempAnimationController;
  late Animation<Movie> _animationTempStatusScreen;

  //current index = 3
  late AnimationController _tyreAnimationController;
  late Animation<Movie> _animationTyreStatusScreen;
  late List<TyreProps> _tyreAnimations;

  void setUpBatteryAnimation() {
    _batteryAnimationController = createController();

    _animationBatteryStatusScreen = MovieTween()
        .scene(begin: 0.milliseconds, end: 300.milliseconds)
        .tween(BatteryProps.battery, Tween<double>(begin: 0.0, end: 1.0))
        .thenFor(delay: 60.milliseconds, duration: 240.milliseconds)
        .tween(BatteryProps.batteryStatus, Tween<double>(begin: 50.0, end: 0.0))
        .tween(BatteryProps.opacity, Tween<double>(begin: 0.0, end: 1.0))
        .parent
        .animate(_batteryAnimationController);
  }

  void setUpTempAnimation() {
    _tempAnimationController = createController();

    _animationTempStatusScreen = MovieTween()
        .scene(begin: 300.milliseconds, end: 600.milliseconds)
        .tween(TempProps.carShift, Tween<double>(begin: 0.0, end: 1.0))
        .thenFor(delay: 75.milliseconds, duration: 300.milliseconds)
        .tween(TempProps.tempInfo, Tween<double>(begin: 60.0, end: 0.0))
        .tween(TempProps.opacity, Tween<double>(begin: 0.0, end: 1.0))
        .thenFor(delay: 75.milliseconds, duration: 450.milliseconds)
        .tween(TempProps.glow, Tween(begin: -150.0, end: 0.0))
        .parent
        .animate(_tempAnimationController);
  }

  void setUpTyreAnimation() {
    _tyreAnimationController = createController();

    _animationTyreStatusScreen = MovieTween()
        .scene(begin: 420.milliseconds, end: 600.milliseconds)
        .tween(TyreProps.tyre1psi, Tween<double>(begin: 0.0, end: 1.0))
        .thenTween(
          TyreProps.tyre2psi,
          Tween<double>(begin: 0.0, end: 1.0),
          duration: 192.milliseconds,
        )
        .thenTween(
          TyreProps.tyre3psi,
          Tween<double>(begin: 0.0, end: 1.0),
          duration: 192.milliseconds,
        )
        .thenTween(
          TyreProps.tyre4psi,
          Tween<double>(begin: 0.0, end: 1.0),
          duration: 192.milliseconds,
        )
        .parent
        .animate(_tyreAnimationController);
  }

  @override
  void initState() {
    setUpBatteryAnimation();
    setUpTempAnimation();
    setUpTyreAnimation();
    _tyreAnimations = [
      TyreProps.tyre1psi,
      TyreProps.tyre2psi,
      TyreProps.tyre3psi,
      TyreProps.tyre4psi,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController,
        _tyreAnimationController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                _batteryAnimationController.play(duration: 600.milliseconds);
              } else if (_controller.selectedBottomTab == 1 && index != 1) {
                _batteryAnimationController.reverse(from: 0.7);
              }

              if (index == 2) {
                _tempAnimationController.play(duration: 1500.milliseconds);
              } else if (_controller.selectedBottomTab == 2 && index != 2) {
                _tempAnimationController.reverse(from: 0.4);
              }

              if (index == 3) {
                _tyreAnimationController.play(duration: 1200.milliseconds);
              } else if (_controller.selectedBottomTab == 3 && index != 3) {
                _tyreAnimationController.reverse();
              }

              _controller.showTyresController(index);
              _controller.showTyrePsiController(index);

              _controller.onBottomTabNavigationChange(index);
            },
            selectedTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),

                    //Car
                    Positioned(
                      left: constrains.maxWidth /
                          2 *
                          _animationTempStatusScreen.value.get(TempProps.carShift),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),

                    //Door Locks
                    //right door lock
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.02
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLocked,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),

                    //left door lock
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.02
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLocked,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),

                    //bonnet door lock
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.15
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetDoorLocked,
                          press: _controller.updateBonnetDoorLock,
                        ),
                      ),
                    ),

                    //trunk door lock
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.18
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkDoorLocked,
                          press: _controller.updateTrunkDoorLock,
                        ),
                      ),
                    ),

                    //Battery
                    Opacity(
                      opacity: _animationBatteryStatusScreen.value.get(BatteryProps.battery),
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    //battery status
                    Positioned(
                      top: _animationBatteryStatusScreen.value.get(BatteryProps.batteryStatus),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatusScreen.value.get(BatteryProps.opacity),
                        child: BatteryStatus(
                          constrains: constrains,
                        ),
                      ),
                    ),

                    //Temperature buttons
                    Positioned(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      top: _animationTempStatusScreen.value.get(TempProps.tempInfo),
                      child: Opacity(
                        opacity: _animationTempStatusScreen.value.get(TempProps.opacity),
                        child: TempDetails(controller: _controller),
                      ),
                    ),

                    //Glow
                    Positioned(
                      right: _animationTempStatusScreen.value.get(TempProps.glow),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolBtnSelected
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                width: 200,
                                key: UniqueKey(),
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                width: 200,
                                key: UniqueKey(),
                              ),
                      ),
                    ),

                    if (_controller.showTyres) ...tyres(constrains),

                    if (_controller.isShowTypePsi)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: defaultPadding,
                              mainAxisSpacing: defaultPadding,
                              childAspectRatio: constrains.maxWidth / constrains.maxHeight),
                          itemBuilder: (context, index) => Transform.scale(
                            scale: _animationTyreStatusScreen.value.get(_tyreAnimations[index]),
                            child: TyrePsiCard(
                              isBottomTwoTyre: index > 1,
                              tyrePsi: demoPsiList[index],
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
