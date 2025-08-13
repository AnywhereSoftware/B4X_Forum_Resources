B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.3
@EndOfDesignText@
'Class module
Sub Class_Globals

Dim nativeMe As JavaObject

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(minrating As Int, maxrating As Int) As String
  Dim sudokustring As String = ""
  nativeMe = Me
  sudokustring = nativeMe.RunMethod("generate",Array(minrating, maxrating))
  Return sudokustring
  
End Sub

#If Java

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

/**
 *
 * @author Rolf Sandberg
 */

//public class DLXEngine {
    dlx_generator generator;
    dlx_solver solver;
    
//    public void DLXEngine() {
//        generator = new dlx_generator();
//        solver = new dlx_solver();
//    }
    
    public String generate(int minrating, int maxrating){
	    generator = new dlx_generator();
        solver = new dlx_solver();
        Date t = new Date();
        long start = t.getTime(), seed;
        int tries = 0, i, samples = 5;
        long rating = 0;
        String ss[] = new String[samples],
                temp = new String();
        
        for(tries = 0; tries < samples; tries++)
            ss[tries] = new String();
        tries = 1;

        // Generator:
        // First arg: rand seed
        // Second arg: #samples, ignored if <= 0
        // Third arg: rating and hints, ignored if <= 0
        
        // Task: Find a Sudoku with a rating in a specified interval.
        // Do it by generating samples and examine them
        // Continue until an appropriate puzzle is found.
        while(tries < 9999999) {
            tries++;
            t = new Date();
            seed = t.getTime();
            ss = generator.generate(seed, samples, 0);
            for(i = 0; i < samples; i++) {
                rating = generator.rate(ss[i].replace("\n","").trim());
                if(rating > minrating && rating < maxrating) {
                    return ss[i];
                }
            }
            //System.out.println(minrating + ", " + maxrating + ", " + rating + ", looping");
        }
        return ss[0];
    }
    
    public long rate(String s) {
        return generator.rate(s);
    }
    
    public String solve(String s){
        String result = solver.solve(s);
        return result;
    }
//}



#End If