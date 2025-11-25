<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.DAO.CourseDAO, model.Course, java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String sucesso = request.getParameter("sucesso");
    String erro = request.getParameter("erro");

    boolean mostrarDesativadas = "true".equals(request.getParameter("mostrarDesativadas"));

    CourseDAO dao = new CourseDAO();
    List<Course> disciplinas;

    if (mostrarDesativadas) {
        disciplinas = dao.listarTodas();
    } else {
        disciplinas = dao.listarAtivas();
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Lista de Disciplinas</title>
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
            }
            .titulo {
                color: #007BFF;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
                text-align: center;
            }
            .vazio {
                color: gray;
                font-style: italic;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            th {
                background-color: #007BFF;
                color: white;
                padding: 12px;
            }
            td {
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }
            .btn {
                padding: 6px 12px;
                border-radius: 5px;
                text-decoration: none;
                margin: 2px;
            }
            .btn-editar {
                background: #28a745;
                color: white;
            }
            .btn-excluir {
                background: #dc3545;
                color: white;
            }
            .btn-reativar {
                background: #17a2b8;
                color: white;
            }
        </style>
    </head>
    <body>

        <div class="card">

            <h1 class="titulo">📚 Lista de Disciplinas</h1>

            <div class="tabela-container">
                <table>
                    <thead>
                        <tr>
                            <th>Nome</th>
                            <th>Descrição</th>
                            <th>Carga Horária</th>
                            <th>Nível</th>
                            <th>Status</th>
                            <th>Documento</th>   <!-- NOVA COLUNA -->
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (disciplinas.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="7" class="vazio">Nenhuma disciplina encontrada.</td>
                        </tr>
                        <%
                        } else {
                            for (Course disciplina : disciplinas) {
                        %>
                        <tr>
                            <td><%= disciplina.getNome()%></td>
                            <td><%= disciplina.getDescricao() != null ? disciplina.getDescricao() : "Sem descrição"%></td>
                            <td><%= disciplina.getCarga_horaria()%>h</td>
                            <td><%= disciplina.getNivel()%></td>
                            <td><%= disciplina.isAtiva() ? "Ativa" : "Inativa"%></td>

                            <!-- EXIBIR DOCUMENTO -->
                            <td>
                                <% if (disciplina.getDocumento() != null && !disciplina.getDocumento().isEmpty()) {%>
                                <a href="../uploads/<%= disciplina.getDocumento()%>" target="_blank">📄 Abrir</a>
                                <% } else { %>
                                <span class="vazio">Nenhum</span>
                                <% }%>
                            </td>

                            <td>
                                <a class="btn btn-editar" href="update_course.jsp?id=<%= disciplina.getId()%>">Editar</a>

                                <% if (disciplina.isAtiva()) {%>
                                <a class="btn btn-excluir" href="delete_course.jsp?id=<%= disciplina.getId()%>">Desativar</a>
                                <% } else {%>
                                <a class="btn btn-reativar" href="reactivate_course.jsp?id=<%= disciplina.getId()%>">Reativar</a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

        </div>

    </body>
</html>
