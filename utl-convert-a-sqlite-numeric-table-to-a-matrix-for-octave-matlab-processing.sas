%let pgm=utl-convert-a-sqlite-numeric-table-to-a-matrix-for-octave-matlab-processing;

%stop_submission;

Convert a sqlite numeric table to a matrix for octave matlab processing;

github
https://tinyurl.com/2weexse6
https://github.com/rogerjdeangelis/utl-convert-a-sqlite-numeric-table-to-a-matrix-for-octave-matlab-processing

related
https://tinyurl.com/2r9ekpn8
https://github.com/rogerjdeangelis/utl-how-to-store-octave-matlab-objects-in-external-files-for-later-use-with-octave-r-and-python

SOAPBOX ON

  Octave has limited support for mixed type dbtables, but octave makes extensive use of numeric matricies.
  This repo provide a siple way to convert any numeric sqlite table to a octave numeric matrix.

  Basically

  tbl=table(fetch(db,"select * from have"));

  result_matrix = tbl.Variables; --> This is all you need

  disp("Resulting matrix:");
  disp(result_matrix);
  is_matrix = (ndims(result_matrix) == 2);
  disp(is_matrix)

SOAPBOX OFF;



/**************************************************************************************************************************/
/*             INPUT & PROCESS                        |     OUTPUT                                                        */
/*             ===============                        |     ======                                                        */
/*   Sqlite table have                                |                                                                   */
/*                                                    | output local octave dbtable                                       */
/*   cid  name  type  notnull  dflt_value  pk         |                                                                   */
/*   ___  ____  ____  _______  __________  __         | tbl=table(fetch(db,"select * from have"));                        */
/*                                                    |                                                                   */
/*   0    n1    REAL  0                    0          | variables in scope: top scope                                     */
/*   1    n2    REAL  0                    0          |                                                                   */
/*   2    n3    REAL  0                    0          |   Attr   Name     Size    Bytes  Class                            */
/*   3    n4    REAL  0                    0          |   ====   ====     ====    =====  =====                            */
/*                                                    |          tbl      4x4         0  dbtable                          */
/* %utl_mbegin;                                       |                                                                   */
/* parmcards4;                                        |   have dbtable (not a matrix yet)                                 */
/* pkg load sqlite                                    |                                                                   */
/* pkg load windows                                   |    n1  n2  n3  n4                                                 */
/* db = sqlite(":memory:", "create");                 |    __  __  __  __                                                 */
/* execute(db,["create table have " ...               |                                                                   */
/*   "(n1 real,n2 real,n3 real,n4 real)"]);           |    1   2   3   6                                                  */
/* execute(db, ...                                    |    3   5   7   2                                                  */
/*  ["insert into have (n1,n2,n3,n4) values " ...     |    13  10  11  12                                                 */
/*   "( 01,02,03,06 ), " ...                          |    32  1   8   3                                                  */
/*   "( 03,05,07,02 ), " ...                          |                                                                   */
/*   "( 13,10,11,12 ), " ...                          | Cinvert to matrix                                                 */
/*   "( 32,01,08,03 ); " ...                          | result_matrix = tbl.Variables;  --> key assignment                */
/*  ]);                                               |                                                                   */
/*                                                    |                                                                   */
/* meta = fetch(db,"pragma table_info('have');");     | Attr   Name           Size   Bytes  Class                         */
/* disp(meta);                                        | ====   ====           ====   =====  =====                         */
/*                                                    |        result_matrix  1x4      128  cell                          */
/* tbl=table(fetch(db,"select * from have"));         |                                                                   */
/* whos tbl;                                          |                                                                   */
/* disp(tbl)                                          | is_matrix = (ndims(result_matrix) == 2)                           */
/*                                                    | disp(is_matrix)                                                   */
/* result_matrix = tbl.Variables;                     |                                                                   */
/* whos result_matrix;                                | is_matrix                                                         */
/* disp("Resulting matrix:");                         |                                                                   */
/* disp(result_matrix);                               |     1   --> true                                                  */
/* is_matrix = (ndims(result_matrix) == 2);           |                                                                   */
/* disp('is_matrix')                                  | Resulting matrix:                                                 */
/* disp(is_matrix)                                    | {                                                                 */
/* close(db)                                          |   [1,1] =                                                         */
/* ;;;;                                               |   {                                                               */
/* %utl_mend;                                         |     [1,1] = 1                                                     */
/*                                                    |     [2,1] = 3                                                     */
/*                                                    |     [3,1] = 13                                                    */
/*                                                    |     [4,1] = 32                                                    */
/*                                                    |   }                                                               */
/*                                                    |   [1,2] =                                                         */
/*                                                    |   {                                                               */
/*                                                    |     [1,1] = 2                                                     */
/*                                                    |     [2,1] = 5                                                     */
/*                                                    |     [3,1] = 10                                                    */
/*                                                    |     [4,1] = 1                                                     */
/*                                                    |   }                                                               */
/*                                                    |   [1,3] =                                                         */
/*                                                    |   {                                                               */
/*                                                    |     [1,1] = 3                                                     */
/*                                                    |     [2,1] = 7                                                     */
/*                                                    |     [3,1] = 11                                                    */
/*                                                    |     [4,1] = 8                                                     */
/*                                                    |   }                                                               */
/*                                                    |   [1,4] =                                                         */
/*                                                    |   {                                                               */
/*                                                    |     [1,1] = 6                                                     */
/*                                                    |     [2,1] = 2                                                     */
/*                                                    |     [3,1] = 12                                                    */
/*                                                    |     [4,1] = 3                                                     */
/*                                                    |   }                                                               */
/*                                                    | }                                                                 */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
