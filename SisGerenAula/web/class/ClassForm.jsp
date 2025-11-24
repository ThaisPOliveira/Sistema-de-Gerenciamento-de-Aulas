<<<<<<< Updated upstream
<%-- 
    Document   : ClassForm
    Created on : 5 de nov. de 2025, 12:16:23
    Author     : Happy
--%>
=======
<%

String usuarioLogado = (String) session.getAttribute("usuarioLogado");
String tipoUsuario = (String) session.getAttribute("tipoUsuario");
%>

<%@include file="../WEB-INF/checkAuth.jsp"%>
<%
// Verificar se Ã© admin
if (!"admin".equals(tipoUsuario)) {
    response.sendRedirect("../user/home_professor.html");
    return;
}
%>
>>>>>>> Stashed changes

<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.Disciplina"%>
<%@page import="model.DAO.DisciplinaDAO"%>
<%@page import="model.Aluno"%>
<%@page import="model.DAO.AlunoDAO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Turma</title>

        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    </head>
    <body>
        <h1>Cadastro de Turma</h1>

        <form method="post" action="ClassProcess.jsp">

            <!-- Nome da turma -->
            <label>Nome da Turma:</label>
            <input type="text" name="nomeTurma" required><br><br>

            <!-- Professor  -->
            <label>Professor:</label>
            <select name="nomeProfessor" required>
                <option value="">Selecione um professor</option>
                <%
                    ProfessorDAO pdao = new ProfessorDAO();
                    List<User> professores = pdao.ListarProfessores();
                    for (User prof : professores) {
                %>
                <option value="<%= prof.getNome()%>"><%= prof.getNome()%></option>
                <%
                    }
                %>
            </select>
            <br><br>

            <!-- Alunos select2  -->
            <label>Alunos:</label>
            <select name="alunosSelecionados" multiple="multiple" id="alunosSelect" style="width: 300px;">
                <%
                    AlunoDAO adao = new AlunoDAO();
                    List<Aluno> alunos = adao.listarAlunos();
                    for (Aluno a : alunos) {
                %>
                <option value="<%= a.getId()%>"><%= a.getNome()%></option>
                <%
                    }
                %>
            </select>
            <br>

            <!-- Horario -->
            <label>Horário:</label>
            <input type="time" name="horario" required><br><br>

            <!-- Disciplina -->
            <label>Disciplina:</label>
            <select name="idDisciplina" required>
                <option value="">Selecione uma disciplina</option>
                <%
                    DisciplinaDAO ddao = new DisciplinaDAO();
                    List<Disciplina> disciplinas = ddao.listarDisciplinas();
                    for (Disciplina d : disciplinas) {
                %>
                <option value="<%= d.getId()%>" title="<%= d.getDescricao()%>"><%= d.getNome()%></option>
                <%
                    }
                %>
            </select>
            <br><br>


            <button type="submit">Cadastrar</button>
            <button type="reset">Limpar</button>
        </form>

        <br>
        <a href="../home_admin.html">Voltar</a>

        <script>
            $(document).ready(function () {
                $('#alunosSelect').select2({
                    placeholder: "Selecione os alunos",
                    allowClear: true,
                    width: 'resolve'
                });
            });
        </script>
    </body>
</html>
