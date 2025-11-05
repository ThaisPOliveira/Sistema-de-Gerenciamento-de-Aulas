package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import config.ConectaDB;

public class UserDAO {

    public boolean cadastrar(User user) throws ClassNotFoundException {
        String sql = "INSERT INTO usuarios (nome, email, senha, tipo) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getNome());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getSenha());
            pstmt.setString(4, user.getTipo()); 

            pstmt.executeUpdate();
            System.out.println("Registro incluído com sucesso!");
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public User autenticar(String email, String senha) throws ClassNotFoundException {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            pstmt.setString(2, senha);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setNome(rs.getString("nome"));
                    user.setEmail(rs.getString("email"));
                    user.setSenha(rs.getString("senha"));
                    user.setTipo(rs.getString("tipo"));
                    System.out.println("Usuário autenticado com sucesso!");
                    return user;
                } else {
                    System.out.println("Usuário não encontrado ou senha incorreta.");
                    return null;
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
