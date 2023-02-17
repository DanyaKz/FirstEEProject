import DBManagePack.DBManager;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "Home", value = "/")
public class Home extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DBManager.connect();
            List<HashMap<String, Object>> laptops = DBManager.readLaptops();

            request.setAttribute("laptops", laptops);
            request.getRequestDispatcher("index.jsp").forward(request, response);

            DBManager.conn.close();
        } catch (SQLException e) {
            request.getRequestDispatcher("errors/500.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}