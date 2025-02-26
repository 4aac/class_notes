# ASIER ACUÑA CASAL
# 2º GrIA ~ REPRESENTACIÓN DEL CONOCIMIENTO


# Comandos para la instalación de las librerías:
# !pip install pyswip
# !sudo apt install swi-prolog


from pyswip import Prolog

def cargar_base_conocimiento(prolog, archivo):
    """
    Carga la base de conocimiento desde un archivo al programa.
    """
    try:
        prolog.consult(archivo)
        print("Base de conocimiento cargada correctamente")
    except:
        print("Ha habido un error al cargar la base de conocimiento")

def agregar_hecho_regla(prolog):
    hecho = input("Introduce el hecho o regla: ")
    hecho = hecho.strip().rstrip('.')

    try:
        if ":-" in hecho:
            prolog.assertz(f"({hecho})")
        else:
            prolog.assertz(hecho)
        print("Hecho o regla agregado correctamente")

    except:
        print("Error al agregar el hecho o regla")

def eliminar_hecho_regla(prolog):
    hecho = input("Introduce el hecho o regla a eliminar: ")
    hecho = hecho.strip().rstrip('.')

    try:
        if ":-" in hecho:
            prolog.retract(f"({hecho})")
        else:
            prolog.retract(hecho)
        print("Hecho o regla eliminado correctamente")

    except:
        print("Error al eliminar el hecho o regla")


def realizar_consulta(prolog):
    """
    Realiza una consulta sobre los hechos y las reglas en la base de conocimiento.
    """
    print("""
          Elige el tipo de consulta:
          (1) General (no es ninguna de las siguientes)
          (2) ¿Cuántos...?
          (3) ¿Hay algún...?
          (4) Volver
          """)
    opcion = input("Opción: ")

    if opcion == "1":
        consulta = input("""
                         Introduce la consulta (ej. hombre(X)).
                         Los argumentos deben estar en mayúscula:
                         """)
        try:
            resultados = list(prolog.query(consulta))
            if resultados:
                print("Resultados de la consulta:")
                for resultado in resultados:
                    print(resultado)
            else:
                print("No se encontraron resultados.")
        except:
            print("Error en la consulta")

    elif opcion == "2":
        predicado = input("""
                         Introduce la consulta (ej. hombre(X)).
                         Los argumentos deben estar en mayúscula:
                         """)

        predicado = predicado.strip().rstrip('.')
        try:
            if "," in predicado:
                consulta = f"findall(X, ({predicado}), Lista), length(Lista, N)"
                resultados = list(prolog.query(consulta))
                if resultados:
                    print(f"Hay {resultados[0]['N']} resultados")
                else:
                    print("No se encontraron resultados")
            else:
                consulta = f"findall(X, {predicado}, Lista), length(Lista, N)"
                resultados = list(prolog.query(consulta))
                if resultados:
                    print(f"Hay {resultados[0]['N']} resultados")
                else:
                    print("No se encontraron resultados")
        except:
            print("Error en la consulta")

    elif opcion == "3":
        consulta = input("""
                         Introduce la consulta (ej. hombre(X)).
                         Los argumentos deben estar en mayúscula:
                         """)
        consulta = consulta.strip().rstrip('.')
        try:
            resultados = list(prolog.query(consulta))
            if resultados:
                print("Sí, hay al menos un resultado")
            else:
                print("No hay resultados")
        except:
            print("Error en la consulta")

    elif opcion == "4":
        print("Volviendo al menú principal...")
    else:
        print("Opción no válida. Inténtalo de nuevo")

def ver_hechos_reglas(archivo):
    """
    Muestra los hechos y las reglas cargados en el archivo con la base de conocimiento.
    """
    try:
        with open(archivo, "r", encoding="utf-8") as f:
            lineas = f.readlines()
    except:
        print("Error al abrir el archivo")
        return

    print("\nHechos y reglas del archivo introducido:\n")

    for linea in lineas:
        linea = linea.strip()
        if linea.startswith("%"):  # Ignorar líneas vacías y comentarios
            continue

        if ":-" in linea:
            regla = linea.split(":-")
            parte1 = regla[0].strip()
            parte2 = regla[1].strip()
            print(f"{parte1} :- {parte2}")
        else:
            print(f"{linea}")


def main():
    prolog = Prolog()
    archivo = input("Introduce la ruta del archivo: ")
    cargar_base_conocimiento(prolog, archivo)

    continuar = True
    while continuar:
        print("""
              Elige una opción:
              (1) Agregar un hecho o regla
              (2) Eliminar un hecho o regla
              (3) Realizar una consulta
              (4) Ver hechos y reglas
              (5) Salir
              """)
        opcion = input("Opción: ")

        if opcion == "1":
            agregar_hecho_regla(prolog, archivo)
        elif opcion == "2":
            eliminar_hecho_regla(prolog, archivo)
        elif opcion == "3":
            realizar_consulta(prolog, archivo)
        elif opcion == "4":
            ver_hechos_reglas(archivo)
        elif opcion == "5":
            print("Saliendo del programa...")
            continuar = False
        else:
            print("Opción no válida. Inténtalo de nuevo")

if __name__ == "__main__":
    main()