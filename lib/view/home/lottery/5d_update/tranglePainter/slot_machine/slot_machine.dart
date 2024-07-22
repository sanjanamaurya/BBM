import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tiranga/res/aap_colors.dart';

class SlotMachineNumberController {
  const SlotMachineNumberController({
    required this.start,
    required this.stop,
  });

  final void Function({required int hitRollItemIndex}) start;
  final void Function({required int reelIndex, required int resultIndex}) stop;
}

class SlotMachineNumber extends StatefulWidget {
  const SlotMachineNumber({
    Key? key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 300,
    this.height = 100, //235
    this.reelWidth = 50,
    this.reelHeight = 100, //245
    this.reelItemExtent = 65,
    this.reelSpacing = 8,
    required this.onCreated,
    required this.onFinished,
  }) : super(key: key);

  final List<RollItemNumber> rollItems;
  final int multiplyNumberOfSlotItems;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final void Function(SlotMachineNumberController) onCreated;
  final void Function(List<int> resultIndexes) onFinished;

  @override
  State<SlotMachineNumber> createState() => _SlotMachineNumberState();
}

class _SlotMachineNumberState extends State<SlotMachineNumber> {
  late SlotMachineNumberController _slotMachineController;
  late final Map<int, _ReelController> _reelControllers = {};
  late final List<int> _resultIndexes = [];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    _slotMachineController = SlotMachineNumberController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  List<RollItemNumber> _generateRollItems() {
    return List.generate(widget.rollItems.length, (index) {
      return widget.rollItems[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Padding(
                padding:
                    EdgeInsets.only(right: index < 4 ? widget.reelSpacing : 0),
                child: _Reel(
                  reelWidth: widget.reelWidth,
                  reelHeight: widget.reelHeight,
                  itemExtent: widget.reelItemExtent,
                  rollItems: _generateRollItems(),
                  shuffle: widget.shuffle,
                  onCreated: (lc) => _reelControllers[index] = lc,
                  color: index == 0
                      ? AppColors.gradientFirstColor
                      : const Color(0xffacafc2),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  void _start({required int hitRollItemIndex}) {
    _stopCounter = 0;
    _resultIndexes.clear();
    // Extract each digit of the input number
    for (int i = 4; i >= 0; i--) {
      _resultIndexes.add((hitRollItemIndex ~/ pow(10, i)) % 10);
    }
    // Start each reel
    _reelControllers.forEach((key, lc) {
      lc.start();
    });

    // Stop each reel with a slight delay between each stop
    for (int i = 0; i < _reelControllers.length; i++) {
      Future.delayed(Duration(seconds: 2 + i), () {
        _stop(reelIndex: i, resultIndex: _resultIndexes[i]);
      });
    }
  }

  void _stop({required int reelIndex, required int resultIndex}) {
    if (reelIndex < 0 || reelIndex >= _reelControllers.length) {
      print("Error: Invalid reelIndex: $reelIndex");
      return;
    }

    final lc = _reelControllers[reelIndex];
    if (lc == null) {
      print("Error: No controller found for reelIndex: $reelIndex");
      return;
    }

    lc.stop(to: resultIndex);

    _stopCounter++;
    if (_stopCounter == 5) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_resultIndexes);
      });
    }
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final void Function() start;
  final void Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
    required this.color,
  }) : super(key: key);

  final List<RollItemNumber> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final bool shuffle;
  final void Function(_ReelController) onCreated;
  final Color color;

  @override
  State<_Reel> createState() => __ReelState();
}

class __ReelState extends State<_Reel> {
  late Timer _timer;
  late _ReelController _laneController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);
  int _counter = 0;
  late List<RollItemNumber> _actualRollItems;

  @override
  void initState() {
    super.initState();
    _actualRollItems = List.from(widget.rollItems);
    if (widget.shuffle) _actualRollItems.shuffle();

    _laneController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_laneController);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.reelWidth,
      height: widget.reelHeight,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: widget.itemExtent,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: _actualRollItems.map((item) {
            return Container(
              color: const Color(0xff333333),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: widget.color,
                child: Center(
                  child: Text(
                    item.index.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _start() {
    _counter = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _scrollController.animateToItem(
        _counter,
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      _counter--;
    });
  }

  void _stop({required int to}) {
    _timer.cancel();
    final hitItemIndex =
        _actualRollItems.indexWhere((item) => item.index == to);

    final mod = (-_counter) % _actualRollItems.length - 1;
    final addCount = (_actualRollItems.length - mod) +
        (_actualRollItems.length - hitItemIndex) -
        1;

    _scrollController.animateToItem(
      _counter - addCount,
      duration: const Duration(milliseconds: 750),
      curve: Curves.decelerate,
    );
  }
}

class RollItemNumber {
  const RollItemNumber({
    required this.index,
  });

  final int index;
}
