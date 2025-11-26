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
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Minhas Turmas - Sistema de Gerenciamento</title>
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
            }
            
            /* Layout Principal */
            .app-container {
                display: flex;
                min-height: 100vh;
            }
            
            /* Sidebar/Menu Lateral */
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
            }
            
            .sidebar-menu {
                padding: 20px 0;
            }
            
            .menu-item {
                padding: 15px 25px;
                display: flex;
                align-items: center;
                transition: var(--transition);
                cursor: pointer;
                border-left: 4px solid transparent;
            }
            
            .menu-item:hover {
                background: rgba(255, 255, 255, 0.1);
                border-left-color: rgba(255, 255, 255, 0.5);
            }
            
            .menu-item.active {
                background: rgba(255, 255, 255, 0.15);
                border-left-color: white;
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
            
            .main-content {
                flex: 1;
                margin-left: var(--sidebar-width);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
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
                background: var(--warning-color);
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
            
            /* Conteúdo da Página */
            .page-content {
                flex: 1;
                padding: 30px;
                background: #f5f7fb;
            }
            
            .welcome-section {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: var(--shadow);
                margin-bottom: 30px;
                position: relative;
                overflow: hidden;
                text-align: center;
            }
            
            .welcome-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, var(--primary-color), var(--success-color), var(--warning-color));
            }
            
            .welcome-icon {
                font-size: 60px;
                color: var(--warning-color);
                margin-bottom: 20px;
            }
            
            .welcome-title {
                font-size: 28px;
                color: var(--dark-color);
                margin-bottom: 10px;
            }
            
            .welcome-subtitle {
                color: var(--secondary-color);
                font-size: 16px;
                margin-bottom: 20px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.6;
            }
            
            .footer {
                background: white;
                padding: 20px 30px;
                border-top: 1px solid #eee;
                margin-left: var(--sidebar-width);
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
            
            /* Botão Sair */
            .btn-sair {
                display: inline-flex;
                align-items: center;
                padding: 12px 25px;
                background: var(--danger-color);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                transition: var(--transition);
                font-weight: 600;
                border: none;
                cursor: pointer;
                margin-top: 20px;
            }
            
            .btn-sair:hover {
                background: #c82333;
                color: white;
                text-decoration: none;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
            }
            
            .btn-sair i {
                margin-right: 8px;
            }
            
            /* Estilos específicos da página de listagem de turmas */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }
            
            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--shadow);
                display: flex;
                align-items: center;
                transition: var(--transition);
                border-left: 4px solid var(--primary-color);
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
            }
            
            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                font-size: 20px;
                color: white;
                background: var(--primary-color);
            }
            
            .stat-info {
                flex: 1;
            }
            
            .stat-number {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 5px;
                color: var(--dark-color);
            }
            
            .stat-label {
                color: var(--secondary-color);
                font-size: 14px;
                font-weight: 500;
            }
            
            .turmas-container {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 25px;
                margin-bottom: 40px;
            }
            
            .turma-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: var(--shadow);
                transition: var(--transition);
                position: relative;
            }
            
            .turma-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            }
            
            .turma-header {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
                color: white;
                padding: 20px;
                position: relative;
                overflow: hidden;
            }
            
            .turma-header::before {
                content: '';
                position: absolute;
                top: -10px;
                right: -10px;
                width: 80px;
                height: 80px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
            }
            
            .turma-title {
                font-size: 22px;
                font-weight: 700;
                margin-bottom: 5px;
                position: relative;
                z-index: 1;
            }
            
            .turma-disciplina {
                font-size: 16px;
                opacity: 0.9;
                position: relative;
                z-index: 1;
            }
            
            .turma-body {
                padding: 20px;
            }
            
            .turma-info {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            
            .info-icon {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                background: rgba(0, 123, 255, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                color: var(--primary-color);
                font-size: 16px;
            }
            
            .info-text {
                flex: 1;
            }
            
            .info-label {
                font-size: 14px;
                color: var(--secondary-color);
                margin-bottom: 3px;
            }
            
            .info-value {
                font-size: 16px;
                font-weight: 600;
                color: var(--dark-color);
            }
            
            .alunos-section {
                margin-top: 20px;
                border-top: 1px solid #eee;
                padding-top: 15px;
            }
            
            .alunos-title {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 10px;
                color: var(--dark-color);
                display: flex;
                align-items: center;
            }
            
            .alunos-title i {
                margin-right: 8px;
                color: var(--primary-color);
            }
            
            .alunos-list {
                max-height: 120px;
                overflow-y: auto;
                padding-right: 5px;
            }
            
            .aluno-item {
                padding: 8px 10px;
                background: var(--light-color);
                border-radius: 6px;
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                transition: var(--transition);
            }
            
            .aluno-item:hover {
                background: rgba(0, 123, 255, 0.1);
                transform: translateX(5px);
            }
            
            .aluno-avatar {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background: var(--primary-color);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 12px;
                font-weight: 600;
                margin-right: 10px;
            }
            
            .aluno-nome {
                font-size: 14px;
                color: var(--dark-color);
            }
            
            .sem-alunos {
                text-align: center;
                padding: 15px;
                color: var(--secondary-color);
                font-style: italic;
                background: var(--light-color);
                border-radius: 8px;
            }
            
            .turma-footer {
                padding: 15px 20px;
                background: var(--light-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .turma-actions {
                display: flex;
                gap: 10px;
            }
            
            .btn-action {
                padding: 8px 15px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 500;
                cursor: pointer;
                transition: var(--transition);
                border: none;
                display: flex;
                align-items: center;
                gap: 5px;
            }
            
            .btn-primary {
                background: var(--primary-color);
                color: white;
            }
            
            .btn-primary:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
            }
            
            .btn-secondary {
                background: white;
                color: var(--primary-color);
                border: 1px solid var(--primary-color);
            }
            
            .btn-secondary:hover {
                background: var(--primary-color);
                color: white;
                transform: translateY(-2px);
            }
            
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                background: white;
                border-radius: 15px;
                box-shadow: var(--shadow);
                margin-bottom: 30px;
            }
            
            .empty-icon {
                font-size: 80px;
                color: #dee2e6;
                margin-bottom: 20px;
            }
            
            .empty-title {
                font-size: 24px;
                color: var(--secondary-color);
                margin-bottom: 10px;
            }
            
            .empty-text {
                color: var(--secondary-color);
                margin-bottom: 30px;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
                line-height: 1.6;
            }
            
            .btn-voltar {
                display: inline-flex;
                align-items: center;
                padding: 12px 25px;
                background: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                transition: var(--transition);
                font-weight: 600;
                gap: 8px;
                margin-top: 20px;
            }
            
            .btn-voltar:hover {
                background: var(--primary-dark);
                text-decoration: none;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
            }
            
            /* Custom scrollbar */
            .alunos-list::-webkit-scrollbar {
                width: 6px;
            }
            
            .alunos-list::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 10px;
            }
            
            .alunos-list::-webkit-scrollbar-thumb {
                background: var(--primary-color);
                border-radius: 10px;
            }
            
            .alunos-list::-webkit-scrollbar-thumb:hover {
                background: var(--primary-dark);
            }
            
            /* Animações */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .fade-in-up {
                animation: fadeInUp 0.6s ease-out;
            }
            
            /* Efeito de brilho nos cards */
            .glow-card {
                position: relative;
                overflow: hidden;
            }
            
            .glow-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
                transition: var(--transition);
            }
            
            .glow-card:hover::before {
                left: 100%;
            }
            
            /* Responsividade */
            @media (max-width: 992px) {
                .sidebar {
                    width: 70px;
                    overflow: visible;
                }
                
                .logo-text, .menu-text {
                    display: none;
                }
                
                .menu-item {
                    justify-content: center;
                    padding: 15px;
                }
                
                .menu-icon {
                    margin-right: 0;
                }
                
                .main-content, .footer {
                    margin-left: 70px;
                }
                
                .sidebar:hover {
                    width: var(--sidebar-width);
                }
                
                .sidebar:hover .logo-text,
                .sidebar:hover .menu-text {
                    display: block;
                }
                
                .sidebar:hover .menu-item {
                    justify-content: flex-start;
                    padding: 15px 25px;
                }
                
                .sidebar:hover .menu-icon {
                    margin-right: 15px;
                }
            }
            
            @media (max-width: 768px) {
                .header {
                    padding: 0 20px;
                }
                
                .page-content {
                    padding: 20px;
                }
                
                .stats-container {
                    grid-template-columns: 1fr;
                }
                
                .turmas-container {
                    grid-template-columns: 1fr;
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
                }
                
                .menu-toggle {
                    display: block;
                    font-size: 24px;
                    cursor: pointer;
                    color: var(--primary-color);
                }
                
                .turma-actions {
                    flex-direction: column;
                    width: 100%;
                }
                
                .btn-action {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Menu Lateral -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <div class="logo">
                        <div class="logo-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <div class="logo-text">Gerenciamento de Aulas</div>
                    </div>
                </div>
                
                <div class="sidebar-menu">
                    <div class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="menu-text" onclick="window.location.href='../home_professor.jsp'">Dashboard</div>
                        
                    </div>
                    
                    <div class="menu-divider"></div>
                    
                    <div class="menu-item active">
                        <div class="menu-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="menu-text" onclick="window.location.href='ClassList_prof.jsp'" >Minhas Turmas</div>
                    </div>
                    
                    <div class="menu-divider"></div>         
                   
                </div>
            </div>
            
            <!-- Conteúdo Principal -->
            <div class="main-content">
                <!-- Header -->
                <header class="header">
                    <div class="header-left">
                        <h1>Minhas Turmas</h1>
                    </div>
                    
                    <div class="header-right">
                        <div class="user-profile">
                            <div class="user-avatar">
                                <%= prof.getNome().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="user-info">
                                <div class="user-name">Prof. <%= prof.getNome() %></div>
                                <div class="user-role">Professor</div>
                            </div>
                        </div>
                    </div>
                </header>
                
                <!-- Conteúdo da Página -->
                <div class="page-content">
                    <div class="welcome-section fade-in-up">
                        <div class="welcome-icon">???</div>
                        <h2 class="welcome-title">Minhas Turmas</h2>
                        <p class="welcome-subtitle">Gerencie e visualize todas as suas turmas atribuídas</p>
                    </div>
                    
                    <div class="stats-container fade-in-up">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number"><%= turmas.size() %></div>
                                <div class="stat-label">Total de Turmas</div>
                            </div>
                        </div>
                        
                        <%
                            int totalAlunos = 0;
                            for (Turma t : turmas) {
                                totalAlunos += t.getAlunos().size();
                            }
                        %>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-user-graduate"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number"><%= totalAlunos %></div>
                                <div class="stat-label">Total de Alunos</div>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="stat-info">
                                <%
                                    // Contar disciplinas únicas
                                    java.util.Set<String> disciplinas = new java.util.HashSet<>();
                                    for (Turma t : turmas) {
                                        disciplinas.add(t.getNomeDisciplina());
                                    }
                                %>
                                <div class="stat-number"><%= disciplinas.size() %></div>
                                <div class="stat-label">Disciplinas Ministradas</div>
                            </div>
                        </div>
                    </div>
                    
                    <%
                        if (turmas.isEmpty()) {
                    %>
                    <div class="empty-state fade-in-up">
                        <div class="empty-icon">
                            <i class="fas fa-users-slash"></i>
                        </div>
                        <h2 class="empty-title">Nenhuma turma atribuída</h2>
                        <p class="empty-text">No momento, você não possui nenhuma turma cadastrada. Entre em contato com a administração para ser atribuído a uma turma.</p>
                        <a href="../home_professor.jsp" class="btn-voltar">
                            <i class="fas fa-arrow-left"></i>
                            Voltar à Home
                        </a>
                    </div>
                    <%
                        } else {
                    %>
                    <div class="turmas-container">
                        <%
                            for (Turma t : turmas) {
                        %>
                        <div class="turma-card fade-in-up">
                            <div class="turma-header">
                                <h2 class="turma-title"><%= t.getNomeTurma() %></h2>
                                <p class="turma-disciplina"><%= t.getNomeDisciplina() %></p>
                            </div>
                            
                            <div class="turma-body">
                                <div class="turma-info">
                                    <div class="info-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div class="info-text">
                                        <div class="info-label">Horário</div>
                                        <div class="info-value"><%= t.getHorario() %></div>
                                    </div>
                                </div>
                                
                                <div class="turma-info">
                                    <div class="info-icon">
                                        <i class="fas fa-user-friends"></i>
                                    </div>
                                    <div class="info-text">
                                        <div class="info-label">Quantidade de Alunos</div>
                                        <div class="info-value"><%= t.getAlunos().size() %> alunos</div>
                                    </div>
                                </div>
                                
                                <div class="alunos-section">
                                    <h3 class="alunos-title">
                                        <i class="fas fa-user-graduate"></i>
                                        Lista de Alunos
                                    </h3>
                                    
                                    <div class="alunos-list">
                                        <%
                                            if (t.getAlunos().isEmpty()) {
                                        %>
                                        <div class="sem-alunos">
                                            Nenhum aluno cadastrado nesta turma
                                        </div>
                                        <%
                                            } else {
                                                for (int i = 0; i < t.getAlunos().size(); i++) {
                                                    String nomeAluno = t.getAlunos().get(i).getNome();
                                                    String[] nomes = nomeAluno.split(" ");
                                                    String iniciais = "";
                                                    if (nomes.length >= 2) {
                                                        iniciais = nomes[0].substring(0, 1) + nomes[nomes.length - 1].substring(0, 1);
                                                    } else if (nomes.length == 1) {
                                                        iniciais = nomes[0].substring(0, 1);
                                                    }
                                        %>
                                        <div class="aluno-item">
                                            <div class="aluno-avatar">
                                                <%= iniciais.toUpperCase() %>
                                            </div>
                                            <div class="aluno-nome"><%= nomeAluno %></div>
                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="turma-footer">
                                <div class="turma-actions">
                                    <button class="btn-action btn-primary">
                                        <i class="fas fa-eye"></i>
                                        Descrição
                                    </button>
                                    <button class="btn-action btn-secondary">
                                        <i class="fas fa-chart-line"></i>
                                        Material
                                    </button>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <div style="text-align: center;">
                        <a href="../home_professor.jsp" class="btn-voltar">
                            <i class="fas fa-arrow-left"></i>
                            Voltar à Home
                        </a>
                    </div>
                    <%
                        }
                    %>
                    
                    <div style="text-align: center; margin-top: 40px;">
                        <a href="../index.html" class="btn-sair">
                            <i class="fas fa-sign-out-alt"></i>
                            Sair do Sistema
                        </a>
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

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const cards = document.querySelectorAll('.fade-in-up');
                cards.forEach((card, index) => {
                    card.style.animationDelay = `${index * 0.1}s`;
                });
                
                const menuItems = document.querySelectorAll('.menu-item');
                menuItems.forEach(item => {
                    item.addEventListener('click', function() {
                        menuItems.forEach(i => i.classList.remove('active'));
                        this.classList.add('active');
                    });
                });
            });
        </script>
    </body>
</html>