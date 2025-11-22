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
            opacity: 0.6;
        }
        .disciplina-inativa {
            background-color: #f8f9fa;
            opacity: 0.7;
        }
        .actions {
            white-space: nowrap;
        }
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .filtros {
            background: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .filtro-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }
        .contador {
            background: #007BFF;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 12px;
            margin-left: 10px;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 5px;
            text-align: center;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .btn-reativar {
            background-color: #17a2b8;
            color: white;
        }
        .btn-reativar:hover {
            background-color: #138496;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="header-container">
            <h1 class="titulo">📚 Lista de Disciplinas</h1>
            <a href="course.html" class="btn btn-novo">➕ Nova Disciplina</a>
            <a href="../home_admin.html" class="btn btn-novo">Voltar</a>
        </div>

        <% if ("desativada".equals(sucesso)) { %>
            <div class="alert alert-success">
                ✅ <strong>Sucesso!</strong> Disciplina desativada com sucesso!
            </div>
        <% } %>

        <% if ("reativada".equals(sucesso)) { %>
            <div class="alert alert-success">
                ✅ <strong>Sucesso!</strong> Disciplina reativada com sucesso!
            </div>
        <% } %>

        <% if ("editado".equals(sucesso)) { %>
            <div class="alert alert-success">
                ✅ <strong>Sucesso!</strong> Disciplina atualizada com sucesso!
            </div>
        <% } %>

        <% if ("desativar".equals(erro)) { %>
            <div class="alert alert-error">
                ❌ <strong>Erro!</strong> Não foi possível desativar a disciplina.
            </div>
        <% } %>

        <% if ("reativar".equals(erro)) { %>
            <div class="alert alert-error">
                ❌ <strong>Erro!</strong> Não foi possível reativar a disciplina.
            </div>
        <% } %>

        <!-- Filtros -->
        <div class="filtros">
            <form method="get" action="list_course.jsp" class="filtro-group">
                <label class="checkbox-label">
                    <input type="checkbox" 
                           name="mostrarDesativadas" 
                           value="true" 
                           <%= mostrarDesativadas ? "checked" : "" %>
                           onchange="this.form.submit()">
                    Mostrar disciplinas desativadas
                </label>
                <span class="contador">
                    <%= disciplinas.size() %> disciplina(s)
                </span>
            </form>
        </div>
        
        <div class="tabela-container">
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
                        if (disciplinas.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="6" class="vazio">
                                <% if (mostrarDesativadas) { %>
                                    Nenhuma disciplina cadastrada.
                                <% } else { %>
                                    Nenhuma disciplina ativa encontrada.
                                <% } %>
                            </td>
                        </tr>
                    <%
                        } else {
                            for (Course disciplina : disciplinas) {
                                String linhaClass = disciplina.isAtiva() ? "" : "disciplina-inativa";
                    %>
                        <tr class="<%= linhaClass %>">
                            <td>
                                <strong><%= disciplina.getNome() %></strong>
                                <% if (!disciplina.isAtiva()) { %>
                                    <br><small style="color: #dc3545;">(Desativada)</small>
                                <% } %>
                            </td>
                            <td>
                                <% if (disciplina.getDescricao() != null && !disciplina.getDescricao().isEmpty()) { %>
                                    <%= disciplina.getDescricao() %>
                                <% } else { %>
                                    <span class="vazio">Sem descrição</span>
                                <% } %>
                            </td>
                            <td><%= disciplina.getCarga_horaria() %>h</td>
                            <td><%= disciplina.getNivel() %></td>
                            <td class="<%= disciplina.isAtiva() ? "status-ativa" : "status-inativa" %>">
                                <%= disciplina.isAtiva() ? "● Ativa" : "● Inativa" %>
                            </td>
                            <td class="actions">
                                <a href="update_course.jsp?id=<%= disciplina.getId() %>" class="btn btn-editar">✏️ Editar</a>
                                <% if (disciplina.isAtiva()) { %>
                                    <a href="delete_course.jsp?id=<%= disciplina.getId() %>" 
                                       class="btn btn-excluir" 
                                       onclick="return confirm('Tem certeza que deseja desativar a disciplina &quot;<%= disciplina.getNome() %>&quot;?\n\nEla não aparecerá mais nas listas padrão, mas poderá ser reativada depois.')">🗑️ Desativar</a>
                                <% } else { %>
                                    <a href="reactivate_course.jsp?id=<%= disciplina.getId() %>" 
                                       class="btn btn-reativar" 
                                       onclick="return confirm('Tem certeza que deseja reativar a disciplina &quot;<%= disciplina.getNome() %>&quot;?')">♻️ Reativar</a>
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