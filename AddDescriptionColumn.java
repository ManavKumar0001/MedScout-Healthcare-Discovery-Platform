import java.sql.*;

public class AddDescriptionColumn {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/medscout?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "root";
        String pass = "M^1G^6V^3##&&@2897_se";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement()) {
            
            stmt.execute("ALTER TABLE inventory ADD COLUMN description TEXT AFTER price");
            System.out.println("Column 'description' added successfully to 'inventory' table!");
            
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
            if (e.getMessage().contains("Duplicate column name")) {
                System.out.println("Column already exists.");
            }
        }
    }
}
