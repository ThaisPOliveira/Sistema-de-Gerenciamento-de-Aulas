<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="model.Course"%>
<%@page import="model.DAO.CourseDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Disciplina</title>
</head>
<body>

<%
try {

    // VERIFICA SE O FORM É MULTIPART
    if (!ServletFileUpload.isMultipartContent(request)) {
        out.println("O formulário não possui enctype multipart/form-data.");
        return;
    }

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    List<FileItem> formItems = upload.parseRequest(request);

    Course disciplina = new Course();
    String nomeArquivo = "";

    for (FileItem item : formItems) {

        if (item.isFormField()) {
            switch (item.getFieldName()) {
                case "nome": disciplina.setNome(item.getString("UTF-8")); break;
                case "descricao": disciplina.setDescricao(item.getString("UTF-8")); break;
                case "carga_horaria": disciplina.setCarga_horaria(Integer.parseInt(item.getString())); break;
                case "nivel": disciplina.setNivel(item.getString("UTF-8")); break;
                case "ativa": disciplina.setAtiva(Boolean.parseBoolean(item.getString())); break;
            }

        } else {

            nomeArquivo = new File(item.getName()).getName();

            if (!nomeArquivo.isEmpty()) {
                String caminho = application.getRealPath("") + File.separator + "uploads";

                File pasta = new File(caminho);
                if (!pasta.exists()) pasta.mkdir();

                File destino = new File(caminho + File.separator + nomeArquivo);
                item.write(destino);
            }
        }
    }

    disciplina.setDocumento(nomeArquivo);

    CourseDAO dao = new CourseDAO();
    boolean sucesso = dao.cadastrar(disciplina);

    if (sucesso) {
%>
<script>
    alert("Disciplina cadastrada com sucesso!");
    window.location.href = "../home_admin.html";
</script>
<%
    } else {
%>
<script>
    alert("Erro ao cadastrar disciplina!");
    window.location.href = "course.html";
</script>
<%
    }

} catch (Exception e) {
    out.println("Erro: " + e.getMessage());
    e.printStackTrace();
}
%>

</body>
</html>
