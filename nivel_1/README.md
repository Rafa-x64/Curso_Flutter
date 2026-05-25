# Resumen Nivel 1 — Cimientos de Ingeniería

## **Para cerrar este nivel, un breve resumen:** 

## 1. El Ecosistema y Punto de Entrada

Flutter no es un framework que manipula componentes nativos; es un motor que dibuja píxel por píxel usando **Impeller/Skia**

Tu aplicación comienza estrictamente en la función `main()`, que ejecuta `runApp()`, encargada de montar el **árbol de widgets** en la memoria del dispositivo

```dart

//flutter no redibuja los componetes nativos de cada SO, dibuja sobre un lienzo en blanco pixel por pixel. esta libreria contiene las herrameintas para dibujar la interfaz con el diseño "Materia design de Google"
import 'package:flutter/material.dart';

//punto de entrada principal de la app en la que se monta la clase MyApp. No importa el orden a a hora de declarar o llamar funciones (al igual que en JS)
void main() => runApp(const MyApp());
```

> Es el equivalente al **hoisting de funciones** en JS/TS: el compilador lee todo el archivo antes de arrancar.

## 2. Estructura de la Vista (Anidación Declarativa)

La interfaz se construye por `composición` (como piezas de Lego) y no por `imperativas` paso a paso:

- **MaterialApp**: Es el cerebro de la app. Configura temas, navegación y localización.

- **Scaffold**: Es el esqueleto visual. Provee el lienzo blanco, soporte para barras superiores y cuerpos.

- **Widgets de Disposición (`Center`, `Column`)**: Controlan el flujo espacial de sus hijos (child o children).

- **BuildContext**: Es el **"acta de nacimiento"** del widget. Indica su posición exacta en el árbol jerárquico para heredar estilos o navegar.

```dart

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
```

## 3. StatelessWidget: Inmutabilidad de Alto Rendimiento

Un StatelessWidget es una estructura ligera. Se asemeja a una `función pura` en **programación funcional**: dada la misma entrada, siempre produce el mismo output visual y no mantiene un estado interno que **cambie** tras ser renderizado.

```dart

class MyApp extends StatelessWidget { //puede heredar de statelesswidget o statefullwidget
//asigna un identificador para este widget en el arbol de widgets para saber cual es cual en el arbol gerarquico. una vez asignado el ID se creara una sola vez
  const MyApp({
    super.key,
  });

  //el override se coloca porque la funcion build es propia de la clase abstracta StatelessWidget
  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
        .
        .
        .  
    );
  }
}
```

> Es el equivalente a un componente funcional estático en **React**.

## 4. Gestión de Memoria y Variables
**Dart** es fuertemente tipado. La eficiencia de tu app depende de cómo gestiones la **inmutabilidad**:
Tipos Primitivos: 

- `String` (UTF-16).
- `int/double` (64 bits).
- `bool` (solo true/false, sin valores "truthy" como en JS).

- `final` (Runtime): La variable se asigna una vez cuando el código pasa por esa línea. Es el estándar para datos de APIs o bases de datos

- `const` (Compile-time): El valor se congela antes de que la app corra. 

> **Flutter** reutiliza la misma instancia en RAM para todos los elementos `const` idénticos, reduciendo drásticamente el trabajo del recolector de basura (**Garbage Collector**)

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
