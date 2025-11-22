<%@page import="model.Professor, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Professores</title>
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
        .btn-desativar {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-desativar:hover {
            background-color: #e0a800;
            text-decoration: none;
        }
        .btn-ativar {
            background-color: #17a2b8;
            color: white;
        }
        .btn-ativar:hover {
            background-color: #138496;
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
        .status-ativo {
            color: #28a745;
            font-weight: bold;
        }
        .status-inativo {
            color: #dc3545;
            font-weight: bold;
            opacity: 0.6;
        }
        .professor-inativo {
            background-color: #f8f9fa;
            opacity: 0.7;
        }
        .actions {
            white-space: nowrap;
        }
        .foto-professor {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ddd;
        }
        .sem-foto {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 12px;
            border: 2px solid #dee2e6;
        }
    </style>
</head>
<body>

<div class="card">
    <h2 class="titulo">Lista de Professores</h2>

    <!-- Mensagens -->
    <% if (request.getParameter("sucesso") != null) { %>
        <div style="color: green; padding: 10px; background: #f0fff0; border-radius: 5px; margin-bottom: 15px;">
            ✅ <%= request.getParameter("sucesso") %>
        </div>
    <% } %>

    <% if (request.getParameter("erro") != null) { %>
        <div style="color: red; padding: 10px; background: #fff0f0; border-radius: 5px; margin-bottom: 15px;">
            ❌ <%= request.getParameter("erro") %>
        </div>
    <% } %>

    <p>
        <a href="regist_professor.jsp" class="btn-novo">
            + Cadastrar Novo Professor
        </a>
    </p>

    <div class="tabela-container">
        <table>
            <thead>
                <tr>
                    <th>Foto</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Formação</th>
                    <th>CPF</th>
                    <th>Telefone</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Professor> professores = (List<Professor>) request.getAttribute("professores");
                    if (professores != null && !professores.isEmpty()) {
                        for (Professor prof : professores) {
                %>
                <tr class="<%= !prof.isAtivo() ? "professor-inativo" : "" %>">
                    <td>
                        <% if (prof.getImagem() != null && prof.getImagem().length > 0) { %>
                            <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(prof.getImagem()) %>" 
                                 class="foto-professor" alt="Foto">
                        <% } else { %>
                            <div class="sem-foto">Sem foto</div>
                        <% } %>
                    </td>
                    <td><%= prof.getNome() %></td>
                    <td><%= prof.getEmail() %></td>
                    <td><%= prof.getFormacao() %></td>
                    <td><%= prof.getCpf() %></td>
                    <td><%= prof.getTelefone() != null ? prof.getTelefone() : "N/A" %></td>
                    <td>
                        <% if (prof.isAtivo()) { %>
                            <span class="status-ativo">● Ativo</span>
                        <% } else { %>
                            <span class="status-inativo">● Inativo</span>
                        <% } %>
                    </td>
                    <td class="actions">
                        <a href="professor?action=editar&id=<%= prof.getId_professor() %>" class="btn btn-editar">Editar</a>
                        
                        <% if (prof.isAtivo()) { %>
                            <a href="professor?action=desativar&id=<%= prof.getId_professor() %>" 
                               class="btn btn-desativar"
                               onclick="return confirm('Desativar este professor?')">
                                Desativar
                            </a>
                        <% } else { %>
                            <a href="professor?action=ativar&id=<%= prof.getId_professor() %>" 
                               class="btn btn-ativar"
                               onclick="return confirm('Ativar este professor?')">
                                Ativar
                            </a>
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8" class="vazio">Nenhum professor cadastrado</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <p style="margin-top: 20px;">
        <a href="../home_admin.html">← Voltar para Home</a>
    </p>
    
</div>

</body>
</html>