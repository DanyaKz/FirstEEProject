package DBManagePack;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;


public class DBManager {
    public static Connection conn;
    static {
        try {
            connect();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static void connect() throws SQLException, ClassNotFoundException {
        Class.forName("org.sqlite.JDBC");
        conn = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\Daniil\\IdeaProjects\\FirstEEProject\\GoodsDB.sqlite");
        System.out.println("DB has connected");
    }


    public static void writeLaptop(String model, int price, int count) {
        String sql = "INSERT INTO Laptops('model', 'price', 'count') VALUES (?, ?, ?);";
        try(PreparedStatement prStmt = conn.prepareStatement(sql)){
            prStmt.setString(1, model);
            prStmt.setInt(2, price);
            prStmt.setInt(3, count);
            prStmt.executeUpdate();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }


    public static List<HashMap<String, Object>> readLaptops() {
        try (Statement stmt = conn.createStatement()){
            ResultSet resultSet = stmt.executeQuery("SELECT * FROM Laptops");
            LinkedList<HashMap<String, Object>> laptopsData = new LinkedList<>();
            ResultSetMetaData rsmd = resultSet.getMetaData();
            while(resultSet.next()) {
                laptopsData.add(new HashMap<String, Object>());
                for (int i = 1; i < rsmd.getColumnCount()+1; i++) {
                    laptopsData.getLast().put(rsmd.getColumnName(i), resultSet.getObject(i));
                }
            }
            return laptopsData;
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    public static void deleteProduct(int id){
        String sql = "DELETE FROM Laptops WHERE id = ?;";
        try(PreparedStatement prStmt = conn.prepareStatement(sql)){
            prStmt.setInt(1, id);
            prStmt.executeUpdate();
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public static String laptopById(int id){
        String sql = "SELECT * FROM Laptops WHERE id = ?;";
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)){
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            rs.next();
            return String.format("{\"id\": %d, \"model\": \"%s\", \"price\": %d, \"count\": %d}",
                    rs.getInt("id"), rs.getString("model"),
                    rs.getInt("price"), rs.getInt("count"));
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    public static void updateLaptop(int id, String model, int price, int count){
        String sql = "UPDATE Laptops SET model = ?, price = ?, count = ? WHERE id = ?;";
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)){
            preparedStatement.setString(1,model);
            preparedStatement.setInt(2, price);
            preparedStatement.setInt(3, count);
            preparedStatement.setInt(4, id);
            preparedStatement.executeUpdate();
        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }


}