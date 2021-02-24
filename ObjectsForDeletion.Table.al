table 50900 "Objects for Deletion"
{
    // version DataDel1.0

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Object ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No Of Records"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; Delete; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Date Populated"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Time Populated"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Copy Setup"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; Comment; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Object ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

