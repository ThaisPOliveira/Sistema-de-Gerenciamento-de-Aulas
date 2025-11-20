package model.DAO;

import config.ConectaDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Professor;

public class ProfessorDAO {

 
    public boolean cadastrar(Professor p) throws ClassNotFoundException {
        String sql = "INSERT INTO professor (nome, cpf, email, senha, imagem) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNome());
            stmt.setString(2, p.getCpf());
            stmt.setString(3, p.getEmail());
            stmt.setString(4, p.getSenha());

            if (p.getImagem() != null) {
                stmt.setBytes(5, p.getImagem());
            } else {
                stmt.setNull(5, Types.BLOB);
            }

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

   
    public List<Professor> listar() throws ClassNotFoundException {
        List<Professor> professores = new ArrayList<>();
        String sql = "SELECT * FROM professor";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Professor p = new Professor();

                p.setId(rs.getInt("id_professor"));
                p.setNome(rs.getString("nome"));
                p.setCpf(rs.getString("cpf"));
                p.setEmail(rs.getString("email"));
                p.setSenha(rs.getString("senha"));
                p.setImagem(rs.getBytes("imagem"));

                professores.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return professores;
    }

    public Professor buscarPorId(int id) throws ClassNotFoundException {
        String sql = "SELECT * FROM professor WHERE id_professor = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Professor p = new Professor();

                    p.setId(rs.getInt("id_professor"));
                    p.setNome(rs.getString("nome"));
                    p.setCpf(rs.getString("cpf"));
                    p.setEmail(rs.getString("email"));
                    p.setSenha(rs.getString("senha"));
                    p.setImagem(rs.getBytes("imagem"));

                    return p;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean atualizar(Professor p) throws ClassNotFoundException {
        String sql = "UPDATE professor SET nome = ?, cpf = ?, email = ?, senha = ?, imagem = ? WHERE id_professor = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, p.getNome());
            stmt.setString(2, p.getCpf());
            stmt.setString(3, p.getEmail());
            stmt.setString(4, p.getSenha());

            if (p.getImagem() != null) {
                stmt.setBytes(5, p.getImagem());
            } else {
                stmt.setNull(5, Types.BLOB);
            }

            stmt.setInt(6, p.getId());

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean remover(int id) throws ClassNotFoundException {
        String sql = "DELETE FROM professor WHERE id_professor = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
