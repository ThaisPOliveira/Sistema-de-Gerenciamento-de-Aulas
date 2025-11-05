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
%>
                <script>
              
                    window.location.href="../home_admin.html";
                </script>
<%
            } else {
%>
                <script>
                    
                    window.location.href="../home_professor.html";
                </script>
<%
            }
        } else {
%>
    <script>
        alert("Usuário não encontrado ou senha incorreta!");
        window.location.href="../cadastro/login.html";
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <p>Erro ao processar o login: <%= e.getMessage() %></p>
<%
    }
%>

</body>
</html>
