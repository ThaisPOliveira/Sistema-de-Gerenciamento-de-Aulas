package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time; 
import model.Class; 
import config.ConectaDB;

public class ClassDAO {

    public boolean cadastrar(Class turma) throws ClassNotFoundException {
        
        String sql = "INSERT INTO TURMA (nome_turma, nome_professor, nome_aluno, horario, id_disciplina) VALUES (?, ?, ?, ?, ?)"; 

        try (Connection conn = ConectaDB.conectar();
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, turma.getNomeTurma());
            stmt.setString(2, turma.getNomeProfessor()); 
            stmt.setString(3, turma.getNomeAlunos()); 
            Time horarioSql = Time.valueOf(turma.getHorario()); 
            stmt.setTime(4, horarioSql); 
            stmt.setInt(5, turma.getIdDisciplina()); 

            stmt.executeUpdate();
            return true;

        } catch (SQLException ex) {
            
            ex.printStackTrace();
            return false;
        }
    }
}