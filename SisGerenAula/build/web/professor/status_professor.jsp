<%@page import="model.DAO.ProfessorDAO"%>
<%
    String idParam = request.getParameter("id");
    String action = request.getParameter("action");
    
    if (idParam != null && action != null) {
        try {
            int id = Integer.parseInt(idParam);
            ProfessorDAO professorDAO = new ProfessorDAO();
            boolean sucesso = false;
            String mensagem = "";
            
            if ("ativar".equals(action)) {
                sucesso = professorDAO.ativar(id);
                mensagem = sucesso ? "Professor ativado com sucesso" : "Erro ao ativar professor";
            } else if ("desativar".equals(action)) {
                sucesso = professorDAO.desativar(id);
                mensagem = sucesso ? "Professor desativado com sucesso" : "Erro ao desativar professor";
            } else {
                mensagem = "Ação inválida";
            }
            
            if (sucesso) {
                response.sendRedirect("list_professor.jsp?sucesso=" + mensagem);
            } else {
                response.sendRedirect("list_professor.jsp?erro=" + mensagem);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list_professor.jsp?erro=Erro ao alterar status: " + e.getMessage());
        }
    } else {
        response.sendRedirect("list_professor.jsp?erro=Parâmetros inválidos");
    }
%>