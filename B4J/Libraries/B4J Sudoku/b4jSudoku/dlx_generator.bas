B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.3
@EndOfDesignText@
'Class module
Sub Class_Globals

'Dim nativeMe As JavaObject

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

'  nativeMe = Me
'  sudokustring = nativeMe.RunMethod("solve",Null)
'  Return sudokustring
  
End Sub

#If Java

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

/******************************************************************************
 * dlx_generator generate single solution locally minimized Sudoku puzzles.
 * Locally minimized means that all keys that can be removed without creating
 * a degenerate Sudoku (multiple solutions) are removed.
 ******************************************************************************/
//class dlx_generator {
    long zr = 362436069, wr = 521288629;
    long MWC() {
        return ((zr = 36969 *(zr & 65535) + (zr >> 16)) ^ ( wr = 18000 * (wr & 65535) + (wr >> 16)));
    }
    
    int Rows[]      = new int[325],
            Cols[]  = new int[730],
            Row[][] = new int[325][10],
            Col[][] = new int[730][5],
            Ur[]    = new int[730],
            Uc[]    = new int[325],
            V[]     = new int[325],
            W[]     = new int[325];
    int P[]         = new int[88],
            A[]     = new int[88],
            C[]     = new int[88],
            I[]     = new int[88],
            Two[]   = new int[888];
    char B[]= {'0',
            '1','1','1','2','2','2','3','3','3',
            '1','1','1','2','2','2','3','3','3',
            '1','1','1','2','2','2','3','3','3',
            '4','4','4','5','5','5','6','6','6',
            '4','4','4','5','5','5','6','6','6',
            '4','4','4','5','5','5','6','6','6',
            '7','7','7','8','8','8','9','9','9',
            '7','7','7','8','8','8','9','9','9',
            '7','7','7','8','8','8','9','9','9'
    };
    char H[][] = new char[326][7];
    long c2, w, seed;
    int b, f, s1, m0, c1,
            r1, l, i1, m1, m2, a, p,
            i, j, k, r, c, d, n = 729,
            m = 324, x, y, s, z, fi;
    int mi1, mi2, q7, part, nt, rate, nodes, 
            solutions, min, samples, sam1, clues;
    char L[]= {'.','1','2','3','4','5','6','7','8','9'};
    
    /** State machine states */
    static final int M0S = 10;
    static final int M0  = 11;
    static final int MR1 = 12;
    static final int MR3 = 13;
    static final int MR4 = 14;
    static final int M2  = 15;
    static final int M3  = 16;
    static final int M4  = 17;
    static final int M9  = 18;
    static final int MR  = 19;
    static final int END = 20;
    static final int M6  = 21;
    
    /** Set to true to generate debug output */
    boolean DBG = false;
    
    /** Output trace messages */
    public void dbg(String s) {
        if(DBG)
            System.out.println(s);
    }
    
    public dlx_generator() {
        dbg("In constructor");
    }
    
    /**
     * Save the generated Sudoku to a file.
     */
    public void saveSudokuToFile(String s) {
        FileOutputStream FO = null;
        byte[] buffer = new byte[s.length()+1];
        int i = 0;
        
        while (i < s.length()){
            buffer[i] = (byte) s.charAt(i);
            i++;
        }
        
        try {
            FO = new FileOutputStream("generated_sudoku.sdk");
            FO.write(buffer);
            FO.close();
        } catch (IOException IOE) {
            // Well, well, well....
            return;
        }
    }
    
    /**
     * Initialization code for both generate() and rate()
     */
    public void initialize() {
        for(i = 0; i < 888; i++) {
            j = 1;
            while(j <= i)
                j += j;
            Two[i] = j - 1;
        }
        
        r = 0;
        for(x = 1; x <= 9; x++) for(y = 1; y <= 9; y++) for(s = 1;s <= 9; s++) {
            r++;
            Cols[r] = 4;
            Col[r][1] = x * 9 - 9 + y;
            Col[r][2] = (B[x * 9 - 9 + y] - 48) * 9 - 9 + s + 81;
            Col[r][3] = x * 9 - 9 + s + 81 * 2;
            Col[r][4] = y * 9 - 9 + s + 81 * 3;
        }
        
        for(c = 1; c <= m; c++) Rows[c] = 0;
        
        for(r = 1; r <= n; r++) for(c = 1; c <= Cols[r]; c++) {
            a = Col[r][c];
            Rows[a]++;
            Row[a][Rows[a]] = r;
        }
        
        c = 0;
        for(x = 1; x <= 9; x++) for(y = 1; y <= 9; y++) {
            c++;
            H[c][0] = 'r';
            H[c][1] = L[x];
            H[c][2] = 'c';
            H[c][3] = L[y];
            H[c][4] = 0;
        }
        
        c = 81;
        for(b = 1; b <= 9; b++) for(s = 1; s <= 9; s++) {
            c++;
            H[c][0] = 'b';
            H[c][1] = L[b];
            H[c][2] = 's';
            H[c][3] = L[s];
            H[c][4] = 0;
        }
        
        c = 81 * 2;
        for(x = 1; x <= 9; x++) for(s = 1; s <= 9; s++) {
            c++;
            H[c][0] = 'r';
            H[c][1] = L[x];
            H[c][2] = 's';
            H[c][3] = L[s];
            H[c][4] = 0;
        }
        
        c = 81 * 3;
        for(y = 1; y <= 9; y++) for(s = 1; s <= 9; s++) {
            c++;
            H[c][0] = 'c';
            H[c][1] = L[y];
            H[c][2] = 's';
            H[c][3] = L[s];
            H[c][4] = 0;
        }
    }
    
    /*
     * Rating function
     */
    public long rate(String puzzle) {
        int STATE = M6;
        int Solutions;
        Date t = new Date();
        seed = t.getTime();
        zr ^= seed;
        wr += seed;
        z = 100;
        fi = 0;
        rate = 1;
        
        for(i = 0; i < 88; i++)
            A[i] = 0;
        
        initialize();
        
        while(STATE != END) {
            switch (STATE) {
                case M6:
                    clues = 0;
                    for(i = 1; i <= 81; i++){
                        c = puzzle.charAt(i-1);
                        j = 0;
                        
                        if(c == '-' || c == '.'|| c == '0' || c == '*'){
                            A[i] = j;
                        } else {
                            while(L[j] != c && j <= 9)
                                j++;
                            
                            if(j <= 9){
                                A[i] = j;
                            }
                        }
                    }
                    
                    if(clues == 81){
                        clues--;
                        A[1] = 0;
                    }
                    
                    nt = 0;
                    mi1 = 9999;
                    for(f = 0; f < z; f++){
                        Solutions = solve();
                        if(Solutions != 1){
                            if(Solutions > 1)
                            nt = -1 * Solutions;
                            STATE = END;
                            break;
                        }
                        nt += nodes;
                        if(nodes < mi1) {
                            mi1 = nodes;
                            mi2 = C[clues];
                        }
                    }
                    if (STATE == END)
                        break;
                    
                    if(fi > 0) if((nt / z) > fi){
                        for(i = 1; i <= 81; i++)
                            System.out.println(L[A[i]]);
                        System.out.println();
                        STATE = M6;
                        break;
                    }
                    
                    if(fi > 0) {
                        STATE = M6;
                        break;
                    }
                    
                    if((z&1) > 0) {
                        System.out.println(nt/z);
                        STATE = M6;
                        break;
                    }
                                        
                    if(rate > 1)
                        System.out.println("hint: " + H[mi2]);
                    
                    STATE = END;
                    break;
            } // End of switch statement
        } // End of while loop
        return (nt);
    }
    
    public String[] generate(long Seed, int Samples, int Rate){
        int STATE = M0S;
        String result[] = new String[Samples];
        
        dbg("Entering generate");
        
        seed = Seed;
        zr = zr ^ seed;
        wr = wr + seed;
        
        samples = 1000;
        if (Samples > 0)
            samples = Samples;
        
        for(i = 0; i < samples; i++)
            result[i] = new String();
        
        // Set to 1 for rating, set to 2 for rating and hint
        rate = 0;
        if(Rate > 0)
            rate = Rate;
        if(rate > 2)
            rate = 2;
        
        initialize();
        
        dbg("Entering state machine");
        
        sam1 = -1;
        while(STATE != END) {
            switch (STATE) {
                case M0S:
                    sam1++;
                    if(sam1 >= samples) {
                        STATE = END;
                        break;
                    }
                    
                case M0:
                    for(i = 1; i <= 81; i++) A[i] = 0;
                    part = 0;
                    q7 = 0;
                    
                case MR1:
                    i1 = (int)((MWC()>>8)&127);
                    if(i1 > 80) {
                        STATE = MR1;
                        break;
                    }
                    
                    i1++;
                    if(A[i1] > 0) {
                        STATE = MR1;
                        break;
                    }
                    
                case MR3:
                    s = (int)((MWC()>>9)&15);
                    if(s > 8) {
                        STATE = MR3;
                        break;
                    }
                    
                    s++;
                    A[i1] = s;
                    m2 = solve();
                    q7++;
                    
                    if(m2 < 1)
                        A[i1] = 0;
                    
                    if(m2 != 1){
                        STATE = MR1;
                        break;
                    }
                    
                    part++;
                    if(solve() != 1) {
                        STATE = M0;
                        break;
                    }
                    
                case MR4:
                    for(i = 1; i <= 81; i++){
                        x = (int)((MWC()>>8)&127);
                        while(x >= i) {
                            x = (int)((MWC()>>8)&127);
                        }
                        x++;
                        P[i] = P[x];
                        P[x]=i;
                    }
                    
                    for(i1 = 1; i1 <= 81; i1++){
                        s1 = A[P[i1]];
                        A[P[i1]] = 0;
                        if(solve() > 1) A[P[i1]] = s1;
                    }
                    
                    if(rate > 0){
                        nt = 0;
                        mi1 = 9999;
                        for(f = 0; f < 100; f++){
                            solve();
                            nt += nodes;
                            if(nodes < mi1) {
                                mi1 = nodes;
                                mi2 = C[clues];
                            }
                        }
                        result[sam1] = result[sam1].concat("Rating:" + nt + "# ");
                        if(rate > 1) {
                            result[sam1] = result[sam1].concat("hint: " + String.valueOf(H[mi2]).substring(0, 4) + " #\n");
                        } else
                            result[sam1] = result[sam1].concat("\n");
                    }
                    
                    for(i = 1; i <= 81; i++) {
                        result[sam1] = result[sam1].concat(String.valueOf(L[A[i]]));
                        if(i%9 == 0) {
                            //result[sam1] = result[sam1].concat("\n");
                        }
                    }
                    //result[sam1] = result[sam1].concat("\n");
                    
                default:
                    dbg("Default case. New state M0S");
                    STATE = M0S;
                    break;
            } // end of switch statement
        } // end of while loop
        return result;
    }
    
    public int solve(){//returns 0 (no solution), 1 (unique sol.), 2 (more than one sol.)
        int STATE = M2;
        
        for(i = 0; i <= n; i++) Ur[i] = 0;
        for(i = 0; i <= m; i++) Uc[i] = 0;
        clues = 0;
        
        for(i = 1; i <= 81; i++) if(A[i] > 0){
            clues++;
            r = i * 9 - 9 + A[i];
            
            for(j = 1; j <= Cols[r]; j++){
                d = Col[r][j];
                if(Uc[d] > 0) return 0;
                Uc[d]++;
                
                for(k = 1; k <= Rows[d]; k++){
                    Ur[Row[d][k]]++;
                }
            }
        }
        
        for(c = 1; c <= m; c++) {
            V[c] = 0;
            for(r = 1; r <= Rows[c]; r++) if(Ur[Row[c][r]] == 0)
                V[c]++;
        }
        
        i = clues;
        m0 = 0;
        m1 = 0;
        solutions = 0;
        nodes = 0;
        
        dbg("Solve: Entering state machine");
        
        while(STATE != END) {
            switch(STATE) {
                case M2:
                    i++;
                    I[i] = 0;
                    min = n+1;
                    if((i > 81) || (m0 > 0)){
                        STATE = M4;
                        break;
                    }
                    
                    if(m1 > 0){
                        C[i] = m1;
                        STATE = M3;
                        break;
                    }
                    
                    w = 0;
                    for(c = 1; c <= m; c++) if(Uc[c] == 0){
                        if(V[c] < 2){
                            C[i] = c;
                            STATE = M3;
                            break;
                        }
                        
                        if(V[c] <= min){
                            w++;
                            W[(int)w] = c;
                        }
                        ;
                        
                        if(V[c] < min){
                            w = 1;
                            W[(int)w] = c;
                            min = V[c];
                        }
                    }
                    
                    if(STATE == M3) {
                        // break in for loop detected, continue breaking
                        break;
                    }
                    
                case MR:
                    c2 = (MWC()&Two[(int)w]);
                    while (c2 >= w){
                        c2 = (MWC()&Two[(int)w]);
                    }
                    C[i] = W[(int)c2 + 1];
                    
                case M3:
                    c = C[i];
                    I[i]++;
                    if(I[i] > Rows[c]){
                        STATE = M4;
                        break;
                    }
                    
                    r = Row[c][I[i]];
                    if(Ur[r] > 0){
                        STATE = M3;
                        break;
                    }
                    m0 = 0;
                    m1 = 0;
                    nodes++;
                    for(j = 1; j <= Cols[r]; j++){
                        c1 = Col[r][j];
                        Uc[c1]++;
                    }
                    
                    for(j = 1; j <= Cols[r]; j++){
                        c1 = Col[r][j];
                        for(k = 1; k <= Rows[c1]; k++){
                            r1 = Row[c1][k];
                            Ur[r1]++;
                            if(Ur[r1] == 1) for(l = 1; l <= Cols[r1]; l++){
                                c2 = Col[r1][l];
                                V[(int)c2]--;
                                if(Uc[(int)c2] + V[(int)c2] < 1)
                                    m0 = (int)c2;
                                if(Uc[(int)c2] == 0 && V[(int)c2] < 2)
                                    m1 = (int)c2;
                            }
                        }
                    }
                    
                    if(i == 81)
                        solutions++;
                        
                    if(solutions > 1) {
                        STATE = M9;
                        break;
                    }
                    STATE = M2;
                    break;
                    
                case M4:
                    i--;
                    if(i == clues) {
                        STATE = M9;
                        break;
                    }
                    c = C[i];
                    r = Row[c][I[i]];

                    for(j = 1; j <= Cols[r]; j++){
                        c1 = Col[r][j];
                        Uc[c1]--;
                        for(k = 1; k <= Rows[c1]; k++){
                            r1 = Row[c1][k];
                            Ur[r1]--;
                            if(Ur[r1] == 0) for(l = 1; l <= Cols[r1]; l++){
                                c2 = Col[r1][l];
                                V[(int)c2]++;
                            }
                        }
                    }
                    
                    if(i > clues) {
                        STATE = M3;
                        break;
                    }
                    
                case M9:
                    STATE = END;
                    break;
                default:
                    STATE = END;
                    break;
            } // end of switch statement
        } // end of while statement
        return solutions;
    }
//}


#End If