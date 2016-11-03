# Chapie
Chapie es un robot para competencias de mini sumo

**Lenguaje de desarrollo:** Assembler

**Microcontrolador:** PIC 18f4550


Caracteristicas del robot:

- 4 ruedas en oruga
- Bakela compuesta con(Microchip pic18f1550,cristal 2MHz,capacitores 22 pico faradios, 1 interruptor, 2 pulsadores, 1 led,2 resistencias, 1 diodo,1 regulador)
- 2 motores
- 4 sensores qtr (2 adelante, 2 atras)
- 2 sensores IR (Encima de la pala)

## Analisis del entorno

- Entorno blanco.
En el entorno blanco, el robot tiene la capacidad de detectar con que parte del chasis esta ubicado en el entorno blanco, para aplicar el sentido a los motores necesario para volver al entorno negro.
- Entorno negro.
En el entorno negro, el robot esta en capacidad de comenzar a rastrear al enemigo, ejecutando vueltas en un sentido de izquierda a derecha, hasta que ubique al robot enemigo.



## Diseño
El robot se basa en el chasis pololu, con sus ruedas en oruga, dos motores en el eje de adelante, uno en cada rueda, motores pololu 100:1, 4 sensores de línea qtr1-a, ubicados en superifices compuestas de balso integradas al chasis, 2 en la parte frontal y 2 en la parte trasera, 4 pilas en serie a 6voltios en el empaque del chasis, que alimentaran el puente hl298, 2 balsos encima del chasis donde se ubicara otra pila en serie a 6v, que alimentara el PIC, encima de las pilas, nuevamente 2  balsos, que realizaran la función de base para la bakela y el punteh, encima de los balsos va la bakelita unida con tornillos a los balsos, en la parte de atrás del carro, va el punte h l298, de forma vertical mirando hacia atrás, para no sobrepasar los limites de las dimensiones según el reglamento.

