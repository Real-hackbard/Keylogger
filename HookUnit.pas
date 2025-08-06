unit HookUnit;

interface

{$SCOPEDENUMS ON}

uses
  Windows, Messages, SysUtils;

type
  TGlobalKeyboardHook = class
  public
    type
      TKBDLLHookStruct = packed record
        vkCode: DWORD;
        scanCode: DWORD;
        flags: DWORD;
        time: DWORD;
        dwExtraInfo: ULONG_PTR;
      end;
      PKBDLLHookStruct = ^TKBDLLHookStruct;

      TKeyAction = (KeyDown, KeyUp, SysKeyDown, SysKeyUp);
  private
    class var
      FInstance: TGlobalKeyboardHook;
    type
      TOnKeyEvent = procedure(const AKeyAction: TGlobalKeyboardHook.TKeyAction; const AKeyCode: DWORD;
        const AWasInjected: Boolean; const AKey: Char) of object;
    const
      LLKHF_EXTENDED = $00000001;
      LLKHF_INJECTED = $00001000;
      LLKHF_ALTDOWN = $00010000;
      LLKHF_UP = $01000000;
    var
      FActive: Boolean;
      FHook: THandle;
      FOnKeyEvent: TOnKeyEvent;
      FShiftKeyPressed: Boolean;
    class function GetInstance: TGlobalKeyboardHook; static;
    function HookKeyboard: Boolean;
    function UnhookKeyboard: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetOnKeyEvent(const Value: TOnKeyEvent);
    procedure DoKeyboardEvent(const nCode, AMessage: LongInt; const AData: TGlobalKeyboardHook.PKBDLLHookStruct);
  public
    destructor Destroy;
    class destructor Destroy;
    class property Instance: TGlobalKeyboardHook read GetInstance;
    property Active: Boolean read FActive write SetActive;
    property OnKeyEvent: TOnKeyEvent read FOnKeyEvent write SetOnKeyEvent;
  end;

implementation

function KeyboardHookProc(const nCode, AMessage: LongInt; const AData: TGlobalKeyboardHook.PKBDLLHookStruct): Integer; stdcall;
begin
  Result := CallNextHookEx(TGlobalKeyboardHook.Instance.FHook, nCode, AMessage, NativeInt(AData));
  if nCode = HC_ACTION then
    TGlobalKeyboardHook.Instance.DoKeyboardEvent(nCode, AMessage, AData);
end;

{ TGlobalKeyboardHook }

class destructor TGlobalKeyboardHook.Destroy;
begin
  if Assigned(FInstance) then
    FreeAndNil(FInstance);
end;

procedure TGlobalKeyboardHook.DoKeyboardEvent(const nCode, AMessage: Integer; const AData: TGlobalKeyboardHook.PKBDLLHookStruct);
var
  CurrentChar: Char;
  KeyAction: TGlobalKeyboardHook.TKeyAction;
  KeyboardState: TKeyboardState;
begin
  if Assigned(FOnKeyEvent) then
  begin
    case AMessage of
      WM_KEYDOWN:
        begin
          KeyAction := TGlobalKeyboardHook.TKeyAction.KeyDown;
          if AData.vkCode in [VK_SHIFT, VK_LSHIFT, VK_RSHIFT] then
            FShiftKeyPressed := True;
        end;
      WM_KEYUP:
        begin
          KeyAction := TGlobalKeyboardHook.TKeyAction.KeyUp;
          if AData.vkCode in [VK_SHIFT, VK_LSHIFT, VK_RSHIFT] then
            FShiftKeyPressed := False;
        end;
      WM_SYSKEYDOWN:
        KeyAction := TGlobalKeyboardHook.TKeyAction.SysKeyDown;
      WM_SYSKEYUP:
        KeyAction := TGlobalKeyboardHook.TKeyAction.SysKeyUp;
    end;

    if AData.vkCode >= VK_SPACE then
    begin
      CurrentChar := Char(MapVirtualKey(AData.vkCode, MAPVK_VK_TO_CHAR));
      if FShiftKeyPressed then
        CurrentChar := CharUpper(@CurrentChar)^
      else
        CurrentChar := CharLower(@CurrentChar)^;
    end
    else
      CurrentChar := #0;

    FOnKeyEvent(KeyAction, AData.vkCode, LLKHF_INJECTED and AData.flags > 0, CurrentChar);
  end;
end;

destructor TGlobalKeyboardHook.Destroy;
begin
  Active := False;
end;

class function TGlobalKeyboardHook.GetInstance: TGlobalKeyboardHook;
begin
  if not Assigned(FInstance) then
    FInstance := TGlobalKeyboardHook.Create;
  Result := FInstance;
end;

procedure TGlobalKeyboardHook.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    if Value then
      HookKeyboard
    else
      UnhookKeyboard;
    FActive := Value;
  end;
end;

procedure TGlobalKeyboardHook.SetOnKeyEvent(const Value: TOnKeyEvent);
begin
  FOnKeyEvent := Value;
end;

function TGlobalKeyboardHook.HookKeyboard: Boolean;
begin
  if FHook = 0 then
  begin
    FHook := SetWindowsHookEx(WH_KEYBOARD_LL, @KeyboardHookProc, HInstance, 0);
    Result := FHook <> 0;
  end
  else
    Result := True;
end;

function TGlobalKeyboardHook.UnhookKeyboard: Boolean;
begin
  if FHook <> 0 then
  begin
    Result := UnhookWindowsHookEx(FHook);
    FHook := 0;
  end
  else
    Result := True;
end;

end.
