function [c,ceq] = constraintFcnSolver3(optimInput)
% Example:

% Edit the lines below with your calculation
% Note, if no inequality constraints, specify c = []
% Note, if no equality constraints, specify ceq = []



 global trainedModel param1;


%upFuel1,upFuel2,paxload1,paxload2,cargo1,cargo2


upFuel1 = optimInput(1);
upFuel2 = optimInput(2);
paxload1 = optimInput(3);
paxload2 = optimInput(4);
cargo1 = optimInput(5);
cargo2 = optimInput(6);


dayofYear1 = day(datetime(param1.offBlock1),"dayofyear");
dayofYear2 = day(datetime(param1.offBlock2),"dayofyear");
 hourofDay1 = hour(datetime(param1.offBlock1));
 hourofDay2 = hour(datetime(param1.offBlock2));

 varNames = ["BlockTime","FlightTime","dayOfYear","distance","fieldElev1","fieldElev2",...
     "hourOfDay","payloadKg","totalWeightKg"];
 varTypes = ["double","double","double","double","double","double","double","double","double"];
 inT = table('Size',size(varNames),'VariableTypes',varTypes,'VariableNames',varNames);


 payload1 = paxload1 + cargo1;
 totalWeight1 = upFuel1 + payload1 + param1.emptyWeight;
 inT(1,:) = array2table([param1.BlockTime1 param1.FlightTime1 dayofYear1 param1.distance param1.fieldElev1 ...
     param1.fieldElev2 hourofDay1 payload1 totalWeight1]);
 fuelUsed1 = trainedModel.predictFcn(inT);
 %fuelUsed1 = 8000;
  fuel1 = totalWeight1 - payload1 - param1.emptyWeight;
  fuelRemained1 = fuel1 - fuelUsed1;
%fuelUsed1 = 0;
 payload2 = paxload2 + cargo2;
 totalWeight2 = upFuel2 + fuelRemained1 + payload2 + param1.emptyWeight ;
 inT(1,:) = array2table([param1.BlockTime2 param1.FlightTime2 dayofYear2 param1.distance param1.fieldElev2 ...
     param1.fieldElev1 hourofDay2 payload2 totalWeight2]);
  fuelUsed2 = trainedModel.predictFcn(inT);
% fuelUsed2 = 7500;
 
 fuel2 = fuelRemained1 + upFuel2;
 fuelRemained2 = fuel2 - fuelUsed2;

pax1 = ceil(paxload1/param1.averagePaxWeightKG);
pax2 = ceil(paxload2/param1.averagePaxWeightKG);

landingWeight1 = totalWeight1 - double(fuelUsed1) ;
landingWeight2 = totalWeight2 - double(fuelUsed2) ;
zfw1 = payload1 + param1.emptyWeight;
zfw2 = payload2 + param1.emptyWeight;

c(1) = totalWeight1 - param1.MTOW1;
c(2) = totalWeight2 - param1.MTOW2;
c(3) =  landingWeight1 - param1.MLW1;
c(4) = landingWeight2 - param1.MLW2;
c(5) =  -fuelRemained1 + param1.fuelTresh;
c(6) =  -fuelRemained2 + param1.fuelTresh;
c(7) = fuel1 - param1.maxFuelTankKg;
c(8) = fuel2 - param1.maxFuelTankKg;
c(9) = -upFuel1 ;
c(10) = -upFuel2 ;
c(11) = zfw1 - param1.maxZeroFuelWeight;
c(12) = zfw2 - param1.maxZeroFuelWeight;
c(13) = pax1 - param1.maxPax;
c(14) = pax2 - param1.maxPax;
c(15) = -paxload1 ;
c(16) = -paxload2 ;
c(17) = cargo1 - param1.maxCargo;
c(18) = cargo2 - param1.maxCargo;
c(19) = -cargo1 ;
c(20) = -cargo2 ;
c(21) =  fuelRemained2 - param1.fuelTresh*1.2;
%c(21) =  costFunctionSolver(optimInput);
%display(c);
ceq = [];


end
