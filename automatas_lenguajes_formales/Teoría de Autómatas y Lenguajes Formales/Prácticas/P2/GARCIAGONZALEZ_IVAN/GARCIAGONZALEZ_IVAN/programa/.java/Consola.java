import java.util.Scanner;

public final class Consola {
    private static final Scanner scanner = new Scanner(System.in);

    public Consola() {
    }

    public static void imprimir(Object mensaje) {
        System.out.print(mensaje);
    }

    public static String leer(String texto) {
        imprimir(texto);
        return scanner.nextLine();
    }
}
