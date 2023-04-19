import 'package:rive/rive.dart';

class RiveAvatar {
  RiveAvatar({required this.motion});
  String? motion;
  SMITrigger? animate;

  void onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    animate = controller.findInput<bool>(motion!) as SMITrigger;
  }

  void hitAnimation() => animate!.fire();

}
