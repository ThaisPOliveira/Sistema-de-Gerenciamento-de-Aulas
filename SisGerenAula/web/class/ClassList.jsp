<%-- 
    Document   : ClassList
    Created on : 12 de nov. de 2025, 10:26:10
    Author     : Happy
--%>
<%@page import="java.util.List"%>
<%@page import="model.Class"%>
<%@page import="model.DAO.ClassDAO"%>

<%
    ClassDAO dao = new ClassDAO();
    List<Class> turmas = dao.listarTurmas();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Turmas Cadastradas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        .card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 15px;
            line-height: 1.6;
        }
        .titulo {
            color: #007BFF;
            font-size: 20px;
            font-weight: bold;
        }
        .label {
            font-weight: bold;
            color: #333;
        }
        .vazio {
            color: gray;
            font-style: italic;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h1>Turmas Cadastradas</h1>

<%
if (turmas.isEmpty()) {
%>
    <p class="vazio">Nenhuma turma cadastrada.</p>
<%
} else {
    for (Class t : turmas) {
%>
    <div class="card">
        <div class="titulo"><%= t.getNomeTurma() %></div>
        <p><span class="label">Professor:</span> <%= t.getNomeProfessor() %></p>
        <p><span class="label">Disciplina:</span> <%= t.getNomeTurma()%></p>
        <p><span class="label">Horário:</span> <%= t.getHorario() %></p>
        <p><span class="label">Alunos:</span> <%= t.getNomeAlunos() %></p>
    </div>
<%
    }
}
%>

<br>
<a href="ClassForm.jsp">Cadastrar nova turma</a> |
<a href="../home_admin.html">Voltar à Home</a>

</body>
</html>
