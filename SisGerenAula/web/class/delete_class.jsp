<%@page import="model.DAO.ClassDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idParam = request.getParameter("id");

    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("ClassList.jsp?erro=ID não fornecido");
        return;
    }

    try {
        int id = Integer.parseInt(idParam);
        ClassDAO dao = new ClassDAO();
        boolean sucesso = dao.excluirTurma(id);

        if (sucesso) {
            response.sendRedirect("ClassList.jsp?sucesso=Turma excluída com sucesso");
        } else {
            response.sendRedirect("ClassList.jsp?erro=Erro ao excluir turma");
        }

    } catch (NumberFormatException e) {
        response.sendRedirect("ClassList.jsp?erro=ID inválido");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ClassList.jsp?erro=Erro ao excluir turma: " + e.getMessage());
    }
%>