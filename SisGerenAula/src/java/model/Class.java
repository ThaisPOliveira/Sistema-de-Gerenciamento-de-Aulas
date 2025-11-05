package model;

import java.time.LocalTime;
/**
 *
 * @author Thais Oliveira
 */
public class Class{
    private int id;
    private String nomeTurma;
    private String nomeProfessor;
    private String nomeAlunos;
    private LocalTime horario;
    private int idDisciplina;
    
    //GET
    public int getId() {
        return this.id;
    }

    public String getNomeTurma() {
        return this.nomeTurma;
    }

    public String getNomeProfessor() {
        return this.nomeProfessor;
    }

    public String getNomeAlunos() {
        return this.nomeAlunos;
    }

    public LocalTime getHorario() {
        return this.horario;
    }

    public int getIdDisciplina() {
        return this.idDisciplina;
    }
    
    //SET

    public void setId(int id) {
        this.id = id;
    }

    public void setNomeTurma(String nomeTurma) {
        this.nomeTurma = nomeTurma;
    }

    public void setNomeProfessor(String nomeProfessor) {
        this.nomeProfessor = nomeProfessor;
    }

    public void setNomeAlunos(String nomeAlunos) {
        this.nomeAlunos = nomeAlunos;
    }

    public void setHorario(LocalTime horario) {
        this.horario = horario;
    }

    public void setIdDisciplina(int idDisciplina) {
        this.idDisciplina = idDisciplina;
    }
    
    
    

}