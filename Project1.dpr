program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Unit1 in 'Unit1.pas';

//var
     //n: integer;
     //i: integer;
     //x: TInfo;
     //y:string;

begin
 // readln(n);
  SizeTable:= n;
  SetLength (A, SizeTable);
  Create;
  {for i := 0 to n-1 do
  begin
    readln(x);
    readln(y);
    add(x,y);
  end }
  add(4, 'abc');
  add(2, 'def');
  add(5, 'ghi');
  add(2, 'jk');
  add(1, 'lmn');
  add(12, 'ghi1');
  add(7, 'lmn');
  writeln(Find(7));
  writeln(delete(7, 'lmn'));
  writeln(Find(7));
  WriteHash; //вот процедура, которую вы просили, которая выводит таблицу
  readln;
  
end.
