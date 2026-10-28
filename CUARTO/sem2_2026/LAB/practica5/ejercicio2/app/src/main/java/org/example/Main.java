package org.example;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.Class;
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

public class Main {

    public static void main(String[] args) {
        Mapeado mapeado = new Mapeado();
        Procesador.procesar(mapeado);
    }
}
