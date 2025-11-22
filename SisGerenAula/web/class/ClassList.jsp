<%@page import="java.util.List"%>
<%@page import="model.Class"%>
<%@page import="model.DAO.ClassDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Turmas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .titulo {
            color: #007BFF;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 15px;
            font-size: 24px;
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn-novo {
            background: #007BFF;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .btn-novo:hover {
            background: #0056b3;
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
        }
        
        .tabela-container {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
        }
        
        th {
            background: #007BFF;
            color: white;
            padding: 15px 12px;
            text-align: left;
            font-weight: bold;
            font-size: 14px;
        }
        
        td {
            padding: 15px 12px;
            border-bottom: 1px solid #e9ecef;
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
            font-size: 12px;
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
        
        .vazio {
            color: #6c757d;
            font-style: italic;
            text-align: center;
            padding: 40px 20px;
        }
        
        .actions {
            white-space: nowrap;
        }
        
        .info-turma {
            font-size: 12px;
            color: #6c757d;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
            margin-left: 5px;
        }
        
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="titulo">Lista de Turmas</h1>

        <div class="header-container">
            <a href="ClassForm.jsp" class="btn-novo">+ Nova Turma</a>
        </div>

        <div class="tabela-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome da Turma</th>
                        <th>Professor</th>
                        <th>Disciplina</th>
                        <th>Horário</th>
                        <th>Alunos</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ClassDAO dao = new ClassDAO();
                        List<Class> turmas = dao.listarTurmas();
                        
                        if (turmas != null && !turmas.isEmpty()) {
                            for (Class turma : turmas) {
                    %>
                    <tr>
                        <td><%= turma.getId() %></td>
                        <td>
                            <strong><%= turma.getNomeTurma() %></strong>
                        </td>
                        <td><%= turma.getNomeProfessor() %></td>
                        <td>
                            <%= turma.getNomeDisciplina() != null ? turma.getNomeDisciplina() : "N/A" %>
                        </td>
                        <td>
                            <span class="badge badge-success">
                                <%= turma.getHorario() != null ? turma.getHorario().toString().substring(0, 5) : "N/A" %>
                            </span>
                        </td>
                        <td>
                            <div class="info-turma">
                                <%= turma.getNomeAlunos() != null ? turma.getNomeAlunos() : "Nenhum aluno" %>
                            </div>
                        </td>
                        <td class="actions">
                            <a href="ClassEdit.jsp?id=<%= turma.getId() %>" class="btn btn-editar">Editar</a>
                            <a href="ClassDelete.jsp?id=<%= turma.getId() %>" 
                               class="btn btn-excluir"
                               onclick="return confirm('Tem certeza que deseja excluir esta turma?')">
                                Excluir
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="vazio">Nenhuma turma cadastrada</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <a href="../home_admin.html" class="btn-novo" style="background: #28a745;">← Voltar para Home</a>
        </div>
    </div>
</body>
</html>