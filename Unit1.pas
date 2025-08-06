unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Shell.ShellCtrls, Vcl.StdCtrls, HookUnit, Vcl.ExtCtrls, Winapi.PsAPI;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ListBox1: TListBox;
    Timer1: TTimer;
    Button1: TButton;
    HeaderControl1: THeaderControl;
    HeaderControl2: THeaderControl;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Timer2: TTimer;
    Timer3: TTimer;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private-Deklarationen }
    flbHorzScrollWidth: Integer;
    procedure KeyHookEvent(const AKeyAction: TGlobalKeyboardHook.TKeyAction; const AKeyCode: DWORD; const AWasInjected: Boolean;
      const AKey: Char);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  FHookHandle: HHOOK;

implementation

{$R *.dfm}
function MyMouseClick(AwParam: wParam): string;
begin
  case AwParam of
    WM_MOUSEMOVE:
      result := '(Mouse Moving action)';
    WM_LBUTTONDOWN:
      result := '(Left Button Down)';
    WM_LBUTTONUP:
      result := '(Left Button Up)';
    WM_LBUTTONDBLCLK:
      result := '(Left Button Double-click)';
    WM_RBUTTONDOWN:
      result := '(Right Button Down)';
    WM_RBUTTONUP:
      result := '(Right Button Up)';
    WM_RBUTTONDBLCLK:
      result := '(Right Button Double-click)';
    WM_MBUTTONDOWN:
      result := '(Middle Button Down)';
    WM_MBUTTONUP:
      result := '(Middle Button Up)';
    WM_MBUTTONDBLCLK:
      result := '(Middle Button Double-click)';
    WM_MOUSEWHEEL:
      result := '(Mouse Wheel action)';
  else
    result := 'Others...';
  end;
end;


function MouseHookProc(nCode: integer; wParam: wParam; lParam: lParam): LRESULT; stdcall;
begin
  Form1.Label2.Caption := 'Time: ' + TimeToStr(Now);
  Form1.Label3.Caption := 'HC_ACTION = ' + HC_ACTION.ToString;
  Form1.Label4.Caption := 'nCode = ' + nCode.ToString;
  Form1.StatusBar1.Panels[1].Text := 'wParam = ' + wParam.ToString + ' ' + MyMouseClick(wParam);
  //
  if (HC_ACTION = 0) then
    begin
      case wParam of
        WM_LBUTTONDOWN:
          begin
          Form1.Label1.Caption := 'Mouse Left Clicked';
            if Form1.RadioButton1.Checked = true then begin
            Form1.Button1.Click;
            end;
          end;
        WM_RBUTTONDOWN:
          begin
          Form1.Label1.Caption := 'Mouse Right Clicked';
          end;
      end;
    end;
  result := CallNextHookEx(FHookHandle, nCode, wParam, lParam); // next process...
end;

function EnumWindowsProc(wHandle: HWND; lb: TListBox): Bool; stdcall; export;
var
  Title, ClassName: array[0..255] of char;
begin
  Result := True;
  GetWindowText(wHandle, Title, 255);
  GetClassName(wHandle, ClassName, 255);
  if IsWindowVisible(wHandle) then
     lb.Items.Add(string(Title) + '-' + string(ClassName));
end;


function GetText(wnd:Thandle):string;
 var
  caption:PChar;
  length:integer;
begin
 length:=SendMessage(wnd,WM_GETTEXTLENGTH,0,0);
 if length <> 0 then
  begin
   GetMem(caption, length+1);
   SendMessage(wnd,WM_GETTEXT,length+1,Integer(caption));
   result:=caption;
   FreeMem(caption);
  end;
end;

function ActiveCaption: string;
var
  Handle: THandle;
  Len: LongInt;
  Title: string;
begin
  Result := '';
  Handle := GetForegroundWindow;
  if Handle <> 0 then
  begin
    Len := GetWindowTextLength(Handle) + 1;
    SetLength(Title, Len);
    GetWindowText(Handle, PChar(Title), Len);
    ActiveCaption := TrimRight(Title);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  cPos: TPoint;
  hWnd:THandle;
  WinClass : array[0..80] of Char;
