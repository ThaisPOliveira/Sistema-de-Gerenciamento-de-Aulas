<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.DAO.CourseDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String idParam = request.getParameter("id");
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            CourseDAO dao = new CourseDAO();
            boolean sucesso = dao.reativar(Integer.parseInt(idParam));
            
            if (sucesso) {
                response.sendRedirect("list_course.jsp?sucesso=reativada");
            } else {
                response.sendRedirect("list_course.jsp?erro=reativar");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("list_course.jsp?erro=id_invalido");
        }
    } else {
        response.sendRedirect("list_course.jsp");
    }
%>