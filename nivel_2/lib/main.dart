import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(const Main());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Row(
          //padre (equivalente a un div class="row")
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, //propiedades del row en e eje x
          crossAxisAlignment:
              CrossAxisAlignment.center, //propiedades del row en e eje y
          children: [
            //children se pone asi por que pueden ser uno o mas hijos si fura uno solo solo se pone child
            Icon(
              Icons.dns,
            ), //creacion de un icono (ya vienen incluidos al instalar flutter)
            Expanded(
              //expanded es un contenedor que hace que el hijo use todo el espacio disponible en el eje principal (x)
              child: Text(
                //otro child de tipo texto
                "Servidor de Producción Centralizado - Región Este",
                overflow: TextOverflow
                    .ellipsis, //a los childs tambien se le pueden poner propiedades
              ),
            ),
            const Text("activo"),
          ],
        ),
      ),
    );
  }
}

class WidgetDos extends StatelessWidget {
  const WidgetDos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text("Panel de metricas"),
        ),
      ),
    );
  }
}

class Edad extends StatelessWidget {
  const Edad({super.key});

  @override
  Widget build(BuildContext context) {
    String fechaNacimiento = '2006';
    int nacimiento = int.parse(fechaNacimiento);
    const int anoActual = 2026;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('año de nacimiento: $fechaNacimiento'),
              Text('año actual: $anoActual'),
              Text('Tu edad: ${anoActual - nacimiento}'),
            ],
          ),
        ),
      ),
    );
  }
}

class Propina extends StatelessWidget {
  const Propina({super.key});

  @override
  Widget build(BuildContext context) {
    num totalCount = 2150.50;
    num tipPercent = (15 / totalCount) * 100;
    num totalToPay = totalCount + tipPercent;
    const int persons = 4;
    num payPerPerson = totalToPay / persons;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Monto de a cuenta: ${totalCount.toStringAsFixed(2)}\$'),
                  Text('Propina a agregar: ${tipPercent.toStringAsFixed(2)}\$'),
                  Text('Total a pagar: ${totalToPay.toStringAsFixed(2)}\$'),
                  Text('Numero de personas: $persons'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Pago por personas: ${payPerPerson.toStringAsFixed(2)}\$',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CasoA extends StatelessWidget {
  const CasoA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.api, size: 48.0, color: Colors.white),
            Icon(Icons.accessibility_new, size: 48.0, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class CasoB extends StatelessWidget {
  const CasoB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: null, child: const Text('Boton 1')),
          OutlinedButton(onPressed: null, child: const Text('Boton 2')),
          TextButton(onPressed: null, child: const Text('Boton 3')),
        ],
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatusCard(titulo: 'CPU', valor: 20.5, color: Colors.blue,),
              const SizedBox(height: 40),
              StatusCard(titulo: 'RAM', valor: 40, color: Colors.red,),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String titulo;
  final num valor;
  final Color color;

  const StatusCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('$titulo: ${valor.toStringAsFixed(2)}%')],
      ),
    );
  }
}
