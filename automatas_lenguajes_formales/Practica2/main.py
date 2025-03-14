class MaquinaExpendedora:
    def __init__(self, archivo):
        self.estados = list()
        self.estados_finales = list()
        self.alfabeto = list()
        self.tabla_transiciones = list()
        
        self.cargar_automata(archivo)  # Ejecuta la función para cargar el archivo del automata


    def cargar_automata(self, archivo):
        """
        Carga los datos del autómata desde el archivo especificado.
        """
        try:
            with open(archivo, 'r') as f:
                contenido = f.read().splitlines()
        except:
            print("Error, no se ha podido abrir el archivo")

        # Procesar la información del archivo
        self.estados = self.leer_cabecera(contenido[0])
        self.estados_finales = self.leer_cabecera(contenido[1])
        self.alfabeto = self.leer_cabecera(contenido[2])
        self.tabla_transiciones = self.leer_tabla(contenido[4:], len(self.estados), len(self.alfabeto))
        self.alfabeto.append("LAMBDA")  # Añadir la transición lambda al alfabeto


    def leer_cabecera(self, linea):
        """
        Procesa las primeras líneas del archivo (lee la línea a partir del primer número).
        """
        return linea.strip("#").split(" ")[1:]
    

    def leer_tabla(self, lineas, num_estados, num_simbolos):
        """
        Lee la tabla de transiciones y la almacena en una matriz.
        """
        matriz = [ [ [] for _ in range(num_simbolos + 1) ] for _ in range(num_estados) ]
        
        i = 0  # Índice para recorrer los estados
        while i < num_estados:
            valores = lineas[i].split("#")[:-1]
            j = 0  # Índice para recorrer los símbolos
            while j < len(valores):
                matriz[i][j] = valores[j].strip().split(" ")
                j += 1
            i += 1

        return matriz
    

    def funcion_transicion(self, estado, simbolo):
        """
        Devuelve la lista de estados alcanzables desde un estado dado con un símbolo dado.
        """
        # Si el estado o símbolo no son válidos
        if estado not in self.estados or simbolo not in self.alfabeto:
            return []  

        transiciones = self.tabla_transiciones[self.estados.index(estado)][self.alfabeto.index(simbolo)]
        
        # Filtramos cualquier valor vacío ("")
        return [t for t in transiciones if t]
    

    def clausura_lambda(self, estados_iniciales):
        """
        Calcula la clausura lambda de un conjunto de estados.
        """
        estados_actuales = list(estados_iniciales)
        continuar = True
        while continuar:
            nuevos_estados = estados_actuales[:]  # Copia de los estados
            for estado in estados_actuales:
                nuevos_estados += self.funcion_transicion(estado, "LAMBDA")
            
            nuevos_estados = list(set(nuevos_estados))  # Usa set para eliminar duplicados
            if len(nuevos_estados) == len(estados_actuales):
                continuar = False  # Si no hay cambios, finaliza
            estados_actuales = nuevos_estados
            
        return estados_actuales
    

    def comprobar_aceptada(self, estados_actuales):
        """
        Comprobar si alguno de los estados actuales es un estado final.
        """
        return any(estado in self.estados_finales for estado in estados_actuales)


    def procesar_cadena(self, cadena):
        """
        Comprobar si una cadena es aceptada por el autómata.
        """
        estados_actuales = self.clausura_lambda([self.estados[0]])

        for simbolo in cadena:
            if simbolo not in self.alfabeto:
                print(f"El símbolo {simbolo} no pertenece al alfabeto del autómata.")
                return False
            
            nuevos_estados = list()
            for estado in estados_actuales:
                nuevos_estados = sum([self.funcion_transicion(estado, simbolo) for estado in estados_actuales], [])

            estados_actuales = self.clausura_lambda(nuevos_estados)
            print(f"Transición (Estado: {estado}, Símbolo: '{simbolo}') --> Estado/s actual/es: {estados_actuales}")

        print(f"Estado final: {estados_actuales}")
        if self.comprobar_aceptada(estados_actuales):
            print("RESULTADO: CADENA ACEPTADA.")
        else:
            print("RESULTADO: CADENA NO ACEPTADA.")

        return self.comprobar_aceptada(estados_actuales)


def main():
    """
    Función para ejecutar la máquina expendedora.
    """
    automata = MaquinaExpendedora("automatas_lenguajes_formales\Practica2\ejDefinicion.txt")
    #automata = MaquinaExpendedora("automatas_lenguajes_formales\Practica2\\automata_maquina_expendedora.txt")  # Archivo predefinido con el automata del enunciado
    print("\nAutomata de la Máquina Expendedora: ")
    print(f"Estados: {automata.estados}")
    print(f"Estados Finales: {automata.estados_finales}")
    print(f"Alfabeto: {automata.alfabeto}")

    cadena = input("\nIngrese la cadena a evaluar: ")
    automata.procesar_cadena(list(cadena))


if __name__ == "__main__":
    main()
