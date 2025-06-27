# utl-convert-a-sqlite-numeric-table-to-a-matrix-for-octave-matlab-processing
    %let pgm=utl-convert-a-sqlite-numeric-table-to-a-matrix-for-octave-matlab-processing;

    %stop_submission;

    Add function table2mat to octave autocall library to convert a numeric octave table to a matrix and invert the matrix

    Contents

        1 sqlite table to matrix
        2 table2matx function

    Problem:

      Invert this matrix stored in a sqlite table

       01 02 03 06
       03 05 07 02
       13 10 11 12
       32 01 08 03

    /***************************************************************************************************************************/
    /*        INPUT & PROCESS                               |                    OUTPUT                                        */
    /*        ===============                               |                    ======                                        */
    /*  Sqlite table have                                   |  1 SQLITE TABLE TO MATRIX                                        */
    /*                   not                                |  ========================                                        */
    /*  cid  name  type  null dflt  pk                      |                                             n                    */
    /*  ___  ____  ____  ____ ____  __                      |  local fetched copy of sqlite table                              */
    /*                                                      |                                                                  */
    /*  0    n1    REAL  0          0                       |  tbl=fetch(db,"select * from have");                             */
    /*  1    n2    REAL  0          0                       |                                                                  */
    /*  2    n3    REAL  0          0                       |  n1  n2  n3  n4                                                  */
    /*  3    n4    REAL  0          0                       |  __  __  __  __                                                  */
    /*                                                      |                                                                  */
    /*  4x4 table                                           |  1   2   3   6                                                   */
    /*                                                      |  3   5   7   2                                                   */
    /*  n1  n2  n3  n4                                      |  13  10  11  12                                                  */
    /*  __  __  __  __                                      |  32  1   8   3                                                   */
    /*                                                      |                                                                  */
    /*  1   2   3   6                                       |                                                                  */
    /*  3   5   7   2                                       |  table2matx 4x4 matrix numeric                                   */
    /*  13  10  11  12                                      |                                                                  */
    /*  32  1   8   3                                       |  Name    Size      Bytes  Class                                  */
    /*                                                      |  ====    ====      =====  =====                                  */
    /*                                                      |  matx    4x4         128  double ---> cell type has no type info */
    /* %utl_mbegin;                                         |                                                                  */
    /* parmcards4;                                          |  matx                                                            */
    /* pkg load sqlite                                      |    1    2    3    6                                              */
    /* db = sqlite(":memory:", "create");                   |    3    5    7    2                                              */
    /* execute(db,["create table have " ...                 |   13   10   11   12                                              */
    /*   "(n1 real,n2 real,n3 real,n4 real)"]);             |   32    1    8    3                                              */
    /* execute(db, ...                                      |                                                                  */
    /*  ["insert into have (n1,n2,n3,n4) values " ...       |                                                                  */
    /*   "( 01,02,03,06 ), " ...                            |                                                                  */
    /*   "( 03,05,07,02 ), " ...                            | INVERSE                                                          */
    /*   "( 13,10,11,12 ), " ...                            |                                                                  */
    /*   "( 32,01,08,03 ); " ...                            | -7.6826e-02  -5.9331e-02   4.2850e-02   2.1805e-02               */
    /*  ]);                                                 | -4.3864e-01  -1.3083e-01   2.6116e-01  -8.0122e-02               */
    /*                                                      |  2.9539e-01   2.8753e-01  -2.0766e-01   4.8174e-02               */
    /* meta = fetch(db,"pragma table_info('have');");       |  1.7799e-01  -9.0264e-02   9.6349e-03  -1.0142e-03               */
    /* disp(meta);                                          |                                                                  */
    /*                                                      |------------------------------------------------------------------*/
    /* tbl=fetch(db,"select * from have");                  | 2 TABLE2MATX FUNCTION                                            */
    /* disp(tbl);                                           | ======================                                           */
    /*                                                      |                                                                  */
    /* matx=table2matx(tbl);                                | function matx=table2matx(tbl);                                   */
    /* disp(matx);                                          |                                                                  */
    /* whos matx;                                           |    ##################################################            */
    /*                                                      |    ##  dbtbl must have only numeric values         ##            */
    /* matx_inv=inv(matx);                                  |    ##  might work for mixed or character sql table ##            */
    /* disp(matx_inv);                                      |    ##################################################            */
    /*                                                      |                                                                  */
    /* close(db);                                           |    [rows,cols]=size(tbl);                                        */
    /* ;;;;                                                 |                                                                  */
    /* %utl_mend;                                           |    mat = cell(rows,cols);                                        */
    /*                                                      |                                                                  */
    /*                                                      |    for row=1:rows;                                               */
    /*                                                      |      for col=1:cols;                                             */
    /*                                                      |        mat(row,col)= tbl{row}{col};                              */
    /*                                                      |      end;                                                        */
    /*                                                      |    end;                                                          */
    /*                                                      |                                                                  */
    /*                                                      |    matx=cell2mat(mat);                                           */
    /*                                                      | end                                                              */
    /***************************************************************************************************************************/

    /*---- save function in octave autocall library ----*/

    %let oto=C:/Program Files/GNU Octave/Octave-10.2.0/mingw64/share/octave/10.2.0/m/miscellaneous;
    filename ft15f001 "&oto/table2matx.m";
    parmcards4;
    function matx=table2matx(tbl);

       ##################################################
       ##  dbtbl must have only numeric values         ##
       ##  might work for mixed or character sql table ##
       ##################################################

       [rows,cols]=size(tbl);

       mat = cell(rows,cols);

       for row=1:rows;
         for col=1:cols;
           mat(row,col)= tbl{row}{col};
         end;
       end;

       matx=cell2mat(mat);
    end
    ;;;;
    run;quit;

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
