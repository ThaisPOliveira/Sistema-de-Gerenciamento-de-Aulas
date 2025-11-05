<%@page import="model.DAO.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro Usuario</title>
</head>
<body>
<%
    try {
        User user = new User();

        user.setNome(request.getParameter("nome"));
        user.setEmail(request.getParameter("email"));
        user.setSenha(request.getParameter("senha"));

        // Validação básica
        if (user.getNome() == null || user.getEmail() == null || user.getSenha() == null || 
            user.getNome().trim().isEmpty() || user.getEmail().trim().isEmpty() || user.getSenha().trim().isEmpty()) {
%>
    <script>
        alert("Preencha todos os campos!");
        window.location.href = "register.html";
    </script>
<%
            return;
        }

        UserDAO cadastrarDAO = new UserDAO();
        boolean sucesso = cadastrarDAO.cadastrar(user);

        if (sucesso) {
%>
    <script>
        alert("Cadastrado realizado com sucesso!");
        window.location.href = "../home.html"; 
    </script>
<%
        } else {
%>
    <script>
        alert("Falha no cadastro! Verifique os dados e tente novamente.");
        window.location.href = "register.html";
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Erro no sistema: <%= e.getMessage() %>");
        window.location.href = "register.html";
    </script>
<%
    }
%>
</body>
</html>