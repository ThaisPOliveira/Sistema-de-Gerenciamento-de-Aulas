package model.DAO;

import java.sql.*;
import java.util.*;
import model.Class;
import config.ConectaDB;

public class ClassDAO {

    public boolean cadastrar(Class turma) throws ClassNotFoundException {
        String sql = "INSERT INTO turma (nome_turma, nome_professor, nome_aluno, id_disciplina, horario) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, turma.getNomeTurma());
            stmt.setString(2, turma.getNomeProfessor());
            stmt.setString(3, turma.getNomeAlunos()); // IDs separados por vírgula, ex: "1,2,3"
            stmt.setInt(4, turma.getIdDisciplina());
            stmt.setTime(5, java.sql.Time.valueOf(turma.getHorario())); // converte LocalTime para SQL

            int linhas = stmt.executeUpdate();
            return linhas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Class> listarTurmas() throws ClassNotFoundException {
        List<Class> lista = new ArrayList<>();

        String sql = """
            SELECT 
                t.id_turma,
                t.nome_turma,
                t.nome_professor,
                t.nome_aluno,
                t.horario,
                d.nome AS nome_disciplina
            FROM turma t
            LEFT JOIN disciplina d ON t.id_disciplina = d.id
            ORDER BY t.nome_turma;
        """;

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Class turma = new Class();
                turma.setId(rs.getInt("id_turma"));
                turma.setNomeTurma(rs.getString("nome_turma"));
                turma.setNomeProfessor(rs.getString("nome_professor"));
                turma.setHorario(rs.getString("horario"));
                turma.setNomeDisciplina(rs.getString("nome_disciplina"));

                String idsAlunos = rs.getString("nome_aluno");
                if (idsAlunos != null && !idsAlunos.isBlank()) {
                    turma.setNomeAlunos(buscarNomesPorIds(idsAlunos, conn));
                } else {
                    turma.setNomeAlunos("Nenhum aluno cadastrado");
                }

                lista.add(turma);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    private String buscarNomesPorIds(String ids, Connection conn) {
        StringBuilder nomes = new StringBuilder();

        String sql = "SELECT nome FROM alunos WHERE id IN (" + ids + ")";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                if (nomes.length() > 0) {
                    nomes.append(", ");
                }
                nomes.append(rs.getString("nome"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return nomes.length() > 0 ? nomes.toString() : "Nenhum aluno encontrado";
    }
}
