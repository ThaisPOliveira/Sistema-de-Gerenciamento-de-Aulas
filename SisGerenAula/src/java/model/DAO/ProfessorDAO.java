package model.DAO;

import config.ConectaDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import model.Professor;

public class ProfessorDAO {


    private String hashSenha(String senha) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(senha.getBytes());
            StringBuilder sb = new StringBuilder();

            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }


    public boolean cadastrar(Professor professor) throws ClassNotFoundException {
        String sql = "INSERT INTO professor (nome, cpf, email, telefone, formacao, senha, imagem, ativo) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, professor.getNome());
            stmt.setString(2, professor.getCpf());
            stmt.setString(3, professor.getEmail());
            stmt.setString(4, professor.getTelefone());
            stmt.setString(5, professor.getFormacao());

            
            stmt.setString(6, hashSenha(professor.getSenha()));

            if (professor.getImagem() != null && professor.getImagem().length > 0) {
                stmt.setBytes(7, professor.getImagem());
            } else {
                stmt.setNull(7, java.sql.Types.BLOB);
            }

            stmt.setBoolean(8, professor.isAtivo());

            stmt.executeUpdate();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }


    public List<Professor> listarTodos() throws ClassNotFoundException {
        List<Professor> professores = new ArrayList<>();
        String sql = "SELECT * FROM professor ORDER BY nome";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Professor professor = extrairProfessorResultSet(rs);
                professores.add(professor);
            }

        } catch (SQLException ex) {
            System.err.println("Erro ao listar professores: " + ex.getMessage());
        }

        return professores;
    }

    public List<Professor> listarAtivos() throws ClassNotFoundException {
        List<Professor> professores = new ArrayList<>();
        String sql = "SELECT * FROM professor WHERE ativo = true ORDER BY nome";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Professor professor = extrairProfessorResultSet(rs);
                professores.add(professor);
            }

        } catch (SQLException ex) {
            System.err.println("Erro ao listar professores ativos: " + ex.getMessage());
        }

        return professores;
    }

    public Professor buscarPorId(int id) throws ClassNotFoundException {
        String sql = "SELECT * FROM professor WHERE id_professor = ?";
        Professor professor = null;

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                professor = extrairProfessorResultSet(rs);
            }

            rs.close();

        } catch (SQLException ex) {
            System.err.println("Erro ao buscar professor: " + ex.getMessage());
        }

        return professor;
    }

    public boolean editar(Professor professor) throws ClassNotFoundException {
        String sql = "UPDATE professor SET nome=?, cpf=?, email=?, telefone=?, " +
                     "formacao=?, senha=?, imagem=?, ativo=? WHERE id_professor=?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, professor.getNome());
            stmt.setString(2, professor.getCpf());
            stmt.setString(3, professor.getEmail());
            stmt.setString(4, professor.getTelefone());
            stmt.setString(5, professor.getFormacao());

           
            if (professor.getSenha() != null && !professor.getSenha().isEmpty()) {
                stmt.setString(6, hashSenha(professor.getSenha()));
            } else {
                stmt.setNull(6, java.sql.Types.VARCHAR);
            }

            if (professor.getImagem() != null && professor.getImagem().length > 0) {
                stmt.setBytes(7, professor.getImagem());
            } else {
                stmt.setNull(7, java.sql.Types.BLOB);
            }

            stmt.setBoolean(8, professor.isAtivo());
            stmt.setInt(9, professor.getId_professor());

            return stmt.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.err.println("Erro ao editar professor: " + ex.getMessage());
            return false;
        }
    }

  
    private Professor extrairProfessorResultSet(ResultSet rs) throws SQLException {
        Professor professor = new Professor();
        professor.setId_professor(rs.getInt("id_professor"));
        professor.setNome(rs.getString("nome"));
        professor.setCpf(rs.getString("cpf"));
        professor.setEmail(rs.getString("email"));
        professor.setTelefone(rs.getString("telefone"));
        professor.setFormacao(rs.getString("formacao"));
        professor.setSenha(rs.getString("senha"));
        professor.setImagem(rs.getBytes("imagem"));
        professor.setAtivo(rs.getBoolean("ativo"));
        professor.setData_cadastro(rs.getDate("data_cadastro"));
        return professor;
    }
}
