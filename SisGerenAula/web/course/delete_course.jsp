<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.DAO.CourseDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String idParam = request.getParameter("id");
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            CourseDAO dao = new CourseDAO();
            boolean sucesso = dao.excluir(Integer.parseInt(idParam));
            
            if (sucesso) {
                response.sendRedirect("delete_course.jsp?sucesso=excluido");
            } else {
                response.sendRedirect("delete_course.jsp?erro=excluir");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("delete_course.jsp?erro=id_invalido");
        }
    } else {
        response.sendRedirect("delete_course.jsp");
    }
%>