<%@page import="java.util.List"%>
<%@page import="model.Class"%>
<%@page import="model.DAO.ClassDAO"%>
<%@page import="model.Professor"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.Course"%>
<%@page import="model.DAO.CourseDAO"%>
<%@page import="model.Aluno"%>
<%@page import="model.DAO.AlunoDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idParam = request.getParameter("id");
    Class turma = null;
    List<Integer> alunosSelecionados = new ArrayList<>();
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            ClassDAO dao = new ClassDAO();
            turma = dao.buscarPorId(id);
            
            if (turma != null && turma.getNomeAlunos() != null && !turma.getNomeAlunos().isEmpty()) {
                // Se getNomeAlunos() retorna os IDs como string (ex: "1,2,3")
                String[] idsArray = turma.getNomeAlunos().split(",");
                for (String idAluno : idsArray) {
                    if (!idAluno.trim().isEmpty()) {
                        try {
                            alunosSelecionados.add(Integer.parseInt(idAluno.trim()));
                        } catch (NumberFormatException e) {
                            // Se for nomes em vez de IDs, ignora
                        }
                    }
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("ClassList.jsp?erro=ID inválido");
            return;
        }
    }
    
    if (turma == null) {
        response.sendRedirect("ClassList.jsp?erro=Turma não encontrada");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Turma</title>
        
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                margin: 0;
                padding: 20px;
            }
            
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 30px;
            }
            
            .titulo {
                color: #007BFF;
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 2px solid #007BFF;
                padding-bottom: 15px;
                font-size: 24px;
            }
            
            .alert {
                padding: 12px 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                text-align: center;
                font-weight: bold;
            }
            
            .alert-error {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
            }
            
            .form-group {
                margin-bottom: 25px;
            }
            
            label {
                display: block;
                font-weight: bold;
                color: #333;
                margin-bottom: 8px;
            }
            
            input[type="text"],
            input[type="time"],
            select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                box-sizing: border-box;
                transition: border-color 0.3s;
            }
            
            input[type="text"]:focus,
            input[type="time"]:focus,
            select:focus {
                outline: none;
                border-color: #007BFF;
                box-shadow: 0 0 5px rgba(0,123,255,0.3);
            }
            
            .select2-container--default .select2-selection--multiple {
                border: 1px solid #ddd;
                border-radius: 5px;
                min-height: 45px;
                padding: 5px;
            }
            
            .select2-container--default.select2-container--focus .select2-selection--multiple {
                border-color: #007BFF;
                box-shadow: 0 0 5px rgba(0,123,255,0.3);
            }
            
            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }
            
            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                font-weight: bold;
                transition: all 0.3s;
                text-decoration: none;
                text-align: center;
                flex: 1;
            }
            
            .btn-primary {
                background: #007BFF;
                color: white;
            }
            
            .btn-primary:hover {
                background: #0056b3;
                transform: translateY(-2px);
                box-shadow: 0 3px 8px rgba(0,123,255,0.3);
            }
            
            .btn-secondary {
                background: #6c757d;
                color: white;
            }
            
            .btn-secondary:hover {
                background: #545b62;
                transform: translateY(-2px);
            }
            
            .btn-voltar {
                display: inline-block;
                padding: 10px 20px;
                background: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 20px;
                transition: all 0.3s;
            }
            
            .btn-voltar:hover {
                background: #218838;
                text-decoration: none;
                transform: translateY(-1px);
            }
            
            .campo-obrigatorio::after {
                content: " *";
                color: red;
            }
            
            .info-text {
                font-size: 12px;
                color: #6c757d;
                margin-top: 5px;
            }
            
            .alunos-selecionados {
                margin-top: 10px;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 5px;
                border-left: 3px solid #007BFF;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="titulo">Editar Turma</h1>

            <% if (request.getParameter("erro") != null) { %>
                <div class="alert alert-error">
                    ❌ <%= request.getParameter("erro") %>
                </div>
            <% } %>

            <form method="post" action="update_class.jsp">
                <input type="hidden" name="id_turma" value="<%= turma.getId() %>">
                
                <!-- Nome da turma -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Nome da Turma:</label>
                    <input type="text" name="nomeTurma" value="<%= turma.getNomeTurma() %>" required placeholder="Ex: Turma A - Matemática">
                </div>

                <!-- Professor -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Professor:</label>
                    <select name="nomeProfessor" required>
                        <option value="">Selecione um professor</option>
                        <%
                            ProfessorDAO pdao = new ProfessorDAO();
                            List<Professor> professores = pdao.listarTodos();
                            for (Professor prof : professores) {
                        %>
                        <option value="<%= prof.getNome()%>" <%= prof.getNome().equals(turma.getNomeProfessor()) ? "selected" : "" %>>
                            <%= prof.getNome()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <!-- Alunos select2 -->
                <div class="form-group">
                    <label>Alunos:</label>
                    <select name="alunosSelecionados" multiple="multiple" id="alunosSelect" style="width: 100%;">
                        <%
                            AlunoDAO adao = new AlunoDAO();
                            List<Aluno> alunos = adao.listarAlunos();
                            for (Aluno a : alunos) {
                        %>
                        <option value="<%= a.getId()%>" <%= alunosSelecionados.contains(a.getId()) ? "selected" : "" %>>
                            <%= a.getNome()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                    <div class="info-text">Selecione um ou mais alunos (opcional)</div>
                </div>

                <!-- Horario -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Horário:</label>
                    <input type="time" name="horario" value="<%= turma.getHorario() != null ? turma.getHorario().toString() : "" %>" required>
                </div>

                <!-- Disciplina -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Disciplina:</label>
                    <select name="idDisciplina" required>
                        <option value="">Selecione uma disciplina</option>
                        <%
                            CourseDAO cdao = new CourseDAO();
                            List<Course> disciplinas = cdao.listarTodas();
                            for (Course d : disciplinas) {
                        %>
                        <option value="<%= d.getId()%>" <%= d.getId() == turma.getIdDisciplina() ? "selected" : "" %>>
                            <%= d.getNome()%> - <%= d.getNivel()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">💾 Atualizar Turma</button>
                    <a href="ClassList.jsp" class="btn btn-secondary">❌ Cancelar</a>
                </div>
            </form>

            <div style="text-align: center; margin-top: 20px;">
                <a href="ClassList.jsp" class="btn-voltar">← Voltar para Lista</a>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $('#alunosSelect').select2({
                    placeholder: "Selecione os alunos...",
                    allowClear: true,
                    width: '100%',
                    language: {
                        noResults: function() {
                            return "Nenhum aluno encontrado";
                        }
                    }
                });
                
                function atualizarContadorAlunos() {
                    const selected = $('#alunosSelect').val();
                    $('.alunos-selecionados').remove();
                    
                    if (selected && selected.length > 0) {
                        $('#alunosSelect').after('<div class="alunos-selecionados">🎓 ' + selected.length + ' aluno(s) selecionado(s)</div>');
                    }
                }
                
                atualizarContadorAlunos();
                
                $('#alunosSelect').on('change', atualizarContadorAlunos);
            });
        </script>
    </body>
</html>