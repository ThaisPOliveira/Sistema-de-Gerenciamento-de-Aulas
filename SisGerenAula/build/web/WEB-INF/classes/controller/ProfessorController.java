package controller;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import model.Professor;
import model.DAO.ProfessorDAO;

@WebServlet("/professor")
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 2,      
    maxRequestSize = 1024 * 1024 * 5,  
    fileSizeThreshold = 1024 * 512      
)
public class ProfessorController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            try {
                listarProfessores(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("listar".equals(action)) {
            try {
                listarProfessores(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("editar".equals(action)) {
            try {
                editarProfessor(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("desativar".equals(action)) {
            try {
                desativarProfessor(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("ativar".equals(action)) {
            try {
                ativarProfessor(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                listarProfessores(request, response);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ProfessorController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("cadastrar".equals(action)) {
            cadastrarProfessor(request, response);
        } else if ("atualizar".equals(action)) {
            atualizarProfessor(request, response);
        } else {
            try {
                Professor professor = new Professor();
                
                professor.setNome(request.getParameter("nome"));
                professor.setCpf(request.getParameter("cpf"));
                professor.setEmail(request.getParameter("email"));
                professor.setTelefone(request.getParameter("telefone"));
                professor.setFormacao(request.getParameter("formacao"));
                professor.setSenha(request.getParameter("senha"));
                professor.setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));
                
                Part filePart = request.getPart("imagem");
                if (filePart != null && filePart.getSize() > 0) {
                    InputStream fileContent = filePart.getInputStream();
                    byte[] imagemBytes = inputStreamToByteArray(fileContent);
                    professor.setImagem(imagemBytes);
                }
                
                if (!request.getParameter("senha").equals(request.getParameter("confirmar_senha"))) {
                    response.sendRedirect("professor/regist_professor.jsp?erro=Senhas não conferem");
                    return;
                }
                
                ProfessorDAO dao = new ProfessorDAO();
                boolean sucesso = dao.cadastrar(professor);
                
                if (sucesso) {
                    response.sendRedirect("professor?action=listar&sucesso=Professor cadastrado com sucesso");
                } else {
                    response.sendRedirect("professor/regist_professor.jsp?erro=Erro ao cadastrar professor");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("professor/regist_professor.jsp?erro=Erro: " + e.getMessage());
            }
        }
    }
    
    private void preencherProfessorFromRequest(Professor professor, HttpServletRequest request) 
            throws ServletException, IOException {
        
        professor.setNome(request.getParameter("nome"));
        professor.setCpf(request.getParameter("cpf"));
        professor.setEmail(request.getParameter("email"));
        professor.setTelefone(request.getParameter("telefone"));
        professor.setFormacao(request.getParameter("formacao"));
        professor.setSenha(request.getParameter("senha"));
        professor.setAtivo(Boolean.parseBoolean(request.getParameter("ativo")));
        
        Part filePart = request.getPart("imagem");
        if (filePart != null && filePart.getSize() > 0) {
            InputStream fileContent = filePart.getInputStream();
            byte[] imagemBytes = inputStreamToByteArray(fileContent);
            professor.setImagem(imagemBytes);
        }
    }
    
    private void listarProfessores(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, ClassNotFoundException {
        
        ProfessorDAO dao = new ProfessorDAO();
        java.util.List<Professor> professores = dao.listarTodos();
        
        request.setAttribute("professores", professores);
        
        // ✅ CORREÇÃO: Caminho completo
        RequestDispatcher dispatcher = request.getRequestDispatcher("professor/list_professor.jsp");
        dispatcher.forward(request, response);
    }
    
    private void editarProfessor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, ClassNotFoundException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProfessorDAO dao = new ProfessorDAO();
            Professor professor = dao.buscarPorId(id);
            
            if (professor != null) {
                request.setAttribute("professor", professor);
                // ✅ CORREÇÃO: Caminho completo
                RequestDispatcher dispatcher = request.getRequestDispatcher("professor/edit_professor.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("professor?action=listar&erro=Professor não encontrado");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("professor?action=listar&erro=ID inválido");
        }
    }
    
    private void desativarProfessor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, ClassNotFoundException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProfessorDAO dao = new ProfessorDAO();
            boolean sucesso = dao.desativar(id);//o codigo diz q nao existe
            
            if (sucesso) {
                response.sendRedirect("professor?action=listar&sucesso=Professor desativado com sucesso");
            } else {
                response.sendRedirect("professor?action=listar&erro=Erro ao desativar professor");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("professor?action=listar&erro=ID inválido");
        }
    }
    
    private void ativarProfessor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, ClassNotFoundException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProfessorDAO dao = new ProfessorDAO();
            boolean sucesso = dao.ativar(id);//ativar nao existe
            
            if (sucesso) {
                response.sendRedirect("professor?action=listar&sucesso=Professor ativado com sucesso");
            } else {
                response.sendRedirect("professor?action=listar&erro=Erro ao ativar professor");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("professor?action=listar&erro=ID inválido");
        }
    }
    
    private void cadastrarProfessor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Professor professor = new Professor();
            preencherProfessorFromRequest(professor, request);
            
            ProfessorDAO dao = new ProfessorDAO();
            boolean sucesso = dao.cadastrar(professor);
            
            if (sucesso) {
                response.sendRedirect("professor?action=listar&sucesso=Professor cadastrado com sucesso");
            } else {
                response.sendRedirect("regist_professor.jsp?erro=Erro ao cadastrar professor");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("regist_professor.jsp?erro=Erro: " + e.getMessage());
        }
    }
    
    private void atualizarProfessor(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Professor professor = new Professor();
            preencherProfessorFromRequest(professor, request);
            
            int id = Integer.parseInt(request.getParameter("id_professor"));
            professor.setId_professor(id);
            
            ProfessorDAO dao = new ProfessorDAO();
            boolean sucesso = dao.editar(professor);
            
            if (sucesso) {
                response.sendRedirect("professor?action=listar&sucesso=Professor atualizado com sucesso");
            } else {
                response.sendRedirect("professor?action=editar&id=" + id + "&erro=Erro ao atualizar professor");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            int id = Integer.parseInt(request.getParameter("id_professor"));
            response.sendRedirect("professor?action=editar&id=" + id + "&erro=Erro: " + e.getMessage());
        }
    }
    
    private byte[] inputStreamToByteArray(InputStream inputStream) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        int nRead;
        byte[] data = new byte[1024];
        
        while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        
        buffer.flush();
        return buffer.toByteArray();
    }
}