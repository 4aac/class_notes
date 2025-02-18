import java.io.*;
import java.util.*;


public class Procesador {
    private String fileName;
    private String input;
    private ArrayList<String> estados;
    private  ArrayList<String> estadosFinales;
    private ArrayList<String> alfabeto;
    private String[][] transiciones;
    private String estadoActual;



    public Procesador(String[] args) {
        if (args.length != 2) {
            Consola.imprimir("\nUso correcto: java Procesador <fichero> <cadena>.");
            System.exit(1);
        }
        this.fileName = args[0]; // primer parámetro de entrada
        this.input = args[1]; // segundo parámetro de entrada
        this.estados = new ArrayList<>();
        this.estadosFinales = new ArrayList<>();
        this.alfabeto = new ArrayList<>();
    }

    public void run() throws IOException {
        this.leerArchivo(); // extraer la información del autómata
        Consola.imprimir("\nEstados finales: " + this.estadosFinales + "\n");
        if (isDeterminista()){
            Consola.imprimir("\nAutómata Determinista");
            this.procesarCadenaDeterminista();

        } else {
            Consola.imprimir("\nAutómata No Determinista");
            this.procesarCadenaNoDeterminista();
        }
        Consola.imprimir("\n\nEs aceptada la cadena?: ");
        if (this.isAccepted()) Consola.imprimir("Sí.");
        else Consola.imprimir("No.");
    }

    public void leerArchivo() throws IOException {
        BufferedReader file = new BufferedReader(new FileReader(this.fileName));

        String line;
        String[] partes;

        // Leer la línea de estados
        line = file.readLine();
        partes = line.split(" "); // Dividir la línea en los substrings delimitados por espacios
        int numeroEstados = Integer.parseInt(partes[0].substring(1));
        for (int i = 1; i <= numeroEstados; i++) {
            this.estados.add(partes[i]);
        }

        // Leer la línea de estados finales
        line = file.readLine();
        partes = line.split(" ");
        int numeroEstadosFinales = Integer.parseInt(partes[0].substring(1));
        for (int i = 1; i <= numeroEstadosFinales; i++) {
            this.estadosFinales.add(partes[i]);
        }

        // Leer la línea de símbolos
        line = file.readLine();
        partes = line.split(" ");
        int numeroSimbolos = Integer.parseInt(partes[0].substring(1));
        for (int i = 1; i <= numeroSimbolos; i++) {
            this.alfabeto.add(partes[i]);
        }
        this.alfabeto.add("_");

        // Leer la tabla de transiciones
        line = file.readLine();
        if (!line.contains("TABLA DE TRANSICIONES")) {
            Consola.imprimir("\nTabla de transiciones mal señalizada. Leído: " + line);
            System.exit(1);
        }

        transiciones = new String[estados.size()][alfabeto.size()];  // Crear una matriz de número de filas número de estados y número de columnas número de símbolos del alfabeto
        for (int i = 0; i < estados.size(); i++) {

            line = file.readLine();
            partes = line.split("#");
            for (int j = 0; j < alfabeto.size(); j++) {
                transiciones[i][j] = partes[j].replace(" ", "");
                if (transiciones[i][j].isEmpty()) transiciones[i][j] = "_";
            }
        }
        this.estadoActual = this.estados.get(0);
    }

    public void transiciones() {
        Consola.imprimir("\n");
        for (int i = 0; i < this.estados.size(); i++) {
            for (int j = 0; j < this.alfabeto.size(); j++) {
                Consola.imprimir(transiciones[i][j] + " ");
            }
            Consola.imprimir("\n");
        }
    }

    public void procesarCadenaDeterminista() {
        String aux;
        String estadoAnterior = estadoActual;

        for (char entrada : this.input.toCharArray()) {
            if (!this.alfabeto.contains(entrada + "")) {
                Consola.imprimir("\nError: El autómata no permite el símbolo \"" + entrada + "\" como entrada.");
                System.exit(1);
            }

            estadoAnterior = estadoActual;

            if(estadoActual.length() != 1) {  // Si se está en varios estados actualmente
                aux = "";
                for (char c : estadoActual.toCharArray()) { // Añadir el estado siguiente a cada estado de los actuales según la entrada
                    aux = aux + this.transiciones[this.estados.indexOf(c + "")][this.alfabeto.indexOf(entrada + "")];
                }
                estadoActual = aux;
            } else estadoActual = this.transiciones[this.estados.indexOf(this.estadoActual)][this.alfabeto.indexOf(entrada + "")]; // Estado actual igual al siguiente según la entrada

            Consola.imprimir("\n(" + estadoAnterior + ", " + entrada + ") => " + estadoActual);
            estadoActual = estadoActual.replace("_",""); // Eliminar _ correspondiente a vacío
        }
    }

    public void procesarCadenaNoDeterminista() {
        String estadoAnterior = estadoActual;
        estadoActual = cierreEpsilon(estadoActual); // Obtener los estados en los que se encuentra actualmente el autómata ante ninguna entrada
        Consola.imprimir("\nEstado inicial: " + estadoActual);
        String siguientes;
        String res;
        String auxE;
        for (char c : input.toCharArray()) {  // por cada símbolo de la cadena de entrada
            siguientes = "";
            res = "";
            for (char e : estadoActual.toCharArray()) { // por cada estado de los actuales
                res = transiciones[estados.indexOf(e + "")][alfabeto.indexOf(c + "")]; // obtener el estado o estados siguientes
                for (char r : res.toCharArray()) { // por cada estado siguiente
                    if (r != '_') { // Si no es vacío
                        auxE = cierreEpsilon(r + ""); // Obtener los estados en los que se encontraría ante ninugna entrada
                        for (char d : auxE.toCharArray()) { // por cada estado
                            if (!siguientes.contains(d + "")) {  // Si no es un estado actual ya
                                siguientes = siguientes + d;
                            }
                        }
                    }
                }
            }
            estadoActual = siguientes; // Actualizar estado actual
            Consola.imprimir("\n(" + estadoAnterior + ", " + c + ") => " + estadoActual);
        }
        Consola.imprimir("\nEstadoFinal: " + estadoActual);
    }

    public String cierreEpsilon(String entrada) {
        Queue<Character> cola = new LinkedList<>(); // crear cola
        for (char c : entrada.toCharArray()) { // por cada estado de los pasados a la función
            if (c != '_') cola.add(c); // si no es vacío añade el estado a la cola
        }
        char e1;
        String sig;
        String add = entrada;

        while(!cola.isEmpty()) { // si la cola aún tiene algún elemento
            e1 = cola.poll(); // extraer elemento
            sig = transiciones[estados.indexOf(e1 + "")][alfabeto.indexOf("_")]; // obtener el estado o estados siguientes
            if (!sig.equals("_")) {
                for (char c : sig.toCharArray()) {
                    if (c != '_') {
                        cola.add(c);
                        if (!add.contains(c + "")) add = add + c;
                    }

                }
            }
        }
        return add;
    }

    public boolean isAccepted() {
        if (this.estadoActual.length() != 1)
            for (char c : this.estadoActual.toCharArray()) { // Si alguno de los estados actuales está entre los finales
                if (this.estadosFinales.contains(c + "")) return true;
            }
        else return this.estadosFinales.contains(estadoActual);
        return false;
    }

    public boolean isDeterminista() {
        for (int i = 0; i < estados.size(); i++) {
            if (this.transiciones[i][this.alfabeto.size()-1].equals("_")) {
                return false;
            }
        }
        return true;
    }
}
