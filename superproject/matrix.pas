type matrix = record
  data: array[,] of real;
  size: integer;
  
  constructor(n: integer);
  begin
    data := new real[n, n];
    size := n;
  end;
  
  procedure inFromKeyboard();
  begin
    for var i := 0 to size - 1 do
      for var j := 0 to size - 1 do
        read(data[i, j]);
  end;
  
  function ToString(): string; override;
  begin
    result := '';
    for var i := 0 to size - 1 do
    begin
      for var j := 0 to size - 1 do
        result += data[i, j].ToString() + ' ';
      result += #10;
    end;
  end;
  
  procedure swapRows(i, j:integer);
  begin
    for var k := 0 to size - 1 do
      swap(data[i, k], data[j, k]);
  end;
   
  procedure swapCols(i, j:integer);
  begin
    for var k := 0 to size - 1 do
      swap(data[k, i], data[k, j]);
  end;
  
  procedure rowDown(i: integer);
  begin
    for var k := i to size - 2 do
      swapRows(k, k + 1);
  end;
  
  procedure colRight(i: integer);
  begin
    for var k := i to size - 2 do
      swapCols(k, k + 1);
  end;
  
  function angle(): matrix;
  begin
    result := new matrix(size - 1);
    for var i := 0 to size - 2 do
      for var j := 0 to size - 2 do
        result.data[i, j] := data[i, j];
  end;
  
  function alg(k, l: integer): matrix;
  begin
    var m: matrix := new matrix(size);
    for var i := 0 to size - 1 do
      for var j := 0 to size - 1 do
        m.data[i, j] := data[i, j];
    m.rowDown(k);
    m.colRight(l);
    result := new matrix(size - 1);
    result := m.angle();
  end;
 
  function det(): real; 
  begin
    
  end;
end;

begin
  var a: matrix := new matrix(3);
  a.inFromKeyboard();
  write(a.alg(1, 1));
end.