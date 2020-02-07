type row = record
  data: array of real;
  length: integer := 4;
  constructor(a: real := 0; e: real := 0; c: real := 0; d: real := 0);
  begin
    data := new real[4];
    data[0] := a;
    data[1] := e;
    data[2] := c;
    data[3] := d;
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
  rows: array of row;
  size: integer := 3;
  constructor(r1, r2, r3: row);
  begin
    rows := new row[3];
    rows[0] := r1;
    rows[1] := r2;
    rows[2] := r3;
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
  var i: integer;
  begin
    if rows[k][k] = 0 then
    begin
      i := k + 1;
      while rows[i][k] = 0 do
        i += 1;
      swapRows(k , i);
    end;
    // coming soon
  end;
  
  procedure gauss();
  begin  
    for var i := 1 to 3 - 1 do
      stepGauss(i);
  end;
end;

var
  r1 := new row(1, 2, 3, 4);
  r2 := new row(5, 6, 7, 8);
  r3 := new row(4, 3, 2, 1);
  s := new linearSystem(r1, r2, r3);
  
begin
  writeln(s);
  s.swapRows(0, 2);
  write(s);
end.