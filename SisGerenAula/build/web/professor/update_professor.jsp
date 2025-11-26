<%@page import="model.Professor, model.DAO.ProfessorDAO, java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String idStr = request.getParameter("id_professor");
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String formacao = request.getParameter("formacao");
        String senha = request.getParameter("senha");
        String ativoStr = request.getParameter("ativo");
        
        if (idStr == null || nome == null || cpf == null || email == null) {
            response.sendRedirect("list_professor.jsp?erro=Dados inválidos");
            return;
        }
        
        int id = Integer.parseInt(idStr);
        boolean ativo = Boolean.parseBoolean(ativoStr);
        
        ProfessorDAO professorDAO = new ProfessorDAO();
        Professor professorAtual = professorDAO.buscarPorId(id);
        
        if (professorAtual == null) {
            response.sendRedirect("list_professor.jsp?erro=Professor não encontrado");
            return;
        }
        
        Professor professor = new Professor();
        professor.setId_professor(id);
        professor.setNome(nome);
        professor.setCpf(cpf);
        professor.setEmail(email);
        professor.setTelefone(telefone);
        professor.setFormacao(formacao);
        professor.setAtivo(ativo);
        
        if (senha != null && !senha.trim().isEmpty()) {
            professor.setSenha(senha);
        } else {
            professor.setSenha(professorAtual.getSenha()); 
        }
        
        // TRATAMENTO DE IMAGEM COMPATÍVEL COM JAVA 8
        Part filePart = request.getPart("imagem");
        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            
            // Substituição do readAllBytes() para Java 8
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            int nRead;
            byte[] data = new byte[1024];
            
            while ((nRead = fileContent.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            
            buffer.flush();
            byte[] imagemBytes = buffer.toByteArray();
            professor.setImagem(imagemBytes);
            
            fileContent.close();
            buffer.close();
        } else {
            professor.setImagem(professorAtual.getImagem());
        }
        
        boolean sucesso = professorDAO.editar(professor);
        
        if (sucesso) {
            response.sendRedirect("list_professor.jsp?sucesso=Professor atualizado com sucesso");
        } else {
            response.sendRedirect("list_professor.jsp?erro=Erro ao atualizar professor");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("list_professor.jsp?erro=Erro ao processar atualização: " + e.getMessage());
    }
%>