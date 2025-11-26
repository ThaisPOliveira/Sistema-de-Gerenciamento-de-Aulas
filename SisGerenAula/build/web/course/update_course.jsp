<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.DAO.CourseDAO, model.Course" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            
            Course disciplina = new Course();
            disciplina.setId(Integer.parseInt(request.getParameter("id")));
            disciplina.setNome(request.getParameter("nome"));
            disciplina.setDescricao(request.getParameter("descricao"));
            disciplina.setCarga_horaria(Integer.parseInt(request.getParameter("carga_horaria")));
            disciplina.setNivel(request.getParameter("nivel"));
            disciplina.setAtiva(Boolean.parseBoolean(request.getParameter("ativa")));
            
            CourseDAO dao = new CourseDAO();
            boolean sucesso = dao.atualizar(disciplina);
            
            if (sucesso) {
                response.sendRedirect("list_course.jsp?sucesso=editado");
            } else {
                response.sendRedirect("list_course.jsp?erro=editar");
            }
            return;
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list_course.jsp?erro=editar");
            return;
        }
    }
    
    String idParam = request.getParameter("id");
    Course disciplina = null;
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            CourseDAO dao = new CourseDAO();
            disciplina = dao.buscarPorId(Integer.parseInt(idParam));
        } catch (NumberFormatException e) {
        }
    }
    
    if (disciplina == null) {
        response.sendRedirect("list_course.jsp");
        return;
    }
    
    String sucesso = request.getParameter("sucesso");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Disciplina</title>
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
            margin-bottom: 15px;
            line-height: 1.6;
            max-width: 600px;
            margin: 0 auto;
        }
        .titulo {
            color: #007BFF;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
        }
        .label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }
        .vazio {
            color: gray;
            font-style: italic;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            margin-right: 10px;
            font-size: 14px;
            transition: all 0.3s;
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
        .btn-group {
            text-align: center;
            margin-top: 25px;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 5px;
            text-align: center;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1 class="titulo">Editar Disciplina</h1>
        
        <form method="post" action="update_course.jsp">
            <input type="hidden" name="id" value="<%= disciplina.getId() %>">
            
            <span class="label">Nome da Disciplina:</span>
            <input type="text" name="nome" value="<%= disciplina.getNome() %>" required>
            
            <span class="label">Descrição:</span>
            <textarea name="descricao" required><%= disciplina.getDescricao() != null ? disciplina.getDescricao() : "" %></textarea>
            
            <span class="label">Carga Horária (horas):</span>
            <input type="number" name="carga_horaria" value="<%= disciplina.getCarga_horaria() %>" required>
            
            <span class="label">Nível:</span>
            <select name="nivel" required>
                <option value="Básico" <%= "Básico".equals(disciplina.getNivel()) ? "selected" : "" %>>Básico</option>
                <option value="Intermediário" <%= "Intermediário".equals(disciplina.getNivel()) ? "selected" : "" %>>Intermediário</option>
                <option value="Avançado" <%= "Avançado".equals(disciplina.getNivel()) ? "selected" : "" %>>Avançado</option>
            </select>
            
            <span class="label">Ativa:</span>
            <select name="ativa" required>
                <option value="true" <%= disciplina.isAtiva() ? "selected" : "" %>>Sim</option>
                <option value="false" <%= !disciplina.isAtiva() ? "selected" : "" %>>Não</option>
            </select>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-salvar">Salvar Alterações</button>
                <a href="list_course.jsp" class="btn btn-cancelar">   Voltar para Lista</a>
            </div>
        </form>
    </div>
</body>
</html>