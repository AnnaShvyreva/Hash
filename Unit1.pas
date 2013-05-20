unit Unit1;

interface

uses
  sysutils;

type

  TInfo = integer;
  TRecord= record
    inf: TInfo;      //ключ
    value:string;    //значение
  end;
  PNode = ^TNode;
  TNode = record
    info: TRecord;  //ключ, значение
    next: PNode;
    visit: boolean;
  end;

  const
    n=7;

var
  SizeTable:integer;
  A: array of TNode;
  //q, t:PNode;

procedure Create;
function HashFunction ( key: TInfo): integer;
procedure Add(key: TInfo; value: string);
procedure AddList (key: Tinfo; value: string; var q: PNode);
function Find(key: TInfo):string;
function FindSp(key: TInfo; q:PNode):string;
function Delete(key: TInfo; value:string):boolean;
function DeleteSp (key:TInfo; value:string; var q:PNode): boolean;
procedure WriteHash;
procedure WriteHash2(var q:PNode);

implementation

procedure Create;   //непосещено
var
  i: integer;
begin
For i:=0 to SizeTable do
  a[i].visit:=false;
end;

function HashFunction ( key: TInfo): integer;  //индекс элемента в таблице
//var
  //i: integer;
  //tmp: string;
begin
 //tmp := inttostr(key);
 Result:=key mod n;
 {Result:=0;
  for i:=1 to length(tmp) do
    Result:=Result+ord(tmp[i])*i;
  Result:=Result mod SizeTable;}
end;

procedure Add(key: TInfo; value: string);   //ключ, значение
var
  p:integer;  //индекс
begin
  p:=HashFunction(key);
  if A[p].visit=false then    //если не посещено
  begin
    A[p].info.inf:=key;
    A[p].info.value:=value;
    A[p].next:=nil;
    A[p].visit:=true;
  end

  else                      //коллизии
    if key <> A[p].info.inf then
      AddList(key, value, A[p].next);

end;

procedure AddList (key: Tinfo; value: string; var q: PNode);
var
  p: PNode;
begin
  new(p);
  p.info.inf := key;
  p.info.value:=value;
  p.next := nil;
  if q = nil then
    q := p
  else
    if key <> q.info.inf then
      AddList(key, value, q.next);

end;

function Find(key: TInfo):string;
var
  p: integer;
begin
  result := 'false';
  p:=HashFunction(key);       //индекс
  if (A[p].visit <> false) and (A[p].info.inf=key) then
    Result:=A[p].info.value //нашли
  else
    if (A[p].visit <> false) and (A[p].next <> nil) then
      result := FindSp(key, A[p].next);
end;

function FindSp(key: TInfo; q:PNode):string;
begin
  if q.info.inf = key then
    result := q.info.value
  else
    result := FindSp(key, q.next);
end;

function Delete(key: TInfo; value:string):boolean;
var
  p:integer;
begin
  Result:=false;
  p:=HashFunction(key);   //индекс
  if A[p].info.inf=key then
    if A[p].next=nil then
    begin
    //A[p].info= 0
      A[p].visit:=false;
      result:=true;
    end
    else
    begin
      a[p]:=a[p].next^;
      a[p].visit:=true;
    end;
  if (A[p].next <> nil) and (a[p].next.info.inf=key) then
  begin
    a[p].next:=a[p].next.next;
    result:=true;
  end;
  if (A[p].next <> nil) and (a[p].info.inf<>key) then
    result:=DeleteSp(key, value, a[p].next);
end;

function DeleteSp (key:TInfo; value:string; var q:PNode): boolean;
begin
  Result:=false;
  if q.next.info.inf=key then
  begin
    q.next:=q.next.next;
    Result:=true;
  end
  else
    if (q.next<>nil) and (q.info.inf<>key) then
      Result:=DeleteSp(key, value, q.next);
end;

procedure WriteHash;
var
  i:integer;
begin
  for i:=0 to n-1 do

    if A[i].visit=false then
      writeln ('A[',i,']=nil')
    else
      if A[i].next=nil then
        writeln ('A[',i,']= key=',A[i].info.inf,' value=', A[i].info.value)
      else
      begin
        write ('A[',i,']= key=',A[i].info.inf, ' value=', A[i].info.value,'; ');
        writehash2(a[i].next);
      end;

end;

procedure WriteHash2(var q:PNode);
begin
  if q.next=nil then
        writeln ('key=',q.info.inf,' value=', q.info.value)
  else
    begin
      write ('key=',q.info.inf, ' value=', q.info.value,'; ');
      writehash2(q.next);
    end;
end;

end.
