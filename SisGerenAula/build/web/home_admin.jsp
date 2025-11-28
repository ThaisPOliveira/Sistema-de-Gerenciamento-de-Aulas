<!DOCTYPE html>
<%@ page import="model.DAO.AlunoDAO" %>
<%@ page import="model.DAO.TurmaDAO" %>
<%@ page import="model.DAO.DisciplinaDAO" %>
<%@ page import="model.DAO.ProfessorDAO" %>

<%
    TurmaDAO turmaDAO = new TurmaDAO();
    DisciplinaDAO disciplinaDAO = new DisciplinaDAO();
    ProfessorDAO professorDAO = new ProfessorDAO();
    AlunoDAO alunoDAO = new AlunoDAO();
%>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Admin - Sistema de Gerenciamento</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="style.css"/>
    </head>
    <body>
        <div class="app-container">
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
                    <!-- Dashboard -->
                    <a href="home_admin.jsp" class="menu-item active">
                        <div class="menu-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="menu-text">Dashboard</div>
                    </a>

                    <div class="menu-divider"></div>

                    <!-- Turmas -->
                    <a href="class/ClassList.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="menu-text">Turmas</div>
                    </a>

                    <!-- Disciplinas -->
                    <a href="course/list_course.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="menu-text">Disciplinas</div>
                    </a>

                    <!-- Professores -->
                    <a href="professor/list_professor.jsp" class="menu-item">
                        <div class="menu-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div class="menu-text">Professores</div>
                    </a>

                    <div class="menu-divider"></div>

                    <!-- Sair -->
                    <a href="index.html" class="menu-item">
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
                        <h1>Dashboard Admin</h1>
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
                    <!-- Seção de Boas-vindas -->
                    <div class="welcome-section fade-in-up">
                        <h2 class="welcome-title">Bem-vindo ao Sistema de Gerenciamento</h2>
                        <p class="welcome-subtitle">Gerencie turmas, disciplinas e professores de forma eficiente e intuitiva</p>
                    </div>

                    <!-- Stats Container CORRETO -->
                    <div class="stats-container">
                        <!-- Card Turmas -->
                        <div class="stat-card turmas glow-card fade-in-up">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number" id="countTurmas"><%= turmaDAO.countTurmas()%></div>
                                <div class="stat-label">Turmas Ativas</div>
                            </div>
                        </div>

                        <!-- Card Disciplinas -->
                        <div class="stat-card disciplinas glow-card fade-in-up">
                            <div class="stat-icon">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number" id="countDisciplinas"><%= disciplinaDAO.countDisciplinas()%></div>
                                <div class="stat-label">Disciplinas</div>
                            </div>
                        </div>

                        <!-- Card Professores -->
                        <div class="stat-card professores glow-card fade-in-up">
                            <div class="stat-icon">
                                <i class="fas fa-chalkboard-teacher"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number" id="countProfessores"><%= professorDAO.countProfessores()%></div>
                                <div class="stat-label">Professores</div>
                            </div>
                        </div>

                        <!-- Card Alunos -->
                        <div class="stat-card alunos glow-card fade-in-up">
                            <div class="stat-icon">
                                <i class="fas fa-user-graduate"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number" id="countAlunos"><%= alunoDAO.countAlunos()%></div>
                                <div class="stat-label">Alunos</div>
                            </div>
                        </div>
                    </div>

                    <!-- Actions Container -->
                    <div class="actions-container">
                        <div class="action-section turmas-section glow-card fade-in-up">
                            <div class="section-header">
                                <div class="section-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3 class="section-title">Turmas</h3>
                            </div>

                            <div class="menu-links">
                                <a href="class/ClassForm.jsp" class="btn-link">
                                    <i class="fas fa-plus-circle"></i>
                                    Cadastrar Nova Turma
                                </a>
                                <a href="class/ClassList.jsp" class="btn-link">
                                    <i class="fas fa-list"></i>
                                    Visualizar Turmas Cadastradas
                                </a>
                            </div>
                        </div>

                        <div class="action-section disciplinas-section glow-card fade-in-up">
                            <div class="section-header">
                                <div class="section-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <h3 class="section-title">Disciplinas</h3>
                            </div>

                            <div class="menu-links">
                                <a href="course/course.html" class="btn-link">
                                    <i class="fas fa-plus-circle"></i>
                                    Cadastrar Nova Disciplina
                                </a>
                                <a href="course/list_course.jsp" class="btn-link">
                                    <i class="fas fa-list"></i>
                                    Visualizar Disciplinas Cadastradas
                                </a>
                            </div>
                        </div>

                        <div class="action-section professores-section glow-card fade-in-up">
                            <div class="section-header">
                                <div class="section-icon">
                                    <i class="fas fa-chalkboard-teacher"></i>
                                </div>
                                <h3 class="section-title">Professores</h3>
                            </div>

                            <div class="menu-links">
                                <a href="professor/regist_professor.jsp" class="btn-link">
                                    <i class="fas fa-plus-circle"></i>
                                    Cadastrar Novo Professor
                                </a>
                                <a href="professor/list_professor.jsp" class="btn-link">
                                    <i class="fas fa-list"></i>
                                    Visualizar Professores Cadastrados
                                </a>
                            </div>
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

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Animações dos cards
                const cards = document.querySelectorAll('.fade-in-up');
                cards.forEach((card, index) => {
                    card.style.animationDelay = `${index * 0.1}s`;
                });

                // Menu items
                const menuItems = document.querySelectorAll('.menu-item');
                menuItems.forEach(item => {
                    item.addEventListener('click', function () {
                        menuItems.forEach(i => i.classList.remove('active'));
                        this.classList.add('active');
                    });
                });

                // Carregar contadores
                carregarContadores();
            });

            function carregarContadores() {
                // Pega os valores reais que já vieram do JSP
                const countTurmas = parseInt(document.getElementById('countTurmas').textContent);
                const countDisciplinas = parseInt(document.getElementById('countDisciplinas').textContent);
                const countProfessores = parseInt(document.getElementById('countProfessores').textContent);
                const countAlunos = parseInt(document.getElementById('countAlunos').textContent);

                // Reseta para 0 para poder animar
                document.getElementById('countTurmas').textContent = '0';
                document.getElementById('countDisciplinas').textContent = '0';
                document.getElementById('countProfessores').textContent = '0';
                document.getElementById('countAlunos').textContent = '0';

                // Anima os contadores
                setTimeout(() => {
                    animarContador(document.getElementById('countTurmas'), countTurmas);
                    animarContador(document.getElementById('countDisciplinas'), countDisciplinas);
                    animarContador(document.getElementById('countProfessores'), countProfessores);
                    animarContador(document.getElementById('countAlunos'), countAlunos);
                }, 500);
            }

            // Função para animar os números (contador animado)
            function animarContador(element, valorFinal, duracao = 2000) {
                let valorInicial = 0;
                const incremento = valorFinal / (duracao / 16);
                let valorAtual = valorInicial;

                const timer = setInterval(() => {
                    valorAtual += incremento;
                    if (valorAtual >= valorFinal) {
                        valorAtual = valorFinal;
                        clearInterval(timer);
                    }
                    element.textContent = Math.floor(valorAtual);
                }, 16);
            }
        </script>
    </body>
</html>