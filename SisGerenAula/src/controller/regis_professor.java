package controller;

import model.DAO.ProfessorDAO;
import model.Professor;
import config.ConectaDB;
import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/CadastrarProfessor")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) // 10MB
public class regis_professor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Recebendo os campos normais
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            // Recebendo a imagem
            Part filePart = request.getPart("imagem");
            byte[] imagemBytes = null;

            if (filePart != null && filePart.getSize() > 0) {
                InputStream input = filePart.getInputStream();

                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                byte[] data = new byte[1024];
                int nRead;

                while ((nRead = input.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }

                imagemBytes = buffer.toByteArray();
            }

            // Validação simples
            if (nome == null || cpf == null || email == null || senha == null ||
                    nome.trim().isEmpty() || cpf.trim().isEmpty() ||
                    email.trim().isEmpty() || senha.trim().isEmpty()) {

                response.getWriter().write("<script>alert('Preencha todos os campos!'); window.location.href='register_professor.html';</script>");
                return;
            }

            // Criar objeto Professor
            Professor p = new Professor();
            p.setNome(nome);
            p.setCpf(cpf);
            p.setEmail(email);
            p.setSenha(senha);
            p.setImagem(imagemBytes);

            // Salvar no banco
            ProfessorDAO dao = new ProfessorDAO();
            boolean sucesso = dao.cadastrar(p);

            if (sucesso) {
                response.getWriter().write("<script>alert('Professor cadastrado com sucesso!'); window.location.href='../home_admin.html';</script>");
            } else {
                response.getWriter().write("<script>alert('Erro ao cadastrar professor!'); window.location.href='register_professor.html';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<script>alert('Erro no sistema: " + e.getMessage() + "'); window.location.href='register_professor.html';</script>");
        }
    }
}
