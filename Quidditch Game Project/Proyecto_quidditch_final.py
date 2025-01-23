#Datos
import math
resultados = []
equipos_torneo = []
numero_juegos = []
numero_oponentes = []
puntaje_total = []
oponentes_prom = []
oponentes = []
puntaje_total_torneo = []
puntaje_juegos = []
puntaje_oponentes = []
i = 0

#Funciones 
def obtener_equipos_torneo(equipos_torneo,numero_juegos,numero_oponentes,puntaje_oponentes):
    ingresar_equipos = ''
    ingresar_numero_juegos = 0
    ingresar_numero_oponentes = 0
    cant_equipos_torneo = int(input('\nIngrese la cantidad de equipos que participaran en el torneo: '))
    for i in range (cant_equipos_torneo):
        puntaje_total_torneo.append(0)
        ingresar_equipos = input(f'\nIngrese el nombre del equipo {i+1}: ')
        equipos_torneo.append(ingresar_equipos)
        ingresar_numero_juegos = int(input('\nIngrese el numero de juegos que realizara el equipo de {}: '.format(equipos_torneo[i])))
        numero_juegos.append(ingresar_numero_juegos)
        ingresar_numero_oponentes =  int(input('\nIngrese la cantidad de oponentes a los que se enfrentara el equipo de {}: '.format(equipos_torneo[i])))
        numero_oponentes.append(ingresar_numero_oponentes)
        puntos_oponentes = 0
        if (numero_oponentes[i] == 1):
            puntos_oponentes += 1/3
        elif (numero_oponentes[i] == 2):
            puntos_oponentes += 2/3
        elif (numero_oponentes[i] >=  3) :
            puntos_oponentes += 1
        puntaje_oponentes.append(puntos_oponentes)
    


def obtener_resultados_equipos(equipos_torneo,puntaje_total):
    for i in range(len(equipos_torneo)):
        puntos_totales = 0
        registro_juegos = []
        oponentes_prom = []
        for n in range(numero_juegos[i]):
           print(f'\nJuego {n+1} del equipo {equipos_torneo[i]}')
           oponente = input('Ingrese el nombre del equipo oponente: ')
           marcador_equipo = int(input(f'Ingrese el marcador de {equipos_torneo[i]}: '))
           marcador_oponente = int(input(f'Ingrese el marcador de {oponente}: '))
           snitch = input(f'¿Quién atrapó la snitch? ({equipos_torneo[i]} o {oponente}): ')
           if snitch == equipos_torneo[i]:
              resultado = f'{marcador_equipo}* - {marcador_oponente}'
           else:
              resultado = f'{marcador_equipo} - {marcador_oponente}*'
           registro_juegos.append(f'{equipos_torneo[i]} vs {oponente} \t {resultado}')
           puntos_totales += marcador_equipo
        oponentes_prom.append(oponente)
        resultados.append(registro_juegos)
        puntaje_total.append(puntos_totales)

def obtener_resultados(equipos_torneo, resultados):
    for i in range(len(equipos_torneo)):
        print('\n \tResultados del equipo {} '.format(equipos_torneo[i]))
        for registro_juegos in resultados[i]:
            print(registro_juegos)
            

def obtener_puntaje_total_partidos(equipos_torneo,puntaje_total):
    for i in range (len(equipos_torneo)):
        print('\nEl Puntaje total obtenidos en los partidos del equipo {} es de {}'.format(equipos_torneo[i], puntaje_total[i]))

def obtener_promedio_oponentes(equipos_torneo,oponentes_prom):
    cant_equipos_torneo = len(equipos_torneo)
    oponentes = []
    for i in range(len(equipos_torneo)):
        if equipos_torneo[i] != oponentes_prom and equipos_torneo[i] not in oponentes:
            oponentes.append(equipos_torneo[i])
    oponentes_dif = len(oponentes)/cant_equipos_torneo 
    print('\nEl promedio de oponentes diferentes del torneo fue de: ',oponentes_dif)

