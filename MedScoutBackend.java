import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * MedScout Backend - Minimal JDBC Implementation
 * Version: 1.1
 */
public class MedScoutBackend {

    // Database Configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/medscout?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public static void main(String[] args) throws Exception {
        // Verify DB Connection
        try (Connection conn = getConnection()) {
            System.out.println("[INFO] Successfully connected to the MedScout Database!");
        } catch (SQLException e) {
            System.err.println("[WARNING] Could not connect to Database. Ensure MySQL is running.");
            System.err.println("[DEBUG] " + e.getMessage());
        }

        // Initialize Server
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        
        // Register Endpoints
        server.createContext("/api/health", new HealthHandler());
        server.createContext("/api/medicines", new MedicineHandler());
        server.createContext("/api/users", new UserHandler());
        
        server.setExecutor(null);
        server.start();
        System.out.println("[INFO] MedScout Backend running at http://localhost:8080");
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // =========================================================================
    // HANDLERS
    // =========================================================================

    /**
     * Basic Health Check
     */
    static class HealthHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            sendResponse(exchange, 200, "{\"status\":\"UP\", \"message\":\"MedScout Backend is healthy\"}");
        }
    }

    /**
     * Handles /api/medicines
     */
    static class MedicineHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            if (!"GET".equals(exchange.getRequestMethod())) {
                sendResponse(exchange, 405, "{\"error\":\"Method Not Allowed\"}");
                return;
            }

            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT id, brand_name, generic_name, form FROM medicines");
                 ResultSet rs = stmt.executeQuery()) {
                 
                List<String> results = new ArrayList<>();
                while (rs.next()) {
                    results.add(toJson(
                        "id", rs.getLong("id"),
                        "brandName", rs.getString("brand_name"),
                        "genericName", rs.getString("generic_name"),
                        "form", rs.getString("form")
                    ));
                }
                sendResponse(exchange, 200, "[" + String.join(",", results) + "]");

            } catch (SQLException e) {
                sendResponse(exchange, 500, "{\"error\":\"Database Error: " + escape(e.getMessage()) + "\"}");
            }
        }
    }

    /**
     * Handles /api/users
     */
    static class UserHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            if (!"GET".equals(exchange.getRequestMethod())) {
                sendResponse(exchange, 405, "{\"error\":\"Method Not Allowed\"}");
                return;
            }

            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement("SELECT id, email, full_name, role FROM users");
                 ResultSet rs = stmt.executeQuery()) {
                 
                List<String> results = new ArrayList<>();
                while (rs.next()) {
                    results.add(toJson(
                        "id", rs.getLong("id"),
                        "email", rs.getString("email"),
                        "fullName", rs.getString("full_name"),
                        "role", rs.getString("role")
                    ));
                }
                sendResponse(exchange, 200, "[" + String.join(",", results) + "]");

            } catch (SQLException e) {
                sendResponse(exchange, 500, "{\"error\":\"Database Error: " + escape(e.getMessage()) + "\"}");
            }
        }
    }

    // =========================================================================
    // UTILS
    // =========================================================================

    private static void sendResponse(HttpExchange exchange, int code, String response) throws IOException {
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.getResponseHeaders().set("Access-Control-Allow-Origin", "*");
        exchange.getResponseHeaders().set("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        exchange.getResponseHeaders().set("Access-Control-Allow-Headers", "Content-Type, Authorization");

        if ("OPTIONS".equals(exchange.getRequestMethod())) {
            exchange.sendResponseHeaders(204, -1);
            return;
        }

        byte[] bytes = response.getBytes(StandardCharsets.UTF_8);
        exchange.sendResponseHeaders(code, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }

    private static String toJson(Object... pairs) {
        StringBuilder sb = new StringBuilder("{");
        for (int i = 0; i < pairs.length; i += 2) {
            String key = (String) pairs[i];
            Object val = pairs[i + 1];
            sb.append("\"").append(key).append("\":");
            if (val instanceof Number) {
                sb.append(val);
            } else {
                sb.append("\"").append(escape(String.valueOf(val))).append("\"");
            }
            if (i < pairs.length - 2) sb.append(",");
        }
        sb.append("}");
        return sb.toString();
    }

    private static String escape(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
