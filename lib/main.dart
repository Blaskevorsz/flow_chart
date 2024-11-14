// ignore_for_file: unnecessary_new

import 'package:flow_chart/widgets/text_field_model.dart';
import 'package:flutter/material.dart';

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

class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController arrowsUp = TextEditingController();
    TextEditingController arrowsDown = TextEditingController();
    TextEditingController lineLenght = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: size.height * 0.05,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              width: size.width * 0.9,
              height: size.height * 0.3,
              color: Colors.transparent,
              child: CustomPaint(
                painter: FlowChartPainter(),
              ),
            ),
            SizedBox(height: size.height * 0.05,),
            textFieldModel(size: size, arrowsUp: lineLenght, title: 'Longitud',),
            SizedBox(height: size.height * 0.05,),
            textFieldModel(size: size, arrowsUp: arrowsUp, title: 'Flechas arriba',),
            SizedBox(height: size.height * 0.05,),
            textFieldModel(size: size, arrowsUp: arrowsDown, title: 'Flechas abajo',),
            
          ],
        ),
      ),
    );
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
    pathArrowUp.moveTo(size.width / 3 * 1, size.height * 0.2);
    pathArrowUp.lineTo(size.width / 3 * 1, size.height * 0.45);

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
    pathArrowDown.moveTo(size.width / 3 * 2, size.height * 0.8);
    pathArrowDown.lineTo(size.width / 3 * 2, size.height * 0.55);

    canvas.drawPath(pathArrowDown, paintArrowDown);

    //prueba para colocar los numeros

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    final textSpan = TextSpan(
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

    //posicion de la fecha, si es flecha abajo 0.75, si es flecha arriba 0.25
    final textArrowDown = Offset(size.width / 3 * 2, size.height * 0.8);
    final textArrowUp = Offset(size.width / 3 * 1, size.height * 0.13);
    textPainter.paint(canvas, textArrowDown);
    textPainter.paint(canvas, textArrowUp);
  }

  @override
  bool shouldRepaint(FlowChartPainter oldDelegate) => false;
}
