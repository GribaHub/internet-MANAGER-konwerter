unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    EditA1F: TEdit;
    EditA1IN: TEdit;
    EditA1M: TEdit;
    CheckBoxAutorzy: TCheckBox;
    Button1: TButton;
    CheckBoxLogo: TCheckBox;
    EditA2F: TEdit;
    EditA2IN: TEdit;
    EditA2M: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroupA1F: TRadioGroup;
    RadioGroupA1IN: TRadioGroup;
    RadioGroupA1M: TRadioGroup;
    RadioGroupA2F: TRadioGroup;
    RadioGroupA2IN: TRadioGroup;
    RadioGroupA2M: TRadioGroup;
    Editdlr: TEdit;
    Editbld: TEdit;
    ProgressBar1: TProgressBar;
    Edititl: TEdit;
    GroupBox2: TGroupBox;
    CheckBoxR1: TCheckBox;
    CheckBoxR1N: TCheckBox;
    CheckBoxR1Z: TCheckBox;
    Label8: TLabel;
    EditR1: TEdit;
    EditR2: TEdit;
    CheckBoxR2Z: TCheckBox;
    CheckBoxR2N: TCheckBox;
    CheckBoxR2: TCheckBox;
    EditR3: TEdit;
    CheckBoxR3Z: TCheckBox;
    CheckBoxR3N: TCheckBox;
    CheckBoxR3: TCheckBox;
    EditR4: TEdit;
    CheckBoxR4Z: TCheckBox;
    CheckBoxR4N: TCheckBox;
    CheckBoxR4: TCheckBox;
    EditR5: TEdit;
    Label12: TLabel;
    CheckBoxR5Z: TCheckBox;
    CheckBoxR5N: TCheckBox;
    CheckBoxR5: TCheckBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    BitBtn1: TBitBtn;
    CheckBoxP1: TCheckBox;
    CheckBoxP2: TCheckBox;
    CheckBoxR1R: TCheckBox;
    CheckBoxR2R: TCheckBox;
    CheckBoxR3R: TCheckBox;
    CheckBoxR4R: TCheckBox;
    CheckBoxR5R: TCheckBox;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    CheckBoxD: TCheckBox;
    RadioGroupD: TRadioGroup;
    CheckBoxM: TCheckBox;
    LabelT: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CheckBoxAutorzyClick(Sender: TObject);
    procedure RadioGroupA1FClick(Sender: TObject);
    procedure RadioGroupA1INClick(Sender: TObject);
    procedure RadioGroupA1MClick(Sender: TObject);
    procedure RadioGroupA2FClick(Sender: TObject);
    procedure RadioGroupA2INClick(Sender: TObject);
    procedure RadioGroupA2MClick(Sender: TObject);
    procedure CheckBoxR1Click(Sender: TObject);
    procedure CheckBoxR2Click(Sender: TObject);
    procedure CheckBoxR3Click(Sender: TObject);
    procedure CheckBoxR4Click(Sender: TObject);
    procedure CheckBoxR5Click(Sender: TObject);
    procedure Start(Sender: TObject);
  private
    { Private declarations }
    procedure konwertuj(nazwa : string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const en=chr(13)+chr(10);                                   {enter}

      kr85='<hr class=kreska width=85% align=center>';          {kreska 85%}
      kr='<hr class=kreska align=center>';                      {kreska}

      sp='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp';                       {wci�cie}

      ps='<p class=tekst>'+en+sp;                               {akapit standard}
      pg='<p class=glowka>'+en+sp;                              {akapit g��wka}
      pd='<p class=dodatek>'+en+sp;                             {akapit dodatek}

      lp='<a class=firma target=okno href="http://"';           {link pocz�tek}
      ls='>';                                                   {link �rodek}
      lk='</a>'+en+sp;                                          {link koniec}

      mail='<a class=firma href="mailto:';                      {link mail}
      maile='</a>';

      pe='</p>';                                                {paragraf koniec}

      br='<br>';                                                {<br>}
      br2='<br><br>';                                           {2 x <br>}

      img='<img src="artykuly/';                                {img}
      img0='" class=obrazek border=0>';                         {img border=0}
      img1='" class=obrazek border=1>';                         {img border=1}

      ewe='.txt';
      ewy='.htm';

var dzia : array [0..29] of string;
    path : array [0..29] of string;
    mplk : array [0..29] of string;

    rys : array [1..5] of boolean;
    naz : array [1..5] of boolean;
    zro : array [1..5] of boolean;
    ram : array [1..5] of boolean;
    poa : array [1..5] of byte;

    sr,dn : string;

function txt(tekst : string) : string;
var i : integer;
begin
i:=0;

if tekst<>'' then if tekst[1]=' ' then
 begin
 repeat i:=i+1;
 until (i>length(tekst)) or (tekst[i]<>' ');
 tekst:=copy(tekst, i, length(tekst))
 end;

txt:=tekst;
end;

procedure TForm1.konwertuj(nazwa : string);

var plikwe,plikwy : textfile;

    dzial,ph,phout,men : string;

    artykul,tekst,t : string;
    dlr,bld,itl : byte;

    i : integer;

    ilepar,par : integer;

    lik, lip : boolean; {wypunktowanie}
    nrp : byte;     {przypisy}
    przy : boolean; {przypisy}
    hr85 : boolean;

begin

if (RadioGroupD.ItemIndex=-1) then begin showmessage('Wybierz dzia�...'); RadioGroupD.setfocus; exit; end;

 dzial:=dzia[RadioGroupD.ItemIndex]; {nazwa dzia�u}
 ph:=path[RadioGroupD.ItemIndex];    {katalog dzia�u}
 men:=dn+'menu\'+mplk[RadioGroupD.ItemIndex];

if CheckBoxD.Checked then phout:=dn+'artykuly\'+ph+'\' else phout:=sr;

dlr:=strtoint(editdlr.Text);    {d�ugo�� rozdzia�u}
bld:=strtoint(editbld.Text);    {ilo�� paragraf�w bold}
itl:=strtoint(edititl.Text);    {ilo�� paragraf�w italic}

lip:=false; lik:=false; przy:=false;

assignfile(plikwe,sr+nazwa+ewe);

{$I-}
reset(plikwe);
{$I+}

if ioresult<>0 then begin showmessage('B��d pliku <'+sr+nazwa+ewe+'>.'); edit1.setfocus; exit; end;

assignfile(plikwy,phout+nazwa+ewy); rewrite(plikwy);

{zliczanie wierszy w pliku}

if CheckBoxAutorzy.checked then
 begin
     if (RadioGroupA1F.ItemIndex=1) then readln(plikwe,tekst);
     if (RadioGroupA1IN.ItemIndex=1) then readln(plikwe,tekst);
     if (RadioGroupA1M.ItemIndex=1) then readln(plikwe,tekst);

     if (RadioGroupA2F.ItemIndex=1) then readln(plikwe,tekst);
     if (RadioGroupA2IN.ItemIndex=1) then readln(plikwe,tekst);
     if (RadioGroupA2M.ItemIndex=1) then readln(plikwe,tekst);
 end;

ilepar:=0;

while not eof(plikwe) do
 begin
  repeat
   readln(plikwe,tekst); {pusty wiersz}
   tekst:=txt(tekst);
  until (tekst<>'');

  if (length(tekst)>dlr) and not(tekst[1]='`') then ilepar:=ilepar+1;
 end;

closefile(plikwe);

reset(plikwe);
progressbar1.max:=ilepar;

{autorzy}

if CheckBoxAutorzy.checked then
     begin
     if (RadioGroupA1F.ItemIndex<>2) or (RadioGroupA1IN.ItemIndex<>2) or (RadioGroupA1M.ItemIndex<>2) or
        (RadioGroupA2F.ItemIndex<>2) or (RadioGroupA2IN.ItemIndex<>2) or (RadioGroupA2M.ItemIndex<>2) then
         begin writeln(plikwy,'<font class=autor>'); writeln(plikwy,''); end;

     if CheckBoxLogo.Checked then
          begin
          write(plikwy,img+ph+'/'+nazwa+'/rys0.gif'+img0);
          if (RadioGroupA1F.ItemIndex<>2) or (RadioGroupA1IN.ItemIndex<>2) or (RadioGroupA1M.ItemIndex<>2) then
               writeln(plikwy,br2);
          end;

     case RadioGroupA1F.ItemIndex of
     0 : begin
         write(plikwy,EditA1F.Text);
         if (RadioGroupA1IN.ItemIndex<>2) or (RadioGroupA1M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     1 : begin
         readln(plikwe,tekst); write(plikwy,tekst);
         if (RadioGroupA1IN.ItemIndex<>2) or (RadioGroupA1M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     end;

     case RadioGroupA1IN.ItemIndex of
     0 : begin
         write(plikwy,EditA1IN.Text);
         if (RadioGroupA1M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     1 : begin
         readln(plikwe,tekst); write(plikwy,tekst);
         if (RadioGroupA1M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     end;

     case RadioGroupA1M.ItemIndex of
     0 : begin
         write(plikwy,mail+EditA1M.Text+'">'+EditA1M.Text+maile);
         end;
     1 : begin
         readln(plikwe,tekst); write(plikwy,mail+tekst+'">'+tekst+maile);
         end;
     end;

     if (RadioGroupA2F.ItemIndex<>2) or (RadioGroupA2IN.ItemIndex<>2) or (RadioGroupA2M.ItemIndex<>2) then begin writeln(plikwy,br); writeln(plikwy,br); end;

     case RadioGroupA2F.ItemIndex of
     0 : begin
         write(plikwy,EditA2F.Text);
         if (RadioGroupA2IN.ItemIndex<>2) or (RadioGroupA2M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     1 : begin
         readln(plikwe,tekst); write(plikwy,tekst);
         if (RadioGroupA2IN.ItemIndex<>2) or (RadioGroupA2M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     end;

     case RadioGroupA2IN.ItemIndex of
     0 : begin
         write(plikwy,EditA2IN.Text);
         if (RadioGroupA2M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     1 : begin
         readln(plikwe,tekst); writeln(plikwy,tekst);
         if (RadioGroupA2M.ItemIndex<>2) then writeln(plikwy,br);
         end;
     end;

     case RadioGroupA2M.ItemIndex of
     0 : begin
         write(plikwy,mail+EditA2M.Text+'">'+EditA2M.Text+maile);
         end;
     1 : begin
         readln(plikwe,tekst); write(plikwy,mail+tekst+'">'+tekst+maile);
         end;
     end;
     if (RadioGroupA1F.ItemIndex<>2) or (RadioGroupA1IN.ItemIndex<>2) or (RadioGroupA1M.ItemIndex<>2) or
        (RadioGroupA2F.ItemIndex<>2) or (RadioGroupA2IN.ItemIndex<>2) or (RadioGroupA2M.ItemIndex<>2) then writeln(plikwy,en+'</font>'+en+en+br2+en);
     end; {if CheckBoxAutorzy.checked then}

{odczyt pustych wierszy przed tytu�em}

repeat
 readln(plikwe,tekst);
 tekst:=txt(tekst);
until (tekst<>'');

tekst:=txt(tekst); artykul:=tekst;
writeln(plikwy,'<font class=artykul>'+en+tekst+en+'</font>'+en+en+br);

par:=0; hr85:=false;

rys[1]:=CheckBoxR1.Checked; naz[1]:=CheckBoxR1N.Checked; zro[1]:=CheckBoxR1Z.Checked; ram[1]:=CheckBoxR1R.Checked; poa[1]:=strtoint(EditR1.Text);
rys[2]:=CheckBoxR2.Checked; naz[2]:=CheckBoxR2N.Checked; zro[2]:=CheckBoxR2Z.Checked; ram[2]:=CheckBoxR2R.Checked; poa[2]:=strtoint(EditR2.Text);
rys[3]:=CheckBoxR3.Checked; naz[3]:=CheckBoxR3N.Checked; zro[3]:=CheckBoxR3Z.Checked; ram[3]:=CheckBoxR3R.Checked; poa[3]:=strtoint(EditR3.Text);
rys[4]:=CheckBoxR4.Checked; naz[4]:=CheckBoxR4N.Checked; zro[4]:=CheckBoxR4Z.Checked; ram[4]:=CheckBoxR4R.Checked; poa[4]:=strtoint(EditR4.Text);
rys[5]:=CheckBoxR5.Checked; naz[5]:=CheckBoxR5N.Checked; zro[5]:=CheckBoxR5Z.Checked; ram[5]:=CheckBoxR5R.Checked; poa[5]:=strtoint(EditR5.Text);

while not(eof(plikwe)) do
begin

 repeat
  readln(plikwe,tekst); {pusty wiersz}
  tekst:=txt(tekst);
 until (tekst<>'');

 if (length(tekst)>dlr) and not(tekst[1]='`') then begin par:=par+1; ilepar:=ilepar-1; end;

 if (ilepar+1=itl) and not(hr85) then begin writeln(plikwy,en+kr85); hr85:=true; end;

 if ((tekst[1]='*') or (tekst[1]='-')) and not(lik) then begin if lip then write(plikwy,en); write(plikwy,en+'<ul class=koleczko>'); lik:=true; end;
 if ((tekst[1]<>'*') and (tekst[1]<>'-')) and lik then begin write(plikwy,en+'</ul>'+en); lik:=false; end;
 if (tekst[1] in ['0'..'9']) and (tekst[2]='.') and not(lip) then begin write(plikwy,en+'<ul class=punkty>'); lip:=true; end;
 if not(tekst[1] in ['0'..'9']) and not(tekst[2]='.') and not(lik) and lip then begin write(plikwy,en+'</ul>'+en); lip:=false; end;

 {przypisy w tekscie}

 if CheckBoxP1.checked then
  begin
  i:=0; t:='';
  repeat
   i:=i+1;
   if ((tekst[i-1]<>' ') and not(tekst[i-1] in ['0'..'9','$','`']) and (tekst[i] in ['0'..'9']) and (tekst [i+1]=' '))
   or ((tekst[i-1]<>' ') and not(tekst[i-1] in ['0'..'9','$','`']) and (tekst[i] in ['0'..'9']) and (tekst[i+1] in ['0'..'9']) and (tekst [i+2]=' ')) then
    begin
    t:=t+'<a name="';
    t:=t+tekst[i]; if (tekst[i+1] in ['0'..'9']) then begin t:=t+tekst[i+1]; end;
    t:=t+'pr"></a><sup>';
    t:=t+tekst[i]; if (tekst[i+1] in ['0'..'9']) then begin t:=t+tekst[i+1]; end;
    t:=t+'<a href="#pr';
    t:=t+tekst[i]; if (tekst[i+1] in ['0'..'9']) then begin t:=t+tekst[i+1]; i:=i+1; end;
    t:=t+'" class=przypis>>></a></sup></i>';
    end else t:=t+tekst[i];
  until (i>length(tekst)-1);
  tekst:=t;
  end;

 if CheckBoxP2.checked then
  begin
  if (tekst[1]='`') and not(przy) then begin nrp:=0; write(plikwy,en+'<table border=0><tr><td></td><td align=left><hr class=kreska width=15%></td></tr>'); przy:=true; end;
  if not(tekst[1]='`') and przy then begin write(plikwy,en+'</table>'); przy:=false; end;
  end;

 {zdj�cia}
 for i:=1 to 5 do
  if rys[i] and (par=poa[i]+1) then
   begin
   rys[i]:=false;
   if naz[i] then writeln(plikwy,en+'<P class=nazwa>Rys.</P>') else write(plikwy,en);
   write(plikwy,'<center>'+img+ph+'/'+nazwa+'/rys'+inttostr(i)+'.gif');
   if ram[i] then write(plikwy,img1) else write(plikwy,img0);
   writeln(plikwy,'</center>');
   if zro[i] then writeln(plikwy,'<P class=zrodlo>�r�d�o: opracowanie w�asne</P>');
   if (length(tekst)<dlr+1) then writeln(plikwy,br);
   end;

 if przy then begin nrp:=nrp+1; t:=inttostr(nrp); i:=1; repeat i:=i+1; until not(tekst[i] in ['0'..'9']); tekst:=copy(tekst, i+1, length(tekst)); write(plikwy,en+'<tr><td valign=top><font class=przypis><a name="pr'+t+'"></a><a href="#'+t+'pr" class=przypis><sup><<</a>'+t+'</sup></font></td><td><font class=przypis>'+en+tekst+en+'</font></td></tr>') end else
  if lip or lik then begin tekst:=copy(tekst, 3, length(tekst)); write(plikwy,en+'<li>'+tekst) end else
   if (length(tekst)<dlr+1) then writeln(plikwy,en+'<font class=rozdzial>'+tekst+'</font>') else
    if (bld>0) then begin write(plikwy,en+pg+en+tekst+en+pe+en); bld:=bld-1; end else
     if (ilepar+1<itl+1) then write(plikwy,en+pd+en+tekst+en+pe+en) else write(plikwy,en+ps+en+tekst+en+pe+en);

 progressbar1.position:=par;

 end; {while not(eof(plikwe)) do}

if przy then begin write(plikwy,en+'</table>'); przy:=false; end;
if CheckBoxR1.Checked then rys[1]:=true;

closefile(plikwy);
closefile(plikwe);

if CheckBoxM.Checked then
 begin
 assignfile(plikwe,men); reset(plikwe);
 assignfile(plikwy,men+'.tmp'); rewrite(plikwy);

 readln(plikwe,tekst); writeln(plikwy,tekst);
 readln(plikwe,tekst); writeln(plikwy,tekst);
 readln(plikwe,tekst); writeln(plikwy,tekst);
 writeln(plikwy,artykul); writeln(plikwy,nazwa+ewy);

 while not eof(plikwe) do begin readln(plikwe,tekst); write(plikwy,en); write(plikwy,tekst); end;

 closefile(plikwy);
 closefile(plikwe);

 deletefile(men);
 renamefile(men+'.tmp',men);
 end;

if CheckBoxM.Checked then
 showmessage('Pliki do przegrania:'+en+'<'+phout+nazwa+ewy+'>'+en+'<'+men+'>')
else
 showmessage('Plik do przegrania:'+en+'<'+phout+nazwa+ewy+'>');

progressbar1.position:=0;
edit1.setfocus;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
konwertuj(Edit1.Text);
end;

procedure TForm1.CheckBoxAutorzyClick(Sender: TObject);
begin
if CheckBoxAutorzy.Checked then
        begin
        RadioGroupA1F.ItemIndex:=2; RadioGroupA1IN.ItemIndex:=1; RadioGroupA1M.ItemIndex:=2;
        RadioGroupA2F.ItemIndex:=2; RadioGroupA2IN.ItemIndex:=2; RadioGroupA2M.ItemIndex:=2;

        RadioGroupA1F.Enabled:=true; RadioGroupA1IN.Enabled:=true; RadioGroupA1M.Enabled:=true;
        RadioGroupA2F.Enabled:=true; RadioGroupA2IN.Enabled:=true; RadioGroupA2M.Enabled:=true;

        EditA1F.Enabled:=false; EditA1IN.Enabled:=false; EditA1M.Enabled:=false;
        EditA2F.Enabled:=false; EditA2IN.Enabled:=false; EditA2M.Enabled:=false;
        end
else
        begin
        RadioGroupA1F.Enabled:=false; RadioGroupA1IN.Enabled:=false; RadioGroupA1M.Enabled:=false;
        RadioGroupA2F.Enabled:=false; RadioGroupA2IN.Enabled:=false; RadioGroupA2M.Enabled:=false;

        EditA1F.Enabled:=false; EditA1IN.Enabled:=false; EditA1M.Enabled:=false;
        EditA2F.Enabled:=false; EditA2IN.Enabled:=false; EditA2M.Enabled:=false;
        end;
end;

procedure TForm1.RadioGroupA1FClick(Sender: TObject);
begin
if (RadioGroupA1F.ItemIndex=0) then EditA1F.Enabled:=true else EditA1F.Enabled:=false;
end;

procedure TForm1.RadioGroupA1INClick(Sender: TObject);
begin
if (RadioGroupA1IN.ItemIndex=0) then EditA1IN.Enabled:=true else EditA1IN.Enabled:=false;
end;

procedure TForm1.RadioGroupA1MClick(Sender: TObject);
begin
if (RadioGroupA1M.ItemIndex=0) then EditA1M.Enabled:=true else EditA1M.Enabled:=false;
end;

procedure TForm1.RadioGroupA2FClick(Sender: TObject);
begin
if (RadioGroupA2F.ItemIndex=0) then EditA2F.Enabled:=true else EditA2F.Enabled:=false;
end;

procedure TForm1.RadioGroupA2INClick(Sender: TObject);
begin
if (RadioGroupA2IN.ItemIndex=0) then EditA2IN.Enabled:=true else EditA2IN.Enabled:=false;
end;

procedure TForm1.RadioGroupA2MClick(Sender: TObject);
begin
if (RadioGroupA2M.ItemIndex=0) then EditA2M.Enabled:=true else EditA2M.Enabled:=false;
end;

procedure TForm1.CheckBoxR1Click(Sender: TObject);
begin
if CheckBoxR1.Checked then
     begin
     rys[1]:=true;
     CheckBoxR1N.Enabled:=true;
     CheckBoxR1Z.Enabled:=true;
     CheckBoxR1R.Enabled:=true;
     EditR1.Enabled:=true;
     end
                      else
     begin
     CheckBoxR1N.Enabled:=false;
     CheckBoxR1Z.Enabled:=false;
     CheckBoxR1R.Enabled:=false;
     EditR1.Enabled:=false;
     end
end;

procedure TForm1.CheckBoxR2Click(Sender: TObject);
begin
if CheckBoxR2.Checked then
     begin
     rys[2]:=true;
     CheckBoxR2N.Enabled:=true;
     CheckBoxR2Z.Enabled:=true;
     CheckBoxR2R.Enabled:=true;
     EditR2.Enabled:=true;
     end
                      else
     begin
     CheckBoxR2N.Enabled:=false;
     CheckBoxR2Z.Enabled:=false;
     CheckBoxR2R.Enabled:=false;
     EditR2.Enabled:=false;
     end
end;

procedure TForm1.CheckBoxR3Click(Sender: TObject);
begin
if CheckBoxR2.Checked then
     begin
     rys[3]:=true;
     CheckBoxR3N.Enabled:=true;
     CheckBoxR3Z.Enabled:=true;
     CheckBoxR3R.Enabled:=true;
     EditR3.Enabled:=true;
     end
                      else
     begin
     CheckBoxR3N.Enabled:=false;
     CheckBoxR3Z.Enabled:=false;
     CheckBoxR3R.Enabled:=false;
     EditR3.Enabled:=false;
     end
end;

procedure TForm1.CheckBoxR4Click(Sender: TObject);
begin
if CheckBoxR2.Checked then
     begin
     rys[4]:=true;
     CheckBoxR4N.Enabled:=true;
     CheckBoxR4Z.Enabled:=true;
     CheckBoxR4R.Enabled:=true;
     EditR4.Enabled:=true;
     end
                      else
     begin
     CheckBoxR4N.Enabled:=false;
     CheckBoxR4Z.Enabled:=false;
     CheckBoxR4R.Enabled:=false;
     EditR4.Enabled:=false;
     end
end;

procedure TForm1.CheckBoxR5Click(Sender: TObject);
begin
if CheckBoxR2.Checked then
     begin
     rys[5]:=true;
     CheckBoxR5N.Enabled:=true;
     CheckBoxR5Z.Enabled:=true;
     CheckBoxR5R.Enabled:=true;
     EditR5.Enabled:=true;
     end
                      else
     begin
     CheckBoxR5N.Enabled:=false;
     CheckBoxR5Z.Enabled:=false;
     CheckBoxR5R.Enabled:=false;
     EditR5.Enabled:=false;
     end
end;

procedure TForm1.Start(Sender: TObject);
var plik : textfile;
    tekst : string;
    i : byte;

begin
assignfile(plik,'manager.txt'); reset(plik);
readln(plik,tekst); sr:=tekst;
readln(plik,tekst); dn:=tekst;
readln(plik,tekst);
i:=0;
while not eof(plik) do
 begin
 readln(plik,tekst); RadioGroupD.Items[i]:=tekst; dzia[i]:=tekst;
 readln(plik,tekst); path[i]:=tekst;
 readln(plik,tekst); mplk[i]:=tekst;
 readln(plik,tekst);
 i:=i+1;
 end;

closefile(plik);
end;

end.
