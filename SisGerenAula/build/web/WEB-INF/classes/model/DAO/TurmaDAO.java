package model.DAO;

import config.ConectaDB;
import java.sql.*;
import java.util.*;
import model.Turma;
import model.Aluno;

public class TurmaDAO {

    public List<Turma> listarTurmasPorProfessor(int idProfessor) throws ClassNotFoundException {
        List<Turma> turmas = new ArrayList<>();

        // Busca o nome do professor
        String nomeProfessor = buscarNomeProfessorPorId(idProfessor);
        
        if (nomeProfessor == null) {
            System.out.println("❌ Professor não encontrado: ID " + idProfessor);
            return turmas;
        }

        System.out.println("🔍 Buscando turmas para: " + nomeProfessor);

        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.nome_aluno, t.horario, d.nome AS disciplina_nome " +
                   "FROM turma t " +
                   "JOIN disciplina d ON t.id_disciplina = d.id " +
                   "WHERE t.nome_professor = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomeProfessor);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Turma turma = new Turma();
                    turma.setIdTurma(rs.getInt("id_turma"));
                    turma.setNomeTurma(rs.getString("nome_turma"));
                    turma.setNomeProfessor(rs.getString("nome_professor"));
                    turma.setHorario(rs.getString("horario"));
                    turma.setNomeDisciplina(rs.getString("disciplina_nome"));
                    
                    // Processa os alunos
                    String dadosAlunos = rs.getString("nome_aluno");
                    turma.setAlunos(processarAlunos(dadosAlunos, conn));

                    turmas.add(turma);
                    System.out.println("✅ Turma: " + turma.getNomeTurma());
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return turmas;
    }

    private List<Aluno> processarAlunos(String dadosAlunos, Connection conn) {
        List<Aluno> alunos = new ArrayList<>();
        
        if (dadosAlunos == null || dadosAlunos.trim().isEmpty()) {
            return alunos;
        }
        
        System.out.println("🔍 Processando alunos: " + dadosAlunos);
        
        // Se são IDs, busca no banco
        if (dadosAlunos.matches("^[0-9,]+$")) {
            String[] idsArray = dadosAlunos.split(",");
            for (String idStr : idsArray) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    String nome = buscarNomeAlunoPorId(id, conn);
                    if (nome != null) {
                        Aluno aluno = new Aluno();
                        aluno.setId(id);
                        aluno.setNome(nome);
                        alunos.add(aluno);
                        System.out.println("✅ Aluno: ID " + id + " = " + nome);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("❌ ID inválido: " + idStr);
                }
            }
        }
        
        return alunos;
    }

    private String buscarNomeProfessorPorId(int idProfessor) {
        String sql = "SELECT nome FROM professor WHERE id_professor = ?";
        
        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idProfessor);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("nome");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }

    private String buscarNomeAlunoPorId(int idAluno, Connection conn) {
        String sql = "SELECT nome FROM alunos WHERE id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idAluno);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("nome");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("❌ Erro ao buscar aluno ID " + idAluno);
        }
        
        return null;
    }
}