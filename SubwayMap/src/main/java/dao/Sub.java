package dao;

import com.DB;
import com.SubwayBean;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Sub {

    public ArrayList<SubwayBean> ArrayTransferStation(String station1, String station2){

        ArrayList<SubwayBean> resultArray = new ArrayList<>();
        DB db = new DB();
        PreparedStatement preparedStatement=null;
        ResultSet rs = null;
        int i=0;

        try {
            String sql ="WITH RECURSIVE transfer (start_station, stop_station, stops, path) AS (\n" +
                    "    SELECT station_name, next_station, 1, CAST(CONCAT(line_name,' ',station_name , '--->', line_name,' ',next_station) AS CHAR(1000))\n" +
                    "    FROM station_table WHERE station_name = ?\n" +
                    "    UNION ALL\n" +
                    "    SELECT p.start_station, e.next_station, stops + 1, CONCAT(p.path, '--->', e.line_name, ' ',e.next_station)\n" +
                    "    FROM transfer p\n" +
                    "             JOIN station_table e\n" +
                    "                  ON p.stop_station = e.station_name AND (INSTR(p.path, e.next_station) = 0)\n" +
                    ")\n" +
                    "SELECT * FROM transfer WHERE stop_station =?;\n";

            preparedStatement=db.conn.prepareStatement(sql);
            preparedStatement.setString(1,station1);
            preparedStatement.setString(2,station2);
            rs = preparedStatement.executeQuery();

            while (rs.next())
            {
                i++;
                SubwayBean subwayBean = new SubwayBean();
                subwayBean._StartStation = (String) rs.getObject(1);
                subwayBean._EndStation = (String) rs.getObject(2);
                subwayBean._Number = rs.getObject(3);
                subwayBean._Path = (String) rs.getObject(4);
                resultArray.add(subwayBean);

            }
            if(i==0)
            {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            db.close();
        }
        return resultArray;
    }
    public ArrayList<String> ArrayStationLine(String line){

        DB db = new DB();
        ArrayList<String> station = new ArrayList<>();
        String l_name = "'" + line + "'";
        try {
            String selectQuery = "SELECT * FROM station_table WHERE line_name="+l_name;
            db.rs =db.stmt.executeQuery(selectQuery);

            while (db.rs.next()){

                String base_name=db.rs.getString("station_name");
                station.add(base_name);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            db.close();
        }
        if (station.size()==0){
            return null;
        }
        return station;
    }
    public String LineStation(String name){

        DB db = new DB();
        String na = "'" + name + "'";
        String line = "地铁";
        try {
            String selectQuery = "SELECT * FROM station_table WHERE station_name="+na;
            db.rs =db.stmt.executeQuery(selectQuery);

            if (db.rs.next()){
                String base_name=db.rs.getString("line_name");
                line += base_name;
//                line += "号线";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            db.close();
        }
        if (line == "地铁"){
            return null;
        }
        return line;
    }

}
