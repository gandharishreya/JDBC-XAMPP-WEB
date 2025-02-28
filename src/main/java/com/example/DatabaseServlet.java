import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DatabaseServlet")
public class DatabaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String table = request.getParameter("table");
        String airportName = request.getParameter("airportname");

        String jdbcURL = "jdbc:mysql://localhost:3306/airport_db";
        String jdbcUsername = "root";  // Default XAMPP username
        String jdbcPassword = "";      // Default XAMPP password (empty)

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT * FROM " + table + " WHERE name = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, airportName);
                    
                    try (ResultSet rs = stmt.executeQuery()) {
                        out.println("<html><body>");
                        out.println("<h2>Search Results:</h2>");
                        while (rs.next()) {
                            out.println("<p>" + rs.getString("name") + "</p>");
                        }
                        out.println("</body></html>");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace(out);
        }
    }
}
