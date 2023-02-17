package DBManagePack;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;


public class DBManager {
    public static Connection conn;

    public static void connect() throws SQLException
    {
        conn = DriverManager.getConnection("jdbc:sqlite:GoodsDB.sqlite");
        System.out.println("DB has connected");
    }


    public static void writeLaptop(String model, int price, int count) {
        String sql = "INSERT INTO Laptops('model', 'price', 'count') VALUES (?, ?, ?);";
        try(PreparedStatement prStmt = conn.prepareStatement(sql)){
            prStmt.setString(1, model);
            prStmt.setInt(2, price);
            prStmt.setInt(3, count);
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        System.out.println("Таблица заполнена");
    }


    public static List<HashMap<String, Object>> readLaptops() {
        try (Statement stmt = conn.createStatement()){
            ResultSet resultSet = stmt.executeQuery("SELECT * FROM Laptops");
            LinkedList<HashMap<String, Object>> laptopsData = new LinkedList<>();
            ResultSetMetaData rsmd = resultSet.getMetaData();
            while(resultSet.next()) {

                laptopsData.add(new HashMap<String, Object>());
                for (int i = 1; i < rsmd.getColumnCount(); i++) {
                    laptopsData.getLast().put(rsmd.getColumnName(i), resultSet.getObject(i));
                }
            }

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
        return null ;
    }


}