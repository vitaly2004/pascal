type row = record
  x1, x2, x3, b: real;
  constructor(a, e, c, d: real);
  begin
    x1 := a;
    x2 := e;
    x3 := c;
    b := d;
  end;
  function ToString(): string; override;
  begin
    result := String.Format('({0}; {1}; {2}; {3})', x1, x2, x3, b);
  end;
  class function operator+(r1, r2: row): row;
  begin
    result.x1 := r1.x1 + r2.x1;
    result.x2 := r1.x2 + r2.x2;
    result.x3 := r1.x3 + r2.x3;
    result.b := r1.b + r2.b;
  end;
  class function operator*(k: real; r: row): row;
  begin
    result.x1 := k * r.x1;
    result.x2 := k * r.x2;
    result.x3 := k * r.x3;
    result.b := k * r.b;
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
  r1, r2, r3: row;
  constructor(a1, a2, a3: row);
  begin
    r1 := a1;
    r2 := a2;
    r3 := a3;
  end;
  function ToString(): string; override;
  begin
    result := r1.ToString() + #10 + r2.ToString() + #10 + r3.ToString() + #10;
  end;
  procedure swapRows(n1, n2: integer);
  var
    temp: row;
  begin
    if (n1 = 1) and (n2 = 2) then
    begin
      temp := r1;
      r1 := r2;
      r2 := temp;
    end;
  end;
end;

var
  r1 := new row(1, 2, 3, 4);
  r2 := new row(5, 6, 7, 8);
  r3 := new row(1, 2, 3, 4);
  s := new linearSystem(r1, r2, r3);
  
begin
  writeln(s);
  s.swapRows(1, 2);
  write(s);
end.