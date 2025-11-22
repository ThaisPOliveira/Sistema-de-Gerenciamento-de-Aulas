package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import config.ConectaDB;

public class CourseDAO {

  
    public boolean cadastrar(Course disciplina) throws ClassNotFoundException {
    String sql = "INSERT INTO disciplina (nome, descricao, carga_horaria, nivel, ativa) "
               + "VALUES (?, ?, ?, ?, ?)";

    try (Connection conn = ConectaDB.conectar();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, disciplina.getNome());
        stmt.setString(2, disciplina.getDescricao());
        stmt.setInt(3, disciplina.getCarga_horaria());
        stmt.setString(4, disciplina.getNivel());
        stmt.setInt(5, disciplina.isAtiva() ? 1 : 0);

        stmt.executeUpdate();
        System.out.println("Disciplina cadastrada com sucesso!");
        return true;

    } catch (SQLException ex) {
        ex.printStackTrace();
        return false;
    }
}

    public List<Course> listarTodas() throws ClassNotFoundException {
        List<Course> disciplinas = new ArrayList<>();
        String sql = "SELECT * FROM disciplina ORDER BY nome";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Course d = new Course();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setDescricao(rs.getString("descricao"));
                d.setCarga_horaria(rs.getInt("carga_horaria"));
                d.setNivel(rs.getString("nivel"));
                d.setAtiva(rs.getBoolean("ativa"));
                disciplinas.add(d);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return disciplinas;
    }

    public List<Course> listarAtivas() throws ClassNotFoundException {
        List<Course> disciplinas = new ArrayList<>();
        String sql = "SELECT * FROM disciplina WHERE ativa = true ORDER BY nome";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Course d = new Course();
                d.setId(rs.getInt("id"));
                d.setNome(rs.getString("nome"));
                d.setDescricao(rs.getString("descricao"));
                d.setCarga_horaria(rs.getInt("carga_horaria"));
                d.setNivel(rs.getString("nivel"));
                d.setAtiva(rs.getBoolean("ativa"));
                disciplinas.add(d);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return disciplinas;
    }

    
    public Course buscarPorId(int id) throws ClassNotFoundException {
        String sql = "SELECT * FROM disciplina WHERE id = ?";
        Course d = null;

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    d = new Course();
                    d.setId(rs.getInt("id"));
                    d.setNome(rs.getString("nome"));
                    d.setDescricao(rs.getString("descricao"));
                    d.setCarga_horaria(rs.getInt("carga_horaria"));
                    d.setNivel(rs.getString("nivel"));
                    d.setAtiva(rs.getBoolean("ativa"));
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return d;
    }

    public boolean atualizar(Course disciplina) throws ClassNotFoundException {
     String sql = "UPDATE disciplina SET nome=?, descricao=?, carga_horaria=?, nivel=?, ativa=? "
                + "WHERE id=?";

     try (Connection conn = ConectaDB.conectar();
          PreparedStatement stmt = conn.prepareStatement(sql)) {

         stmt.setString(1, disciplina.getNome());
         stmt.setString(2, disciplina.getDescricao());
         stmt.setInt(3, disciplina.getCarga_horaria());
         stmt.setString(4, disciplina.getNivel());
         stmt.setBoolean(5, disciplina.isAtiva());  
         stmt.setInt(6, disciplina.getId());

         int linhasAfetadas = stmt.executeUpdate();
         System.out.println("Linhas afetadas na atualização: " + linhasAfetadas);
         return linhasAfetadas > 0;

     } catch (SQLException ex) {
         System.out.println("ERRO na atualização: " + ex.getMessage());
         ex.printStackTrace();
         return false;
     }
   }
    
    public boolean excluir(int id) throws ClassNotFoundException {
       // Exclusão lógica - marcar como inativa
       String sql = "UPDATE disciplina SET ativa = false WHERE id = ?";

       try (Connection conn = ConectaDB.conectar();
            PreparedStatement stmt = conn.prepareStatement(sql)) {

           stmt.setInt(1, id);
           stmt.executeUpdate();
           return true;

       } catch (SQLException ex) {
           ex.printStackTrace();
           return false;
       }
   }
    public boolean reativar(int id) throws ClassNotFoundException {
        String sql = "UPDATE disciplina SET ativa = true WHERE id = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int linhasAfetadas = stmt.executeUpdate();
            System.out.println("Disciplina reativada - Linhas afetadas: " + linhasAfetadas);
            return linhasAfetadas > 0;

        } catch (SQLException ex) {
            System.out.println("ERRO ao reativar: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

}
