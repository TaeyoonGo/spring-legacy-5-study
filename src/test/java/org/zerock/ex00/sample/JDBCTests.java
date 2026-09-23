package org.zerock.ex00.sample;

import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCTests {


    @Test
    public void testConnation() throws ClassNotFoundException, SQLException {
        // DB Driver class
        Class.forName("org.postgresql.Driver");

        Connection conn =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres" , "taeyoon" , "kds300500@");
        System.out.println(conn);

        conn.close();
    }
}
