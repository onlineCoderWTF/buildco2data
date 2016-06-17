program buildgraph;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  jclStringLists,
  jclFileUtils;

var data: IJCLStringList;
    text: IJCLStringList;
    vals: IJCLStringList;
    temp: IJCLStringList;
    co2: IJCLStringList;
    lbls: IJCLStringList;
    lim1: IJCLStringList;
    lim2: IJCLStringList;
    clrs: IJCLStringList;
    i: integer;
    res: ijclstringlist;
    a: ijclstringlist;
    clr: string;
    tval, prvval: integer;
    ttmp, pvtemp: double;
    fs: TFormatSettings;
    fromFile: string;
    intoFile: string;
const splby =100;
begin
  try
  fromFile := jclFileUtils.ParamValue('fromFile');
  intoFile := jclFileUtils.ParamValue('intoFile');

  data := jclStringList.loadFromFile(fromFile);
    lim1 := JCLStringList;
    lim2 := JCLStringList;
    vals := JCLStringList;
    temp := JCLStringList;
    co2  := JCLStringList;
    lbls := JCLStringList;
    clrs := JCLStringList;
    pvtemp := 0;
    prvval := 0;
    fs.DecimalSeparator := '.';
  a := jclstringlist('category;column-1;column-2;co2color');
  for i := 1 to data.Count - 1 do begin
    //if i mod splby <> 0 then
    //  continue;
    vals := jclStringList.Split(data[i], ',');
    tval :=  strtoint(vals[1]);
    ttmp :=  strtofloat(vals[2], fs);
    if ((i <> 1) and (i <> data.Count - 1)) and (ABS(tval - prvval) < 10) and (ABS(ttmp - pvtemp) < 0.3) then
      continue;
    pvtemp := ttmp;
    prvval := tval;

    lbls.Add('"' + vals[0] + '"');
    temp.Add(vals[2]);
    co2.Add(vals[1]);
    lim1.Add('800');
    lim2.Add('1200');
    clr := '#00FF00';//format('"rgba(%d, %d, %d, 1)"', [000, 255, 000]);
    if strToInt(vals[1]) > 800 then
      clr := '#FF8000';
    if strToInt(vals[1]) > 1200 then
      clr := '#FF0000';
    clrs.Add( clr );
    a.Add(copy(vals[0], 1, 5) + ';' + vals[1] + ';' + vals[2] + ';' + clr);
  end;
  res := jclstringlist;
  res.Add( lbls.Join(',') );
  res.Add( temp.Join(',') );
  res.Add( co2.Join(',') );
  res.Add(lim1.Join(','));
  res.Add(lim2.Join(','));
  res.Add(clrs.Join(','));

  //res.SaveToFile('Y:\09.XML');
  a.SaveToFile(intoFile);
  except
    on anyException: exception do
      writeln('ERR: ' + anyException.message);
  end;
end.
