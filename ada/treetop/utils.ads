with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

package Utils is
    package Integer_Vector is new
    Ada.Containers.Vectors
        (Index_Type => Natural,
        Element_Type => Integer);

    use Integer_Vector;

    subtype Trees is Integer_Vector.Vector;

    package Matrix_Vector is new Ada.Containers.Vectors(Natural, Trees);

    use Matrix_Vector;

    subtype Field is Matrix_Vector.Vector; 
    
    function  Get_List_Of_Seen(Field_Of_Trees: in Field)
        return Integer;
private
    procedure Print_Vector(V: in Trees);
end Utils;