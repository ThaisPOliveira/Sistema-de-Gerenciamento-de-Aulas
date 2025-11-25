<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Professor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .titulo {
            color: #007BFF;
            text-align: center;
            margin-bottom: 25px;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 15px;
            font-size: 24px;
        }
        
        .alert {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }
        
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="file"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            outline: none;
            border-color: #007BFF;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        
        input[type="file"] {
            padding: 8px;
            background: #f8f9fa;
            border: 1px dashed #ddd;
        }
        
        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }
        
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            flex: 1;
        }
        
        .btn-primary {
            background: #007BFF;
            color: white;
        }
        
        .btn-primary:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0,123,255,0.3);
        }
        
        .btn-voltar {
            display: inline-block;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 15px;
            transition: all 0.3s;
        }
        
        .btn-voltar:hover {
            background: #218838;
            text-decoration: none;
            transform: translateY(-1px);
        }
        
        .campo-obrigatorio::after {
            content: " *";
            color: red;
        }
        
        .info-text {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .senha-group {
            display: flex;
            gap: 15px;
        }
        
        .senha-group .form-group {
            flex: 1;
        }
        
        @media (max-width: 600px) {
            .senha-group {
                flex-direction: column;
                gap: 0;
            }
            
            .container {
                padding: 20px;
                margin: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="titulo">Cadastrar Professor</h1>

        <% if (request.getParameter("erro") != null) { %>
            <div class="alert alert-error">
                ❌ <%= request.getParameter("erro") %>
            </div>
        <% } %>

        <% if (request.getParameter("sucesso") != null) { %>
            <div class="alert alert-success">
                ✅ <%= request.getParameter("sucesso") %>
            </div>
        <% } %>

        <form action="../professor" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label class="campo-obrigatorio">Nome Completo:</label>
                <input type="text" name="nome" required placeholder="Ex: João Silva Santos">
            </div>

            <div class="form-group">
                <label class="campo-obrigatorio">CPF:</label>
                <input type="text" name="cpf" maxlength="11" required placeholder="Somente números (11 dígitos)">
                <div class="info-text">Apenas números, sem pontos ou traços</div>
            </div>

            <div class="form-group">
                <label class="campo-obrigatorio">E-mail:</label>
                <input type="email" name="email" required placeholder="exemplo@email.com">
            </div>

            <div class="form-group">
                <label>Telefone:</label>
                <input type="text" name="telefone" maxlength="15" placeholder="(11) 99999-9999">
                <div class="info-text">Incluir DDD</div>
            </div>

            <div class="form-group">
                <label>Formação:</label>
                <input type="text" name="formacao" placeholder="Ex: Graduação em Matemática">
            </div>

            <div class="senha-group">
                <div class="form-group">
                    <label class="campo-obrigatorio">Senha:</label>
                    <input type="password" name="senha" required placeholder="Mínimo 6 caracteres">
                </div>

                <div class="form-group">
                    <label class="campo-obrigatorio">Confirmar Senha:</label>
                    <input type="password" name="confirmar_senha" required placeholder="Digite a senha novamente">
                </div>
            </div>

            <div class="form-group">
                <label>Foto:</label>
                <input type="file" name="imagem" accept="image/*">
                <div class="info-text">Formatos: JPG, PNG, GIF | Máximo: 2MB</div>
            </div>

            <div class="form-group">
                <label class="campo-obrigatorio">Status:</label>
                <select name="ativo" required>
                    <option value="true">Ativo</option>
                    <option value="false">Inativo</option>
                </select>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-primary">👨‍🏫 Cadastrar Professor</button>
            </div>
        </form>

        <div style="text-align: center; margin-top: 20px;">
            <a href="../home_admin.html" class="btn-voltar">← Voltar para Home</a>
        </div>
    </div>
</body>
</html>