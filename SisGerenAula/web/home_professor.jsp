<!DOCTYPE html>
<!-- 
    Author     : Matheus Gabriel 
                 Thais Oliveira 
    UNIVERSIDADE MOGI DAS CRUZES 
-->
    
<%@page import="java.util.List"%>
<%@page import="model.Turma"%>
<%@page import="model.Professor"%>
<%@page import="model.DAO.TurmaDAO"%>

<%
    // Recuperar professor logado da sessão
    Professor prof = (Professor) session.getAttribute("professor");

    if (prof == null) {
        response.sendRedirect("index.html");
        return;
    }

    TurmaDAO dao = new TurmaDAO();
    List<Turma> turmas = dao.listarTurmasPorProfessor(prof.getId_professor());
    
    // Calcular estatísticas
    int totalAlunos = 0;
    for (Turma t : turmas) {
        totalAlunos += t.getAlunos().size();
    }
    
    // Contar disciplinas únicas
    java.util.Set<String> disciplinas = new java.util.HashSet<>();
    for (Turma t : turmas) {
        disciplinas.add(t.getNomeDisciplina());
    }
%>

<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Professor - Sistema de Gerenciamento</title>
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
       
            .menu-item a {
                color: inherit;
                text-decoration: none;
            }

            .menu-item a:hover {
                color: inherit;
                text-decoration: none;
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
        
        .info-box {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            border-left: 4px solid var(--success-color);
        }
        
        .info-box h3 {
            color: var(--dark-color);
            margin-bottom: 15px;
            font-size: 20px;
            display: flex;
            align-items: center;
        }
        
        .info-box h3 i {
            margin-right: 10px;
            color: var(--success-color);
        }
        
        .info-box p {
            color: var(--secondary-color);
            line-height: 1.6;
            margin-bottom: 0;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            transition: var(--transition);
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stat-card.turmas {
            border-left-color: var(--primary-color);
        }
        
        .stat-card.aulas {
            border-left-color: var(--success-color);
        }
        
        .stat-card.alunos {
            border-left-color: var(--warning-color);
        }
        
        .stat-card.disciplinas {
            border-left-color: var(--info-color);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            font-size: 24px;
        }
        
        .stat-card.turmas .stat-icon {
            background: rgba(0, 123, 255, 0.1);
            color: var(--primary-color);
        }
        
        .stat-card.aulas .stat-icon {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
        }
        
        .stat-card.alunos .stat-icon {
            background: rgba(255, 193, 7, 0.1);
            color: var(--warning-color);
        }
        
        .stat-card.disciplinas .stat-icon {
            background: rgba(23, 162, 184, 0.1);
            color: var(--info-color);
        }
        
        .stat-info {
            flex: 1;
        }
        
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: var(--secondary-color);
            font-size: 14px;
            font-weight: 500;
        }
        
        .actions-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .action-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--primary-color);
        }
        
        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .action-icon {
            font-size: 50px;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        .action-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-color);
        }
        
        .action-description {
            color: var(--secondary-color);
            margin-bottom: 25px;
            line-height: 1.5;
        }
        
        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 25px;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 600;
            border: none;
            cursor: pointer;
            width: 100%;
        }
        
        .btn-action:hover {
            background: var(--primary-dark);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        
        .btn-action i {
            margin-right: 8px;
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
            
            .actions-container {
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
                        <div class="menu-text" onclick="window.location.href='class/ClassList_prof.jsp'" >Minhas Turmas</div>
                    </div>
                    
                    <div class="menu-divider"></div> 
                     <div class="menu-item">
                    <div class="menu-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <div class="menu-text">
                        <a href="index.html">Sair do Sistema</a>
                    </div>
                </div>
                   
                </div>
        </div>
        
        <!-- Conteúdo Principal -->
        <div class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="header-left">
                    <h1>Dashboard Professor</h1>
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
                    
                    <h2 class="welcome-title">Bem-vindo ao Sistema de Visualização</h2>
                    <p class="welcome-subtitle">Acesso restrito para professores - Visualize suas turmas, atividades e acompanhe o desempenho dos alunos</p>
                </div>
                
                <div class="info-box fade-in-up">
                    <h3><i class="fas fa-info-circle"></i> Seu Painel de Controle</h3>
                    <p>Aqui você pode visualizar todas as turmas atribuídas, gerenciar suas aulas, criar atividades e acompanhar o desempenho dos alunos de forma intuitiva e eficiente.</p>
                </div>
                
                <div class="stats-container">
                    <div class="stat-card turmas glow-card fade-in-up">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-number"><%= turmas.size() %></div>
                            <div class="stat-label">Turmas Ativas</div>
                        </div>
                    </div>
                    
                    <div class="stat-card alunos glow-card fade-in-up">
                        <div class="stat-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-number"><%= totalAlunos %></div>
                            <div class="stat-label">Total de Alunos</div>
                        </div>
                    </div>
                    
                    <div class="stat-card disciplinas glow-card fade-in-up">
                        <div class="stat-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-number"><%= disciplinas.size() %></div>
                            <div class="stat-label">Disciplinas Ministradas</div>
                        </div>
                    </div>
                </div>
                
                <div class="actions-container">
                    <!-- Visualizar Turmas -->
                    <div class="action-card glow-card fade-in-up">
                        <div class="action-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="action-title">Minhas Turmas</h3>
                        <p class="action-description">Visualize todas as turmas atribuídas a você, com informações detalhadas sobre alunos, horários e disciplinas.</p>
                        <a href="class/ClassList_prof.jsp" class="btn-action">
                            <i class="fas fa-eye"></i>
                            Visualizar Turmas
                        </a>
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