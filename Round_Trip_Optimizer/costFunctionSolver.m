function revenue = costFunctionSolver(optimInput)

%upFuel1,upFuel2,paxload1,paxload2,cargo1,cargo2


upFuel1 = optimInput(1);
upFuel2 = optimInput(2);
paxload1 = optimInput(3);
paxload2 = optimInput(4);
cargo1 = optimInput(5);
cargo2 = optimInput(6);


global param1 trainedModel;

pax1 = ceil(paxload1 / param1.averagePaxWeightKG); 
pax2 = ceil(paxload2 / param1.averagePaxWeightKG); 
%incomes
ticketIncome = param1.ticketPrice1*pax1 + param1.ticketPrice2*pax2;
cargoIncome = param1.cargoPrice1 * cargo1 + param1.cargoPrice2*cargo2;
incomes = ticketIncome+cargoIncome;
%costs
fuelCost = param1.fuelPrice1 * upFuel1 + param1.fuelPrice2*upFuel2;
cargoCost = param1.cargoCost1 * cargo1 + param1.cargoCost2;
paxCost = param1.costsPerPax1 * pax1 + param1.costsPerPax2*pax2;

costs = fuelCost + cargoCost + paxCost;

revenue = -1*(incomes - costs);

end