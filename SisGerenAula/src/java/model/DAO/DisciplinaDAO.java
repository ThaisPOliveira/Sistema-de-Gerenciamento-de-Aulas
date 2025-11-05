package model.DAO;

import config.ConectaDB;
import model.Disciplina;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DisciplinaDAO {
    
    public List<Disciplina> listarDisciplinas() throws ClassNotFoundException {
        List<Disciplina> disciplinas = new ArrayList<>();
        String sql = "SELECT id, nome, descricao FROM disciplina";
        
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Disciplina d = new Disciplina();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setDescricao(rs.getString("descricao"));
                disciplinas.add(d);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return disciplinas;
    }
}
