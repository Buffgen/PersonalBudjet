Unit CreateCategory;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Buttons,
  Vcl.ExtCtrls;

Type
    TFormCreateCategory = class(TForm)
    LabelCategoryName: TLabel;
    EditCategoryName: TEdit;
    LabelWarningName: TLabel;
    ButtonExit: TSpeedButton;
    ButtonAdd: TSpeedButton;
    PanelCreateCategory: TPanel;
    procedure FormShow(Sender: TObject);
    procedure EditCategoryNameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    Private
        Procedure AddNewCategoryElement();
  //      Procedure AddNewAccountStringGrid();

    Public
        { Public declarations }
    End;

Var
    FormCreateCategory: TFormCreateCategory;

Implementation
    {$R *.dfm}

Uses
    Main, Category, UnitProcedure;



Procedure TFormCreateCategory.FormShow(Sender: TObject);
Begin
    LabelCategoryName.StyleElements := LabelCategoryName.StyleElements - [seFont];
    LabelCategoryName.Font.Color := clTeal;
    LabelWarningName.StyleElements := LabelWarningName.StyleElements - [seFont];
    LabelWarningName.Font.Color := clRed;
    EditCategoryName.Clear;
    ButtonAdd.Enabled := False;
End;


Procedure TFormCreateCategory.AddNewCategoryElement();
Begin
    DataHasChanged := True;
    Inc(MaxCategoryID);
    PointerCategory := TailCategory;
    New(PointerCategory^.Next);
    PointerCategory := PointerCategory^.Next;
    PointerCategory^.Next := Nil;
    PointerCategory^.ID := MaxCategoryID;
    PointerCategory^.Name := AnsiLowerCase(EditCategoryName.Text);
    PointerCategory^.Name := StringReplace(PointerCategory^.Name, PointerCategory^.Name[1], AnsiUpperCase(PointerCategory^.Name[1]), []);
    TailCategory := PointerCategory;
    HeadCategory^.ID := HeadCategory^.ID + 1;
End;


Function FindLineInCategoryList(InputLine: String): Boolean;
Var
    IsIncorrect: Boolean;
Begin
    IsIncorrect := False;
    PointerCategory := HeadCategory^.Next;
    InputLine := AnsiLowerCase(InputLine);
    InputLine := StringReplace(InputLine, InputLine[1], AnsiUpperCase(InputLine[1]), []);
    While (PointerCategory <> nil) and (Not IsIncorrect) do
    Begin
        If InputLine = PointerCategory^.Name then
            IsIncorrect := True
        Else
            PointerCategory := PointerCategory^.Next;
    End;

    FindLineInCategoryList := IsIncorrect;
End;


Procedure TFormCreateCategory.EditCategoryNameChange(Sender: TObject);
Begin
    If EditCategoryName.Text = '' then
    Begin
        ButtonAdd.Enabled := False;
        LabelWarningName.Visible := False;
    End
    Else If FindLineInCategoryList(EditCategoryName.Text) then
    Begin
        ButtonAdd.Enabled := False;
        LabelWarningName.Visible := True;
    End
    Else
    Begin
        ButtonAdd.Enabled := True;
        LabelWarningName.Visible := False;
    End;
End;


procedure TFormCreateCategory.ButtonAddClick(Sender: TObject);
Begin
    AddNewCategoryElement();
    FillCategory(FormCategory.StringGridCategory);
    EditCategoryName.Clear;
    ResetTabReportsObjects();
End;


Procedure TFormCreateCategory.ButtonExitClick(Sender: TObject);
Begin
    Close();
End;


Procedure TFormCreateCategory.FormClose(Sender: TObject; var Action: TCloseAction);
Begin
    EditCategoryName.Clear;
End;



End.
