<%@page import="model.Class"%>
<%@page import="model.DAO.ClassDAO"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    String idParam = request.getParameter("id_turma");
    String nomeTurma = request.getParameter("nomeTurma");
    String nomeProfessor = request.getParameter("nomeProfessor");
    String[] alunosArray = request.getParameterValues("alunosSelecionados");
    String horario = request.getParameter("horario");
    String idDisciplinaParam = request.getParameter("idDisciplina");
    
   
    
    if (idParam == null || nomeTurma == null || nomeProfessor == null || horario == null || idDisciplinaParam == null) {
        response.sendRedirect("ClassList.jsp?erro=Dados incompletos");
        return;
    }
    
    try {
        int id = Integer.parseInt(idParam);
        int idDisciplina = Integer.parseInt(idDisciplinaParam);
        
        Class turma = new Class();
        turma.setId(id);
        turma.setNomeTurma(nomeTurma);
        turma.setNomeProfessor(nomeProfessor);
        turma.setIdDisciplina(idDisciplina);
        turma.setHorario(java.time.LocalTime.parse(horario));
        
        if (alunosArray != null && alunosArray.length > 0) {
            StringBuilder nomesAlunos = new StringBuilder();
            for (String alunoId : alunosArray) {
                if (alunoId != null && !alunoId.trim().isEmpty()) {
                    if (nomesAlunos.length() > 0) {
                        nomesAlunos.append(", ");
                    }
                    
                    nomesAlunos.append("Aluno ID: ").append(alunoId);
                }
            }
            turma.setNomeAlunos(nomesAlunos.toString());
        } else {
            turma.setNomeAlunos("");
        }
        
        ClassDAO dao = new ClassDAO();
        boolean sucesso = dao.atualizarTurma(turma);
        
        if (sucesso) {
            response.sendRedirect("ClassList.jsp?sucesso=Turma atualizada com sucesso");
        } else {
            response.sendRedirect("EditClass.jsp?id=" + id + "&erro=Erro ao atualizar turma");
        }
        
    } catch (NumberFormatException e) {
        response.sendRedirect("ClassList.jsp?erro=ID inválido");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ClassList.jsp?erro=Erro ao processar atualização: " + e.getMessage());
    }
%>