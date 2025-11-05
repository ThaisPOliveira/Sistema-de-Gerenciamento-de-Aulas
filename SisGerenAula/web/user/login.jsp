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
        boolean autenticado = userDAO.autenticar(email, senha); 

        if (autenticado) {
%>
    <script>
        alert("Login realizado com sucesso!");
        window.location.href="../home.html";
        
        
    </script>
<%
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
    
<%
    }
%> 
    
 

</body>
</html>
