page 50901 "Company Data Deletion Tool"
{
    // version DataDel1.0

    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = "Objects for Deletion";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ObjectID; "Object ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(NoOfRecords; "No Of Records")
                {
                    ApplicationArea = All;
                }
                field(Delete; Delete)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field(DatePopulated; "Date Populated")
                {
                    ApplicationArea = All;
                }
                field(TimePopulated; "Time Populated")
                {
                    ApplicationArea = All;
                }
                field(CopySetup; "Copy Setup")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Populate Tables")
            {
                ApplicationArea = All;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Clear(ReadObject);
                    ReadObject.PopulateObjects;
                    CurrPage.Update;
                end;
            }
            action("Delete Records")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Clear(ReadObject);
                    ReadObject.DeleteRecs;
                    CurrPage.Update;
                end;
            }
            action("Copy Data")
            {
                ApplicationArea = All;
                Image = CopyFromTask;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Clear(ReadObject);
                    ReadObject.CopyRecs;
                    CurrPage.Update;
                end;
            }
            action("Reset No. Series ")
            {
                ApplicationArea = All;
                Caption = 'Reset No. Series';
                Image = Restore;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to RESET the field Last No Used to BLANK ON ALL No. Series Codes??') then
                        exit;
                    NoSeriesLine.ModifyAll("Last No. Used", '');
                end;
            }
            action("Clear Values")
            {
                ApplicationArea = All;
                Caption = 'Clear Values';
                Image = ClearLog;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Please confirm you would like to reset Transaction No, Customer Last Statment & Bank Account statement fields to balnk/zero??') then
                        exit;

                    GeneralLedgerSetup.Get;
                    GeneralLedgerSetup."Last IC Transaction No." := 0;
                    GeneralLedgerSetup.Modify;

                    if BankAccount.FindSet then
                        repeat
                            BankAccount."Last Statement No." := '';
                            BankAccount."Balance Last Statement" := 0;
                            BankAccount.Modify;

                        until BankAccount.Next = 0;

                    if Customer.FindSet then
                        repeat
                            Customer."Last Statement No." := 0;
                            Customer.Modify;
                        until Customer.Next = 0;
                end;
            }
        }
    }

    var
        Customer: Record Customer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        BankAccount: Record "Bank Account";
        NoSeriesLine: Record "No. Series Line";
        ReadObject: Codeunit "Read Table Data";
}

