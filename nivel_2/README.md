# 🏛️ Flutter Arquitectura Nivel 2: Árbol de Widgets, Layouts y Modularidad

Este documento es tu guía definitiva para los fundamentos de UI en Flutter. Aquí repasaremos las reglas absolutas de renderizado, distribución espacial y las buenas prácticas de código limpio vistas en el **Nivel 2**, con ejemplos directos del código desarrollado.

---

## 1. La Regla de Oro del Renderizado

Si vienes del DOM en la web (HTML/CSS), debes resetear tu modelo mental. En Flutter:
> **Las restricciones bajan. Los tamaños suben. El padre establece la posición.**

Un widget no puede elegir libremente su tamaño en la pantalla; debe negociar con las restricciones (`constraints`) que le impone su widget padre.

---

## 2. Flexbox Nativo: `Row` y `Column`

Son los equivalentes directos a `display: flex` en CSS. No tienen representación visual (no tienen color ni bordes), solo dictan cómo se alinean sus hijos.

* **`Row`**: Apila elementos horizontalmente (`flex-direction: row`).
* **`Column`**: Apila elementos verticalmente (`flex-direction: column`).

### Parámetros de Alineación Críticos

* **`mainAxisAlignment`**: Controla el eje principal (X en `Row`, Y en `Column`).
    * `spaceBetween`: Separa los elementos hacia los extremos.
    * `center`: Agrupa todo en el centro.
* **`crossAxisAlignment`**: Controla el eje perpendicular (Y en `Row`, X en `Column`).
    * `stretch`: Fuerza a los hijos a ocupar todo el ancho/alto disponible del padre.

**Ejemplo en código (`CasoB`):** Botones expandidos usando `stretch`.
```dart
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
```

---

## 3. Control de Desbordamiento: `Expanded`

Cuando un elemento dentro de un `Row` o `Column` es demasiado grande o su texto es muy largo, romperá la pantalla (las famosas líneas amarillas y negras).

Para solucionarlo, envolvemos el widget problemático en un **`Expanded`**. Esto le dice al motor de renderizado: *"Toma todo el espacio sobrante que dejó el resto, pero no te salgas de los límites"*.

**Ejemplo en código (`MyApp`):** Manejo de Textos Largos.
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Icon(Icons.dns),
            Expanded(
              child: Text(
                "Servidor de Producción Centralizado - Región Este",
                overflow: TextOverflow.ellipsis, 
              ),
            ),
            const Text("activo"),
          ],
        ),
      ),
    );
  }
}
```
> [!NOTE]
> **Nota Clínica:** La propiedad `overflow: TextOverflow.ellipsis` añade los tres puntos `...` si el texto es más largo que el contenedor `Expanded`.

---

## 4. Contenedores y Espaciadores

En diseño web acostumbramos a usar `<div>` para todo. En Flutter, segmentamos las responsabilidades para optimizar el rendimiento.

### `Container` (El widget pesado)
Úsalo **solo** cuando necesites decoraciones visuales (fondos, bordes redondeados, sombras).

> [!CAUTION]
> **REGLA ABSOLUTA:** Si usas la propiedad `decoration: BoxDecoration()`, el color del fondo debe ir obligatoriamente dentro del `BoxDecoration`. Si lo pones fuera, la app crashea.

**Ejemplo en código (`WidgetDos`):**
```dart
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
```

### `SizedBox` y `Padding` (Los widgets ligeros)
* **`SizedBox`**: Úsalo para crear espacios vacíos entre elementos (ej. `const SizedBox(height: 40)`). Es infinitamente más rápido de procesar que un `Container` vacío.
* **`Padding`**: Úsalo cuando solo necesites darle "aire" a un elemento sin aplicarle fondos ni bordes.

---

## 5. Lógica Básica e Interpolación de Strings

Dentro del método `build` puedes declarar variables y realizar cálculos lógicos antes de retornar la interfaz.

**Ejemplo en código (`Edad` / `Propina`):**
```dart
String fechaNacimiento = '2006';
int nacimiento = int.parse(fechaNacimiento);
const int anoActual = 2026;

// Inyección de código en Strings:
Text('Tu edad: ${anoActual - nacimiento}')
```
* **Variables con `$`:** Insertamos el valor directo de una variable (ej. `$anoActual`).
* **Expresiones con `${}`:** Ejecutamos lógica u operaciones matemáticas dentro del texto (ej. `${anoActual - nacimiento}`).
* **Formateo de números:** Para limitar decimales usamos `.toStringAsFixed(2)` (ej. `${totalToPay.toStringAsFixed(2)}\$`).

---

## 6. Extracción y Modularidad (Clean Code)

Nunca escribas interfaces monolíticas kilométricas. Si una estructura visual se repite, extráela a un `StatelessWidget` independiente y pásale los datos mediante su constructor.

**Ejemplo en código (`StatusCard`):** Componente Reutilizable.
```dart
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
```

### Conceptos aplicados:
* **Variables `final`**: Garantizamos que los datos recibidos no mutarán.
* **Constructor `required`**: Obliga a pasar los parámetros necesarios.

**Consumo del Componente (`Main`):**
```dart
// ...
children: [
  StatusCard(titulo: 'CPU', valor: 20.5, color: Colors.blue,),
  const SizedBox(height: 40),
  StatusCard(titulo: 'RAM', valor: 40, color: Colors.red,),
]
// ...
```

---

## 7. Rendimiento Extremo: La Inmutabilidad (`const`)

El recolector de basura (Garbage Collector) consume recursos de CPU cada vez que elimina objetos de la memoria. Si un widget no va a cambiar nunca su estado ni su diseño, debes anteponer la palabra clave **`const`**.

Esto le dice a Flutter: *"Crea este widget en la memoria una sola vez al arrancar la app y reutilízalo. No lo vuelvas a procesar nunca"*.

> [!TIP]
> **Regla de Optimización:** Revisa tu árbol de widgets. Si un `Padding`, `SizedBox`, o un `Text` no depende de variables dinámicas, agrégale `const`. Esto separa a los desarrolladores novatos de los verdaderos Arquitectos de Software en Flutter.
