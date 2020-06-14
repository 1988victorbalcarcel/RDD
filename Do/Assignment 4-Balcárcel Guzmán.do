
*Using dataset*
use "C:\Users\Personal\Desktop\VICTOR\SUMMER SCHOOL RECORDS\RDD\Data\hansen_dwi.dta" 

*Point 3. Creation of a dummy DUI equal to 1 if bac1>=0.08*
gen DUI = 0
replace DUI=1 if bac1>=0.08

*Point 4.Searching for manipulation on the running variable*
*4.A. Histogram*
histogram bac1 , w(0.001) xli(0.08, lp(solid) lc(black)) yti(Frequency) xti(BAC) title(BAC histogram, ring(7))

*4.B. MacCrary Test*
net install rddensity, from(https://sites.google.com/site/rdpackages/rddensity/stata) replace
net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace
asdoc rddensity bac1, c(0.08) plot all
graph save "Graph" "C:\Users\Personal\Desktop\VICTOR\SUMMER SCHOOL RECORDS\RDD\Figures\rddensity

*Point 5. Covariate balance*
*Previous: Re-centering the running variable and generating interaction between BAC and DUI*
gen bac1_c = bac1 - 0.08
gen interactionBAC_DUI=bac1*DUI

reg male DUI bac1_c interactionBAC_DUI if inrange(bac1_c,-0.05,0.05), r
outreg2 using "assignment4point4.doc", replace 
reg white DUI bac1_c interactionBAC_DUI if inrange(bac1_c,-0.05,0.05), r
outreg2 using "assignment4point4.doc", append
reg aged DUI bac1_c interactionBAC_DUI if inrange(bac1_c,-0.05,0.05), r
outreg2 using "assignment4point4.doc", append
reg acc DUI bac1_c interactionBAC_DUI if inrange(bac1_c,-0.05,0.05), r
outreg2 using "assignment4point4.doc", append

*Point 6.*

*Point 7. 
*Panel A.Bandwidth 0.03-0.13*
gen interactionBAC_DUI_sq=bac1*bac1

reg recidivism DUI bac1 male white aged acc if inrange(bac1,0.03, 0.13) , r
outreg2 using "PanelA-Point7.doc", replace 
reg recidivism DUI bac1 interactionBAC_DUI male white aged acc if inrange(bac1,0.03, 0.13) , r
outreg2 using "PanelA-Point7.doc", append 
reg recidivism DUI bac1 interactionBAC_DUI_sq male white aged acc if inrange(bac1,0.03, 0.13) , r
outreg2 using "PanelA-Point7.doc", append

*Panel B. Bandwidth 0.055-0.105*

reg recidivism DUI bac1 male white aged acc if inrange(bac1,0.055, 0.105) , r
outreg2 using "PanelA-Point72.doc", replace 
reg recidivism DUI bac1 interactionBAC_DUI male white aged acc if inrange(bac1,0.055, 0.105) , r
outreg2 using "PanelA-Point72.doc", append 
reg recidivism DUI bac1 interactionBAC_DUI_sq male white aged acc if inrange(bac1,0.055, 0.105) , r
outreg2 using "PanelA-Point72.doc", append


