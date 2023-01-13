function elev = getDistance(IATA)
load apt.mat
elev = table2array(apt(IATA,'elev'));

end