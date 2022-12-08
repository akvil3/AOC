with Ada.Text_IO; use Ada.Text_IO;

package body Utils is
    package Integer_Vectors_Sorting is new Integer_Vector.Generic_Sorting;

    use Integer_Vectors_Sorting;

    procedure Print_Vector(V: in Trees) is
        begin
            New_Line;
            Put ("[");
            for El of V loop
                Put(El'Image);
                Put(", ");
            end loop;
            Put("]");
    end Print_Vector;

    function  Get_List_Of_Seen(Field_Of_Trees: in Field)
        return Integer is
            Count: Integer := 0;
            Row_Length: Integer := 0;
            Scenic_Score: Integer := 0;
            Scenic_Scores: Trees;
        begin
        for I in 0..Field_Of_Trees.Length - 1 loop
            New_Line;
            Put("Col: ");
            Put(I'Image);
            declare
                Current_Trees: Trees := Field_Of_Trees(Integer(I));
                Avg_Length: Integer := Integer(Field_Of_Trees(Integer(I)).Length);
                Col_Tree: Integer;
                Row_Tree: Integer;
                Current_Tree: Integer;
                Max_Found: Boolean;
                Edge: Boolean;
            begin
                if Row_Length = 0 then
                    Row_Length := Avg_Length;
                end if;
                
                for L in 0..Avg_Length - 1 loop
                    declare
                        From_Top: Trees;
                        From_Bottom: Trees;
                        From_Left: Trees;
                        From_Right: Trees;
                    begin
                        Max_Found := False;
                        Edge := False;
                        if I = 0 or I = Field_Of_Trees.Length - 1 or L = 0 or L = Avg_Length - 1 then
                            Edge := True;
                        end if;
                        if not Edge then
                            Current_Tree := Current_Trees(Integer(L));
                            for Column in 0..I - 1 loop
                                Col_Tree := Field_Of_Trees(Integer(Column))(Integer(L));
                                From_Top.Append(Col_Tree);
                            end loop;
                            for Column in I + 1..Field_Of_Trees.Length - 1 loop
                                Col_Tree := Field_Of_Trees(Integer(Column))(Integer(L));
                                From_Bottom.Append(Col_Tree);
                            end loop;
                            for Row in 0..L-1 loop
                                Row_Tree := Current_Trees(Integer(Row));
                                From_Left.Append(Row_Tree);
                            end loop;
                            for Row in  L + 1..Avg_Length - 1 loop
                                Row_Tree := Current_Trees(Integer(Row));
                                From_Right.Append(Row_Tree);
                            end loop;
                        declare
                            Exit_Loop: Boolean := False;
                            Top: Integer := 0;
                            Bottom: Integer := 0;
                            Left: Integer := 0;
                            Right: Integer := 0;
                        begin
                            for Trees in reverse 0..From_Top.Length - 1 loop
                                if not Exit_Loop then
                                    if From_Top(Integer(Trees)) < Current_Tree then
                                        Top := Top + 1;
                                    elsif From_Top(Integer(Trees)) >= Current_Tree then
                                        Top := Top + 1;
                                        Exit_Loop := True;
                                    end if;
                                end if;
                            end loop;

                            Exit_Loop := False;

                            for Trees in  0..From_Bottom.Length - 1 loop
                                if not Exit_Loop then
                                    if From_Bottom(Integer(Trees)) < Current_Tree then
                                        Bottom := Bottom + 1;
                                    elsif From_Bottom(Integer(Trees)) >= Current_Tree then
                                        Bottom := Bottom + 1;
                                        Exit_Loop := True;
                                    end if;
                                end if;
                            end loop;

                            Exit_Loop := False;

                            for Trees in reverse 0..From_Left.Length - 1 loop
                                if not Exit_Loop then
                                    if From_Left(Integer(Trees)) < Current_Tree then
                                        Left := Left + 1;
                                    elsif From_Left(Integer(Trees)) >= Current_Tree then
                                        Left := Left + 1;
                                        Exit_Loop := True;
                                    end if;
                                end if;
                            end loop;

                            Exit_Loop := False;

                            for Trees in 0..From_Right.Length - 1 loop
                                if not Exit_Loop then
                                    if From_Right(Integer(Trees)) < Current_Tree then
                                        Right := Right + 1;
                                    elsif From_Right(Integer(Trees)) >= Current_Tree then
                                        Right := Right + 1;
                                        Exit_Loop := True;
                                    end if;
                                end if;
                            end loop;

                            Exit_Loop := False;
                       
                            Scenic_Score := Bottom * Top * Left * Right;
                            Scenic_Scores.Append(Scenic_Score);
                        end;

                        declare
                            Max: Trees;
                        begin
                            Sort(From_Bottom);
                            Max.Append(From_Bottom.Last_Element);
                
                            Sort(From_Top);
                            Max.Append(From_Top.Last_Element);

                            Sort(From_Left);
                            Max.Append(From_Left.Last_Element);

                            Sort(From_Right);
                            Max.Append(From_Right.Last_Element);
            
                            for Maximum of Max loop
                                if Current_Tree > Maximum and not Max_Found then                        
                                    Count := Count + 1;
                                    Max_Found := True;
                                end if;
                            end loop;
                        end;
                        end if;
                    end;
                end loop; 
            
            end;
        end loop;
        Sort(Scenic_Scores);
        New_Line;
        Put("Max Scenic Score: ");
        Put_Line(Scenic_Scores.Last_Element'Image);
        return Count + (Integer(Field_Of_Trees.Length) * 2) + (Row_Length * 2) - 4;
    end Get_List_Of_Seen;
end Utils;