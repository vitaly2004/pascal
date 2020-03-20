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
    Result := new row(r1.length);
    for var i := 0 to r1.length - 1 do
      result.data[i] := r1.data[i] + r2.data[i];
  end;
  class function operator*(k: real; r: row): row;
  begin
    Result := new row(r.length);
    for var i := 0 to r.length - 1 do
      result.data[i] := k * r.data[i];
  end;
  class function operator*(r: row; k: real): row;
  begin
    Result := new row(r.length);
    result := k * r;
  end;
  class function operator-(r: row): row;
  begin
    Result := new row(r.length);
    result := (-1) * r;
  end;
  class function operator-(r1, r2: row): row;
  begin
    Result := new row(r1.length);
    result := r1 + (-r2);
  end;
end;

type linearSystem = record
  rows: array of row;
  size: integer;
  keys: array of real;
  
  constructor(n: integer);
  begin
    rows := new row[n];
    for var i := 0 to n - 1 do
      rows[i] := new row(n + 1);
    keys := new real[n];
    size := n;
  end;
  
  procedure setEl(i, j: integer; value: real);
  begin
    rows[i].data[j] := value;
  end;
  
  function getEl(i, j: integer): real;
  begin
    result := rows[i].data[j];
  end;
  
  property el[i, j: integer]: real Read getEl Write setEl; default;
  
  procedure inFromKeyboard();
  begin
    for var i := 0 to size - 1 do
      for var j := 0 to size do
      begin
        var x: real;
        Read(x);
        el[i, j] := x;
      end;
  end;
  
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
  begin
    if el[k, k] = 0 then
    begin
      var i := k + 1;
      while el[i, k] = 0 do
        i += 1;
      swapRows(k , i);
    end;
    for var i := k + 1 to size - 1 do
    begin
      rows[i] := rows[i] - el[i, k] / el[k, k] * rows[k]; 
    end;
  end;
  
  procedure stepGaussBackward(i: integer);
  begin 
    for var k := i - 1 downto 0 do
    begin
      rows[k] := rows[k] - el[k, i] / el[i, i] * rows[i]; 
    end;
  end;
  
  procedure gauss();
  begin  
    for var i := 0 to size - 2 do
      stepGaussForward(i);
      
    for var i := size - 1 downto 1 do
      stepGaussBackward(i);
      
    for var i := 0 to size - 1 do
      rows[i] := rows[i] * (1 / el[i, i]);
  end;
  
  function kramerMatrix(k: integer): matrix;
  begin
    Result := new matrix(size);
    for var i := 0 to size - 1 do
      for var j := 0 to size - 1 do
        Result.data[i, j] := el[i, j];
    if k = 0 then exit;
    for var i := 0 to size - 1 do
      Result.data[i, k - 1] := el[i, size];
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
  s.Gauss();
  Write(s);
end.