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
                painter: FlowChartPainter(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  Container(
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
                                        textFieldModel(
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
                                            onPressed: () {
                                              isDisabled == true
                                                  ? null
                                                  : setState(() {
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
                                        textFieldModel(
                                          enabled: true,
                                          size: size,
                                          arrowsController:
                                              arrowPositionController,
                                          title: 'Posicion',
                                        ),
                                        textFieldModel(
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
                                                textFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowPositionController,
                                                    title: '#$index'),
                                                textFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowValueController,
                                                    title: '#$index'),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.black,
                                                  child: Icon(Icons.update),
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
                                                textFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowPositionController,
                                                    title: '#$index'),
                                                textFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        arrowValueController,
                                                    title: '#$index'),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.red,
                                                  child: Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {},
                                                  backgroundColor: Colors.black,
                                                  child: Icon(Icons.update),
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
          ],
        ),
      ),
    );
  }

  //funciones

  Map<int, Map<String, dynamic>> listUp = {};

  Map<int, Map<String, dynamic>> listDown = {};

  int lineWidth = 0;

  void setlength() {
    setState(() {
      lineWidth = int.parse(lineLengthController.text);
    });
    print('longitud: $lineWidth');
  }

  void addArrowUp() {
    listUp[indexadd2] = {};

    setState(() {
      listUp[indexadd2]!['position'] = arrowPositionController.text;
      listUp[indexadd2]!['value'] = arrowValueController.text;
    });

    indexadd2++;
    print(listUp[1]);
    print(arrowPositionController.text);
    print(indexadd2);
    arrowPositionController.text = '';
    arrowValueController.text = '';
  }

  void addArrowDown() {
    listDown[indexadd] = {};

    setState(() {
      listDown[indexadd]!['position'] = arrowPositionController.text;
      listDown[indexadd]!['value'] = arrowValueController.text;
    });

    indexadd++;
    print(listDown[6]);
    print(arrowPositionController.text);
    print(indexadd);
    arrowPositionController.text = '';
    arrowValueController.text = '';
  }

  void drawFlowChart () {

    for (var i = 0; i < listUp.length; i++) {
      
    }

  }


}

class FlowChartPainter extends CustomPainter {
  
  @override
  void paint(Canvas canvas, Size size) {
    //linea en la mitad del eje Y y todo el eje X
    final paintLine = new Paint();
    paintLine.color = Colors.black;
    paintLine.strokeWidth = 3;
    paintLine.style = PaintingStyle.stroke;
    paintLine.strokeCap = StrokeCap.round;

    final path = new Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paintLine);

    //flechas arriba

    final paintArrowUp = new Paint();
    paintArrowUp.color = Colors.green;
    paintArrowUp.strokeWidth = 2;
    paintArrowUp.style = PaintingStyle.stroke;
    paintArrowUp.strokeCap = StrokeCap.round;

    final pathArrowUp = new Path();

    pathArrowUp.moveTo(0, size.height * 0.5);
    pathArrowUp.moveTo(size.width / 3 * 1, size.height * 0.1);
    pathArrowUp.lineTo(size.width / 3 * 1, size.height * 0.4);

    canvas.drawPath(pathArrowUp, paintArrowUp);

    //flechas abajo

    final paintArrowDown = new Paint();
    paintArrowDown.color = Colors.red;
    paintArrowDown.strokeWidth = 2;
    paintArrowDown.style = PaintingStyle.stroke;
    paintArrowDown.strokeCap = StrokeCap.round;

    final pathArrowDown = new Path();

    //se saca la posicion con el tamanno del diagrama de flujo (3) y se multiplica por la posicion de la lista (2)
    pathArrowDown.moveTo(0, size.height * 0.5);
    pathArrowDown.moveTo(size.width / 3 * 2, size.height * 0.9);
    pathArrowDown.lineTo(size.width / 3 * 2, size.height * 0.6);

    canvas.drawPath(pathArrowDown, paintArrowDown);

    //prueba para colocar los numeros

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'mregular',
    );
    const textSpan = TextSpan(
      text: '20',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    //posicion de la fecha, si es flecha abajo 0.9, si es flecha arriba 0.55
    final textArrowDown = Offset(size.width / 3 * 2, size.height * 0.9);
    final textArrowUp = Offset(size.width / 3 * 1, size.height * 0.055);
    final textLine = Offset(size.width / 3 * 1, size.height * 0.5);
    textPainter.paint(canvas, textArrowDown);
    textPainter.paint(canvas, textArrowUp);
    textPainter.paint(canvas, textLine);
  }

  @override
  bool shouldRepaint(FlowChartPainter oldDelegate) => false;
}
