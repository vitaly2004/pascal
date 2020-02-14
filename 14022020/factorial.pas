function facIter(n: integer): integer;
begin
  result := 1;
  for var i := 2 to n do
    result *= i;
end;

function facRec(n: integer): integer;
begin
  if n = 1 then result := 1;
  if n > 1 then result := n * facRec(n - 1);
end;

begin
  write(facRec(5));
end.