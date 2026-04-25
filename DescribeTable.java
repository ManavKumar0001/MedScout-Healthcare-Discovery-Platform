import java.sql.*;

public class DescribeTable {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/medscout?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "root";
        String pass = "M^1G^6V^3##&&@2897_se";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("DESCRIBE inventory")) {
            
            System.out.println("Columns in 'inventory':");
            while (rs.next()) {
                System.out.println("- " + rs.getString("Field"));
            }
            
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
