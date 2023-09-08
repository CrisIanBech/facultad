package ar.edu.unq.po2.tp3;

import java.util.Calendar;
import java.util.Date;

public class Person {

    private String name;
    private String surname;
    private Date birthdate;

    public Person(String name, Date birthdate) {
        this.name = name;
        this.birthdate = birthdate;
    }

    public String getName() {
        return name;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public int age() {
        Calendar now = Calendar.getInstance();
        now.setTimeInMillis(System.currentTimeMillis());
        Calendar then = Calendar.getInstance();
        then.setTime(birthdate);
        return now.get(Calendar.YEAR) - then.get(Calendar.YEAR);
    }

    public boolean youngerThan(Person anotherPerson) {
        return age() < anotherPerson.age();
    }

}
