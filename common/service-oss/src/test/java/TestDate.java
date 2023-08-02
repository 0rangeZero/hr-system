import java.time.LocalDateTime;

public class TestDate {

    public static void main(String[] args) {
        LocalDateTime ldt = LocalDateTime.now();
        int year = ldt.getYear();
        int month = ldt.getMonthValue();
        int day = ldt.getDayOfMonth();
        System.out.println(year);
        System.out.println(month);
        System.out.println(day);
    }

}
