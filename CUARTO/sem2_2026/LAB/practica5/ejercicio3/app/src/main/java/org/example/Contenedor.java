package org.example;

import java.io.IOException;
import java.lang.reflect.Method;
import java.net.InetSocketAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;

public class Contenedor {

    private final Object instancia;
    private final Servidor config;
    private final List<Method> metodos;

    public Contenedor(Class<?> clase) throws Exception {
        // Devuelve la anotacion del tipo especificado, sino null
        config = clase.getAnnotation(Servidor.class);

        if (config == null) {
            throw new IllegalArgumentException(
                "The class must have @Servidor"
            );
        }

        // Crea una instancia de la clase recibida como parametro
        // Puede dar null
        instancia = clase.getDeclaredConstructor().newInstance();

        // Guarda los metodos de la clase anotados con invocar
        metodos = Arrays.stream(clase.getDeclaredMethods())
            .filter(m -> m.isAnnotationPresent(Invocar.class))
            .collect(Collectors.toList());
    }

    public void iniciar() throws IOException {
        // Usa los  parametros de la anotacion
        HttpServer server = HttpServer.create(
            new InetSocketAddress(
                config.direccion(),
                config.puerto()
            ),
            0
        );

        server.createContext("/", this::atenderPeticion);
        server.setExecutor(null);
        server.start();

        System.out.println(
            "Server running at http://" + config.direccion()
            + ":" + config.puerto()
        );
    }

    private void atenderPeticion(HttpExchange exchange)
            throws IOException {

        String ip = exchange.getRemoteAddress()
            .getAddress()
            .getHostAddress();

        String fecha = LocalDateTime.now().format(
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
        );

        String linea = fecha + " - IP: " + ip
            + System.lineSeparator();

        Files.write(
            Path.of(config.archivo()),
            linea.getBytes(StandardCharsets.UTF_8),
            StandardOpenOption.CREATE,
            StandardOpenOption.APPEND
        );

        try {
            // Invoca todos los metodos anotados con @Invocar
            for (Method metodo : metodos) {
                metodo.setAccessible(true);
                metodo.invoke(instancia, exchange);
            }
        } catch (ReflectiveOperationException e) {
            e.printStackTrace();

            byte[] error = "Internal Server Error"
                .getBytes(StandardCharsets.UTF_8);

            exchange.sendResponseHeaders(500, error.length);

            try (var os = exchange.getResponseBody()) {
                os.write(error);
            }
        }
    }
}
