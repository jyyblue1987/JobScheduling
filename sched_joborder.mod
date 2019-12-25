 using CP;
 
 int jobs = ...;
 
 // Index
 range J = 1..jobs;
 
 // Data
 
 // Processing Time
 int p[J] = ...;
 
 // Delivery Time
 int d[J] = ...;
 
 // Risk
 int r[J] = ...;
 
 dvar interval itvs[j in J] size p[j];
 dvar sequence mchs in all(j in J) itvs[j];
 
 execute {
  		cp.param.FailLimit = 100000;
}

minimize sum(j in J) maxl(endOf(itvs[j]) - d[j], 0) * r[j];
subject to {
  noOverlap1:
    noOverlap(mchs);  
}

execute {
  for (var j in J) {    
      write(j, " job's' delay: ", Opl.maxl(itvs[j].end - d[j], 0)  + " days");
      write("\n");
  }
}
