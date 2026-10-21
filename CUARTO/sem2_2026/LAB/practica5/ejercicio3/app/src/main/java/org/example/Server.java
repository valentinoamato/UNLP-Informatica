package org.example;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

@Servidor(
    direccion = "127.0.0.1",
    puerto = 8000,
    archivo = "login.log"
)
public class Server {

    public static void main(String[] args) {
        try {
            // Envia la clase como parametro
            new Contenedor(Server.class).iniciar();
        } catch (Exception e) {
            System.out.println(
                "Error starting the server: " + e.getMessage()
            );
        }
    }

    @Invocar
    public void atender(HttpExchange exchange) throws IOException {
        String response = "Hello World!";

        exchange.getResponseHeaders().set(
            "Content-Type", "text/plain; charset=UTF-8"
        );

        byte[] bytes = response.getBytes(java.nio.charset.StandardCharsets.UTF_8);

        exchange.sendResponseHeaders(200, bytes.length);

        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }

    @Invocar
    public void imprimir(HttpExchange exchange) throws IOException {
        System.out.println("Got Request!");
    }
}

