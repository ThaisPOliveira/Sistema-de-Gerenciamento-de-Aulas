<%-- 
    Document   : ClassProcess
    Created on : 5 de nov. de 2025, 12:17:50
    Author     : Matheus e Thais
--%>
<%@page import="java.time.format.DateTimeParseException"%>
<%@page import="java.time.LocalTime"%>
<%@page import="model.Class"%> 
<%@page import="model.DAO.ClassDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Processando Cadastro da Turma</title>
</head>
<body>

<%
    try {
        Class turma = new Class();
        
        turma.setNomeTurma(request.getParameter("nomeTurma"));
        turma.setNomeProfessor(request.getParameter("nomeProfessor")); 
        
    
        String[] alunosSelecionados = request.getParameterValues("alunosSelecionados");
      
        if (alunosSelecionados != null && alunosSelecionados.length > 0) {
            turma.setNomeAlunos(String.join(",", alunosSelecionados)); 
        } else {
          
            turma.setNomeAlunos(null);
        }

        
        String idDisciplinaStr = request.getParameter("idDisciplina");
        if (idDisciplinaStr != null && !idDisciplinaStr.trim().isEmpty()) {
            turma.setIdDisciplina(Integer.parseInt(idDisciplinaStr));
        } else {
            throw new NumberFormatException("ID da disciplina não informado");
        }

        
        String horarioStr = request.getParameter("horario");
        if (horarioStr != null && !horarioStr.trim().isEmpty()) {
          
            if (horarioStr.length() == 5) {
                horarioStr = horarioStr + ":00"; 
            }
            turma.setHorario(LocalTime.parse(horarioStr));
        } else {
            throw new DateTimeParseException("Horário não informado", horarioStr, 0);
        }

    
        ClassDAO turmaDAO = new ClassDAO();
        boolean sucesso = turmaDAO.cadastrar(turma);

        if (sucesso) {
%>
    <script>
        alert("Turma cadastrada com sucesso!");
        window.location.href = "../home_admin.jsp"; 
    </script>
<%
        } else {
%>
    <script>
        alert("Falha ao cadastrar a turma.");
        window.location.href = "../class/ClassForm.jsp"; 
    </script>
<%
        }
    
    } catch (NumberFormatException ex) {
        ex.printStackTrace(); 
%>
    <script>
        alert("Erro no formato numérico! Verifique se a Disciplina ID é um número válido.");
        window.location.href = "../class/ClassForm.jsp"; 
    </script>
<%
    } catch (DateTimeParseException ex) {
        ex.printStackTrace();
%>
    <script>
        alert("Erro no formato do horário! Use o formato HH:MM (ex: 14:30).");
        window.location.href = "../class/ClassForm.jsp"; 
    </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Ocorreu um erro inesperado no sistema: " + <%= e.getMessage() %>);
        window.location.href = "../class/ClassForm.jsp"; 
    </script>
<%
    }
%>

</body>
</html>