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
            
            String alunosStr = converterIdsParaString(turma.getIdsAlunos());
            stmt.setString(3, alunosStr);
            
            stmt.setInt(4, turma.getIdDisciplina());
            stmt.setTime(5, java.sql.Time.valueOf(turma.getHorario()));

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Erro ao cadastrar turma: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

 
    public List<Class> listarTurmas() throws ClassNotFoundException {
        List<Class> lista = new ArrayList<>();

        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.nome_aluno, t.horario, " +
                    "d.nome AS nome_disciplina " +
                    "FROM turma t " +
                    "LEFT JOIN disciplina d ON t.id_disciplina = d.id " +
                    "ORDER BY t.nome_turma";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Class turma = extrairTurmaResultSet(rs, conn);
                lista.add(turma);
            }

        } catch (SQLException e) {
            System.err.println("❌ Erro ao listar turmas: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }


    public Class buscarPorId(int id) throws ClassNotFoundException {
        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.nome_aluno, t.horario, " +
                    "t.id_disciplina, d.nome AS nome_disciplina " +
                    "FROM turma t " +
                    "LEFT JOIN disciplina d ON t.id_disciplina = d.id " +
                    "WHERE t.id_turma = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extrairTurmaResultSet(rs, conn);
            }

        } catch (SQLException e) {
            System.err.println("❌ Erro ao buscar turma por ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

 
      public boolean atualizarTurma(Class turma) throws ClassNotFoundException {
    String sql = "UPDATE turma SET nome_turma=?, nome_professor=?, nome_aluno=?, id_disciplina=?, horario=? WHERE id_turma=?";

    try (Connection conn = ConectaDB.conectar();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, turma.getNomeTurma());
        stmt.setString(2, turma.getNomeProfessor());
        
        // ✅ CORREÇÃO: Envie IDs, não nomes
        String alunosIdsStr = converterIdsParaString(turma.getIdsAlunos());
        stmt.setString(3, alunosIdsStr);
        
        stmt.setInt(4, turma.getIdDisciplina());
        stmt.setTime(5, java.sql.Time.valueOf(turma.getHorario()));
        stmt.setInt(6, turma.getId());

        return stmt.executeUpdate() > 0;

    } catch (SQLException e) {
        System.err.println("❌ Erro ao atualizar turma: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}


   
    public boolean excluirTurma(int id) throws ClassNotFoundException {
        String sql = "DELETE FROM turma WHERE id_turma = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Erro ao excluir turma: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

 
    private Class extrairTurmaResultSet(ResultSet rs, Connection conn) throws SQLException {
    Class turma = new Class();
    
    turma.setId(rs.getInt("id_turma"));
    turma.setNomeTurma(rs.getString("nome_turma"));
    turma.setNomeProfessor(rs.getString("nome_professor"));
    turma.setNomeDisciplina(rs.getString("nome_disciplina"));
    
    Time horario = rs.getTime("horario");
    if (horario != null) {
        turma.setHorario(horario.toLocalTime());
    }
    
    String idsAlunos = rs.getString("nome_aluno");
    if (idsAlunos != null && !idsAlunos.trim().isEmpty()) {
        // ✅ Popula os IDs também (importante para edição)
        List<Integer> ids = new ArrayList<>();
        String[] idsArray = idsAlunos.split(",");
        for (String idStr : idsArray) {
            try {
                if (idStr.matches("\\d+")) { // Só adiciona se for número
                    ids.add(Integer.parseInt(idStr.trim()));
                }
            } catch (NumberFormatException e) {
                System.err.println("❌ Erro ao converter ID: " + idStr);
            }
        }
        turma.setIdsAlunos(ids);
        
        // Busca os nomes para exibição
        turma.setNomeAlunos(buscarNomesAlunos(idsAlunos, conn));
    } else {
        turma.setNomeAlunos("Nenhum aluno");
        turma.setIdsAlunos(new ArrayList<>());
    }

    return turma;
}

    // CORREÇÃO APENAS DESTE MÉTODO - buscarNomesAlunos
    private String buscarNomesAlunos(String idsAlunos, Connection conn) {
        if (idsAlunos == null || idsAlunos.trim().isEmpty()) {
            return "Nenhum aluno";
        }
        
        // DEBUG: Verifica o que está vindo
        System.out.println("🔍 IDs recebidos: '" + idsAlunos + "'");
        
        // Verifica se já são nomes (contém letras) ou são IDs (apenas números)
        if (idsAlunos.matches(".*[a-zA-Z].*")) {
            // Já são nomes - retorna diretamente
            System.out.println("✅ Já são nomes, retornando diretamente: " + idsAlunos);
            return idsAlunos;
        }
        
        // São IDs - busca os nomes no banco
        StringBuilder nomes = new StringBuilder();
        
        try {
            // Divide os IDs pela vírgula
            String[] idsArray = idsAlunos.split(",");
            List<String> placeholders = new ArrayList<>();
            
            // Cria os placeholders para a query
            for (int i = 0; i < idsArray.length; i++) {
                placeholders.add("?");
            }
            
            // Query com PreparedStatement para evitar SQL injection
            String sql = "SELECT nome FROM alunos WHERE id IN (" + String.join(",", placeholders) + ")";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Define os parâmetros
                for (int i = 0; i < idsArray.length; i++) {
                    stmt.setInt(i + 1, Integer.parseInt(idsArray[i].trim()));
                }
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        if (nomes.length() > 0) {
                            nomes.append(", ");
                        }
                        nomes.append(rs.getString("nome"));
                    }
                }
            }
            
            System.out.println("✅ Nomes encontrados: " + nomes.toString());

        } catch (SQLException e) {
            System.err.println("❌ Erro ao buscar nomes dos alunos: " + e.getMessage());
            e.printStackTrace();
            return "Erro ao carregar alunos";
        } catch (NumberFormatException e) {
            System.err.println("❌ Erro ao converter IDs: " + e.getMessage());
            return "Erro ao carregar alunos";
        }

        return nomes.length() > 0 ? nomes.toString() : "Nenhum aluno encontrado";
    }

    
    private String converterIdsParaString(List<Integer> idsAlunos) {
        if (idsAlunos == null || idsAlunos.isEmpty()) {
            return null;
        }
        
        StringBuilder sb = new StringBuilder();
        for (Integer id : idsAlunos) {
            if (sb.length() > 0) {
                sb.append(",");
            }
            sb.append(id);
        }
        return sb.toString();
    }

   
    public List<Class> listarPorProfessor(String nomeProfessor) throws ClassNotFoundException {
        List<Class> lista = new ArrayList<>();
        
        String sql = "SELECT t.id_turma, t.nome_turma, t.nome_professor, t.nome_aluno, t.horario, " +
                    "d.nome AS nome_disciplina " +
                    "FROM turma t " +
                    "LEFT JOIN disciplina d ON t.id_disciplina = d.id " +
                    "WHERE t.nome_professor = ? " +
                    "ORDER BY t.nome_turma";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomeProfessor);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Class turma = extrairTurmaResultSet(rs, conn);
                lista.add(turma);
            }

        } catch (SQLException e) {
            System.err.println("❌ Erro ao listar turmas por professor: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }

 
    public boolean existeTurmaComNome(String nomeTurma) throws ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM turma WHERE nome_turma = ?";

        try (Connection conn = ConectaDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomeTurma);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("❌ Erro ao verificar existência da turma: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}