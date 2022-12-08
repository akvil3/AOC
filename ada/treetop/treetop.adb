with Utils; use Utils;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Treetop is
    File: File_Type;
    Fields: Utils.Field;
    Count: Integer;
    begin
        Open(File => File,
            Mode => In_File,
            Name => "../treetop.txt");
        While not End_Of_File (File) Loop
            declare
                Line: Unbounded_String;
                Trees_Line: Utils.Trees;
                Parse_Int: Integer;
            begin 
                Line := To_Unbounded_String(Get_Line(File));
                for I in 1..Length(Line) loop
                    Parse_Int := Integer'Value((1 => Element (Line, I)));
                    Trees_Line.Append(Parse_Int);
                end loop;
                Fields.Append(Trees_Line);
            end;
            Ada.Text_IO.New_Line;
        end loop;
        Close (File);
        Count := Utils.Get_List_Of_Seen(Fields);
        Put_Line(Count'Image);
end Treetop;