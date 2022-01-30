classdef RobotState < Simulink.IntEnumType
% Enumeration for the Robot's state in the warehouse.
    enumeration
        CHARGING(1)
        NO_PACKAGE(2)
        HAS_PACKAGE(3)
    end
end
