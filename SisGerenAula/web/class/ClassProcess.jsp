<%-- 
    Document   : ClassForm
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
        
        // Alunos — agora pega múltiplos, se houver
        String[] alunosSelecionados = request.getParameterValues("alunosSelecionados");
        // ainda mantém compatibilidade com o campo antigo (nomeAlunos)
        if (alunosSelecionados != null) {
            turma.setNomeAlunos(String.join(",", alunosSelecionados)); // salva como "1,2,3"
        } else {
            turma.setNomeAlunos(request.getParameter("nomeAlunos"));
        }

        // Disciplina e horário
        String idDisciplinaStr = request.getParameter("idDisciplina");
        turma.setIdDisciplina(Integer.parseInt(idDisciplinaStr)); 

        String horarioStr = request.getParameter("horario");
        turma.setHorario(LocalTime.parse(horarioStr));

        ClassDAO turmaDAO = new ClassDAO();
       boolean sucesso = turmaDAO.cadastrar(turma);//erro em cadastrar

        if (sucesso) {
%>
    <script>
        alert("Turma cadastrada com sucesso!");
        window.location.href = "../home_admin.html"; 
    </script>
<%
        } else {
%>
    <script>
        alert("Falha ao cadastrar a turma.");
        window.location.href = "../class/Class.html"; 
    </script>
<%
        }
    
    } catch (NumberFormatException | DateTimeParseException ex) {
        ex.printStackTrace(); 
%>
    <script>
        alert("Erro no formato dos dados! Verifique se a Disciplina ID é um número e o Horário está no formato correto (ex: HH:MM:SS).");
        window.location.href = "../class/Class.html"; 
    </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("Ocorreu um erro inesperado no sistema. Tente novamente.");
        window.location.href = "../class/Class.html"; 
    </script>
<%
    }
%>

</body>
</html>

