<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.DAO.CourseDAO, model.Course, java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
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
            line-height: 1.6;
        }
        .titulo {
            color: #007BFF;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .label {
            font-weight: bold;
            color: #333;
        }
        .vazio {
            color: gray;
            font-style: italic;
            text-align: center;
            padding: 20px;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        
        /* Estilos da tabela */
        .tabela-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th {
            background-color: #007BFF;
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: bold;
        }
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }
        tr:hover {
            background-color: #f8f9fa;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            margin: 2px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .btn-editar {
            background-color: #28a745;
            color: white;
        }
        .btn-editar:hover {
            background-color: #218838;
            text-decoration: none;
        }
        .btn-excluir {
            background-color: #dc3545;
            color: white;
        }
        .btn-excluir:hover {
            background-color: #c82333;
            text-decoration: none;
        }
        .btn-novo {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            margin-bottom: 20px;
            font-size: 16px;
            border-radius: 5px;
        }
        .btn-novo:hover {
            background-color: #0056b3;
            text-decoration: none;
        }
        .status-ativa {
            color: #28a745;
            font-weight: bold;
        }
        .status-inativa {
            color: #dc3545;
            font-weight: bold;
        }
        .actions {
            white-space: nowrap;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1> Lista de Disciplinas</h1>
        <a href="course.html" class="btn btn-novo">Nova Disciplina</a>
        
        <table>
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Descrição</th>
                    <th>Carga Horária</th>
                    <th>Nível</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    CourseDAO dao = new CourseDAO();
                    List<Course> disciplinas = dao.listarTodos();
                    
                    if (disciplinas.isEmpty()) {
                %>
                    <tr>
                        <td colspan="7" style="text-align: center;">Nenhuma disciplina cadastrada.</td>
                    </tr>
                <%
                    } else {
                        for (Course disciplina : disciplinas) {
                %>
                    <tr>
                        <td><%= disciplina.getNome() %></td>
                        <td><%= disciplina.getDescricao() != null ? disciplina.getDescricao() : "" %></td>
                        <td><%= disciplina.getCarga_horaria() %>h</td>
                        <td><%= disciplina.getNivel() %></td>
                        <td class="<%= disciplina.isAtiva() ? "status-ativa" : "status-inativa" %>">
                            <%= disciplina.isAtiva() ? "Ativa" : "Inativa" %>
                        </td>
                        <td class="actions">
                            <a href="update_course.jsp?id=<%= disciplina.getId() %>" class="btn btn-editar">️ Editar</a>
                            <a href="delete_course.jsp?id=<%= disciplina.getId() %>" 
                               class="btn btn-excluir" 
                               onclick="return confirm('Tem certeza que deseja excluir a disciplina <%= disciplina.getNome() %>?')"> Excluir</a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>