package model.DAO;

import config.ConectaDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Professor;

public class ProfessorDAO {

    
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
            stmt.setString(6, professor.getSenha()); 
            
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
            stmt.setString(6, professor.getSenha());
            
            // Imagem - se for null, mantém a atual
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
    
    public boolean desativar(int id) throws ClassNotFoundException {
        String sql = "UPDATE professor SET ativo = false WHERE id_professor = ?";
        
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            System.err.println("Erro ao desativar professor: " + ex.getMessage());
            return false;
        }
    }
    
    
    public boolean ativar(int id) throws ClassNotFoundException {
        String sql = "UPDATE professor SET ativo = true WHERE id_professor = ?";
        
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            System.err.println("Erro ao ativar professor: " + ex.getMessage());
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



