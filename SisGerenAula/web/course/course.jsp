<%@page import="model.Course"%>
<%@page import="model.DAO.CourseDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Disciplina</title>
</head>
<body>

<%
    try {
        Course disciplina = new Course();
        
        disciplina.setNome(request.getParameter("nome"));
        disciplina.setDescricao(request.getParameter("descricao"));
        
        CourseDAO courseDAO = new CourseDAO();
        boolean sucesso = courseDAO.cadastrar(disciplina);

        if (sucesso) {
%>
    <script>
        alert("Disciplina cadastrada com sucesso!");
        window.location.href = "inicial.html";
        
    </script>
<%
        } else {
%>
    <script>
        alert("Falha ao cadastrar a disciplina.");
        window.location.href = "course.html"; 
    </script>
<%
        }
    } catch (Exception e) {
    }
%>

</body>
</html>