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
Public Sub Initialize(sudokustring As String) As String
  nativeMe = Me
  sudokustring = nativeMe.RunMethod("solve",Array(sudokustring))
  Return sudokustring

End Sub

#If Java

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

/****************************************************************************
 * dlx_solver solve any Sudoku in a fraction of a second. Input is
 * a string of dots and digits representing the puzzle to solve and
 * output is the solved puzzle.
 *
 * @author Rolf Sandberg
 ****************************************************************************/

//public class dlx_solver {
    static final int M = 8; // change this for larger grids. Use symbols as in L[] below
    static final int M2 = M * M;
    static final int M4 = M2 * M2;
    long zr=362436069, wr=521288629;
    
    /** Pseudo-random number generator */
    long MWC() {
        return ((zr=36969*(zr&65535)+(zr>>16))^(wr=18000*(wr&65535)+(wr>>16)));
    }
    
    int A0[][]      = new int[M2 + 9][M2 + 9],
            A[][]   = new int[M2 + 9][M2 + 9],
            Rows[]  = new int[4 * M4 + 9],
            Cols[]  = new int[M2 * M4 + 9],
            Row[][] = new int[4 * M4 + 9][M2 + 9];
    int Col[][]     = new int[M2 * M4 + 9][5],
            Ur[]    = new int[M2 * M4 + 9],
            Uc[]    = new int[4 * M4 + 9],
            V[]     = new int[M2 * M4 + 9];
    int C[]         = new int[M4 + 9],
            I[]     = new int[M4 + 9],
            T[]     = new int[M2 * M4 + 9],
            P[]     = new int[M2 * M4 + 9];
    int Mr[] = {0,1,63,1023,4095,16383,46655,131071,262143};
    int Mc[] = {0,1,63,511,1023,4095,8191,16383,16383};
    int Mw[] = {0,1,3,15,15,31,63,63,63};
    
    int nocheck = 0, max, _try_,
            rnd = 0, min, clues, gu, tries;
    long Node[] = new long[M4 + 9];
    long nodes, tnodes, solutions, vmax, smax, time0, time1, t1, x1;
    double xx, yy;
    int q, a, p, i, i1, j, k, l, r, r1,
            c, c1, c2, n, N = 0, N2, N4,
            m, m0, m1, x, y, s;
    char L[] = {'.',
            '1','2','3','4','5','6','7','8','9',
            'A','B','C','D','E','F','G','H','I',
            'J','K','L','M','N','O','P','Q','R',
            'S','T','U','V','W','X','Y','Z','a',
            'b','c','d','e','f','g','h','i','j',
            'k','l','m','n','o','p','q','r','s',
            't','u','v','w','x','y','z','#','*','~'
    };
    
    /** State machine states */
    static final int M6 = 10;
    static final int M7 = 11;
    static final int RESTART = 12;
    static final int M22 = 13;
    static final int M3 = 14;
    static final int M44 = 15;
    static final int NEXT_TRY = 16;
    static final int END = 30;
    
    /**
     * Solver function. 
     * Input parameter: A puzzle to solve
     * Output: The solved puzzle
     **/
    public String solve(String puzzle) {
        String result = new String();
        int STATE = M6;
        
        vmax = 4000000;
        smax = 25;
        p = 1;
        q = 0;
        
        Date t = new Date();
        t1 = t.getTime();
        zr ^= t1;
        wr += t1;
        
        if(rnd < 999) {
            zr ^= rnd;
            wr += rnd;
            for(i = 1; i < rnd; i++)
                MWC();
        }
        
        if(q > 0) {
            vmax=99999999;
            smax=99999999;
        }
        
        N = 3;
        N2 = N  * N;
        N4 = N2 * N2;
        m  = 4  * N4;
        n  = N2 * N4;
        
        if(puzzle.length() < N4){
            return "Error, puzzle incomplete";
        }

        t = new Date();
        time0 = t.getTime();
        while (STATE != END) {
            switch (STATE) {
                case M6:
                    clues = 0;
                    i = 0;
                    for(x = 0; x < N2; x++) for(y = 0; y < N2; y++) {
                        c = puzzle.charAt(x * N2 + y);
                        j = 0;
                        
                        if(c == '-' || c == '.'|| c == '0' || c == '*'){
                            A0[x][y] = j;
                            i++;
                        } else {
                            while(L[j] != c && j <= N2)
                                j++;
                            
                            if(j <= N2){
                                A0[x][y] = j;
                                if(j > 0)
                                    clues++;
                                i++;
                            }
                        }
                    }
                    
                    if(clues == N4) {
                        clues--;
                        A0[1][1] = 0;
                    }
                    
                    
                    if(p < 8) {
                        for(i = 0; i <= N4; i++)
                            Node[i]=0;
                    }
                    tnodes = 0;
                    
                case RESTART:
                    r = 0;
                    for(x = 1; x <= N2; x++) for(y = 1; y <= N2; y++) for(s = 1; s <= N2; s++) {
                        r++;
                        Cols[r] = 4;
                        Col[r][1] = x*N2-N2+y;
                        Col[r][4] = (N * ((x - 1) / N) + (y - 1) / N) * N2 + s + N4;
                        
                        Col[r][3]=x * N2 - N2 + s + N4 * 2;
                        Col[r][2]=y * N2 - N2 + s + N4 * 3;
                    }
                    for(c = 1; c <= m; c++) Rows[c]=0;
                    
                    for(r = 1; r <= n; r++) for(c = 1; c <= Cols[r]; c++) {
                        x = Col[r][c];
                        Rows[x]++;
                        Row[x][Rows[x]] = r;
                    }
                    
                    for(x = 0; x < N2; x++) for(y = 0; y < N2; y++)
                        A[x][y] = A0[x][y];
                    
                    for(i = 0; i <= n; i++) Ur[i] = 0;
                    for(i = 0; i <= m; i++) Uc[i] = 0;
                    
                    solutions = 0;
                    
                    for(x = 1; x <= N2; x++) for(y = 1; y <= N2; y++) if(A[x-1][y-1] > 0) {
                        r = x * N4 - N4 + y * N2 - N2 + A[x-1][y-1];
                        
                        for(j = 1; j <= Cols[r]; j++) {
                            c1 = Col[r][j];
                            if(Uc[c1] > 0 && nocheck == 0) {
                                STATE = NEXT_TRY;
                                break;
                            }
                            
                            Uc[c1]++;
                            
                            for(k = 1; k <= Rows[c1]; k++) {
                                r1 = Row[c1][k];
                                Ur[r1]++;
                            }
                        }
                        if(STATE == NEXT_TRY)
                            break;
                    }
                    if(STATE == NEXT_TRY)
                        break;
                    
                    if(rnd > 0 && rnd != 17 && rnd != 18)
                        shuffle();
                    
                    for(c = 1; c <= m; c++) {
                        V[c] = 0;
                        for(r = 1; r <= Rows[c]; r++) if(Ur[Row[c][r]] == 0)
                            V[c]++;
                    }
                    
                    i = clues;
                    nodes = 0;
                    m0 = 0;
                    m1 = 0;
                    gu = 0;
                    solutions = 0;
                    
                case M22:
                    i++;
                    I[i] = 0;
                    min = n+1;
                    if(i > N4 || m0 > 0){
                        STATE = M44;
                        break;
                    }
                    if(m1 > 0) {
                        C[i] = m1;
                        STATE = M3;
                        break;
                    }
                    for(c = 1; c <= m; c++) if(Uc[c] == 0) {
                        if(V[c] <= min) c1 = c;
                        if(V[c] < min) {
                            min = V[c];
                            C[i] = c;
                            if(min < 2) {
                                STATE = M3;
                                break;
                            }
                        }
                    }
                    if(STATE == M3)
                        break;
                    
                    gu++;
                    if(min > 2) {
                        STATE = M3;
                        break;
                    }
                    
                    if((rnd&255) == 18) if((nodes&1) > 0) {
                        c = m + 1;
                        c--;
                        while(Uc[c]> 0 || V[c] != 2)
                            c--;
                        C[i] = c;
                    }
                    
                    if((rnd&255) == 17) {
                        c1 = (int)(MWC() & Mc[N]);
                        while(c1 >= m)
                            c1 = (int)(MWC() & Mc[N]);
                        c1++;
                        
                        for(c = c1; c <= m; c++) if(Uc[c] == 0) if(V[c] == 2) {
                            C[i] = c;
                            STATE = M3;
                            break;
                        }
                        for(c = 1; c < c1; c++) if(Uc[c] == 0)if(V[c] == 2) {
                            C[i] = c;
                            STATE = M3;
                            break;
                        }
                    }
                    
                case M3:
                    c = C[i];
                    I[i]++;
                    if(I[i] > Rows[c]) {
                        STATE = M44;
                        break;
                    }
                    
                    r = Row[c][I[i]];
                    if(Ur[r] > 0) {
                        STATE = M3;
                        break;
                    }
                    m0 = 0;
                    m1 = 0;
                    
                    if(q > 0 && i > 32 && i < 65) if((MWC()&127) < q) {
                        STATE = M3;
                        break;
                    }
                    
                    k = N4;
                    x = (r - 1) / k + 1;
                    y = ((r - 1) % k) / j + 1;
                    s =(r - 1) % j + 1;
                    
                    if((p&1) > 0) {
                        j = N2;
                        k = N4;
                        x = (r - 1) / k + 1;
                        y =((r - 1) % k) / j + 1;
                        s =(r - 1) % j + 1;
                        A[x-1][y-1] = s;
                        if(i == k) {
                            for(x = 0; x < j; x++) for(y = 0; y < j; y++)
                                result = result.concat(String.valueOf(L[A[x][y]]));
                        }
                    }
                    
                    for(j = 1; j <= Cols[r]; j++) {
                        c1 = Col[r][j];
                        Uc[c1]++;
                    }
                    
                    for(j = 1; j <= Cols[r]; j++) {
                        c1 = Col[r][j];
                        
                        for(k = 1; k <= Rows[c1]; k++) {
                            r1 = Row[c1][k];
                            Ur[r1]++;
                            if(Ur[r1] == 1) for(l = 1; l <= Cols[r1]; l++) {
                                c2 = Col[r1][l];
                                V[c2]--;
                                
                                if(Uc[c2] + V[c2] < 1) m0 = c2;
                                if(Uc[c2] == 0 && V[c2] < 2) m1 = c2;
                            }
                        }
                    }
                    Node[i]++;
                    tnodes++;
                    nodes++;
                    if(rnd > 99 && nodes > rnd) {
                        STATE = RESTART;
                        break;
                    }
                    if(i == N4) solutions++;
                    
                    if(solutions >= smax) {
                        System.out.println("smax xolutions found");
                        if(_try_ == 1) System.out.print("+");
                        STATE = NEXT_TRY; 
                        break;
                    }
                    if(tnodes > vmax) {
                        if(_try_ == 1) System.out.print("-");
                        STATE = NEXT_TRY; 
                        break;
                    }
                    STATE = M22;
                    break;
                    
                case M44:
                    i--;
                    c = C[i];
                    r = Row[c][I[i]];
                    if(i == clues) {
                        STATE = NEXT_TRY;
                        break;
                    }
                    
                    for(j = 1; j <= Cols[r]; j++) {
                        c1 = Col[r][j];
                        Uc[c1]--;
                        
                        for(k = 1; k <= Rows[c1]; k++) {
                            r1 = Row[c1][k];
                            Ur[r1]--;
                            
                            if(Ur[r1] == 0) for(l = 1; l <= Cols[r1]; l++) {
                                c2 = Col[r1][l];
                                V[c2]++;
                            }
                        }
                    }
                    if(p > 0) {
                        j = N2;
                        k = N4;
                        x = (r - 1) / k + 1;
                        y = ((r - 1) % k) / j + 1;
                        s = (r - 1) % j + 1;
                        A[x-1][y-1] = 0;
                    }
                    if(i > clues){
                        STATE = M3;
                        break;
                    }
                    
                case NEXT_TRY:
                    t = new Date();
                    time1 = t.getTime();
                    x1 = time1 - time0;
                    
                    time0 = time1;
                    
                    if(q > 0) {
                        xx = 128;
                        yy = 128 - q;
                        xx = xx / yy;
                        yy = solutions;
                        for(i = 1; i < 33; i++) yy = yy * xx;
                        System.out.println("clues: " + clues + " estimated solutions:" + yy + " time " + x1 + "ms");
                        
                        STATE = END;
                        break;
                    }
                    if((p == 0 || p == 1) && tnodes <= 999999) {
                        if(solutions >= smax)
                            result = result.concat("More than " + solutions + " solutions ( bad sudoku!! ), rating " + (100 * tnodes / solutions) + ", time " + x1 + " ms");
                        else if (solutions == 1)
                            result = result.concat(solutions + " solution, rating " + (100 * tnodes) + ", time " + x1 + " ms");
                        else if (solutions == 0)
                            result = result.concat("0 solutions, no rating possible, time " + x1 + " ms");
                        else
                            result = result.concat(solutions + " solutions ( bad sudoku!! ), rating " + (100 * tnodes / solutions) + ", time " + x1 + " ms");
                        
                        STATE = END;
                        break;
                    }
                    if(p == 6) {
                        System.out.println(solutions);
                        STATE = END;
                        break;
                    }
                    if(p == 0 || p == 1) {
                        System.out.println(solutions + " solution(s), rating " + (100 * tnodes) +", time " + x1 + "ms");
                    }
                    if(p > 5) {
                        x = 0;
                        for(i = 1; i <= N4; i++) {
                            x += Node[i];
                            System.out.print(Node[i]);
                            if(i % 9 == 0)
                                System.out.println();
                        }
                        System.out.println(x);
                    }
                    STATE = END;
                    break;
            } // end of switch statement
        } // end of while loop
        return result;
    }
    
    /**
     * Helper function.
     **/
    public int shuffle() {
        for(i = 1; i <= m; i++) {
            a = (int)((MWC()>>8) & Mc[N]);
            while(a >= i)
                a = (int)((MWC()>>8) & Mc[N]);
            a++;
            P[i] = P[a];
            P[a] = i;
        }
        
        for(c = 1; c <= m; c++) {
            Rows[c] = 0;
            T[c] = Uc[c];
        }
        
        for(c = 1; c <= m; c++)
            Uc[P[c]] = T[c];
        
        for(r = 1; r <= n; r++) for(i = 1; i <= Cols[r]; i++) {
            c = P[Col[r][i]];
            Col[r][i] = c;
            Rows[c]++;
            Row[c][Rows[c]] = r;
        }
        
        for(i = 1; i <= n; i++) {
            a = (int)((MWC()>>8) & Mr[N]);
            while(a >= i)
                a = (int)((MWC()>>8) & Mr[N]);
            a++;
            P[i] = P[a];
            P[a] = i;
        }
        
        for(r = 1; r <= n; r++) {
            Cols[r] = 0;
            T[r] = Ur[r];
        }
        
        for(r = 1; r <= n; r++)
            Ur[P[r]] = T[r];
        
        for(c = 1; c <= m; c++) for(i = 1; i <= Rows[c]; i++) {
            r = P[Row[c][i]];
            Row[c][i] = r;
            Cols[r]++;
            Col[r][Cols[r]] = c;
        }
        
        for(r = 1; r <= n; r++) {
            for(i = 1; i <= Cols[r]; i++) {
                a = (int)((MWC()>>8) & 7);
                while(a >= i)
                    a = (int)((MWC()>>8) & 7);
                a++;
                P[i] = P[a];
                P[a] = i;
            }
            
            for(i = 1; i <= Cols[r]; i++)
                T[i] = Col[r][P[i]];
            
            for(i = 1; i <= Cols[r]; i++)
                Col[r][i] = T[i];
        }
        
        for(c = 1; c <= m; c++) {
            for(i = 1; i <= Rows[c]; i++) {
                a = (int)((MWC()>>8) & Mw[N]);
                while(a >= i)
                    a = (int)((MWC()>>8) & Mw[N]);
                a++;
                P[i] = P[a];
                P[a] = i;
            }
            
            for(i = 1; i <= Rows[c]; i++)
                T[i] = Row[c][P[i]];
            
            for(i = 1; i <= Rows[c]; i++)
                Row[c][i] = T[i];
        }
        return 0;
    }
//}   


#End If