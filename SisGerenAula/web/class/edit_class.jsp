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
                String[] idsArray = turma.getNomeAlunos().split(",");
                for (String idAluno : idsArray) {
                    if (!idAluno.trim().isEmpty()) {
                        try {
                            alunosSelecionados.add(Integer.parseInt(idAluno.trim()));
                        } catch (NumberFormatException e) {
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
        <title>Editar Turma - Sistema de Gerenciamento</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <style>
            :root {
                --primary-color: #007BFF;
                --primary-dark: #0056b3;
                --primary-light: #4dabf7;
                --secondary-color: #6c757d;
                --light-color: #f8f9fa;
                --dark-color: #343a40;
                --success-color: #28a745;
                --danger-color: #dc3545;
                --warning-color: #ffc107;
                --info-color: #17a2b8;
                --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 30px 20px;
                color: var(--dark-color);
            }
            
            .container {
                max-width: 800px;
                margin: 0 auto;
                background: white;
                border-radius: 15px;
                box-shadow: var(--shadow);
                padding: 40px;
                position: relative;
            }
            
            .titulo {
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 30px;
                font-size: 32px;
                font-weight: 700;
                position: relative;
            }
            
            .titulo::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: linear-gradient(90deg, var(--primary-color), var(--success-color));
                border-radius: 2px;
            }
            
            /* Alertas */
            .alert {
                padding: 15px 20px;
                margin-bottom: 25px;
                border-radius: 10px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 12px;
                animation: slideIn 0.5s ease-out;
                border-left: 4px solid;
            }
            
            .alert-error {
                background: #f8d7da;
                color: #721c24;
                border-left-color: var(--danger-color);
            }
            
            .alert-warning {
                background: #fff3cd;
                color: #856404;
                border-left-color: var(--warning-color);
            }
            
            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            /* Formulários */
            .form-group {
                margin-bottom: 25px;
            }
            
            label {
                display: block;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 8px;
                font-size: 14px;
            }
            
            .campo-obrigatorio::after {
                content: " *";
                color: var(--danger-color);
            }
            
            input[type="text"],
            input[type="time"],
            input[type="number"],
            select {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid #e9ecef;
                border-radius: 10px;
                font-size: 15px;
                box-sizing: border-box;
                transition: var(--transition);
                background: white;
            }
            
            input[type="text"]:focus,
            input[type="time"]:focus,
            input[type="number"]:focus,
            select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
                transform: translateY(-2px);
            }
            
            /* Select2 Customizado */
            .select2-container--default .select2-selection--multiple {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                min-height: 50px;
                padding: 8px;
                transition: var(--transition);
            }
            
            .select2-container--default .select2-selection--multiple:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
            }
            
            .select2-container--default .select2-selection--multiple .select2-selection__choice {
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 6px;
                padding: 4px 8px;
                font-size: 13px;
            }
            
            /* Botões */
            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
                flex-wrap: wrap;
            }
            
            .btn {
                padding: 14px 28px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                transition: var(--transition);
                text-decoration: none;
                text-align: center;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                flex: 1;
                min-width: 140px;
            }
            
            .btn-success {
                background: var(--success-color);
                color: white;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            }
            
            .btn-success:hover {
                background: #218838;
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
                text-decoration: none;
                color: white;
            }
            
            .btn-secondary {
                background: var(--secondary-color);
                color: white;
            }
            
            .btn-secondary:hover {
                background: #545b62;
                transform: translateY(-3px);
                text-decoration: none;
                color: white;
            }
            
            .btn-voltar {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 12px 25px;
                background: var(--secondary-color);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                transition: var(--transition);
                font-weight: 600;
                margin-top: 20px;
            }
            
            .btn-voltar:hover {
                background: #545b62;
                transform: translateY(-2px);
                text-decoration: none;
                color: white;
            }
            
            /* Informações adicionais */
            .info-text {
                font-size: 13px;
                color: var(--secondary-color);
                margin-top: 6px;
                font-style: italic;
            }
            
            .alunos-selecionados {
                margin-top: 12px;
                padding: 12px 15px;
                background: #e7f3ff;
                border-radius: 8px;
                border-left: 4px solid var(--primary-color);
                font-size: 14px;
                color: var(--primary-dark);
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
                animation: slideIn 0.3s ease-out;
            }
            
            /* Responsividade */
            @media (max-width: 768px) {
                .container {
                    padding: 25px 20px;
                }
                
                .titulo {
                    font-size: 26px;
                }
                
                .btn-group {
                    flex-direction: column;
                }
                
                .btn {
                    flex: none;
                    width: 100%;
                }
            }
            
            @media (max-width: 480px) {
                body {
                    padding: 15px 10px;
                }
                
                .container {
                    padding: 20px 15px;
                }
                
                .titulo {
                    font-size: 22px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="titulo">
                <i class="fas fa-edit"></i>
                Editar Turma
            </h1>

            <% if (request.getParameter("erro") != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getParameter("erro") %>
                </div>
            <% } %>

            <% if (request.getParameter("warning") != null) { %>
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-triangle"></i>
                    <%= request.getParameter("warning") %>
                </div>
            <% } %>

            <form method="post" action="update_class.jsp" id="editForm">
                <input type="hidden" name="id_turma" value="<%= turma.getId() %>">
                
                <div class="form-group">
                    <label class="campo-obrigatorio">
                        <i class="fas fa-tag"></i>
                        Nome da Turma:
                    </label>
                    <input type="text" name="nomeTurma" value="<%= turma.getNomeTurma() %>" required placeholder="Ex: Turma A - Matemática Avançada">
                </div>

                <div class="form-group">
                    <label class="campo-obrigatorio">
                        <i class="fas fa-chalkboard-teacher"></i>
                        Professor:
                    </label>
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

                <div class="form-group">
                    <label>
                        <i class="fas fa-user-graduate"></i>
                        Alunos:
                    </label>
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

                <div class="form-group">
                    <label class="campo-obrigatorio">
                        <i class="fas fa-clock"></i>
                        Horário:
                    </label>
                    <input type="time" name="horario" value="<%= turma.getHorario() != null ? turma.getHorario().toString() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="campo-obrigatorio">
                        <i class="fas fa-book"></i>
                        Disciplina:
                    </label>
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
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i>
                        Atualizar Turma
                    </button>
                    <a href="ClassList.jsp" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                </div>
            </form>

            <div style="text-align: center; margin-top: 20px;">
                <a href="ClassList.jsp" class="btn-voltar">
                    <i class="fas fa-arrow-left"></i>
                    Voltar para Lista
                </a>
            </div>
        </div>

        <script>
  function showAlert(message, type) {
    // Remove alertas existentes
    const existingAlert = document.querySelector('.alert');
    if (existingAlert) {
        existingAlert.remove();
    }
    
    // Cria o elemento do alerta
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    
    // Ícone baseado no tipo - usando FontAwesome
    const icon = type === 'success' ? 'fas fa-check-circle' : 
                 type === 'error' ? 'fas fa-exclamation-circle' : 
                 type === 'warning' ? 'fas fa-exclamation-triangle' : 'fas fa-info-circle';
    
    alertDiv.innerHTML = `
        <i class="${icon}"></i>
        <span class="alert-message">${message}</span>
    `;
    
    // Adiciona ao container após o título
    const container = document.querySelector('.container');
    const titulo = document.querySelector('.titulo');
    container.insertBefore(alertDiv, titulo.nextSibling);
    
    // Remove automaticamente após 5 segundos
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.style.opacity = '0';
            alertDiv.style.transform = 'translateY(-20px)';
            setTimeout(() => alertDiv.remove(), 300);
        }
    }, 5000);
}

