import ar.edu.unq.po2.tp3.Person;
import ar.edu.unq.po2.tp3.WorkTeam;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;
public class WorkTeamTest {

    @Test
    public void testAge() {

        WorkTeam workTeam = new WorkTeam("equipo piola");

        for(int i = 0; i < 5; i++) {
            Date birthDay = new Date();
            birthDay.setYear(89 + i);
            workTeam.addMember(new Person(("Pepe " + i), birthDay));
        }

        assertEquals(32, workTeam.getAverageAge());

    }

}
