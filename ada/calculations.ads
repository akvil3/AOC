with Ada.Containers; use Ada.Containers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package Calculations is
    package Integer_Vector is new
        Ada.Containers.Vectors
            (Index_Type => Natural,
            Element_Type => Integer);
    
    use Integer_Vector;

    type Rucksack_Package is record
        First_Half: Vector;
        Second_Half: Vector;
    end record;

    type Rucksack_Normal is record
        Sack: Vector;
        Length: Integer;
    end record;

    function Get_Dominant_Part_One (First_Half: in Vector;
        Second_Half: in Vector)
        return Integer;

    function Get_Dominant_Part_Two (First_Group: in Vector;
                             Second_Group: in Vector;
                             Third_Group: in Vector)
                return Integer;
        
    function Get_Package (Unbounded_List: in Unbounded_String)
        return Rucksack_Package;

    function Get_Normal_Package(Unbounded_List: in Unbounded_String)
        return Rucksack_Normal;
private
    function Get_Val_From_Letter (Letter: in Character) 
        return Integer;

end Calculations;