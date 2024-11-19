// ignore_for_file: unnecessary_new

import 'package:flow_chart/widgets/text_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:toastification/toastification.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const MyPage(),
      ),
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
  Map<int, TextEditingController> positionControllers = {};
  Map<int, TextEditingController> valueControllers = {};
  Map<int, TextEditingController> positionControllersDown = {};
  Map<int, TextEditingController> valueControllersDown = {};

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
      appBar: AppBar(
          title: const Text('Eco Flow Chart:)'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.02,
            fontFamily: 'msbold',
          )),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              width: size.width * 0.9,
              height: size.height * 0.45,
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
                                        Center(
                                          child: SizedBox(
                                            width: size.width * 0.25,
                                            child: TextField(
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  signed: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp(r'^-?\d*$'),
                                                ),
                                              ],
                                              enabled: !isDisabled,
                                              controller: lineLengthController,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'msbold'),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'mregular'),
                                                hintText: 'Ingresa algo...',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal:
                                                            size.width * 0.05,
                                                        vertical:
                                                            size.height * 0.02),
                                                labelText: 'Longitud',
                                                labelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'mbold'),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.5),
                                                ),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                              ),
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton.extended(
                                            backgroundColor: isDisabled ||
                                                    lineLengthController
                                                        .text.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            onPressed: isDisabled ||
                                                    lineLengthController
                                                        .text.isEmpty
                                                ? null
                                                : () {
                                                    if (lineLengthController
                                                        .text
                                                        .contains('-')) {
                                                      showNotification(
                                                          size,
                                                          'Error',
                                                          'La longitud debe ser un numero valido',
                                                          Icons
                                                              .no_encryption_rounded,
                                                          Colors.red);
                                                    } else {
                                                      setState(() {
                                                        isDisabled = true;
                                                      });
                                                      setlength();
                                                      showNotification(
                                                          size,
                                                          'Exito!',
                                                          'Longitud establecida correctamente',
                                                          Icons.check,
                                                          Colors.green);
                                                    }
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
                                          enabled: isDisabled,
                                          size: size,
                                          arrowsController:
                                              arrowPositionController,
                                          title: 'Posicion',
                                        ),
                                        TextFieldModel(
                                            enabled: isDisabled,
                                            size: size,
                                            arrowsController:
                                                arrowValueController,
                                            title: 'Valor'),
                                        FloatingActionButton(
                                            backgroundColor: !isDisabled
                                                ? Colors.grey
                                                : Colors.green,
                                            onPressed: !isDisabled
                                                ? null
                                                : () {
                                                    if (arrowPositionController
                                                            .text
                                                            .contains('-') ||
                                                        arrowPositionController
                                                            .text.isEmpty ||
                                                        int.parse(
                                                                arrowPositionController
                                                                    .text) >
                                                            lineWidth ||
                                                        int.parse(
                                                                arrowPositionController
                                                                    .text) <
                                                            0) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir una posicion valida',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else if (arrowValueController
                                                        .text.isEmpty) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir un valor valido',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else {
                                                      addArrowUp();
                                                      showNotification(
                                                          size,
                                                          'Exito!',
                                                          'Flecha agregada correctamente',
                                                          Icons.check,
                                                          Colors.green);
                                                    }
                                                  },
                                            child: const Icon(Icons
                                                .keyboard_double_arrow_up_rounded)),
                                        FloatingActionButton(
                                            backgroundColor: !isDisabled
                                                ? Colors.grey
                                                : Colors.red,
                                            onPressed: !isDisabled
                                                ? null
                                                : () {
                                                    if (arrowPositionController
                                                            .text.isEmpty ||
                                                        int.parse(
                                                                arrowPositionController
                                                                    .text) >
                                                            lineWidth ||
                                                        int.parse(
                                                                arrowPositionController
                                                                    .text) <
                                                            0) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir una posicion valida',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else if (arrowValueController
                                                        .text.isEmpty) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir un valor valido',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else {
                                                      addArrowDown();
                                                      showNotification(
                                                          size,
                                                          'Exito!',
                                                          'Flecha agregada correctamente',
                                                          Icons.check,
                                                          Colors.green);
                                                    }
                                                  },
                                            child: const Icon(Icons
                                                .keyboard_double_arrow_down_rounded)),
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
                                                        getOrCreateController(
                                                      positionControllers,
                                                      index,
                                                      listUp[index]['position'],
                                                    ),
                                                    title:
                                                        '#${listUp[index]['position']}'),
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        getOrCreateController(
                                                      valueControllers,
                                                      index,
                                                      listUp[index]['value'],
                                                    ),
                                                    title:
                                                        '#${listUp[index]['position']}'),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      listUp.removeAt(index);
                                                      positionControllers[index]
                                                          ?.dispose();
                                                      valueControllers[index]
                                                          ?.dispose();
                                                      positionControllers
                                                          .remove(index);
                                                      valueControllers
                                                          .remove(index);
                                                    });
                                                    showNotification(
                                                        size,
                                                        'Exito!',
                                                        'Eliminado correctamente',
                                                        Icons.check,
                                                        Colors.green);
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    if (positionControllers[
                                                                index]!
                                                            .text
                                                            .isEmpty ||
                                                        positionControllers[
                                                                index]!
                                                            .text
                                                            .contains('-') ||
                                                        int.parse(
                                                                positionControllers[
                                                                        index]!
                                                                    .text) >
                                                            lineWidth ||
                                                        int.parse(
                                                                positionControllers[
                                                                        index]!
                                                                    .text) <
                                                            0) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debes ingresar una posicion valida para actualizar',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else if (valueControllers[
                                                            index]!
                                                        .text
                                                        .isEmpty) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir un valor valido',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else {
                                                      setState(() {
                                                        listUp[index]
                                                                ['position'] =
                                                            positionControllers[
                                                                        index]
                                                                    ?.text ??
                                                                '';
                                                        listUp[index]['value'] =
                                                            valueControllers[
                                                                        index]
                                                                    ?.text ??
                                                                '';
                                                      });
                                                      showNotification(
                                                          size,
                                                          'Exito!',
                                                          'Actualizado correctamente',
                                                          Icons.check,
                                                          Colors.green);
                                                    }
                                                  },
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
                                                        getOrCreateController(
                                                      positionControllersDown,
                                                      index,
                                                      listDown[index]
                                                          ['position'],
                                                    ),
                                                    title:
                                                        '#${listDown[index]['position']}'),
                                                TextFieldModel(
                                                    enabled: true,
                                                    size: size,
                                                    arrowsController:
                                                        getOrCreateController(
                                                      valueControllersDown,
                                                      index,
                                                      listDown[index]['value'],
                                                    ),
                                                    title:
                                                        '#${listDown[index]['position']}'),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      listDown.removeAt(index);
                                                    });
                                                    showNotification(
                                                        size,
                                                        'Exito!',
                                                        'Eliminado correctamente',
                                                        Icons.check,
                                                        Colors.green);
                                                  },
                                                  backgroundColor: Colors.red,
                                                  child:
                                                      const Icon(Icons.delete),
                                                ),
                                                FloatingActionButton(
                                                  onPressed: () {
                                                    if (positionControllersDown[
                                                                index]!
                                                            .text
                                                            .isEmpty ||
                                                        positionControllersDown[
                                                                index]!
                                                            .text
                                                            .contains('-') ||
                                                        int.parse(
                                                                positionControllersDown[
                                                                        index]!
                                                                    .text) >
                                                            lineWidth ||
                                                        int.parse(
                                                                positionControllersDown[
                                                                        index]!
                                                                    .text) <
                                                            0) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debes ingresar una posicion valida para actualizar',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else if (valueControllersDown[
                                                            index]!
                                                        .text
                                                        .isEmpty) {
                                                      showNotification(
                                                          size,
                                                          'Aviso',
                                                          'Debe introducir un valor valido',
                                                          Icons.warning_rounded,
                                                          Colors.orange);
                                                    } else {
                                                      setState(() {
                                                        listDown[index]
                                                                ['position'] =
                                                            positionControllersDown[
                                                                        index]
                                                                    ?.text ??
                                                                '';
                                                        listDown[index]
                                                                ['value'] =
                                                            valueControllersDown[
                                                                        index]
                                                                    ?.text ??
                                                                '';
                                                      });
                                                      showNotification(
                                                          size,
                                                          'Exito!',
                                                          'Actualizado correctamente',
                                                          Icons.check,
                                                          Colors.green);
                                                    }
                                                  },
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
                            selectedPage = 0;
                            _pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceIn);
                            showNotification(
                                size,
                                'Exito!',
                                'Todo se reinicio correctamente',
                                Icons.check,
                                Colors.green);
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

  TextEditingController getOrCreateController(
      Map<int, TextEditingController> controllers,
      int index,
      String initialValue) {
    if (!controllers.containsKey(index)) {
      controllers[index] = TextEditingController(text: initialValue);
    }
    return controllers[index]!;
  }

  void setlength() {
    if (int.tryParse(lineLengthController.text) != null) {
      setState(() {
        lineWidth = int.parse(lineLengthController.text);
      });
    }
  }

  void addArrowUp() {
    listUp.add({
      'position': arrowPositionController.text,
      'value': arrowValueController.text
    });

    setState(() {
      int index = listUp.length - 1;
      positionControllers[index] =
          TextEditingController(text: arrowPositionController.text);
      valueControllers[index] =
          TextEditingController(text: arrowValueController.text);
      arrowPositionController.clear();
      arrowValueController.clear();
    });
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

  void showNotification(size, title, description, icon, iconColor) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 2),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: size.height * 0.02,
          fontFamily: 'msbold',
        ),
      ),
      description: RichText(
          text: TextSpan(
        text: description,
        style: TextStyle(
          color: Colors.black,
          fontSize: size.height * 0.015,
          fontFamily: 'mregular',
        ),
      )),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: Icon(icon),
      showIcon: true,
      primaryColor: iconColor,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
    );
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
    _drawNumbers(canvas, size);

    for (var arrow in arrowsData) {
      bool isUp = arrow['isUp'];
      double xPosition = size.width / lineWidth * int.parse(arrow['position']);
      String value = arrow['value'].toString();
      _drawArrow(canvas, size, xPosition, isUp, value);
    }
  }

  void _drawNumbers(Canvas canvas, Size size) {
    int counter = 0;

    for (int i = 0; i <= lineWidth; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: counter.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
          size.width / lineWidth * i - (textPainter.width / 2),
          size.height * 0.52);

      textPainter.paint(canvas, textOffset);
      counter++;
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
