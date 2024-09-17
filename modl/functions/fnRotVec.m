function [Vout] = fnRotVec(V, Yaw, Pitch, Roll, Method)
    if strcmp(Method,'ZYX')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = fnRotZ(Yaw) * fnRotY(Pitch) * fnRotX(Roll) * tmp;
                Vout(i,:) = tmp';
        end
    elseif strcmp(Method,'XYZ')
        Vout = zeros(size(V));
        for i = 1:size(V,1)
                tmp = V(i,:)';
                tmp = fnRotX(Roll) * fnRotY(Pitch) * fnRotZ(Yaw) * tmp;
                Vout(i,:) = tmp';
        end
    else
        error("Method argument invalid. Select from: ['ZYX', 'XYZ']")
    end
    
end