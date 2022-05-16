Unit EditCategory;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

Type
    TFormEditCategory = class(TForm)
        PanelEditCategory: TPanel;
        EditCategoryOldName: TEdit;
        EditCategoryNewName: TEdit;
        LabelOldName: TLabel;
        LabelNewName: TLabel;
        ButtonAdd: TSpeedButton;
        ButtonExit: TSpeedButton;
        EditCategoryID: TEdit;
        LabelNewNameWarning: TLabel;

    Procedure ButtonAddClick(Sender: TObject);
    Procedure EditCategoryNewNameChange(Sender: TObject);
    Procedure ButtonExitClick(Sender: TObject);
    Procedure FormShow(Sender: TObject);

    Private
    
    Public
        { Public declarations }
    End;

Var
    FormEditCategory: TFormEditCategory;

Implementation
    {$R *.dfm}

Uses Category, Main, UnitProcedure;

Var
    RowFocusIndex: Integer;



Procedure TFormEditCategory.FormShow(Sender: TObject);
Begin
    RowFocusIndex := FormCategory.StringGridCategory.Row;
    EditCategoryNewName.Clear;
    EditCategoryID.Visible := False;
    LabelNewNameWarning.Visible := False;
    LabelNewNameWarning.StyleElements := LabelNewNameWarning.StyleElements - [seFont];
    LabelNewNameWarning.Font.Color := clRed;
    LabelNewNameWarning.Font.Style := LabelNewNameWarning.Font.Style + [fsBold];
End;


Function FindLineInCategoryList(InputLine: String): Boolean;
Var
    IsIncorrect: Boolean;
    I: Integer;
Begin
    IsIncorrect := False;
    PointerCategory := HeadCategory^.Next;
    InputLine := MakeLettersInCategoryFormat(InputLine);
    While (PointerCategory <> nil) and (Not IsIncorrect) do
    Begin
        If InputLine = PointerCategory^.Name then
            IsIncorrect := True
        Else
            PointerCategory := PointerCategory^.Next;
    End;

    FindLineInCategoryList := IsIncorrect;
End;


Procedure ChangeElementInCategoryList(ID: Integer; InputLine: String);
Var
    IsIncorrect: Boolean;
    I: Integer;
Begin
    IsIncorrect := False;
    PointerCategory := HeadCategory^.Next;
    While (PointerCategory <> nil) and (Not IsIncorrect) do
    Begin
        If ID = PointerCategory^.ID then
        Begin
            IsIncorrect := True;
            PointerCategory^.Name := InputLine;
        End
        Else
            PointerCategory := PointerCategory^.Next;
    End;
End;


Procedure TFormEditCategory.ButtonAddClick(Sender: TObject);
Var    
    InputLine: String;
Begin
    InputLine := MakeLettersInCategoryFormat(EditCategoryNewName.Text);
    ChangeElementInCategoryList(StrToInt(EditCategoryID.Text), InputLine);
    FormCategory.StringGridCategory.Cells[1, RowFocusIndex] := InputLine;
    If FormMain.StringGridLastAccountAction.Cells[2, 1] = EditCategoryOldName.Text then
        FormMain.StringGridLastAccountAction.Cells[2, 1] := InputLine;
    ChangeCategoryOfListJournal(EditCategoryOldName.Text, InputLine);
    ChangeCategoryStringGridJournal(FormMain.StringGridJournal, EditCategoryOldName.Text, InputLine);
    ResetTabReportsObjects();
    EditCategoryNewName.Clear;
    DataHasChanged := True;
    Close();
End;


Procedure TFormEditCategory.EditCategoryNewNameChange(Sender: TObject);
Begin
    If EditCategoryNewName.Text = '' then
    Begin
        ButtonAdd.Enabled := False;
        LabelNewNameWarning.Visible := False;
    End
    Else If FindLineInCategoryList(EditCategoryNewName.Text) then
    Begin
        ButtonAdd.Enabled := False;
        LabelNewNameWarning.Visible := True;
    End
    Else
    Begin
        ButtonAdd.Enabled := True;
        LabelNewNameWarning.Visible := False;
    End;
End;


Procedure TFormEditCategory.ButtonExitClick(Sender: TObject);
Begin
    Close();
End;

End.
