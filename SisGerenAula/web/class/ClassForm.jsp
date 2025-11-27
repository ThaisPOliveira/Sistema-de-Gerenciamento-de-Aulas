<%-- 
    Document   : ClassList_prof
    Created on : 12 de nov. de 2025
    Author     : Matheus e Thais
--%>


<%@page import="java.util.List"%>
<%@page import="model.Professor"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.Disciplina"%>
<%@page import="model.DAO.DisciplinaDAO"%>
<%@page import="model.Aluno"%>
<%@page import="model.DAO.AlunoDAO"%>
<%@page import="model.DAO.CourseDAO"%>
<%@page import="model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Turma - Sistema de Gerenciamento</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
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

            /* ESTILOS PARA LINKS DO MENU */
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

            /* Remove qualquer estilo de link */
            .sidebar-menu a.menu-item:focus {
                outline: none;
                text-decoration: none;
            }

            /* Conteúdo Principal */
            .main-content {
                flex: 1;
                margin-left: var(--sidebar-width);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Header */
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

            /* Conteúdo da Página */
            .page-content {
                flex: 1;
                padding: 30px;
                background: #f5f7fb;
            }

            .form-container {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: var(--shadow);
                margin-bottom: 30px;
                position: relative;
                overflow: hidden;
            }

            .form-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, var(--primary-color), var(--success-color), var(--warning-color));
            }

            .form-header {
                margin-bottom: 30px;
            }

            .form-title {
                font-size: 28px;
                color: var(--dark-color);
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .form-subtitle {
                color: var(--secondary-color);
                font-size: 16px;
            }

            /* Alertas */
            .alert {
                padding: 15px 20px;
                margin-bottom: 25px;
                border-radius: 10px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 12px;
                animation: slideIn 0.5s ease-out;
                border-left: 4px solid;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border-left-color: var(--success-color);
            }

            .alert-error {
                background: #f8d7da;
                color: #721c24;
                border-left-color: var(--danger-color);
            }

            .alert-warning {
                background: #fff3cd;
                color: #856404;
                border-left-color: var(--warning-color);
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Formulários */
            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 25px;
            }

            .form-col {
                flex: 1;
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 8px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .campo-obrigatorio::after {
                content: " *";
                color: var(--danger-color);
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="time"],
            input[type="number"],
            input[type="file"],
            textarea,
            select {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                font-size: 15px;
                box-sizing: border-box;
                transition: var(--transition);
                background: white;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="password"]:focus,
            input[type="time"]:focus,
            input[type="number"]:focus,
            input[type="file"]:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
                transform: translateY(-2px);
            }

            /* Select2 Customizado */
            .select2-container--default .select2-selection--multiple {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                min-height: 50px;
                padding: 8px;
                transition: var(--transition);
            }

            .select2-container--default .select2-selection--multiple:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
            }

            .select2-container--default .select2-selection--multiple .select2-selection__choice {
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 4px 8px;
                font-size: 13px;
            }

            /* Informações adicionais */
            .info-text {
                font-size: 13px;
                color: var(--secondary-color);
                margin-top: 6px;
                font-style: italic;
            }

            .alunos-selecionados {
                margin-top: 12px;
                padding: 12px 15px;
                background: #e7f3ff;
                border-radius: 8px;
                border-left: 4px solid var(--primary-color);
                font-size: 14px;
                color: var(--primary-dark);
                font-weight: 500;
            }

            /* Botões */
            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
                flex-wrap: wrap;
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

            .btn-secondary {
                background: var(--secondary-color);
                color: white;
            }

            .btn-secondary:hover {
                background: #545b62;
                transform: translateY(-3px);
                text-decoration: none;
                color: white;
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

            /* Footer */
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

            /* Responsividade */
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
            }

            @media (max-width: 768px) {
                .header {
                    padding: 0 20px;
                }

                .page-content {
                    padding: 20px;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }

                .btn-group {
                    flex-direction: column;
                }

                .btn {
                    flex: none;
                    width: 100%;
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
        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Sidebar -->
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
                    <!-- Dashboard -->
                    <a href="../home_admin.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="menu-text">Dashboard</div>
                    </a>

                    <div class="menu-divider"></div>

                    <!-- Turmas -->
                    <a href="../class/ClassList.jsp" class="menu-item active">
                        <div class="menu-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="menu-text">Turmas</div>
                    </a>
                    
                    <!-- Disciplinas -->
                    <a href="../course/list_course.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="menu-text">Disciplinas</div>
                    </a>

                    <!-- Professores -->
                    <a href="../professor/list_professor.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div class="menu-text">Professores</div>
                    </a>

                    <div class="menu-divider"></div>

                    <!-- Sair -->
                    <a href="../index.html" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-sign-out-alt"></i>
                        </div>
                        <div class="menu-text">Sair do Sistema</div>
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <header class="header">
                    <div class="header-left">
                        <h1>Cadastro de Turma</h1>
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

                <!-- Content -->
                <div class="page-content">
                    <div class="form-container fade-in-up">
                        <div class="form-header">
                            <h2 class="form-title">
                                <i class="fas fa-users"></i>
                                Cadastro de Nova Turma
                            </h2>
                            <p class="form-subtitle">Preencha os dados abaixo para cadastrar uma nova turma no sistema</p>
                        </div>

                        <form method="post" action="ClassProcess.jsp" id="turmaForm">
                            <!-- Nome da turma -->
                            <div class="form-group">
                                <label class="campo-obrigatorio">
                                    <i class="fas fa-tag"></i>
                                    Nome da Turma:
                                </label>
                                <input type="text" name="nomeTurma" required placeholder="Ex: Turma A - Matemática Avançada">
                            </div>

                            <!-- Professor e Horário -->
                            <div class="form-row">
                                <div class="form-col">
                                    <div class="form-group">
                                        <label class="campo-obrigatorio">
                                            <i class="fas fa-chalkboard-teacher"></i>
                                            Professor:
                                        </label>
                                        <select name="nomeProfessor" required>
                                            <option value="">Selecione um professor</option>
                                            <%
                                                ProfessorDAO pdao = new ProfessorDAO();
                                                List<Professor> professores = pdao.listarTodos();
                                                for (Professor prof : professores) {
                                            %>
                                            <option value="<%= prof.getNome()%>"><%= prof.getNome()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-col">
                                    <div class="form-group">
                                        <label class="campo-obrigatorio">
                                            <i class="fas fa-clock"></i>
                                            Horário:
                                        </label>
                                        <input type="time" name="horario" required>
                                    </div>
                                </div>
                            </div>

                            <!-- Disciplina -->
                            <div class="form-group">
                                <label class="campo-obrigatorio">
                                    <i class="fas fa-book"></i>
                                    Disciplina:
                                </label>
                                <select name="idDisciplina" required>
                                    <option value="">Selecione uma disciplina</option>
                                    <%
                                        CourseDAO cdao = new CourseDAO();
                                        List<Course> disciplinas = cdao.listarTodas();
                                        for (Course d : disciplinas) {
                                    %>
                                    <option value="<%= d.getId()%>" title="<%= d.getDescricao()%>">
                                        <%= d.getNome()%> - <%= d.getNivel()%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <!-- Alunos select2 -->
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-user-graduate"></i>
                                    Alunos:
                                </label>
                                <select name="alunosSelecionados" multiple="multiple" id="alunosSelect" style="width: 100%;">
                                    <%
                                        AlunoDAO adao = new AlunoDAO();
                                        List<Aluno> alunos = adao.listarAlunos();
                                        for (Aluno a : alunos) {
                                    %>
                                    <option value="<%= a.getId()%>"><%= a.getNome()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                                <div class="info-text">Selecione um ou mais alunos (opcional)</div>
                            </div>

                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    Cadastrar Turma
                                </button>
                                <button type="reset" class="btn btn-secondary">
                                    <i class="fas fa-broom"></i>
                                    Limpar
                                </button>
                            </div>
                        </form>

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

        <!-- Footer -->
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
            // Função para mostrar alertas
            function showAlert(message, type) {
                const existingAlert = document.querySelector('.alert');
                if (existingAlert) {
                    existingAlert.remove();
                }

                const alertDiv = document.createElement('div');
                alertDiv.className = `alert alert-${type}`;

                const icon = type === 'success' ? 'fas fa-check-circle' :
                        type === 'error' ? 'fas fa-exclamation-circle' :
                        type === 'warning' ? 'fas fa-exclamation-triangle' : 'fas fa-info-circle';

                alertDiv.innerHTML = `
                    <i class="${icon}"></i>
                    <span class="alert-message">${message}</span>
                `;

                const container = document.querySelector('.form-container');
                const formHeader = document.querySelector('.form-header');
                container.insertBefore(alertDiv, formHeader.nextSibling);

                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.style.opacity = '0';
                        alertDiv.style.transform = 'translateY(-20px)';
                        setTimeout(() => alertDiv.remove(), 300);
                    }
                }, 5000);
            }

            // Verifica parâmetros da URL para mostrar alertas
            document.addEventListener('DOMContentLoaded', function () {
                const urlParams = new URLSearchParams(window.location.search);
                const sucesso = urlParams.get('sucesso');
                const erro = urlParams.get('erro');

                if (sucesso) {
                    showAlert(sucesso, 'success');
                    window.history.replaceState({}, document.title, window.location.pathname);
                }

                if (erro) {
                    showAlert(erro, 'error');
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            });

            $(document).ready(function () {
                $('#alunosSelect').select2({
                    placeholder: "Selecione os alunos...",
                    allowClear: true,
                    width: '100%',
                    language: {
                        noResults: function () {
                            return "Nenhum aluno encontrado";
                        }
                    }
                });

                $('#alunosSelect').on('change', function () {
                    const selected = $(this).val();
                    $('.alunos-selecionados').remove();

                    if (selected && selected.length > 0) {
                        $(this).after(`<div class="alunos-selecionados">
                            <i class="fas fa-user-graduate"></i>
            ${selected.length} aluno(s) selecionado(s)
                        </div>`);
                    }
                });

                // Validação do formulário
                $('#turmaForm').on('submit', function (e) {
                    const nomeTurma = $('input[name="nomeTurma"]').val().trim();
                    const professor = $('select[name="nomeProfessor"]').val();
                    const horario = $('input[name="horario"]').val();
                    const disciplina = $('select[name="idDisciplina"]').val();

                    if (!nomeTurma || !professor || !horario || !disciplina) {
                        e.preventDefault();
                        showAlert('Por favor, preencha todos os campos obrigatórios.', 'warning');
                        return false;
                    }

                    // Mostra loading
                    $('button[type="submit"]').html('<i class="fas fa-spinner fa-spin"></i> Cadastrando...');
                    $('button[type="submit"]').prop('disabled', true);
                });
            });
        </script>
    </body>
</html>