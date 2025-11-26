/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import config.ConectaDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Aluno;
/**
 *
 * @author Happy
 */
public class AlunoDAO {
    public List<Aluno> listarAlunos() throws ClassNotFoundException {
        List<Aluno> alunos = new ArrayList<>();
        String sql = "SELECT id, nome, idade, responsavel, telefone FROM alunos";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Aluno aluno = new Aluno();
                aluno.setId(rs.getInt("id"));
                aluno.setNome(rs.getString("nome"));
                aluno.setIdade(rs.getInt("idade"));
                aluno.setResponsavel(rs.getString("responsavel"));
                aluno.setTelefone(rs.getString("telefone"));

                alunos.add(aluno);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return alunos;
    }
}
