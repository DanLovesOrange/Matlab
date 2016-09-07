%%Convert LocCentroid particle position data into a format for the
%%georgetown tracking code.

function xyzt = struct2list(LocCentroid);

structlength = length(LocCentroid);
numpart = length(LocCentroid(1, 1).time(:,1));
xyzt=[];

for L = 1:structlength
    leftoff = length(xyzt);
    numpart = length(LocCentroid(1, L).time(:,1:3));
    xyztemp = LocCentroid(1, L).time(:,1:3);
    xyztemp(:,4) = L;
    xyzt(leftoff+1:leftoff+numpart,:) = xyztemp;
%     for M = 1:numpart
%         xyzt(
end