document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const sucesso = urlParams.get('sucesso');
    const erro = urlParams.get('erro');
    const warning = urlParams.get('warning');
    
    if (sucesso) {
        showAlert(sucesso, 'success');
        // Limpa apenas os parâmetros de alerta, mantendo o ID
        const novaUrl = window.location.pathname + '?id=<%= turma.getId() %>';
        window.history.replaceState({}, document.title, novaUrl);
    }
    
    if (erro) {
        showAlert(erro, 'error');
        // Mantém o erro na URL para debug, mas pode remover se quiser
    }
    
    if (warning) {
        showAlert(warning, 'warning');
    }
});

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
            $('#alunosSelect').after(`<div class="alunos-selecionados">
                <i class="fas fa-user-graduate"></i>
                ${selected.length} aluno(s) selecionado(s)
            </div>`);
        }
    }
    
    // Inicializa o contador
    atualizarContadorAlunos();
    
    // Atualiza quando há mudanças
    $('#alunosSelect').on('change', atualizarContadorAlunos);

    // Validação do formulário
    $('#editForm').on('submit', function(e) {
        const nomeTurma = $('input[name="nomeTurma"]').val().trim();
        const professor = $('select[name="nomeProfessor"]').val();
        const horario = $('input[name="horario"]').val();
        const disciplina = $('select[name="idDisciplina"]').val();
        
        if (!nomeTurma || !professor || !horario || !disciplina) {
            e.preventDefault();
            showAlert('Por favor, preencha todos os campos obrigatórios.', 'warning');
            return false;
        }
        
        // Mostra loading
        $('button[type="submit"]').html('<i class="fas fa-spinner fa-spin"></i> Atualizando...');
        $('button[type="submit"]').prop('disabled', true);
    });
});
        </script>
    </body>
</html>