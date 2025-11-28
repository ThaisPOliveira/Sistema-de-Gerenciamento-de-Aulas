package model;

import java.time.LocalTime;
import java.util.List;

public class Class {
    private int id;
    private String nomeTurma;
    private String nomeProfessor;
    private String nomeAlunos;
    private LocalTime horario;
    private int idDisciplina;
    private String nomeDisciplina;
    private List<Integer> idsAlunos; 


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

    public String getNomeDisciplina() {
        return this.nomeDisciplina;
    }

    public List<Integer> getIdsAlunos() {
        return this.idsAlunos;
    }

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

   
    public void setHorario(String horario) {
        this.horario = LocalTime.parse(horario);
    }

    public void setIdDisciplina(int idDisciplina) {
        this.idDisciplina = idDisciplina;
    }

    public void setNomeDisciplina(String nomeDisciplina) {
        this.nomeDisciplina = nomeDisciplina;
    }

    public void setIdsAlunos(List<Integer> idsAlunos) {
        this.idsAlunos = idsAlunos;
    }
}
