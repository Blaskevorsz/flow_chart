// ignore_for_file: unnecessary_new

import 'package:flow_chart/widgets/text_field_model.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({
    super.key,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  TextEditingController arrowPositionController = TextEditingController();
  TextEditingController arrowValueController = TextEditingController();
  TextEditingController lineLengthController = TextEditingController();
  int indexadd = 0;
  int indexadd2 = 0;
  bool isDisabled = false;
  int lineWidth = 0;
  bool isRemoved = false;
  int positionRemoved = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const pageCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              width: size.width * 0.9,
              height: size.height * 0.5,
              color: Colors.transparent,
              child: CustomPaint(
                painter: FlowChartPainter(arrowsData: [
                  for (int i = 0; i < listUp.length; i++)
                    {
                      'isUp': true,
                      'position': listUp[i]['position'],
                      'value': listUp[i]['value'],
                    },
                  for (int i = 0; i < listDown.length; i++)
                    {
                      'isUp': false,
                      'position': listDown[i]['position'],
                      'value': listDown[i]['value'],
                    },
                ], lineWidth: lineWidth),
                size: Size(size.width * 0.9, size.height * 0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                selectedPage = page;
                              });
                            },
                            children: List.generate(pageCount, (index) {
                              if (index == 0) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      height: size.height * 0.05,
                                      child: Text(
                                        'Introducir datos',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.height * 0.03,
                                          fontFamily: 'mregular',
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextFieldModel(
                                          enabled: !isDisabled,
                                          size: size,
                                          arrowsController:
                                              lineLengthController,
                                          title: 'Longitud',
                                        ),
                                        FloatingActionButton.extended(
                                            backgroundColor: isDisabled == true
                                                ? Colors.grey
                                                : Colors.black,
                                            onPressed: isDisabled
                                                ? null
                                                : () {
                                                    setState(() {
                                                      isDisabled = true;
                                                    });
                                                    setlength();
                                                  },
                                            label: Text(
                                              'Establecer',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.height * 0.02,
                                                fontFamily: 'mbold',
                                              ),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextFieldModel(
                                          enabled: true,
                                          size: size,
                                          arrowsController:
                                              arrowPositionController,
                                          title: 'Posicion',
                                        ),
                                        TextFieldModel(
                                            enabled: true,
                                            size: size,
                                            arrowsController:
                                                arrowValueController,
                                            title: 'Valor'),
                                        FloatingActionButton(
                                            backgroundColor: Colors.green,
                                            child: const Icon(Icons
                                                .keyboard_double_arrow_up_rounded),
                                            onPressed: () {
                                              addArrowUp();
                                            }),
                                        FloatingActionButton(
                                            backgroundColor: Colors.red,
                                            child: const Icon(Icons
                                                .keyboard_double_arrow_down_rounded),
                                            onPressed: () {
                                              addArrowDown();
                                            }),
                                      ],
                                    ),
                                  ],
                                );
                              } else if (index == 1) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      height: size.height * 0.05,
                                      child: Text(
                                        'Lista de flechas arriba',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.height * 0.03,
                                          fontFamily: 'mregular',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: listUp.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowPositionController,
                                                    title:
                                                        '#${listUp[index]['position']}'),
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowValueController,
                                                    title:
                                                        '#${listUp[index]['value']}'),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      listUp.removeAt(index);
                                                    });
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.black,
                                                  child:
                                                      const Icon(Icons.update),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.08,
                                                )
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                );
                              } else {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      height: size.height * 0.05,
                                      child: Text(
                                        'Lista de flechas abajo',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.height * 0.03,
                                          fontFamily: 'mregular',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: listDown.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowPositionController,
                                                    title:
                                                        '#${listDown[index]['position']}'),
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowValueController,
                                                    title:
                                                        '#${listDown[index]['value']}'),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      listDown.removeAt(index);
                                                    });
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.black,
                                                  child:
                                                      const Icon(Icons.update),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.08,
                                                )
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                );
                              }
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: PageViewDotIndicator(
                            currentItem: selectedPage,
                            count: pageCount,
                            unselectedColor: Colors.black26,
                            selectedColor: Colors.black,
                            duration: const Duration(milliseconds: 200),
                            boxShape: BoxShape.circle,
                            onItemClicked: (index) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: FloatingActionButton.extended(
                  backgroundColor: !isDisabled ? Colors.grey : Colors.black,
                  onPressed: !isDisabled
                      ? null
                      : () {
                          setState(() {
                            lineLengthController.text = '';
                            isDisabled = false;
                            lineWidth = 0;
                            listUp.clear();
                            listDown.clear();
                          });
                        },
                  label: Text(
                    'Restablecer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * 0.02,
                      fontFamily: 'mbold',
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  //funciones

  List<Map<String, dynamic>> listUp = [];
  List<Map<String, dynamic>> listDown = [];

  void setlength() {
    if (int.tryParse(lineLengthController.text) != null) {
      setState(() {
        lineWidth = int.parse(lineLengthController.text);
      });
    } else {
      // Mostrar un mensaje de error o manejar la entrada inválida
    }
  }

  void addArrowUp() {
    setState(() {
      listUp.add({
        'position': arrowPositionController.text,
        'value': arrowValueController.text,
      });
    });
    indexadd2++;
    arrowPositionController.clear();
    arrowValueController.clear();
  }

  void addArrowDown() {
    setState(() {
      listDown.add({
        'position': arrowPositionController.text,
        'value': arrowValueController.text,
      });
    });
    indexadd++;
    arrowPositionController.clear();
    arrowValueController.clear();
  }

  void drawFlowChart() {
    for (var i = 0; i < listUp.length; i++) {}
  }
}

class FlowChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> arrowsData;
  final int lineWidth;

  FlowChartPainter({
    required this.arrowsData,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawCentralLine(canvas, size);

    for (var arrow in arrowsData) {
      bool isUp = arrow['isUp'];
      double xPosition = size.width / lineWidth * int.parse(arrow['position']);
      String value = arrow['value'].toString();
      _drawArrow(canvas, size, xPosition, isUp, value);
    }
  }

  void _drawCentralLine(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paintLine);
  }

  void _drawArrow(
      Canvas canvas, Size size, double xPosition, bool isUp, String value) {
    final paintArrow = Paint()
      ..color = isUp ? Colors.green : Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pathArrow = Path();

    double yStart = isUp ? size.height * 0.1 : size.height * 0.9;
    double yEnd = isUp ? size.height * 0.4 : size.height * 0.6;

    pathArrow.moveTo(xPosition, yStart);
    pathArrow.lineTo(xPosition, yEnd);

    canvas.drawPath(pathArrow, paintArrow);

    final textPainter = TextPainter(
      text: TextSpan(
        text: value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textOffset = Offset(
        xPosition - (textPainter.width / 2), isUp ? yStart - 22 : yEnd + 135);
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
