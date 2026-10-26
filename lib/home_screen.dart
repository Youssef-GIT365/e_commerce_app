import 'dart:async';

import 'package:e_commerce_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class carousol extends StatefulWidget {
  const new({super.key});

  @override
  State<carousol> createState() => _carousolState();
}

class _carousolState extends State<carousol> {
  late final PageController _pagecontroller;
  Timer? _timer;
  int _currentIndex = 0;
  List colors = [Colors.blue, Colors.orange, Colors.green, Colors.purple];
  @override
  void initState() {
    super.initState();
    _pagecontroller = PageController();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _currentIndex = (_currentIndex + 1) % colors.length;
      _pagecontroller.animateToPage(
        _currentIndex,
        duration: Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (BuildContext context) => Controller(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.7,
                child: PageView.builder(
                  onPageChanged: (value) {
                    context.read<Controller>().increament(value);
                  },
                  controller: _pagecontroller,
                  itemCount: colors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: width * 0.5,
                          child: Row(
                            children: List.generate(colors.length, (index) {
                              return AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: _currentIndex == index ? 20 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? Colors.black
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
