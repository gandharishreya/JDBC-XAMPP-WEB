<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="rep1.css">
</head>
<body>
    <center>
        <h2>Flight Information</h2>

        <table border="1">
            <tr>
                <th>Flight ID</th>
                <th>Flight Number</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Date</th>
                <th>Status</th>
            </tr>

            <%
                HttpSession sessionObj = request.getSession(false);
                if (sessionObj != null && sessionObj.getAttribute("staff_username") != null) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/your_database";
                    String jdbcUsername = "root";
                    String jdbcPassword = "your_password";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                        String sql = "SELECT * FROM flights";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getInt("flight_id") %></td>
                                <td><%= rs.getString("flight_number") %></td>
                                <td><%= rs.getString("departure") %></td>
                                <td><%= rs.getString("arrival") %></td>
                                <td><%= rs.getDate("date") %></td>
                                <td><%= rs.getString("status") %></td>
                            </tr>
            <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<h3>Error: " + e.getMessage() + "</h3>");
                        e.printStackTrace(out);
                    }
                } else {
                    out.println("<h3>You are not logged in.</h3>");
                }
            %>
        </table>
    </center>
</body>
</html>
