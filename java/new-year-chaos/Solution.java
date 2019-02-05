import java.io.*;
import java.math.*;
import java.security.*;
import java.text.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.regex.*;

public class Solution {

    // Complete the minimumBribes function below.
    static void minimumBribes(int[] queue) {
        int[] counter = new int[queue.length];
        int total = 0;

        int bribes = 0;
        for (int i = 0; i < (queue.length - 1); i++) {
            if (queue[i] > queue[i + 1]) {
                if (counter[queue[i] - 1] == 2) {
                    total = -1;
                    break;
                } else {
                    counter[queue[i] - 1]++;
                }
                
                int temp = queue[i];
                queue[i] = queue[i + 1];
                queue[i + 1] = temp;
                bribes++;
            }

            if (bribes != 0 && i == (queue.length - 2)) {
                total += bribes;
                i = -1;
                bribes = 0;
            }
        }

        if (total > -1) {
            System.out.println(total);
        } else {
            System.out.println("Too chaotic");
        }
    }

    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int t = scanner.nextInt();
        scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

        for (int tItr = 0; tItr < t; tItr++) {
            int n = scanner.nextInt();
            scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

            int[] q = new int[n];

            String[] qItems = scanner.nextLine().split(" ");
            scanner.skip("(\r\n|[\n\r\u2028\u2029\u0085])?");

            for (int i = 0; i < n; i++) {
                int qItem = Integer.parseInt(qItems[i]);
                q[i] = qItem;
            }

            minimumBribes(q);
        }

        scanner.close();
    }
}

