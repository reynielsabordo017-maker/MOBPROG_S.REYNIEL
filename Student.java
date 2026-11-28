import java.util.Scanner;

public class Student {

    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);

        String[] names = new String[5];
        double[] grades = new double[5];

        double total = 0;
        double average;

        // INPUT STUDENTS
        System.out.println("===== STUDENT GRADES INPUT =====");

        for (int i = 0; i < 5; i++) {

            System.out.print("[" + (i + 1) + "] Student Name: ");
            names[i] = input.nextLine();

            System.out.print("[" + (i + 1) + "] Student Grade: ");
            grades[i] = input.nextDouble();

            input.nextLine();

            total += grades[i];
        }

        // CALCULATE AVERAGE
        average = total / 5;

        // SORT GRADES (HIGHEST TO LOWEST)
        for (int i = 0; i < 4; i++) {

            for (int j = 0; j < 4 - i; j++) {

                if (grades[j] < grades[j + 1]) {

                    double tempGrade = grades[j];
                    grades[j] = grades[j + 1];
                    grades[j + 1] = tempGrade;

                    String tempName = names[j];
                    names[j] = names[j + 1];
                    names[j + 1] = tempName;
                }
            }
        }

        // DISPLAY STUDENT LIST
        System.out.println("\n========= STUDENT LIST =========");

        for (int i = 0; i < 5; i++) {

            String status;

            if (grades[i] >= 59.5) {
                status = "Passed";
            } else {
                status = "Failed";
            }

            System.out.println(names[i] + " - "
                    + grades[i] + " - " + status);
        }

        // DISPLAY RESULTS
        System.out.println("\n========= RESULTS =========");

        System.out.printf("Average Grade: %.2f%n", average);

        System.out.println("Highest: " + grades[0]
                + " (" + names[0] + ")");

        System.out.println("Lowest: " + grades[4]
                + " (" + names[4] + ")");

        input.close();
    }
}