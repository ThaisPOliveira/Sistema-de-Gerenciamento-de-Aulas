<%@page import="model.Professor"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.DAO.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    // VALIDAÇÃO
    if (email == null || senha == null || email.trim().isEmpty() || senha.trim().isEmpty()) {
        response.sendRedirect("login.html?erro=" + java.net.URLEncoder.encode("Por favor, preencha todos os campos!", "UTF-8"));
        return;
    }

    // Primeiro tenta login de professor
    ProfessorDAO profDAO = new ProfessorDAO();
    Professor prof = profDAO.login(email, senha);

    if (prof != null) {
        session.setAttribute("professor", prof);
        response.sendRedirect("../home_professor.jsp");
        return;
    }

    // Se não for professor, tenta login de usuário comum
    try {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.autenticar(email, senha);

        if (user != null) {
            session.setAttribute("usuarioLogado", user.getNome());
            session.setAttribute("tipoUsuario", user.getTipo());

            if ("admin".equalsIgnoreCase(user.getTipo())) {
                response.sendRedirect("../home_admin.jsp");
            } else {
                response.sendRedirect("../home_professor.jsp");
            }
        } else {
            response.sendRedirect("login.html?erro=" + java.net.URLEncoder.encode("Usuário não encontrado ou senha incorreta!", "UTF-8"));
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.html?erro=" + java.net.URLEncoder.encode("Erro ao processar login: " + e.getMessage(), "UTF-8"));
    }
%>