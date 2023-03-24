package main;

import com.DB;
import dao.Sub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//站点查询
@WebServlet("/SubwayStation")
public class SubwayStation extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String na =  req.getParameter("name");

        DB db = new DB();
        Sub sub = new Sub();

        String line = sub.LineStation(na);
        if (line!=null){
            req.setAttribute("routeStation", line);
            req.getRequestDispatcher("/nameresult.jsp").forward(req, resp);
        }else {
            req.getRequestDispatcher("/fail.jsp").forward(req, resp);
        }


    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
    @Override
    public void init() throws ServletException {
    }
    @Override
    public void destroy() {

    }
}
