/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

/**
 *
 * @author Matheus e Thais
 */

import config.ConectaDB;
import java.sql.*;
import java.util.*;
import model.Turma;
import model.Aluno;


public class TurmaDAO {


    public List<Turma> listarTurmasComAlunos() throws ClassNotFoundException {
        List<Turma> turmas = new ArrayList<>();

        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.horario, d.nome AS disciplina_nome "
                   + "FROM turma t "
                   + "JOIN disciplina d ON t.id_disciplina = d.id";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Turma turma = new Turma();
                turma.setIdTurma(rs.getInt("id_turma"));
                turma.setNomeTurma(rs.getString("nome_turma"));
                turma.setNomeProfessor(rs.getString("nome_professor"));
                turma.setHorario(rs.getString("horario"));
                turma.setNomeDisciplina(rs.getString("disciplina_nome"));

                turma.setAlunos(buscarAlunosPorTurma(turma.getIdTurma()));
                turmas.add(turma);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return turmas;
    }


    private List<Aluno> buscarAlunosPorTurma(int idTurma) throws ClassNotFoundException {
        List<Aluno> alunos = new ArrayList<>();

        String sql = "SELECT a.id, a.nome FROM alunos a "
                   + "JOIN turma_aluno ta ON a.id = ta.id_aluno "
                   + "WHERE ta.id_turma = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idTurma);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Aluno a = new Aluno();
                    a.setId(rs.getInt("id"));
                    a.setNome(rs.getString("nome"));
                    alunos.add(a);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return alunos;
    }


   
    public List<Turma> listarTurmasPorProfessor(int idProfessor) throws ClassNotFoundException {
        List<Turma> turmas = new ArrayList<>();

        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.horario, d.nome AS disciplina_nome "
                   + "FROM turma t "
                   + "JOIN disciplina d ON t.id_disciplina = d.id "
                   + "WHERE t.id_professor = ?";  

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idProfessor); 

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Turma turma = new Turma();
                    turma.setIdTurma(rs.getInt("id_turma"));
                    turma.setNomeTurma(rs.getString("nome_turma"));
                    turma.setNomeProfessor(rs.getString("nome_professor"));
                    turma.setHorario(rs.getString("horario"));
                    turma.setNomeDisciplina(rs.getString("disciplina_nome"));

                    turma.setAlunos(buscarAlunosPorTurma(turma.getIdTurma()));
                    turmas.add(turma);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return turmas;
    }

}