def obtener_equipos_mas_juegos(equipos_torneo, numero_juegos):
    max_juegos = 0
    equipos_max_juegos = []
    for i in range(len(equipos_torneo)):
        if numero_juegos[i] > max_juegos:
            max_juegos = numero_juegos[i]
            equipos_max_juegos = [equipos_torneo[i]]
        elif numero_juegos[i] == max_juegos:
            equipos_max_juegos.append(equipos_torneo[i])
    if len(equipos_max_juegos) == 1:
        print('\nEl equipo que ha jugado más partidos en el torneo es:', ','.join(equipos_max_juegos), 'con', max_juegos, 'partidos jugados.')
    else:
        print('\nLos equipos que han jugado más partidos en el torneo fueron:',','.join(equipos_max_juegos), 'con', max_juegos, 'partidos jugados.')


def obtener_equipo_menor_puntaje(equipos_torneo, puntaje_total):
    menor_puntaje = puntaje_total[0]
    equipo_menor_puntaje = equipos_torneo[0]
    for i in range(len(equipos_torneo)):
        if puntaje_total[i] < menor_puntaje:
            menor_puntaje = puntaje_total[i]
            equipo_menor_puntaje = equipos_torneo[i]
    print('\nEl equipo con menor puntaje en todo el torneo es: {} con {} puntos'.format(equipo_menor_puntaje, menor_puntaje))


def mas_cinco_juegos(equipos_torneo, numero_juegos,puntaje_juegos):
    equipo_mas_juegos = []
    for i in range(len(equipos_torneo)):
        if numero_juegos[i] >= 5:
            equipo_mas_juegos.append(equipos_torneo[i])
            print('\nLos equipos que realizaron más de 5 juegos fueron:', equipo_mas_juegos)
            puntos_juegos = 1
        else:
            puntos_juegos = math.sqrt(numero_juegos[i] * 2.5)
        puntaje_juegos.append(puntos_juegos)
     
    

def obtener_equipos_mayor_promedio(equipos_torneo,numero_oponentes):
    promedio = sum(numero_oponentes) / len(numero_oponentes)
    equipos_mayor_promedio = []
    for i in range(len(equipos_torneo)):
        if numero_oponentes[i] > promedio:
            equipos_mayor_promedio.append(equipos_torneo[i])
            print('\nLos equipos que tuvieron mas oponentes que el promedio que fue de {} del torneo fueron: {}'.format(promedio,equipos_mayor_promedio))


def obtener_puntos_totales_torneo(equipos_torneo,puntaje_total,puntaje_oponentes, puntaje_juegos ):
    for i in range(len(equipos_torneo)):
        puntaje_total_torneo[i] = puntaje_total[i] + puntaje_oponentes[i] + puntaje_juegos[i]
        print('\nEl Puntaje total obtenido en todo torneo por el  equipo {} es de {:.2f}'.format(equipos_torneo[i], puntaje_total_torneo[i]))

#Bloque Main
obtener_equipos_torneo(equipos_torneo,numero_juegos,numero_oponentes,puntaje_oponentes)
obtener_resultados_equipos(equipos_torneo,puntaje_total)
obtener_resultados(equipos_torneo, resultados)
obtener_puntaje_total_partidos(equipos_torneo,puntaje_total)
obtener_promedio_oponentes(equipos_torneo,oponentes_prom)
obtener_equipos_mas_juegos(equipos_torneo, numero_juegos)
obtener_equipo_menor_puntaje(equipos_torneo,puntaje_total)
mas_cinco_juegos(equipos_torneo,numero_juegos,puntaje_juegos)
obtener_equipos_mayor_promedio(equipos_torneo,numero_oponentes)
obtener_puntos_totales_torneo(equipos_torneo,puntaje_total,puntaje_oponentes,puntaje_juegos)