<%-- 
    Document   : ClassList_prof
    Created on : 12 de nov. de 2025
    Author     : Matheus e Thais
--%>

<%@page import="model.Professor, java.util.List, model.DAO.ProfessorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Professores - Sistema de Gerenciamento</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #007BFF;
            --primary-dark: #0056b3;
            --primary-light: #4dabf7;
            --secondary-color: #6c757d;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --sidebar-width: 250px;
            --header-height: 70px;
            --footer-height: 60px;
            --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: #f5f7fb;
            color: var(--dark-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden; /* Previne scroll horizontal no body */
        }
        
        .app-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        
        .sidebar {
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.1);
        }
        
        .sidebar-header {
            padding: 25px 20px;
            display: flex;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .logo {
            display: flex;
            align-items: center;
        }
        
        .logo-icon {
            font-size: 28px;
            margin-right: 12px;
            background: rgba(255, 255, 255, 0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .logo-text {
            font-size: 20px;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }
        
        .logo-text:hover {
            text-decoration: none;
            color: white;
        }
        
        .sidebar-menu {
            padding: 20px 0;
        }
        
        .sidebar-menu a.menu-item {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            text-decoration: none;
            color: white;
            transition: var(--transition);
            cursor: pointer;
            border-left: 4px solid transparent;
        }
        
        .sidebar-menu a.menu-item:hover {
            background: rgba(255, 255, 255, 0.1);
            border-left-color: rgba(255, 255, 255, 0.5);
            color: white;
            text-decoration: none;
        }
        
        .sidebar-menu a.menu-item.active {
            background: rgba(255, 255, 255, 0.15);
            border-left-color: white;
            color: white;
            text-decoration: none;
        }
        
        .menu-icon {
            margin-right: 15px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }
        
        .menu-text {
            font-size: 16px;
            font-weight: 500;
        }
        
        .menu-divider {
            height: 1px;
            background: rgba(255, 255, 255, 0.1);
            margin: 15px 0;
        }
        
        .sidebar-menu a.menu-item:focus {
            outline: none;
            text-decoration: none;
        }
        
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            width: calc(100% - var(--sidebar-width));
            max-width: 100%;
        }
        
        .header {
            height: var(--header-height);
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            position: sticky;
            top: 0;
            z-index: 100;
            width: 100%;
        }
        
        .header-left h1 {
            font-size: 22px;
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .header-right {
            display: flex;
            align-items: center;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
            padding: 8px 15px;
            border-radius: 30px;
            transition: var(--transition);
        }
        
        .user-profile:hover {
            background: var(--light-color);
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            margin-right: 12px;
        }
        
        .user-info {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-weight: 600;
            font-size: 15px;
        }
        
        .user-role {
            font-size: 13px;
            color: var(--secondary-color);
        }
        
        .page-content {
            flex: 1;
            padding: 30px;
            background: #f5f7fb;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        
        .list-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        
        .list-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--success-color), var(--warning-color));
        }
        
        .list-header {
            margin-bottom: 30px;
        }
        
        .list-title {
            font-size: 28px;
            color: var(--dark-color);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .list-subtitle {
            color: var(--secondary-color);
            font-size: 16px;
        }
        
        .mensagem {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            font-weight: 600;
            text-align: center;
            border-left: 4px solid;
        }
        
        .mensagem-sucesso {
            background: #d4edda;
            color: #155724;
            border-left-color: var(--success-color);
        }
        
        .mensagem-erro {
            background: #f8d7da;
            color: #721c24;
            border-left-color: var(--danger-color);
        }
        
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn {
            padding: 14px 28px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: var(--transition);
            text-decoration: none;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
            min-width: 140px;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }
        
        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
            text-decoration: none;
            color: white;
        }
        
        .tabela-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: var(--shadow);
            margin: 25px 0;
            width: 100%;
            max-width: 100%;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            min-width: 1000px; /* Largura mínima para a tabela */
        }
        
        th {
            background: var(--primary-color);
            color: white;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            white-space: nowrap;
        }
        
        td {
            padding: 16px 15px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
            white-space: nowrap;
        }
        
        tr:hover {
            background-color: #f8f9fa;
            transition: var(--transition);
        }
        
        .actions {
            white-space: nowrap;
            display: flex;
            gap: 8px;
        }
        
        .btn-action {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-editar {
            background: var(--success-color);
            color: white;
        }
        
        .btn-editar:hover {
            background: #218838;
            transform: translateY(-2px);
            text-decoration: none;
        }
        
        .btn-desativar {
            background: var(--warning-color);
            color: #212529;
        }
        
        .btn-desativar:hover {
            background: #e0a800;
            transform: translateY(-2px);
            text-decoration: none;
        }
        
        .btn-ativar {
            background: var(--info-color);
            color: white;
        }
        
        .btn-ativar:hover {
            background: #138496;
            transform: translateY(-2px);
            text-decoration: none;
        }
        
        .vazio {
            color: var(--secondary-color);
            font-style: italic;
            text-align: center;
            padding: 60px 20px;
            font-size: 16px;
        }
        
        .professor-inativo {
            background-color: #f8f9fa;
            opacity: 0.7;
        }
        
        .status-ativo {
            color: var(--success-color);
            font-weight: bold;
        }
        
        .status-inativo {
            color: var(--danger-color);
            font-weight: bold;
            opacity: 0.6;
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
        
        .btn-voltar {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 25px;
            background: var(--secondary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 600;
            margin-top: 20px;
        }
        
        .btn-voltar:hover {
            background: #545b62;
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
        }
        
        .footer {
            background: white;
            padding: 20px 30px;
            border-top: 1px solid #eee;
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
        }
        
        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .footer-text {
            color: var(--secondary-color);
            font-size: 14px;
        }
        
        .footer-links {
            display: flex;
            gap: 20px;
        }
        
        .footer-link {
            color: var(--secondary-color);
            text-decoration: none;
            font-size: 14px;
            transition: var(--transition);
        }
        
        .footer-link:hover {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        /* Scrollbar customizada para a tabela */
        .tabela-container::-webkit-scrollbar {
            height: 8px;
        }
        
        .tabela-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        .tabela-container::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }
        
        .tabela-container::-webkit-scrollbar-thumb:hover {
            background: var(--primary-dark);
        }
        
        @media (max-width: 1200px) {
            table {
                min-width: 900px;
            }
            
            th, td {
                padding: 14px 12px;
                font-size: 13px;
            }
        }
        
        @media (max-width: 992px) {
            .sidebar {
                width: 70px;
                overflow: visible;
            }
            
            .logo-text, .menu-text {
                display: none;
            }
            
            .sidebar-menu a.menu-item {
                justify-content: center;
                padding: 15px;
            }
            
            .menu-icon {
                margin-right: 0;
            }
            
            .main-content, .footer {
                margin-left: 70px;
                width: calc(100% - 70px);
            }
            
            .sidebar:hover {
                width: var(--sidebar-width);
            }
            
            .sidebar:hover .logo-text,
            .sidebar:hover .menu-text {
                display: block;
            }
            
            .sidebar:hover .sidebar-menu a.menu-item {
                justify-content: flex-start;
                padding: 15px 25px;
            }
            
            .sidebar:hover .menu-icon {
                margin-right: 15px;
            }
            
            table {
                min-width: 800px;
            }
        }
        
        @media (max-width: 768px) {
            .header {
                padding: 0 20px;
            }
            
            .page-content {
                padding: 20px;
            }
            
            .header-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .btn-action {
                width: 100%;
                justify-content: center;
            }
            
            .btn {
                flex: none;
                width: 100%;
            }
            
            table {
                min-width: 700px;
                font-size: 12px;
            }
            
            th, td {
                padding: 12px 8px;
            }
            
            .footer-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
        
        @media (max-width: 576px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.mobile-open {
                transform: translateX(0);
            }
            
            .main-content, .footer {
                margin-left: 0;
                width: 100%;
            }
            
            table {
                min-width: 600px;
            }
            
            .list-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <a href="../home_admin.jsp" class="logo-text">Gerenciamento de Aulas</a>
                </div>
            </div>
            
            <div class="sidebar-menu">
                <a href="../home_admin.html" class="menu-item">
                    <div class="menu-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="menu-text">Dashboard</div>
                </a>
                
                <div class="menu-divider"></div>
                
                <a href="../class/ClassList.jsp" class="menu-item">
                    <div class="menu-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="menu-text">Turmas</div>
                </a>
                
                <a href="../course/list_course.jsp" class="menu-item">
                    <div class="menu-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="menu-text">Disciplinas</div>
                </a>
                
                <a href="list_professor.jsp" class="menu-item active">
                    <div class="menu-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <div class="menu-text">Professores</div>
                </a>
               
                <div class="menu-divider"></div>
                
                <a href="../index.html" class="menu-item">
                    <div class="menu-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <div class="menu-text">Sair do Sistema</div>
                </a>
            </div>
        </div>
        
        <div class="main-content">
            <header class="header">
                <div class="header-left">
                    <h1>Lista de Professores</h1>
                </div>
                
                <div class="header-right">
                    <div class="user-profile">
                        <div class="user-avatar">AD</div>
                        <div class="user-info">
                            <div class="user-name">Administrador</div>
                            <div class="user-role">Super Usuário</div>
                        </div>
                    </div>
                </div>
            </header>
            
            <div class="page-content">
                <div class="list-container">
                    <div class="list-header">
                        <h2 class="list-title">
                            <i class="fas fa-chalkboard-teacher"></i>
                            Lista de Professores
                        </h2>
                        <p class="list-subtitle">Gerencie todos os professores do sistema</p>
                    </div>

                    <% if (request.getParameter("sucesso") != null) {%>
                        <div class="mensagem mensagem-sucesso">
                            ✅ <%= request.getParameter("sucesso")%>
                        </div>
                    <% } %>

                    <% if (request.getParameter("erro") != null) {%>
                        <div class="mensagem mensagem-erro">
                            ❌ <%= request.getParameter("erro")%>
                        </div>
                    <% } %>

                    <div class="header-container">
                        <a href="regist_professor.jsp" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Novo Professor
                        </a>
                    </div>

                    <%
                        List<Professor> professores = null;
                        try {
                            ProfessorDAO professorDAO = new ProfessorDAO();
                            professores = professorDAO.listarTodos();
                        } catch (Exception e) {
                            out.println("<div class='mensagem mensagem-erro'>Erro ao carregar professores: " + e.getMessage() + "</div>");
                            e.printStackTrace();
                        }
                    %>

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
                                    if (professores != null && !professores.isEmpty()) {
                                        for (Professor prof : professores) {
                                %>
                                <tr class="<%= !prof.isAtivo() ? "professor-inativo" : ""%>">
                                    <td>
                                        <% if (prof.getImagem() != null && prof.getImagem().length > 0) {%>
                                        <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(prof.getImagem())%>" 
                                             class="foto-professor" alt="Foto">
                                        <% } else { %>
                                        <div class="sem-foto">Sem foto</div>
                                        <% }%>
                                    </td>
                                    <td><strong><%= prof.getNome()%></strong></td>
                                    <td><%= prof.getEmail()%></td>
                                    <td><%= prof.getFormacao()%></td>
                                    <td><%= prof.getCpf()%></td>
                                    <td><%= prof.getTelefone() != null ? prof.getTelefone() : "N/A"%></td>
                                    <td>
                                        <% if (prof.isAtivo()) { %>
                                        <span class="status-ativo">● Ativo</span>
                                        <% } else { %>
                                        <span class="status-inativo">● Inativo</span>
                                        <% }%>
                                    </td>
                                   <td class="actions">
                                        <a href="edit_professor.jsp?id=<%= prof.getId_professor()%>" class="btn-action btn-editar">
                                            <i class="fas fa-edit"></i>
                                            Editar
                                        </a>

                                        <% if (prof.isAtivo()) {%>
                                        <a href="status_professor.jsp?action=desativar&id=<%= prof.getId_professor()%>" 
                                           class="btn-action btn-desativar"
                                           onclick="return confirm('Tem certeza que deseja desativar o professor <%= prof.getNome() %>?')">
                                            <i class="fas fa-ban"></i>
                                            Desativar
                                        </a>
                                        <% } else {%>
                                        <a href="status_professor.jsp?action=ativar&id=<%= prof.getId_professor()%>" 
                                           class="btn-action btn-ativar"
                                           onclick="return confirm('Tem certeza que deseja ativar o professor <%= prof.getNome() %>?')">
                                            <i class="fas fa-redo"></i>
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
                                    <td colspan="8" class="vazio">
                                        <i class="fas fa-chalkboard-teacher"></i><br>
                                        Nenhum professor cadastrado
                                    </td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>

                    <div style="text-align:center; margin-top:20px;">
                        <a href="../home_admin.html" class="btn-voltar">
                            <i class="fas fa-arrow-left"></i>
                            Voltar para Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-text">
                &copy; 2025 Sistema de Gerenciamento de Aulas. Todos os direitos reservados.
            </div>
            <div class="footer-links">
                <a href="#" class="footer-link">Política de Privacidade</a>
                <a href="#" class="footer-link">Termos de Uso</a>
                <a href="#" class="footer-link">Suporte</a>
            </div>
        </div>
    </footer>
</body>
</html>