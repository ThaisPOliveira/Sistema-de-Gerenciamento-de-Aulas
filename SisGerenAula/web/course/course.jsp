
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
        int carga = Integer.parseInt(request.getParameter("carga_horaria"));
        disciplina.setCarga_horaria(carga);
        disciplina.setNivel(request.getParameter("nivel"));
        boolean ativa = Boolean.parseBoolean(request.getParameter("ativa"));
        disciplina.setAtiva(ativa);

        // DAO
        CourseDAO courseDAO = new CourseDAO();
        boolean sucesso = courseDAO.cadastrar(disciplina);

        if (sucesso) {
%>
    <script>
        alert("Disciplina cadastrada com sucesso!");
        window.location.href = "../home_admin.html";
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
        out.println("Erro: " + e.getMessage());
        e.printStackTrace();
    }
%>

</body>
</html>
