<%@page import="model.Professor, model.DAO.ProfessorDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Professor professor = null;
    String idParam = request.getParameter("id");
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            ProfessorDAO professorDAO = new ProfessorDAO();
            professor = professorDAO.buscarPorId(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    if (professor == null) {
        response.sendRedirect("list_professor.jsp?erro=Professor não encontrado");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Professor</title>
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
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }
        .titulo {
            color: #007BFF;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 15px;
        }
        .label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
            margin-bottom: 15px;
        }
        input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px dashed #ddd;
            border-radius: 5px;
            background: #f9f9f9;
            margin-bottom: 15px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            font-size: 14px;
            transition: all 0.3s;
            margin-right: 10px;
        }
        .btn-salvar {
            background-color: #28a745;
            color: white;
        }
        .btn-salvar:hover {
            background-color: #218838;
            text-decoration: none;
        }
        .btn-cancelar {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancelar:hover {
            background-color: #545b62;
            text-decoration: none;
        }
        .foto-atual {
            text-align: center;
            margin-bottom: 15px;
        }
        .foto-professor {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007BFF;
        }
        .sem-foto {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #e9ecef;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 12px;
            border: 3px solid #dee2e6;
        }
        .info-foto {
            font-size: 12px;
            color: #6c757d;
            text-align: center;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .alert {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        .campo-obrigatorio::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>

<div class="card">
    <h2 class="titulo">Editar Professor</h2>

    <!-- Mensagens de erro -->
    <% if (request.getParameter("erro") != null) { %>
        <div class="alert alert-error">
            ❌ <%= request.getParameter("erro") %>
        </div>
    <% } %>

    <!-- Foto atual -->
    <div class="foto-atual">
        <% if (professor.getImagem() != null && professor.getImagem().length > 0) { %>
            <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(professor.getImagem()) %>" 
                 class="foto-professor" alt="Foto atual">
            <div class="info-foto">Foto atual</div>
        <% } else { %>
            <div class="sem-foto">Sem foto</div>
            <div class="info-foto">Nenhuma foto cadastrada</div>
        <% } %>
    </div>

    <form action="update_professor.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id_professor" value="<%= professor.getId_professor() %>">
        
        <div class="form-group">
            <label class="label campo-obrigatorio">Nome Completo:</label>
            <input type="text" name="nome" value="<%= professor.getNome() %>" required>
        </div>

        <div class="form-group">
            <label class="label campo-obrigatorio">CPF:</label>
            <input type="text" name="cpf" value="<%= professor.getCpf() %>" maxlength="11" required>
        </div>

        <div class="form-group">
            <label class="label campo-obrigatorio">E-mail:</label>
            <input type="email" name="email" value="<%= professor.getEmail() %>" required>
        </div>

        <div class="form-group">
            <label class="label">Telefone:</label>
            <input type="text" name="telefone" value="<%= professor.getTelefone() != null ? professor.getTelefone() : "" %>" maxlength="15">
        </div>

        <div class="form-group">
            <label class="label">Formação:</label>
            <input type="text" name="formacao" value="<%= professor.getFormacao() != null ? professor.getFormacao() : "" %>">
        </div>

        <div class="form-group">
            <label class="label">Nova Senha:</label>
            <input type="password" name="senha" placeholder="Deixe em branco para manter a senha atual">
            <div class="info-foto">Deixe em branco para manter a senha atual</div>
        </div>

        <div class="form-group">
            <label class="label">Confirmar Senha:</label>
            <input type="password" name="confirmar_senha" placeholder="Deixe em branco para manter a senha atual">
        </div>

        <div class="form-group">
            <label class="label">Nova Foto:</label>
            <input type="file" name="imagem" accept="image/*">
            <div class="info-foto">Deixe em branco para manter a foto atual</div>
        </div>

        <div class="form-group">
            <label class="label campo-obrigatorio">Status:</label>
            <select name="ativo" required>
                <option value="true" <%= professor.isAtivo() ? "selected" : "" %>>Ativo</option>
                <option value="false" <%= !professor.isAtivo() ? "selected" : "" %>>Inativo</option>
            </select>
        </div>

        <div style="text-align: center; margin-top: 25px;">
            <button type="submit" class="btn btn-salvar">Atualizar Professor</button>
            <a href="list_professor.jsp" class="btn btn-cancelar">Cancelar</a>
        </div>
    </form>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const senha = document.querySelector('input[name="senha"]').value;
        const confirmarSenha = document.querySelector('input[name="confirmar_senha"]').value;
        
        if (senha !== confirmarSenha) {
            e.preventDefault();
            alert('As senhas não conferem!');
            return false;
        }
        
        const fileInput = document.querySelector('input[name="imagem"]');
        if (fileInput.files.length > 0) {
            const file = fileInput.files[0];
            const maxSize = 2 * 1024 * 1024; 
            
            if (file.size > maxSize) {
                e.preventDefault();
                alert('A imagem é muito grande! Tamanho máximo: 2MB');
                return false;
            }
        }
    });

    document.querySelector('input[name="imagem"]').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.querySelector('.foto-professor') || document.querySelector('.sem-foto');
                if (img) {
                    if (img.classList.contains('sem-foto')) {
                        const newImg = document.createElement('img');
                        newImg.src = e.target.result;
                        newImg.className = 'foto-professor';
                        newImg.alt = 'Nova foto';
                        img.parentNode.replaceChild(newImg, img);
                        
                        const info = document.querySelector('.info-foto');
                        if (info) {
                            info.textContent = 'Nova foto (pré-visualização)';
                        }
                    } else {
                        img.src = e.target.result;
                        const info = document.querySelector('.info-foto');
                        if (info) {
                            info.textContent = 'Nova foto (pré-visualização)';
                        }
                    }
                }
            };
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>