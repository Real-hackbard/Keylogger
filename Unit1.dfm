object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Keylogger'
  ClientHeight = 505
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 486
    Align = alLeft
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ExplicitHeight = 551
    object Bevel1: TBevel
      Left = 16
      Top = 80
      Width = 145
      Height = 2
    end
    object Bevel2: TBevel
      Left = 16
      Top = 205
      Width = 145
      Height = 2
    end
    object Label1: TLabel
      Left = 24
      Top = 224
      Width = 98
      Height = 15
      Caption = 'Wait Mouse Click..'
    end
    object Label2: TLabel
      Left = 24
      Top = 240
      Width = 34
      Height = 15
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 24
      Top = 256
      Width = 34
      Height = 15
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 24
      Top = 272
      Width = 34
      Height = 15
      Caption = 'Label4'
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 24
      Width = 81
      Height = 17
      Caption = 'Start Hook'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 47
      Width = 81
      Height = 17
      Caption = 'Stop Hook'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton2Click
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 99
      Width = 65
      Height = 17
      TabStop = False
      Caption = 'Stay Top'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 123
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Hide On Task'
      TabOrder = 3
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 146
      Width = 84
      Height = 17
      TabStop = False
      Caption = 'Save Report'
      TabOrder = 4
      OnClick = CheckBox3Click
    end
    object Button1: TButton
      Left = 16
      Top = 492
      Width = 75
      Height = 25
      Caption = 'hwnd'
      TabOrder = 5
      Visible = False
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 6
      Top = 300
      Width = 205
      Height = 61
      Caption = ' Priority '
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Low'
        'Normal'
        'High'
        'Real-Time')
      TabOrder = 6
      OnClick = RadioGroup1Click
    end
    object RadioGroup2: TRadioGroup
      Left = 10
      Top = 367
      Width = 201
      Height = 106
      Caption = ' Unicode '
      Columns = 2
      ItemIndex = 7
      Items.Strings = (
        'ASCii'
        'ANSi'
        'UTF-8'
        'UTF-7'
        'UTF-8 Boom'
        'UTF-16 BE'
        'UTF-16 LE'
        'Defautl')
      TabOrder = 7
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 169
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Show Handles'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBox4Click
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 0
    Width = 423
    Height = 486
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 419
    ExplicitHeight = 551
    object Memo1: TMemo
      Left = 1
      Top = 18
      Width = 421
      Height = 304
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitWidth = 417
      ExplicitHeight = 369
    end
    object ListBox1: TListBox
      Left = 1
      Top = 339
      Width = 421
      Height = 146
      Style = lbOwnerDrawVariable
      Align = alBottom
      ItemHeight = 15
      TabOrder = 1
      OnDrawItem = ListBox1DrawItem
    end
    object HeaderControl1: THeaderControl
      Left = 1
      Top = 322
      Width = 421
      Height = 17
      Align = alBottom
      Sections = <
        item
          ImageIndex = -1
          Text = 'Active Handles found :'
          Width = 150
        end>
      ExplicitTop = 387
      ExplicitWidth = 417
    end
    object HeaderControl2: THeaderControl
      Left = 1
      Top = 1
      Width = 421
      Height = 17
      BiDiMode = bdLeftToRight
      Sections = <
        item
          ImageIndex = -1
          Text = 'Hook Keyboard & Mouse Report :'
          Width = 200
        end>
      ParentBiDiMode = False
      ExplicitWidth = 417
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 486
    Width = 640
    Height = 19
    Panels = <
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Width = 350
      end
      item
        Text = 'X :'
        Width = 30
      end
      item
        Width = 50
      end
      item
        Text = 'Y :'
        Width = 30
      end
      item
        Width = 50
      end>
    ExplicitTop = 551
    ExplicitWidth = 636
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 241
    Top = 32
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 305
    Top = 32
  end
  object Timer3: TTimer
    Interval = 10
    OnTimer = Timer3Timer
    Left = 369
    Top = 32
  end
end
