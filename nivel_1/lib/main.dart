//flutter no redibuja los componetes nativos de cada SO, dibuja sobre un lienzo en blanco pixel por pixel. esta libreria contiene las herrameintas para dibujar la interfaz con el diseño "Materia design de Google"
import 'package:flutter/material.dart';

//punto de entrada principal de la app en la que se monta la clase MyApp. No importa el orden a a hora de declarar o llamar funciones (al igual que en JS)
void main() => runApp(const CalcularInversion());

//la clase MyApp hereda de la clase StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  }); //asigna un identificador para este widget en el arbol de widgets para saber cual es cual en el arbol gerarquico. una vez asignado el ID se creara una sola vez

  //el override se coloca porque la funcion build es propia de la clase abstracta StatelessWidget
  @override
  Widget build(BuildContext context) {
    //Widget = Tipo de retorno de la funcion, build = funcion, (BuildContext context) = parametros superimportantes que le indican al flutter en donde se ubica el widget en el arbol gerarquico. Tecnicamente el acta de nacimiento... se usara mas adelante para cambiar de pantallas, cambiar disposicion de pantalla luego de compilar y heredar estilos
    return const MaterialApp(
      //MaterialApp se encarga de retornar el widget para que pueda ser utilizado
      home: Scaffold(
        //home: scaffold es la pantalla en blanco que se muestra al compilar (osea el lienzo en blanco)
        body: Center(
          //body: center es el contenedor el cual su unico proposito es que el child que esta dentro este centrado
          child: Text(
            "hola mundo",
          ), //child: Text es la salida de texto en pantalla
        ),
      ),
    );
  }
}
//practica
class AplicacionMetricas extends StatelessWidget {
  const AplicacionMetricas({super.key});

  @override
  Widget build(BuildContext context) {
    final int peticionesTotales = 10000;
    final int peticionesFallidas = 1250;
    final double tasaError = (peticionesFallidas / peticionesTotales) * 100;
    return MaterialApp(
      //si las variables acceden a funciones de tipo Object el retorno no puede ser const
      home: Scaffold(
        body: Center(
          child: Text(
            "tasa de Error crítico: ${tasaError.toStringAsFixed(2)}%",
          ),
        ),
      ),
    );
  }
}
//mini proyecto propuesto
class CalcularInversion extends StatelessWidget {
  const CalcularInversion({super.key});

  @override
  Widget build(BuildContext context) {
    const double tasaInteres = 0.10;
    final double montoInicial = 100.50;
    final double montoFinal = montoInicial * (1 + tasaInteres) ;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('monto final de la inversion ${montoFinal.toStringAsFixed(2)}')
        ),
      ),
    );
  }
}
