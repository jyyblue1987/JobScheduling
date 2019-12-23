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
int U[J][J];

execute Profit_Initialize
{
  	var sum = 0;
  	for(var j in J)
  	{
  	  	sum += p[j]; 		
 	}
 	
 	V = sum; 		
 	
 	for(var j in J )
  	{
  	  	for(var k in J)
  	  	{
  	  	  	if( j < k )
  	  			U[j][k] = V - p[j] - p[k];
  	  		else
  	  			U[j][k] = 0;	  	
  	  	}
  	  	 		
 	}
}

dvar float+ q[j in J][k in J] in 0..U[j][k];

// Objective 
minimize
  	sum(j in J)
    	t[j] * r[j];
    	
// contraints
subject to {
  	forall( j in J, k in J : j < k )
	    disjuctive1:	      	
    		V * z[j][k] + (x[j] - x[k]) - p[k] == q[j][k];
    		
    forall( j in J )
      	slack_cond:
      		x[j] + p[j] - d[j] <= t[j];
  			  				
}	
    	
