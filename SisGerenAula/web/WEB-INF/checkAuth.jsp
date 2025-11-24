<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
// Verificar se o usuário está logado
HttpSession userSession = request.getSession(false);
if (userSession == null || userSession.getAttribute("usuarioLogado") == null) {
    response.sendRedirect("../user/login.jsp");
    return;
}

// Verificar tipo de usuário
String userType = (String) userSession.getAttribute("tipoUsuario");
if (userType == null) {
    response.sendRedirect("../user/login.jsp");
    return;
}
%>