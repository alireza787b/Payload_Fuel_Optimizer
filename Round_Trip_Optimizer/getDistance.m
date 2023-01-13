function distNM = getDistance(IATA1,IATA2)
load ../apt.mat
lat1 = table2array(apt(IATA1,'lat'));
lat2 = table2array(apt(IATA2,'lat'));
lon1 = table2array(apt(IATA1,'long'));
lon2 = table2array(apt(IATA2,'long'));
distNM = deg2nm(distance('rh',lat1,lon1,lat2,lon2));
end