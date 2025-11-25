package model;

/**
 *
 * @author Thais Oliveira e Matheus
 */
public class Course {

    private int id;
    private String nome;
    private String descricao;
    private int carga_horaria;
    private String nivel;
    private boolean ativa;
    private String documento;

    // GET
    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }

    public int getId() {
        return this.id;
    }

    public String getNome() {
        return this.nome;
    }

    public String getDescricao() {
        return this.descricao;
    }

    public int getCarga_horaria() {
        return carga_horaria;
    }

    public String getNivel() {
        return nivel;
    }

    public boolean isAtiva() {
        return ativa;
    }

    // SET
    public void setId(int id) {
        this.id = id;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setCarga_horaria(int carga_horaria) {
        this.carga_horaria = carga_horaria;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public void setAtiva(boolean ativa) {
        this.ativa = ativa;
    }
}
