package main;

import com.SubwayBean;
import dao.Sub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 *
 * **/
@WebServlet("/SubwayMain")
public class SubwayMain extends HttpServlet {
    @Override
    public void init() throws ServletException {
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String start = new String(req.getParameter("start_station").getBytes("ISO8859-1"),"UTF-8");
        String end = new String(req.getParameter("end_station").getBytes("ISO8859-1"),"UTF-8");

        try {
            Sub sub = new Sub();
            ArrayList<SubwayBean> arr = sub.ArrayTransferStation(start,end);
            if (arr!=null){
                req.setAttribute("routeMain", arr);
                req.getRequestDispatcher("/bestresult.jsp").forward(req, resp);
            }else {
                req.getRequestDispatcher("/fail.jsp").forward(req, resp);
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {

        }

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
    @Override
    public void destroy() {

    }
}
