<%@page import="model.DAO.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    try {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.autenticar(email, senha); 
        if (user != null) {
        
            session.setAttribute("usuarioLogado", user.getNome());
            session.setAttribute("tipoUsuario", user.getTipo());

            if ("admin".equalsIgnoreCase(user.getTipo())) {
                response.sendRedirect("../home_admin.html");
                return;
            } else {
                response.sendRedirect("../home_professor.html");
                return;
            }
        } else {
%>
    <script>
        alert("Usuário não encontrado ou senha incorreta!");
        window.location.href="login.html";
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Erro ao processar o login!");
        window.location.href="login.html";
    </script>
<%
    }
%>

</body>
</html>