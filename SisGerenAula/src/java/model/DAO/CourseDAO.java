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
        String sql = "INSERT INTO disciplina (nome, descricao) VALUES (?, ?)";

        try (Connection conn = ConectaDB.conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, disciplina.getNome());
            stmt.setString(2, disciplina.getDescricao());

            stmt.executeUpdate();
            System.out.println("Disciplina cadastrada com sucesso!");
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Course> listarTodos() throws ClassNotFoundException {
        List<Course> disciplinas = new ArrayList<>();
        String sql = "SELECT id, nome, descricao FROM disciplina ORDER BY nome";

        try (Connection conn = ConectaDB.conectar(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Course disciplina = new Course();
                disciplina.setId(rs.getInt("id"));
                disciplina.setNome(rs.getString("nome"));
                disciplina.setDescricao(rs.getString("descricao"));
                disciplinas.add(disciplina);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return disciplinas;
    }
}
