------------------------------------------------------------------------------
--                                                                          --
--                         REFLEX EXAMPLES                                  --
--                                                                          --
--          Copyright (C) 1992-2011, Free Software Foundation, Inc.         --
--                                                                          --
-- Reflex is free software; you can redistribute it  and/or modify it under --
-- terms of the  GNU General Public Licensea as published  by the Free Soft- --
-- ware Foundation; either version 3, or (at your option) any later version --
-- Reflex is distributed in the hope that it will be useful, but WITH-      --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License distributed with Reflex; see file COPYING3. If not, go to --
-- http://www.gnu.org/licenses for a complete copy of the license.          --
--                                                                          --
-- Reflex is originally developed  by the Artics team at Grenoble.          --
--                                                                          --
------------------------------------------------------------------------------

package Devices.Pumps is
   
   
   type Pump_Record is new Device_Record with private;
   type Pump_Ptr is access all Pump_Record;
   type Pump_Class_Ptr is access all Pump_Record'Class;
   
   type Pump_State is 
     (Init_State,
      stop_State,
      Run_State,
      Running_State,
      stopping_State);

   procedure Initialize (This : in out Pump_Record);
   
   procedure Cyclic
     (This      : in out Pump_Record;
      Run       : Boolean;
      Running   : Boolean;
      Run_Order : out Boolean);
   
private
   
   type Pump_Record is new Device_Record with record
      State       : Pump_State;
   end record;
   
   No_Pump_Record : constant Pump_Record :=
     (No_Device_Record with
      State         => stop_State);
   
end Devices.Pumps;
