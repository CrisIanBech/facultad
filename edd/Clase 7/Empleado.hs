import Set

module Empleado
    (Empleado, consEmpleado, cuil, agregarSector, sectores)
    where

data Empleado = Emp CUIL (Set SectorId)

type SectorId = Int
type CUIL = Int

consEmpleado :: CUIL -> Empleado
-- Propósito: construye un empleado con dicho CUIL.
-- Costo: O(1)
cuil :: Empleado -> CUIL
-- Propósito: indica el CUIL de un empleado.
-- Costo: O(1)
agregarSector :: SectorId -> Empleado -> Empleado
-- Propósito: agrega un sector a un empleado.
-- Costo: O(log N)
sectores :: Empleado -> [SectorId]
-- Propósito: indica los sectores en los que el empleado trabaja.
-- Costo: O(N)


consEmpleado cuil = Emp cuil emptyS

cuil (Emp cuil _) = cuil

agregarSector sector (Emp cuil sectoresEmp) = (Emp cuil (addS sector sectoresEmp))

sectores (Emp _ sectoresEmp) = setToList sectoresEmp