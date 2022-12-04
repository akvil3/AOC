with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

package body Calculations is
    
    function Get_Val_From_Letter (Letter: in Character) 
        return Integer is
        Val: Integer;
    begin
        Val := Character'Pos(Letter);
        if Val <= 90 then
            Val := Val - 38;
        elsif Val >= 97 then
            Val := Val - 96;
        end if;
        return Val;
    end Get_Val_From_Letter;

    function Get_Dominant_Part_One (First_Half: in Vector;
        Second_Half: in Vector)
        return Integer is
            Most_Common: Integer;
            Common: Integer;
    begin
        for E of First_Half loop
            for E_Second of Second_Half loop
                if E = E_Second then
                    Common := E_Second;
                    Most_Common := E;
                    exit;
                end if;
            end loop;
            if E = Common then
                exit;
            end if;
        end loop;
        return Most_Common;
    end Get_Dominant_Part_One;

    function Get_Dominant_Part_Two (First_Group: in Vector;
                             Second_Group: in Vector;
                             Third_Group: in Vector)
            return Integer is
            Most_Common: Integer;
            Common: Integer;
    begin
        for E of First_Group loop
            for E_Second of Second_Group loop
                for E_Third of Third_Group loop
                    if E = E_Second and E_Second = E_Third then
                        Common := E_Second;
                        Most_Common := E;
                        exit;
                    end if;
                end loop;
                if E_Second = Common then
                    exit;
                end if;
            end loop;
            if E = Common then
                exit;
            end if;
        end loop;
        return Most_Common;
    end Get_Dominant_Part_Two;
    
    function Get_The_Half (Length: in Integer)
        return Natural is
    begin
            return Length / 2;
    end Get_The_Half;

    function Split_First_Half (List: in out Vector)
        return Vector is
            New_Vector: Vector;
            Half_Index: Natural;
            Length_All: Integer;
    begin
        Length_All := Integer(List.Length);
        Half_Index := Get_The_Half(Length_All);
        for I in 0..Half_Index - 1 loop
            New_Vector.Append(List(I));
        end loop;
        return New_Vector;
    end Split_First_Half;

    function Split_Second_Half (List: in out Vector)
        return Vector is
            New_Vector: Vector;
            Half_Index: Natural;
            Length_All: Integer;
    begin
        Length_All := Integer(List.Length);
        Half_Index := Get_The_Half(Length_All);

        for I in Half_Index.. Length_All - 1 loop
            New_Vector.Append(List(I));
        end loop;
        return New_Vector;
    end Split_Second_Half;
    
    function Get_Package (Unbounded_List: in Unbounded_String) 
        return Rucksack_Package is
            Vec: Vector;
            First_Half: Vector;
            Second_Half: Vector;
            Package_Rucksack: Rucksack_Package;
    begin
        for J in 1..Length(Unbounded_List) loop
            declare
                L : Integer;
            begin 
                L := Get_Val_From_Letter ( Element (Unbounded_List, J));
                Vec.append(L);
            end;
        end loop;
        
        First_Half := Split_First_Half (Vec);
        Second_Half := Split_Second_Half (Vec);
        Package_Rucksack := (First_Half, Second_Half);
        return Package_Rucksack;
    end Get_Package;

    function Get_Normal_Package (Unbounded_List: in Unbounded_String)
        return Rucksack_Normal is
            Vec: Vector;
            Rucksack: Rucksack_Normal;
    begin
        for J in 1..Length(Unbounded_List) loop
            declare
                L : Integer;
            begin 
                L := Get_Val_From_Letter ( Element (Unbounded_List, J));
                Vec.append(L);
            end;
        end loop;
        Rucksack := (Vec, Length(Unbounded_List));
        return Rucksack;
    end Get_Normal_Package;
end Calculations;