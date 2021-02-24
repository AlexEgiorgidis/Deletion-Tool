codeunit 50900 "Read Table Data"
{
    // version DataDel1.0

    trigger OnRun()
    begin
    end;

    var
        ObjDel: Record "Objects for Deletion";
        objectRec: Record AllObjWithCaption;
        Objs: record AllObjWithCaption;
        TblInfo: Record "Table Information";
        Test1: RecordID;
        CopyFromTbl: RecordRef;
        CopyToTbl: RecordRef;
        Temp: RecordRef;
        CopyFromFields: FieldRef;
        CopyToFields: FieldRef;
        Window: Dialog;
        TimePop: Time;
        i: Integer;

    procedure PopulateObjects()
    begin
        TimePop := Time;

        ObjDel.reset;
        if ObjDel.FindFirst() then
            if not confirm('Do you want to re-populate the list?', true) then
                Error('');
        ObjDel.DeleteAll(true);

        objectRec.Reset;
        objectRec.SetRange("Object Type", objectRec."Object Type"::Table);
        if objectRec.Findset(true, true) then
            repeat
                if ObjDel.Get(objectRec."Object Id") then begin
                    ObjDel.Name := objectRec."Object Name";
                    if TblInfo.Get(CompanyName, objectRec."Object Id") then begin
                        if (TblInfo."No. of Records" <> 0) and (ObjDel."No Of Records" = 0) then begin
                            ObjDel."Date Populated" := Today;
                            ObjDel."Time Populated" := TimePop;
                        end;
                        ObjDel."No Of Records" := TblInfo."No. of Records"
                    end else
                        ObjDel."No Of Records" := 0;

                    ObjDel.Modify;
                end else begin
                    ObjDel.Init;
                    ObjDel."Object ID" := objectRec."Object Id";
                    ObjDel.Name := objectRec."Object Name";
                    if TblInfo.Get(CompanyName, objectRec."Object Id") then
                        ObjDel."No Of Records" := TblInfo."No. of Records"
                    else
                        ObjDel."No Of Records" := 0;
                    ObjDel."Date Populated" := Today;
                    ObjDel."Time Populated" := TimePop;
                    if ObjDel."No Of Records" <> 0 then
                        ObjDel.Insert;
                end;

            until objectRec.Next = 0;
        Message('list updated.');
    end;

    procedure DeleteRecs()
    begin
        ObjDel.Reset;
        ObjDel.SetRange(Delete, true);
        if not Confirm('Are you sure you want to delete all records from ' + Format(ObjDel.Count) + ' tables !') then
            exit;
        if ObjDel.FindSet(true, true) then
            repeat
                Temp.Open(ObjDel."Object ID");
                Temp.DeleteAll;
                Temp.Close;
            until ObjDel.Next = 0;
        message('Completed.');
    end;

    procedure CopyRecs()
    begin
        ObjDel.Reset;
        ObjDel.SetRange("Copy Setup", true);
        if not Confirm('Are you sure you want to copy all records from ' + Format(ObjDel.Count) + ' tables !') then
            exit;

        CopyToTbl.Open(ObjDel."Object ID");

        Window.Open('Processing #1#############');
        if ObjDel.FindSet(true, true) then
            repeat
                CopyFromTbl.Open(ObjDel."Object ID", false, 'Test Company');
                if CopyFromTbl.Find('-') then
                    repeat
                        Window.Update(1, CopyFromTbl.RecordId);
                        for i := 1 to CopyFromTbl.FieldCount do begin

                            //CopyFromField.field(i) :=  CopyFromTbl.FIELD(i);

                            CopyToTbl := CopyFromTbl;
                        end;
                        CopyToTbl.Insert;

                    until CopyFromTbl.Next = 0;
            until ObjDel.Next = 0;

        Window.Close;
    end;
}

