<%-- 
    Document   : ClassList_prof
    Created on : 12 de nov. de 2025
    Author     : Matheus e Thais
--%>



<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Professor - Sistema de Gerenciamento</title>
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
        
        .app-container {
            display: flex;
            min-height: 100vh;
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
        input[type="file"]:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
            transform: translateY(-2px);
        }
        
        .info-text {
            font-size: 13px;
            color: var(--secondary-color);
            margin-top: 6px;
            font-style: italic;
        }
        
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
                <a href="../home_admin.jsp" class="menu-item">
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
                    <h1>Cadastro de Professor</h1>
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
                <div class="form-container">
                    <div class="form-header">
                        <h2 class="form-title">
                            <i class="fas fa-chalkboard-teacher"></i>
                            Cadastro de Novo Professor
                        </h2>
                        <p class="form-subtitle">Preencha os dados abaixo para cadastrar um novo professor no sistema</p>
                    </div>

                    <% if (request.getParameter("sucesso") != null) { %>
                        <div class="mensagem mensagem-sucesso">
                            ? <%= request.getParameter("sucesso") %>
                        </div>
                    <% } %>

                    <% if (request.getParameter("erro") != null) { %>
                        <div class="mensagem mensagem-erro">
                            ? <%= request.getParameter("erro") %>
                        </div>
                    <% } %>

                    <form action="../professor" method="post" enctype="multipart/form-data" id="professorForm">
                        <div class="form-row">
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-user"></i>
                                        Nome Completo:
                                    </label>
                                    <input type="text" name="nome" required placeholder="Ex: João Silva Santos">
                                </div>
                            </div>
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-id-card"></i>
                                        CPF:
                                    </label>
                                    <input type="text" name="cpf" maxlength="11" required placeholder="Somente números (11 dígitos)">
                                    <div class="info-text">Apenas números, sem pontos ou traços</div>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-envelope"></i>
                                        E-mail:
                                    </label>
                                    <input type="email" name="email" required placeholder="exemplo@email.com">
                                </div>
                            </div>
                            <div class="form-col">
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-phone"></i>
                                        Telefone:
                                    </label>
                                    <input type="text" name="telefone" maxlength="15" placeholder="(11) 99999-9999">
                                    <div class="info-text">Incluir DDD</div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="fas fa-graduation-cap"></i>
                                Formação:
                            </label>
                            <input type="text" name="formacao" placeholder="Ex: Graduação em Matemática">
                        </div>

                        <div class="form-row">
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-lock"></i>
                                        Senha:
                                    </label>
                                    <input type="password" name="senha" required placeholder="Mínimo 6 caracteres">
                                </div>
                            </div>
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-lock"></i>
                                        Confirmar Senha:
                                    </label>
                                    <input type="password" name="confirmar_senha" required placeholder="Digite a senha novamente">
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-col">
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-camera"></i>
                                        Foto:
                                    </label>
                                    <input type="file" name="imagem" accept="image/*">
                                    <div class="info-text">Formatos: JPG, PNG, GIF | Máximo: 2MB</div>
                                </div>
                            </div>
                            <div class="form-col">
                                <div class="form-group">
                                    <label class="campo-obrigatorio">
                                        <i class="fas fa-toggle-on"></i>
                                        Status:
                                    </label>
                                    <select name="ativo" required>
                                        <option value="true">Ativo</option>
                                        <option value="false">Inativo</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                Cadastrar Professor
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <i class="fas fa-broom"></i>
                                Limpar
                            </button>
                        </div>
                    </form>

                    <div style="text-align:center; margin-top:20px;">
                        <a href="../home_admin.jsp" class="btn-voltar">
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

    <script>
        document.getElementById('professorForm').addEventListener('submit', function(e) {
            const nome = this.nome.value.trim();
            const cpf = this.cpf.value.trim();
            const email = this.email.value.trim();
            const senha = this.senha.value;
            const confirmarSenha = this.confirmar_senha.value;
            const ativo = this.ativo.value;
            
            if (!nome || !cpf || !email || !senha || !confirmarSenha || !ativo) {
                e.preventDefault();
                alert('Por favor, preencha todos os campos obrigatórios.');
                return false;
            }
            
            if (senha.length < 6) {
                e.preventDefault();
                alert('A senha deve ter pelo menos 6 caracteres.');
                return false;
            }
            
            if (senha !== confirmarSenha) {
                e.preventDefault();
                alert('As senhas não coincidem.');
                return false;
            }
            
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Cadastrando...';
            submitBtn.disabled = true;
        });

        
    </script>
</body>
</html>