with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;
with Calculations; use Calculations;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Rucksack is
   package Integer_Vector is new
        Ada.Containers.Vectors
            (Index_Type => Natural,
            Element_Type => Integer);
    
    use Integer_Vector;
   File : File_Type;
   Sum : Integer := 0;
   Length: Integer := 0;
   Dominants: Vector;
   Rucksack_Package: Calculations.Rucksack_Package;
begin
   Open (File => File,
         Mode => In_File,
         Name => "../rucksack.txt");
   While not  End_Of_File (File) Loop
      declare
         Dominant: Integer;
         Line: Unbounded_String;
      begin
         Line := To_Unbounded_String(Get_Line(File));
         Rucksack_Package := Calculations.Get_Package (Line);
         Dominant := Calculations.Get_Dominant_Part_One (Rucksack_Package.First_Half, Rucksack_Package.Second_Half);
         Dominants.Append(Dominant);
      end;
      Ada.Text_IO.New_Line;
   end loop;
   Close (File);
   declare
      Sum: Integer := 0;
   begin
      for E of Dominants loop
         Sum := Sum + E;
      end loop;
      Put_Line (Sum'Image);
   end;

   Open (File => File,
         Mode => In_File,
         Name => "../rucksack.txt");
   declare
      Line_One: Rucksack_Normal;
      Line_Two: Rucksack_Normal;
      Line_Three: Rucksack_Normal;
      Index: Integer := 1;
      Dominants_Two: Vector;
   begin
   While not  End_Of_File (File) loop
      declare
         Dominant: Integer;
      begin
         if Index = 1 then
            Line_one := Calculations.Get_Normal_Package(To_Unbounded_String(Get_Line(File)));
            Index := Index + 1;
         elsif Index = 2 then
            Line_Two := Calculations.Get_Normal_Package(To_Unbounded_String(Get_Line(File)));
            
            Index := Index + 1;
         else 
            Line_Three := Calculations.Get_Normal_Package(To_Unbounded_String(Get_Line(File)));
            Dominant := Calculations.Get_Dominant_Part_Two(Line_One.Sack, Line_Two.Sack, Line_Three.Sack);
            Dominants_Two.Append(Dominant);
            Index := 1;
         end if;
      end;
      Ada.Text_IO.New_Line;
   end loop;
   declare
            Sum: Integer := 0;
         begin
            for E of Dominants_Two loop
               Sum := Sum + E;
            end loop;
            Put_Line (Sum'Image);
         end;
   end;
   Close (File);
end Rucksack;