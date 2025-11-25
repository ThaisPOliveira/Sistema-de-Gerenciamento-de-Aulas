<%-- 
    Document   : ClassList_prof
    Created on : 12 de nov. de 2025
    Author     : Matheus e Thais
--%>

<%@page import="java.util.List"%>
<%@page import="model.Turma"%>
<%@page import="model.Professor"%>
<%@page import="model.DAO.TurmaDAO"%>

<%
    // Recuperar professor logado da sessão
    Professor prof = (Professor) session.getAttribute("professor");

    if (prof == null) {
        response.sendRedirect("../index.html");
        return;
    }

    TurmaDAO dao = new TurmaDAO();
    List<Turma> turmas = dao.listarTurmasPorProfessor(prof.getId_professor());
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Turmas do Professor</title>
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

        <h1>Minhas Turmas</h1>

        <%
            if (turmas.isEmpty()) {
        %>
        <p class="vazio">Você não possui nenhuma turma cadastrada.</p>
        <%
        } else {
            for (Turma t : turmas) {
        %>
        <div class="card">
            <div class="titulo"><%= t.getNomeTurma()%></div>
            <p><span class="label">Disciplina:</span> <%= t.getNomeDisciplina()%></p>
            <p><span class="label">Horário:</span> <%= t.getHorario()%></p>

            <p><span class="label">Alunos:</span>
                <%
                    if (t.getAlunos().isEmpty()) {
                        out.print("Nenhum aluno cadastrado.");
                    } else {
                        for (int i = 0; i < t.getAlunos().size(); i++) {
                            out.print(t.getAlunos().get(i).getNome());
                            if (i < t.getAlunos().size() - 1) {
                                out.print(", ");
                            }
                        }
                    }
                %>
            </p>
        </div>
        <%
                }
            }
        %>

        <br>
        <a href="../home_professor.html">Voltar à Home</a>

    </body>
</html>
