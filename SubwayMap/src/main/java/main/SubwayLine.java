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
import java.sql.SQLException;
import java.util.ArrayList;

//线路查询
@WebServlet("/SubwayLine")
public class SubwayLine extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String select =  req.getParameter("line");

        DB db = new DB();
        Sub sub = new Sub();
        ArrayList<String> l1 = sub.ArrayStationLine(select);
        if (l1!=null){
            req.setAttribute("routeLine", l1);
            req.getRequestDispatcher("/lineresult.jsp").forward(req, resp);
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
