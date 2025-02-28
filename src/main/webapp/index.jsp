<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Passenger Dashboard</title>
    <link rel="stylesheet" href="rep1.css">
</head>
<body>
    <center>
        <h2>Your Ticket Information</h2>

        <table border="1">
            <tr>
                <th>Ticket ID</th>
                <th>Passenger Name</th>
                <th>Flight Number</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Date</th>
            </tr>

            <%
                HttpSession sessionObj = request.getSession(false);
                if (sessionObj != null && sessionObj.getAttribute("username") != null) {
                    String username = (String) sessionObj.getAttribute("username");

                    String jdbcURL = "jdbc:mysql://localhost:3306/your_database";
                    String jdbcUsername = "root";
                    String jdbcPassword = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                        String sql = "SELECT * FROM tickets WHERE passenger_name=?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, username);

                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getInt("ticket_id") %></td>
                                <td><%= rs.getString("passenger_name") %></td>
                                <td><%= rs.getString("flight_number") %></td>
                                <td><%= rs.getString("departure") %></td>
                                <td><%= rs.getString("arrival") %></td>
                                <td><%= rs.getDate("date") %></td>
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
