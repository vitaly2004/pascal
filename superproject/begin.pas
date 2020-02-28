uses matrices;

type row = record
  data: array of real;
  length: integer;
  
  constructor(n: integer);
  begin
    data := new real[n];
    length := n;
  end;
  function ToString(): string; override;
  begin
    result := '(' + data[0];
    for var i := 1 to length - 1 do
      result += '; ' + data[i].ToString();
    result += ')';
  end;
  class function operator+(r1, r2: row): row;
  begin
    for var i := 0 to r1.length - 1 do
      result.data[i] := r1.data[i] + r2.data[i];
  end;
  class function operator*(k: real; r: row): row;
  begin
    for var i := 0 to r.length - 1 do
      result.data[i] := k * r.data[i];
  end;
  class function operator*(r: row; k: real): row;
  begin
    result := k * r;
  end;
  class function operator-(r: row): row;
  begin
    result := (-1) * r;
  end;
  class function operator-(r1, r2: row): row;
  begin
    result := r1 + (-r2);
  end;
end;

type linearSystem = record
  data: array[,] of real;
  keys: array of real;
  size: integer;
  {
  rows: array of row;
  size: integer;
  constructor(n: integer);
  begin
    rows := new row[n];
    for var i := 0 to n - 1 do
      rows[i] := new row(n + 1);
    size := n;
  end;
  }
  
  constructor(n: integer);
  begin
    data := new real[n, n + 1];
    keys := new real[n];
    size := n;
  end;
  
  procedure inFromKeyboard();
  begin
    for var i := 0 to size - 1 do
      for var j := 0 to size do
        read(data[i, j]);
  end;
  
  function ToString(): string; override;
  begin
    result := '';
    for var i := 0 to size - 1 do
    begin
      for var j := 0 to size do
        Result += data[i, j].ToString() + ' ';
      Result += #10;
    end;
  end;
  {
  function ToString(): string; override;
  begin
    result := '';
    for var i := 0 to size - 1 do
      result += rows[i] + #10;
  end;
  procedure swapRows(n1, n2: integer);
  var
    temp: row;
  begin
    temp := rows[n1];
    rows[n1] := rows[n2];
    rows[n2] := temp;
  end;
  
  procedure stepGaussForward(k: integer);
  var i: integer;
  begin
    if rows[k].data[k] = 0 then
    begin
      i := k + 1;
      while rows[i].data[k] = 0 do
        i += 1;
      swapRows(k , i);
    end;
    // coming soon
  end;
  
  procedure gauss();
  begin  
    for var i := 1 to 3 - 1 do
      stepGaussForward(i);
  end;
  }
  function kramerMatrix(k: integer): matrix;
  begin
    Result := new matrix(size);
    for var i := 0 to size - 1 do
      for var j := 0 to size - 1 do
        Result.data[i, j] := data[i, j];
    if k = 0 then exit;
    for var i := 0 to size - 1 do
      Result.data[i, k - 1] := data[i, size];
  end;
  
  procedure kramer();
  begin
    var delta: real := kramerMatrix(0).det();
    for var i := 0 to size - 1 do
      keys[i] := kramerMatrix(i + 1).det() / delta; 
  end;
end;


  
begin
  var s := new linearSystem(3);
  s.inFromKeyboard();
  writeln;
  s.kramer();
  Writeln(s.keys);
end.