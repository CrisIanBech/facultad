import Map
import Set
import Empleado

module Empresa
    (Empresa, consEmpresa, buscarPorCUIL, empleadosDelSector, todosLosCUIL, todosLosSectores, agregarEmpleado, agregarASector, borrarEmpleado)
    where

data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)
    deriving Show
    -- Inv rep:
    -- - los id de sectores y los legajos no pueden repetirse.
    -- - los empleados son un tipo abstracto.
    -- - el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
    -- - el segundo map relaciona empleados con su número de CUIL.
    -- - un empleado puede estar asignado a más de un sector

type SectorId = Int
type CUIL = Int

consEmpresa :: Empresa
-- Propósito: construye una empresa vacía.
-- Costo: O(1)
buscarPorCUIL :: CUIL -> Empresa -> Empleado
-- Propósito: devuelve el empleado con dicho CUIL.
-- Precondiciones: debe de existir tal empleado en la empresa.
-- Costo: O(log N)
empleadosDelSector :: SectorId -> Empresa -> [Empleado]
-- Propósito: indica los empleados que trabajan en un sector dado.
-- Precondiciones: Debe de existir tal sector en la empresa.
-- Costo: O(N)
todosLosCUIL :: Empresa -> [CUIL]
-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Costo: O(N)
todosLosSectores :: Empresa -> [SectorId]
-- Propósito: indica todos los sectores de la empresa.
-- Costo: O(N)
agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un empleado a la empresa, en el que trabajará en dichos sectores y tendrá
-- el CUIL dado.
-- Costo: calcular.
agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: calcular.
borrarEmpleado :: CUIL -> Empresa -> Empresa
-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: calcular.

consEmpresa = emptyM emptyM

buscarPorCUIL cuil (ConsE _ mapEmpleados) = lookupM cuil mapEmpleados

empleadosDelSector idSector (ConsE sectores _) = setToList (lookupM idSector sectores) 

todosLosCUIL (ConsE sectores empleados) = keys empleados

todosLosSectores (ConsE sectores _) = keys sectores

agregarEmpleado idSectores cuil (ConsE sectores empleados) = agregarEmpleado' idSectores cuil 
                                                                (ConsE sectores 
                                                                    (assocM cuil 
                                                                        (agregarSectoresEmpleado id 
                                                                            (consEmpleado cuil))
                                                                        empleados))

agregarEmpleado' :: [SectorId] -> CUIL -> Empresa -> Empresa
agregarEmpleado' [] c empresa       =
agregarEmpleado' (id:ids) c empresa = agregarEmpleado' ids c (agregarASector id c empresa)

agregarASector idSector c (ConsE sectores empleados) = let empleado = lookupM c empleados
                                                           sector = lookupM idSector sectores
                                                        in (ConsE
                                                                assocM
                                                                    idSector
                                                                    (addS sector empleado)
                                                                    sectores
                                                                empleados
                                                            )

agregarSectoresEmpleado :: [SectorId] -> Empleado -> Empleado
agregarSectoresEmpleado [] empleado       = empleado
agregarSectoresEmpleado (id:ids) empleado = agregarSector id (agregarSectoresEmpleado ids empleado)

borrarEmpleado :: CUIL -> Empresa -> Empresa
borrarEmpleado cuil empresa = borrarEmpleado' cuil empresa (todosLosSectores empresa)  

borrarEmpleado' :: CUIL -> Empresa -> [SectorId] -> Empresa
borrarEmpleado' cuil (ConsE sectores empleados) sectoresABorrar = 
        ConsE (sectoresSinEmpleado sectoresABorrar sectores cuil) (deleteM cuil empleados)


sectoresSinEmpleado :: [SectorId] -> Map SectorId (Set Empleado) -> CUIL -> Map SectorId (Set Empleado)
sectoresSinEmpleado [] sectores _           = sectores
sectoresSinEmpleado (s:ss) sectores cuil    = assocM s (sectorSinEmpleado (lookupM s sectores) cuil) 
                                                       (sectoresSinEmpleado ss (deleteM s sectores) cuil)

sectorSinEmpleado :: CUIL -> Set Empleado -> Set Empleado
sectorSinEmpleado cuil empleados = deleteM cuil empleados

