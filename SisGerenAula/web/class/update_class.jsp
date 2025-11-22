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
    
    System.out.println("🔍 Processando atualização da turma:");
    System.out.println("🔍 ID: " + idParam);
    System.out.println("🔍 Nome Turma: " + nomeTurma);
    System.out.println("🔍 Professor: " + nomeProfessor);
    System.out.println("🔍 Horário: " + horario);
    System.out.println("🔍 Disciplina ID: " + idDisciplinaParam);
    
    if (idParam == null || nomeTurma == null || nomeProfessor == null || horario == null || idDisciplinaParam == null) {
        System.out.println("❌ Dados incompletos");
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
            System.out.println("🔍 Nomes alunos: " + nomesAlunos.toString());
        } else {
            turma.setNomeAlunos("");
            System.out.println("🔍 Nenhum aluno selecionado");
        }
        
        ClassDAO dao = new ClassDAO();
        boolean sucesso = dao.atualizarTurma(turma);
        
        if (sucesso) {
            System.out.println("✅ Turma atualizada com sucesso");
            response.sendRedirect("ClassList.jsp?sucesso=Turma atualizada com sucesso");
        } else {
            System.out.println("❌ Erro ao atualizar turma no banco");
            response.sendRedirect("EditClass.jsp?id=" + id + "&erro=Erro ao atualizar turma");
        }
        
    } catch (NumberFormatException e) {
        System.out.println("❌ ID inválido: " + e.getMessage());
        response.sendRedirect("ClassList.jsp?erro=ID inválido");
    } catch (Exception e) {
        System.out.println("❌ Erro geral: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("ClassList.jsp?erro=Erro ao processar atualização: " + e.getMessage());
    }
%>