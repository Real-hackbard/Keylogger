object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Keylogger'
  ClientHeight = 608
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 589
    Align = alLeft
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ExplicitHeight = 588
    object Bevel1: TBevel
      Left = 16
      Top = 120
      Width = 145
      Height = 2
    end
    object Bevel2: TBevel
      Left = 16
      Top = 322
      Width = 145
      Height = 2
    end
    object Label1: TLabel
      Left = 24
      Top = 341
      Width = 98
      Height = 15
      Caption = 'Wait Mouse Click..'
    end
    object Label2: TLabel
      Left = 24
      Top = 357
      Width = 34
      Height = 15
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 24
      Top = 373
      Width = 34
      Height = 15
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 24
      Top = 389
      Width = 34
      Height = 15
      Caption = 'Label4'
    end
    object Label5: TLabel
      Left = 32
      Top = 235
      Width = 72
      Height = 15
      Caption = 'Save Interval :'
    end
    object Label6: TLabel
      Left = 177
      Top = 235
      Width = 24
      Height = 15
      Caption = '(ms)'
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
      Top = 139
      Width = 65
      Height = 17
      TabStop = False
      Caption = 'Stay Top'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 163
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Hide On Task'
      TabOrder = 3
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 186
      Width = 138
      Height = 17
      TabStop = False
      Caption = 'Save Keyboard Report'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox3Click
    end
    object Button1: TButton
      Left = 16
      Top = 602
      Width = 75
      Height = 25
      Caption = 'hwnd'
      TabOrder = 5
      Visible = False
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 6
      Top = 417
      Width = 195
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
      Left = 11
      Top = 484
      Width = 190
      Height = 93
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
        'Default')
      TabOrder = 7
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 270
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Show Handles'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBox4Click
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 293
      Width = 106
      Height = 17
      TabStop = False
      Caption = 'Show Clipboard'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBox5Click
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 88
      Width = 107
      Height = 17
      Caption = 'Clipboard Hook'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBox6Click
    end
    object CheckBox7: TCheckBox
      Left = 16
      Top = 209
      Width = 103
      Height = 17
      TabStop = False
      Caption = 'Save Clipboard'
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBox7Click
    end
    object SpinEdit1: TSpinEdit
      Left = 110
      Top = 232
      Width = 61
      Height = 24
      TabStop = False
      MaxLength = 5
      MaxValue = 10000
      MinValue = 1
      TabOrder = 12
      Value = 1000
      OnChange = SpinEdit1Change
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 0
    Width = 472
    Height = 589
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 468
    ExplicitHeight = 588
    object Splitter1: TSplitter
      Left = 0
      Top = 239
      Width = 472
      Height = 5
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter2: TSplitter
      Left = 0
      Top = 421
      Width = 472
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 469
    end
    object Memo1: TMemo
      Left = 0
      Top = 17
      Width = 472
      Height = 222
      Align = alTop
      BorderStyle = bsNone
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitWidth = 468
    end
    object HeaderControl2: THeaderControl
      Left = 0
      Top = 0
      Width = 472
      Height = 17
      BiDiMode = bdLeftToRight
      Sections = <
        item
          ImageIndex = -1
          Text = 'Hook Keyboard & Mouse Report :'
          Width = 200
        end>
      ParentBiDiMode = False
      ExplicitWidth = 468
    end
    object Panel3: TPanel
      Left = 0
      Top = 426
      Width = 472
      Height = 163
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 425
      ExplicitWidth = 468
      object ListBox1: TListBox
        Left = 0
        Top = 17
        Width = 472
        Height = 146
        Style = lbOwnerDrawVariable
        Align = alClient
        BorderStyle = bsNone
        ItemHeight = 15
        TabOrder = 0
        OnDrawItem = ListBox1DrawItem
        ExplicitWidth = 468
      end
      object HeaderControl1: THeaderControl
        Left = 0
        Top = 0
        Width = 472
        Height = 17
        Sections = <
          item
            ImageIndex = -1
            Text = 'Active Handles found :'
            Width = 150
          end>
        ExplicitWidth = 468
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 244
      Width = 472
      Height = 177
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitWidth = 468
      ExplicitHeight = 176
      object HeaderControl3: THeaderControl
        Left = 0
        Top = 0
        Width = 472
        Height = 17
        Sections = <
          item
            ImageIndex = -1
            Text = 'Clipboard :'
            Width = 100
          end>
        ExplicitWidth = 468
      end
      object Memo2: TMemo
        Left = 0
        Top = 17
        Width = 472
        Height = 160
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        ScrollBars = ssBoth
        TabOrder = 1
        ExplicitWidth = 468
        ExplicitHeight = 159
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 589
    Width = 689
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
    ExplicitTop = 588
    ExplicitWidth = 685
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
  object Timer4: TTimer
    Enabled = False
    OnTimer = Timer4Timer
    Left = 433
    Top = 32
  end
end