begin
  GetCursorPos(cPos);
  hWnd := WindowFromPoint(cPos);
  GetClassName(hWnd,WinClass,SizeOf(WinClass));
  Memo1.Lines.Add('');
  Memo1.Lines.Add(WinClass);
  Memo1.Lines.Add('==============================');
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then begin
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
  SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then begin
  ShowWindow( Application.Handle, SW_HIDE );
  end else begin
  ShowWindow( Application.Handle, SW_SHOW );
  end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then begin
  RadioGroup2.Enabled := true;
  Timer2.Enabled := true;
  end else begin
  RadioGroup2.Enabled := false;
  Timer2.Enabled := false;
  end;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then begin
  ListBox1.Visible := true;
  HeaderControl1.Visible := true;


  end else begin
  HeaderControl1.Visible := false;
  ListBox1.Visible := false;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TGlobalKeyboardHook.Instance.OnKeyEvent := KeyHookEvent;
  TGlobalKeyboardHook.Instance.Active := True;
  Memo1.Lines.Add(ActiveCaption);
  Listbox1.Perform(LB_SetHorizontalExtent, 1000, Longint(0));
  FHookHandle := SetWindowsHookEx(WH_MOUSE_LL, @MouseHookProc, HInstance, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnhookWindowsHookEx(FHookHandle);
end;

procedure TForm1.KeyHookEvent(const AKeyAction: TGlobalKeyboardHook.TKeyAction; const AKeyCode: DWORD;
  const AWasInjected: Boolean; const AKey: Char);
begin
  if (AKeyAction = TGlobalKeyboardHook.TKeyAction.KeyDown) and (AKey <> #0) then
    Memo1.Text := Memo1.Text + AKey;
    with Memo1 do
    begin
      SelStart := GetTextLen;
      SelLength := 1;
  end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len: Integer;
 NewText: String;
begin
  NewText:=Listbox1.Items[Index];

  with Listbox1.Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len:=TextWidth(NewText) + Rect.Left + 10;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth:=Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  Timer1.Enabled := true;
  Timer2.Enabled := true;
  TGlobalKeyboardHook.Instance.Active := True;
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  Timer2.Enabled := false;
  TGlobalKeyboardHook.Instance.Active := false;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
const Priority : array[0..3] of integer = (IDLE_PRIORITY_CLASS, NORMAL_PRIORITY_CLASS, HIGH_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS);
      PLevels  : array[0..3] of byte    = (4, 8, 13, 24);
begin
  SetPriorityClass(GetCurrentProcess, Priority[(Sender as TRadioGroup).Tag]);
  if RadioGroup1.ItemIndex = 0 then begin RadioGroup1.Tag := 0; end;
  if RadioGroup1.ItemIndex = 1 then begin RadioGroup1.Tag := 1; end;
  if RadioGroup1.ItemIndex = 2 then begin RadioGroup1.Tag := 2; end;
  if RadioGroup1.ItemIndex = 3 then begin RadioGroup1.Tag := 3; end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ListBox1.Clear;
  EnumWindows(@EnumWindowsProc, Integer(Listbox1));

  with Memo1 do
    begin
      SelStart := GetTextLen;
      SelLength := 1;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
const
  UTF8BOM: array[0..2] of Byte = ($EF, $BB, $BF);

var
  report : String;
  myEncoding : TEncoding;

  UTF8Str: UTF8String;
  FS: TFileStream;

  BOM: WideChar;
  WS: WideString;
  I: Integer;
begin
  if CheckBox3.Checked = true then begin
  report := Memo1.Text;
  myEncoding := TEncoding.Default;

  case RadioGroup2.ItemIndex of

  0 : begin
      myEncoding := TEncoding.ASCII;
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt',myEncoding);
      end;
  1 : begin
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt');
      end;
  2 : begin
      myEncoding := TEncoding.ASCII;
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt',myEncoding);
      end;
  3 : begin
      myEncoding := TEncoding.UTF7;
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt',myEncoding);
      end;
  4 : begin
      UTF8Str := UTF8Encode(Memo1.Text);
      FS := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Report\report.txt', fmCreate);
        try
          FS.WriteBuffer(UTF8BOM[0], SizeOf(UTF8BOM));
          FS.WriteBuffer(PAnsiChar(UTF8Str)^, Length(UTF8Str));
        finally
          FS.Free;
        end;
      end;
  5 : begin
      myEncoding := TEncoding.BigEndianUnicode;
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt',myEncoding);
      end;

  6 : begin
      FS := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Report\report.txt', fmCreate);
        try
          BOM := WideChar($FEFF);
          FS.WriteBuffer(BOM, SizeOf(BOM));
          For I := 0 to Memo1.Lines.Count-1 do
            begin
              WS := WideString(Memo1.Lines[I] + sLineBreak);
              FS.WriteBuffer(PWideChar(WS)^, Length(WS) * SizeOf(WideChar));
            end;
        finally
          FS.Free;
        end;
      end;
  7: begin
      myEncoding := TEncoding.Default;
      Memo1.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'Report\report.txt',myEncoding);
      end;
  end;

  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  StatusBar1.Panels[3].Text := IntToStr(Mouse.CursorPos.X);
  StatusBar1.Panels[5].Text := IntToStr(Mouse.CursorPos.Y);
end;

end.
