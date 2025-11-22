<%@page import="java.util.List"%>
<%@page import="model.Professor"%>
<%@page import="model.DAO.ProfessorDAO"%>
<%@page import="model.Disciplina"%>
<%@page import="model.DAO.DisciplinaDAO"%>
<%@page import="model.Aluno"%>
<%@page import="model.DAO.AlunoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro de Turma</title>
        
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
            <h1 class="titulo">Cadastro de Turma</h1>

            <form method="post" action="ClassProcess.jsp">
                <!-- Nome da turma -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Nome da Turma:</label>
                    <input type="text" name="nomeTurma" required placeholder="Ex: Turma A - Matemática">
                </div>

                <!-- Professor -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Professor:</label>
                    <select name="nomeProfessor" required>
                        <option value="">Selecione um professor</option>
                        <%
                            ProfessorDAO pdao = new ProfessorDAO();
                            List<Professor> professores = pdao.listar();
                            for (Professor prof : professores) {
                        %>
                        <option value="<%= prof.getNome()%>"><%= prof.getNome()%></option>
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
                        <option value="<%= a.getId()%>"><%= a.getNome()%></option>
                        <%
                            }
                        %>
                    </select>
                    <div class="info-text">Selecione um ou mais alunos (opcional)</div>
                </div>

                <!-- Horario -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Horário:</label>
                    <input type="time" name="horario" required>
                </div>

                <!-- Disciplina -->
                <div class="form-group">
                    <label class="campo-obrigatorio">Disciplina:</label>
                    <select name="idDisciplina" required>
                        <option value="">Selecione uma disciplina</option>
                        <%
                            DisciplinaDAO ddao = new DisciplinaDAO();
                            List<Disciplina> disciplinas = ddao.listarDisciplinas();
                            for (Disciplina d : disciplinas) {
                        %>
                        <option value="<%= d.getId()%>" title="<%= d.getDescricao()%>">
                            <%= d.getNome()%> - <%= d.getNivel()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">🏫 Cadastrar Turma</button>
                    <button type="reset" class="btn btn-secondary">🗑️ Limpar</button>
                </div>
            </form>

            <div style="text-align: center; margin-top: 20px;">
                <a href="../home_admin.html" class="btn-voltar">← Voltar para Home</a>
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
                
                // Mostrar contador de alunos selecionados
                $('#alunosSelect').on('change', function() {
                    const selected = $(this).val();
                    $('.alunos-selecionados').remove();
                    
                    if (selected && selected.length > 0) {
                        $(this).after('<div class="alunos-selecionados">🎓 ' + selected.length + ' aluno(s) selecionado(s)</div>');
                    }
                });
            });
        </script>
    </body>
</html>