page 50910 "Objects List"
{
    
    ApplicationArea = All;
    Caption = 'Objects List';
    PageType = List;
    SourceTable = Object;
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("BLOB Reference"; Rec."BLOB Reference")
                {
                    ApplicationArea = All;
                }
                field("BLOB Size"; Rec."BLOB Size")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("DBM Table No."; Rec."DBM Table No.")
                {
                    ApplicationArea = All;
                }
                field("Locked By"; Rec."Locked By")
                {
                    ApplicationArea = All;
                }
                field("Version List"; Rec."Version List")
                {
                    ApplicationArea = All;
                }
                field(Caption; Rec.Caption)
                {
                    ApplicationArea = All;
                }
                field(Compiled; Rec.Compiled)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Locked; Rec.Locked)
                {
                    ApplicationArea = All;
                }
                field(Modified; Rec.Modified)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
}
