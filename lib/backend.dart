import 'dart:io';

void main() {
  int? width;

  stdout.write('Ingrese el tamaño del diagrama: ');

  String? input = stdin.readLineSync();

  if (input != null && input.isNotEmpty) {
    try {
      width = int.parse(input);

      if (width <= 0) {
        throw StateError('Número no válido: debe ser mayor que cero.');
      }

      print('El tamaño del diagrama es: $width');
      List<double> arriba = List.filled(width, 0.0);
      List<double> abajo = List.filled(width, 0.0);
      print('Lista arriba: $arriba');
      print('Lista abajo: $abajo');

      int op = 0;
      do {
        stdout.write(
            'Ingrese #0 Ver listas, Ingrese #1 flecha-arriba, #2 flecha-abajo o #3 para salir: ');
        String? opcion = stdin.readLineSync();

        if (opcion != null && int.tryParse(opcion) != null) {
          int opc = int.parse(opcion);

          switch (opc) {
            case 0:
              print('Lista arriba: $arriba');
              print('Lista abajo: $abajo');
              break;
            case 1:
              modificarLista(arriba, 'arriba');
              break;
            case 2:
              modificarLista(abajo, 'abajo');
              break;
            case 3:
              op = 3;
              print('Saliendo del programa...');
              break;
            default:
              print('Opción no válida, intente de nuevo.');
          }
        } else {
          print('Por favor, ingrese una opción válida.');
        }
      } while (op != 3);
    } catch (e) {
      print('Error: ${e.toString()}. Por favor, ingrese un número válido.');
    }
  } else {
    print('No se ingresó un tamaño válido.');
  }
}

void modificarLista(List<double> lista, String nombreLista) {
  int opc = 0;
  do {
    stdout.write('Ingrese #1 para ingresar valor o #2 para salir: ');
    String? opcion = stdin.readLineSync();

    if (opcion != null && int.tryParse(opcion) != null) {
      opc = int.parse(opcion);

      if (opc == 1) {
        stdout.write('Ingrese el índice (0 a ${lista.length - 1}): ');
        String? pe = stdin.readLineSync();

        if (pe != null && int.tryParse(pe) != null) {
          int periodo = int.parse(pe);

          if (periodo >= 0 && periodo < lista.length && lista[periodo] == 0) {
            stdout.write('Ingrese valor para la lista $nombreLista: ');
            String? va = stdin.readLineSync();

            if (va != null && double.tryParse(va) != null) {
              double valor = double.parse(va);
              lista[periodo] = valor;
              print('Lista $nombreLista actualizada: $lista');
            } else {
              print('Valor no válido.');
            }
          } else {
            print('Índice fuera de rango o ya tiene un valor asignado');
          }
        } else {
          print('Por favor, ingrese un número válido para el índice.');
        }
      } else if (opc != 2) {
        print('Opción no válida.');
      }
    } else {
      print('Por favor, ingrese una opción válida.');
    }
  } while (opc != 2);
}