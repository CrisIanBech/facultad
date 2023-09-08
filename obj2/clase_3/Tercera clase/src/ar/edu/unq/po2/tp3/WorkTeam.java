package ar.edu.unq.po2.tp3;

import java.util.ArrayList;

public class WorkTeam {

    private String name;
    private ArrayList<Person> members = new ArrayList<>();

    public WorkTeam(String name) {
        this.name = name;
    }

    public void addMember(Person newMember) {
        members.add(newMember);
    }

    public String getName() {
        return name;
    }

    private int membersQuantity() {
        return members.size();
    }

    private int membersAgeSumatory() {
        return members.stream().map(Person::age).reduce(0, Integer::sum);
    }

    public int getAverageAge() {
        if(membersQuantity() == 0) return 0;
        return membersAgeSumatory() / membersQuantity();
    }

}
