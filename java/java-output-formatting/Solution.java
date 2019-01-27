import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("================================");
            for (int i = 0; i < 3; i++) {
                String s = scanner.next();
                int x = scanner.nextInt();
                
                System.out.format("%-15s%03d\n", s, x);
            }
            System.out.println("================================");
        }
    }
}
