/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import config.ConectaDB;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author Happy
 */
public class ProfessorDAO {
    
    public List<User> ListarProfessores() throws ClassNotFoundException{
        List<User> professores = new ArrayList<>();
        String sql = "select id, nome from usuarios where tipo = 'professor'";
        
        try (Connection conn = ConectaDB.conectar();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()){
            
            while(rs.next()){
                User p = new User();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                professores.add(p);
                      
                
            }
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return professores;
    }
}
