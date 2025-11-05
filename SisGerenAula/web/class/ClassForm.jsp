<%-- 
    Document   : ClassForm
    Created on : 5 de nov. de 2025, 12:16:23
    Author     : Happy
--%>

<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.Disciplina"%>
<%@page import="model.DAO.DisciplinaDAO"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Turma</title>
</head>
<body>
    <h1>Cadastro de Turma</h1>

    <form method="post" action="ClassProcess.jsp">

        <!-- Nome da turma -->
        <label>Nome da Turma:</label>
        <input type="text" name="nomeTurma" required><br><br>

        <!-- Professor (puxado do banco) -->
        <label>Professor:</label>
        <select name="nomeProfessor" required>
            <option value="">Selecione um professor</option>
            <%
                ProfessorDAO pdao = new ProfessorDAO();
                List<User> professores = pdao.ListarProfessores();
                for (User prof : professores) {
            %>
                <option value="<%= prof.getNome() %>"><%= prof.getNome() %></option>
            <%
                }
            %>
        </select>
        <br><br>

        <!-- Alunos (campo livre, pode depois virar select múltiplo) -->
        <label>Alunos:</label>
        <input type="text" name="nomeAlunos" placeholder="Digite os nomes ou IDs" required><br><br>

        <!-- Horário -->
        <label>Horário:</label>
        <input type="time" name="horario" required><br><br>

        <!-- Disciplina (puxado do banco) -->
        <label>Disciplina:</label>
        <select name="idDisciplina" required>
            <option value="">Selecione uma disciplina</option>
            <%
                DisciplinaDAO ddao = new DisciplinaDAO();
                List<Disciplina> disciplinas = ddao.listarDisciplinas();
                for (Disciplina d : disciplinas) {
            %>
                <option value="<%= d.getId() %>"><%= d.getDescricao() %></option>
            <%
                }
            %>
        </select>
        <br><br>

        <!-- Botões -->
        <button type="submit">Cadastrar</button>
        <button type="reset">Limpar</button>
    </form>

    <br>
    <a href="../home.html">Voltar</a>
</body>
</html>

