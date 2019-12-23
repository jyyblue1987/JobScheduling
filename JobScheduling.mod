/*********************************************
 * OPL 12.10.0.0 Model
 * Author: JKH
 * Creation Date: Dec 22, 2019 at 12:53:32 AM
 *********************************************/

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
 
 // Variables
dvar float+ x[J];
dvar float+ t[J];
dvar boolean z[J][J];

int V = 0;

execute Profit_Initialize
{
  	var sum = 0;
  	for(var j in J)
  	{
  	  	sum += p[j]; 		
 	} 		
 	
 	V = sum;
}

// Objective 
minimize
  	sum(j in J)
    	t[j] * r[j];
    	
// contraints
subject to {
  	forall( j in J, k in J : j < k )
	    disjuctive1:	      	
    		x[j] >= x[k] + p[k] - V * z[j][k];
	        	
	forall( j in J, k in J : j < k )
	    disjuctive2:	      	
    		x[k] >= x[j] + p[j] - V * (1 - z[j][k]);
    		
    forall( j in J )
      	slack_cond:
      		x[j] + p[j] - d[j] <= t[j];
  			  				
}	
    	
