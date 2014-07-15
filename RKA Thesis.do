/* Robert Ackerman
   University of North Carolina
   Master's Thesis
   How does Overeducation Vary by Field of Degree, and How Does it Potentially Impact Earnings
   Accepted Spring 2014
   Partial Stata .do code 
   It was not meant to be executed as a single .do file, but rather served as a repository of the various code used throughout the paper
   For questions or concerns, email me at rackermn@gmail.com */

clear
clear matrix
capture cd "/Users/robertackerman/Desktop/School/Econ 880/Final Paper"
log using "Econ880_Project_Ackerman.log", replace



**** Load Full 2011 ACS Data ****
**** Data was obtained from https://usa.ipums.org/usa/index.shtml ****

**** Load Parial 2011 ACS Data ****
use ACS2011_Partial.dta

set more off

**** Turn this on to aggregate into major group for degfieldd ****
/* gen majgrp=.
label var majgrp "Major Group"
replace majgrp=1 if degfieldd==1102 | degfieldd==1101 | degfieldd==1103 | degfieldd==1104 | degfieldd==1302 | degfieldd==1100 | degfieldd==1199 | degfieldd==1303 | degfieldd==1105 | degfieldd==1106
replace majgrp=2 if degfieldd==6004 | degfieldd==6001 | degfieldd==6005 | degfieldd==6000 | degfieldd==6002 | degfieldd==6007 | degfieldd==6003 | degfieldd==6099
replace majgrp=3 if degfieldd==3601 | degfieldd==3600 | degfieldd==3602 | degfieldd==4006 | degfieldd==3604 | degfieldd==1301 | degfieldd==3605 | degfieldd==3606 | degfieldd==3699 | degfieldd==3603 | degfieldd==3611 | degfieldd==3607 | degfieldd==3608 | degfieldd==3609
replace majgrp=4 if degfieldd==6201 | degfieldd==6202 |degfieldd==6205 | degfieldd==6203 | degfieldd==6207 | degfieldd==6200 | degfieldd==6211 | degfieldd==6209 | degfieldd==6210 | degfieldd==6212 | degfieldd==6206 | degfieldd==6299 | degfieldd==6204
replace majgrp=5 if degfieldd==1904 | degfieldd==1901 | degfieldd==1902 | degfieldd==1903
replace majgrp=6 if degfieldd==3701 | degfieldd==2001 | degfieldd==2106 | degfieldd==2100 | degfieldd==2407 | degfieldd==2107 | degfieldd==2101 | degfieldd==2102 | degfieldd==2105 | degfieldd==3700 | degfieldd==4005
replace majgrp=7 if degfieldd==2314 | degfieldd==2307 | degfieldd==2301 | degfieldd==2304 | degfieldd==2300 | degfieldd==2313 | degfieldd==3501 | degfieldd==2305 | degfieldd==2399 | degfieldd==2306 | degfieldd==2303 | degfieldd==2308 | degfieldd==2309 | degfieldd==2311 | degfieldd==2310 | degfieldd==2312
replace majgrp=8 if degfieldd==2401 | degfieldd==2403 | degfieldd==1401 | degfieldd==2402 | degfieldd==2404 | degfieldd==2405 | degfieldd==2406 | degfieldd==2408 | degfieldd==2502 | degfieldd==2501 | degfieldd==2409 | degfieldd==2500 | degfieldd==2410 | degfieldd==2400 | degfieldd==2411 | degfieldd==2412 | degfieldd==2503 | degfieldd==2413 | degfieldd==2414 | degfieldd==2504 | degfieldd==2415 | degfieldd==2416 | degfieldd==2499 | degfieldd==2599 | degfieldd==2417 | degfieldd==2418 | degfieldd==2419
replace majgrp=9 if degfieldd==6110 | degfieldd==6100 | degfieldd==6103 | degfieldd==6106 | degfieldd==6104 | degfieldd==6105 | degfieldd==6199 | degfieldd==6107 | degfieldd==4002 | degfieldd==6108 | degfieldd==6109 | degfieldd==6102
replace majgrp=10 if degfieldd==5502 | degfieldd==1501 | degfieldd==6006 | degfieldd==3302 | degfieldd==3301 | degfieldd==2602 | degfieldd==6402 | degfieldd==3402 | degfieldd==4001 | degfieldd==3401 | degfieldd==2601 | degfieldd==2603 | degfieldd==4801 | degfieldd==4901 | degfieldd==6403
replace majgrp=11 if degfieldd==5601 | degfieldd==2201 | degfieldd==5701 | degfieldd==2901 | degfieldd==3801 | degfieldd==4101 | degfieldd==5901
replace majgrp=12 if degfieldd==3201 | degfieldd==5301 | degfieldd==3202 | degfieldd==5401 | degfieldd==5402
replace majgrp=13 if degfieldd==5001 | degfieldd==5002 | degfieldd==5003 | degfieldd==5004 | degfieldd==5005 | degfieldd==4000 | degfieldd==5008 | degfieldd==5098 | degfieldd==5102 | degfieldd==5006 | degfieldd==5007 | degfieldd==5000
replace majgrp=14 if degfieldd==5202 | degfieldd==5203 | degfieldd==5201 | degfieldd==5403 | degfieldd==5205 | degfieldd==5299 | degfieldd==5200 | degfieldd==5206 | degfieldd==5404
replace majgrp=15 if degfieldd==5503 | degfieldd==5501 | degfieldd==5500 | degfieldd==5504 | degfieldd==4007 | degfieldd==5505 | degfieldd==5599 | degfieldd==5506 | degfieldd==5507 | degfieldd==3702

*label majgrp
label define majgrp_lbl 1 `"Agriculture and Natural Resources"'
label define majgrp_lbl 2 `"Arts"', add
label define majgrp_lbl 3 `"Biology and Life Sciences"', add
label define majgrp_lbl 4 `"Business"', add
label define majgrp_lbl 5 `"Communications and Journalism"', add
label define majgrp_lbl 6 `"Computers and Mathematics"', add
label define majgrp_lbl 7 `"Education"', add
label define majgrp_lbl 8 `"Engineering"', add
label define majgrp_lbl 9 `"Health"', add
label define majgrp_lbl 10 `"Humanities and Liberal Arts"', add
label define majgrp_lbl 11 `"Industrial Arts and Consumer Services"', add
label define majgrp_lbl 12 `"Law and Public Policy"', add
label define majgrp_lbl 13 `"Physical Sciences"', add
label define majgrp_lbl 14 `"Psychology and Social Work"', add
label define majgrp_lbl 15 `"Social Science"', add
label values majgrp majgrp_lbl */


**** Turn this on for 2nd groupings degfield2d aggregation into majgrp2 ****
/*
gen majgrp2=.
label var majgrp2 "Major Group"
replace majgrp2=1 if degfield2d==1102 | degfield2d==1101 | degfield2d==1103 | degfield2d==1104 | degfield2d==1302 | degfield2d==1100 | degfield2d==1199 | degfield2d==1303 | degfield2d==1105 | degfield2d==1106
replace majgrp2=2 if degfield2d==6004 | degfield2d==6001 | degfield2d==6005 | degfield2d==6000 | degfield2d==6002 | degfield2d==6007 | degfield2d==6003 | degfield2d==6099
replace majgrp2=3 if degfield2d==3601 | degfield2d==3600 | degfield2d==3602 | degfield2d==4006 | degfield2d==3604 | degfield2d==1301 | degfield2d==3605 | degfield2d==3606 | degfield2d==3699 | degfield2d==3603 | degfield2d==3611 | degfield2d==3607 | degfield2d==3608 | degfield2d==3609
replace majgrp2=4 if degfield2d==6201 | degfield2d==6202 |degfield2d==6205 | degfield2d==6203 | degfield2d==6207 | degfield2d==6200 | degfield2d==6211 | degfield2d==6209 | degfield2d==6210 | degfield2d==6212 | degfield2d==6206 | degfield2d==6299 | degfield2d==6204
replace majgrp2=5 if degfield2d==1904 | degfield2d==1901 | degfield2d==1902 | degfield2d==1903
replace majgrp2=6 if degfield2d==3701 | degfield2d==2001 | degfield2d==2106 | degfield2d==2100 | degfield2d==2407 | degfield2d==2107 | degfield2d==2101 | degfield2d==2102 | degfield2d==2105 | degfield2d==3700 | degfield2d==4005
replace majgrp2=7 if degfield2d==2314 | degfield2d==2307 | degfield2d==2301 | degfield2d==2304 | degfield2d==2300 | degfield2d==2313 | degfield2d==3501 | degfield2d==2305 | degfield2d==2399 | degfield2d==2306 | degfield2d==2303 | degfield2d==2308 | degfield2d==2309 | degfield2d==2311 | degfield2d==2310 | degfield2d==2312
replace majgrp2=8 if degfield2d==2401 | degfield2d==2403 | degfield2d==1401 | degfield2d==2402 | degfield2d==2404 | degfield2d==2405 | degfield2d==2406 | degfield2d==2408 | degfield2d==2502 | degfield2d==2501 | degfield2d==2409 | degfield2d==2500 | degfield2d==2410 | degfield2d==2400 | degfield2d==2411 | degfield2d==2412 | degfield2d==2503 | degfield2d==2413 | degfield2d==2414 | degfield2d==2504 | degfield2d==2415 | degfield2d==2416 | degfield2d==2499 | degfield2d==2599 | degfield2d==2417 | degfield2d==2418 | degfield2d==2419
replace majgrp2=9 if degfield2d==6110 | degfield2d==6100 | degfield2d==6103 | degfield2d==6106 | degfield2d==6104 | degfield2d==6105 | degfield2d==6199 | degfield2d==6107 | degfield2d==4002 | degfield2d==6108 | degfield2d==6109 | degfield2d==6102
replace majgrp2=10 if degfield2d==5502 | degfield2d==1501 | degfield2d==6006 | degfield2d==3302 | degfield2d==3301 | degfield2d==2602 | degfield2d==6402 | degfield2d==3402 | degfield2d==4001 | degfield2d==3401 | degfield2d==2601 | degfield2d==2603 | degfield2d==4801 | degfield2d==4901 | degfield2d==6403
replace majgrp2=11 if degfield2d==5601 | degfield2d==2201 | degfield2d==5701 | degfield2d==2901 | degfield2d==3801 | degfield2d==4101 | degfield2d==5901
replace majgrp2=12 if degfield2d==3201 | degfield2d==5301 | degfield2d==3202 | degfield2d==5401 | degfield2d==5402
replace majgrp2=13 if degfield2d==5001 | degfield2d==5002 | degfield2d==5003 | degfield2d==5004 | degfield2d==5005 | degfield2d==4000 | degfield2d==5008 | degfield2d==5098 | degfield2d==5102 | degfield2d==5006 | degfield2d==5007 | degfield2d==5000
replace majgrp2=14 if degfield2d==5202 | degfield2d==5203 | degfield2d==5201 | degfield2d==5403 | degfield2d==5205 | degfield2d==5299 | degfield2d==5200 | degfield2d==5206 | degfield2d==5404
replace majgrp2=15 if degfield2d==5503 | degfield2d==5501 | degfield2d==5500 | degfield2d==5504 | degfield2d==4007 | degfield2d==5505 | degfield2d==5599 | degfield2d==5506 | degfield2d==5507 | degfield2d==3702

label define majgrp_lbl2 1 `"Agriculture and Natural Resources"'
label define majgrp_lbl2 2 `"Arts"', add
label define majgrp_lbl2 3 `"Biology and Life Sciences"', add
label define majgrp_lbl2 4 `"Business"', add
label define majgrp_lbl2 5 `"Communications and Journalism"', add
label define majgrp_lbl2 6 `"Computers and Mathematics"', add
label define majgrp_lbl2 7 `"Education"', add
label define majgrp_lbl2 8 `"Engineering"', add
label define majgrp_lbl2 9 `"Health"', add
label define majgrp_lbl2 10 `"Humanities and Liberal Arts"', add
label define majgrp_lbl2 11 `"Industrial Arts and Consumer Services"', add
label define majgrp_lbl2 12 `"Law and Public Policy"', add
label define majgrp_lbl2 13 `"Physical Sciences"', add
label define majgrp_lbl2 14 `"Psychology and Social Work"', add
label define majgrp_lbl2 15 `"Social Science"', add
label values majgrp2 majgrp_lbl2 */

**** Turn this on to generate gender, race/ethnicity, and educational attainment variables
/* gen male=.
label var male "Male"
replace male=1 if sex==1
replace male=0 if sex==2
label define male_lbl 0 `"No"'
label define male_lbl 1 `"Yes"', add
label values male male_lbl

gen female=.
label var female "Female"
replace female=1 if sex==2
replace female=0 if sex==1
label define female_lbl 0 `"No"'
label define female_lbl 1 `"Yes"', add
label values female female_lbl

* race/ethnicity variable
gen racesimp=.
label var racesimp "Race/Ethnicity Simplified Version"
replace racesimp=1 if hispan==0 & race==1
replace racesimp=2 if hispan==0 & race==2
replace racesimp=4 if hispan==0 & race==4 | race==5 | race==6
replace racesimp=5 if hispan==0 & race==3 | race==7 | race==8 | race==9
replace racesimp=3 if hispan!=0
label define racesimp_lbl 1 `"White"'
label define racesimp_lbl 2 `"Black"', add
label define racesimp_lbl 3 `"Hispanic or Latino"', add
label define racesimp_lbl 4 `"Asian or Pacific Islander"', add
label define racesimp_lbl 5 `"Other Race"', add
label values racesimp racesimp_lbl

gen white=0
replace white=1 if racesimp==1
gen black=0
replace black=1 if racesimp==2
gen hisplat=0
replace hisplat=1 if racesimp==3
gen asian=0
replace asian=1 if racesimp==4
gen otherrace=0
replace otherrace=1 if racesimp==5

* educational attainment variables
replace educd=. if educd==1
gen educatt=.
label var educatt "Educational Attainment"
replace educatt=1 if educd<=100
replace educatt=2 if educd==101
replace educatt=3 if educd>101
label define educatt_lbl 1 `"Less Than Bachelors"'
label define educatt_lbl 2 `"Bachelors"', add
label define educatt_lbl 3 `"More Than Bachelors"', add
label values educatt educatt_lbl

gen educattd=.
label var educattd "Educational Attainment-Detailed"
replace educattd=1 if educd<=61
replace educattd=2 if educd==62 | educd==63 | educd==64
replace educattd=3 if educd==65 | educd==71
replace educattd=4 if educd==81 | educd==82 | educd==83
replace educattd=5 if educd==101
replace educattd=6 if educd==114
replace educattd=7 if educd==115
replace educattd=8 if educd==116
label define educattd_lbl 1 `"Less Than High School"'
label define educattd_lbl 2 `"High School"', add
label define educattd_lbl 3 `"Some College"', add
label define educattd_lbl 4 `"Associates Degree"', add
label define educattd_lbl 5 `"Bachelors Degree"', add
label define educattd_lbl 6 `"Masters Degree"', add
label define educattd_lbl 7 `"Professional Degree"', add
label define educattd_lbl 8 `"Doctoral Degree"', add
label values educattd educattd_lbl */

**** Alternaive Major Group ****
gen majgrpalt=majgrp
replace majgrpalt=majgrp if majgrp!=majgrp2 & majgrp!=. & majgrp2!=.

**** Replace missing values in edscor90 ****
replace edscor90=. if edscor90 > 100

**** Table 3 summary statistics ****
mean male female white black hisplat asian otherrace [pweight=perwt]
estat sd


mean age [pweight=perwt]
estat sd 
mean age if male==1 [pweight=perwt]
estat sd
mean age if female==1 [pweight=perwt]
estat sd
mean age if racesimp==1 [pweight=perwt]
estat sd
mean age if racesimp==2 [pweight=perwt]
estat sd
mean age if racesimp==3 [pweight=perwt]
estat sd
mean age if racesimp==4 [pweight=perwt]
estat sd
mean age if racesimp==5 [pweight=perwt]
estat sd

* generate married and urban indicators 
gen married=.
replace married=1 if marst==1 | marst==2
replace married=0 if marst==3 | marst==4 | marst==5 | marst==6
mean married if age>=25 [pweight=perwt]
mean married if age>=25 & male==1 [pweight=perwt]
mean married if age>=25 & female==1 [pweight=perwt]
mean married if age>=25 & racesimp==1 [pweight=perwt]
mean married if age>=25 & racesimp==2 [pweight=perwt]
mean married if age>=25 & racesimp==3 [pweight=perwt]
mean married if age>=25 & racesimp==4 [pweight=perwt]
mean married if age>=25 & racesimp==5 [pweight=perwt]


gen urban=.
replace urban=1 if metro==2 | metro==3 | metro==4
replace urban=0 if metro==1
mean urban [pweight=perwt]
mean urban if male==1 [pweight=perwt]
mean urban if female==1 [pweight=perwt]
mean urban if racesimp==1 [pweight=perwt]
mean urban if racesimp==2 [pweight=perwt]
mean urban if racesimp==3 [pweight=perwt]
mean urban if racesimp==4 [pweight=perwt]
mean urban if racesimp==5 [pweight=perwt]


prop nchild if age>=25 [pweight=perwt]
prop nchild if age>=25 & male==1 [pweight=perwt]
prop nchild if age>=25 & female==1 [pweight=perwt]
prop nchild if age>=25 & racesimp==1 [pweight=perwt]
prop nchild if age>=25 & racesimp==2 [pweight=perwt]
prop nchild if age>=25 & racesimp==3 [pweight=perwt]
prop nchild if age>=25 & racesimp==4 [pweight=perwt]
prop nchild if age>=25 & racesimp==5 [pweight=perwt]

*recode missing values as . and get summary stats for wage income 
replace incwage=. if incwage==999999
mean incwage if age>=16 & empstat==1 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & male==1 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & female==1 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & racesimp==1 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & racesimp==2 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & racesimp==3 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & racesimp==4 [pweight=perwt]
estat sd
mean incwage if age>=16 & empstat==1 & racesimp==5 [pweight=perwt]
estat sd

prop labforce if age>=16 [pweight=perwt]
prop labforce if age>=16 & male==1 [pweight=perwt]
prop labforce if age>=16 & female==1 [pweight=perwt]
prop labforce if age>=16 & racesimp==1 [pweight=perwt]
prop labforce if age>=16 & racesimp==2 [pweight=perwt]
prop labforce if age>=16 & racesimp==3 [pweight=perwt]
prop labforce if age>=16 & racesimp==4 [pweight=perwt]
prop labforce if age>=16 & racesimp==5 [pweight=perwt]

prop empstat if age>=16 [pweight=perwt]
prop empstat if age>=16 & male==1 [pweight=perwt]
prop empstat if age>=16 & female==1 [pweight=perwt]
prop empstat if age>=16 & racesimp==1 [pweight=perwt]
prop empstat if age>=16 & racesimp==2 [pweight=perwt]
prop empstat if age>=16 & racesimp==3 [pweight=perwt]
prop empstat if age>=16 & racesimp==4 [pweight=perwt]
prop empstat if age>=16 & racesimp==5 [pweight=perwt]


prop educatt if age>=25 [pweight=perwt]
prop educatt if age>=25 & male==1 [pweight=perwt]
prop educatt if age>=25 & female==1 [pweight=perwt]
prop educatt if age>=25 & racesimp==1 [pweight=perwt]
prop educatt if age>=25 & racesimp==2 [pweight=perwt]
prop educatt if age>=25 & racesimp==3 [pweight=perwt]
prop educatt if age>=25 & racesimp==4 [pweight=perwt]
prop educatt if age>=25 & racesimp==5 [pweight=perwt]

prop educattd if age>=25 [pweight=perwt]
prop educattd if age>=25 & male==1 [pweight=perwt]
prop educattd if age>=25 & female==1 [pweight=perwt]
prop educattd if age>=25 & racesimp==1 [pweight=perwt]
prop educattd if age>=25 & racesimp==2 [pweight=perwt]
prop educattd if age>=25 & racesimp==3 [pweight=perwt]
prop educattd if age>=25 & racesimp==4 [pweight=perwt]
prop educattd if age>=25 & racesimp==5 [pweight=perwt]

count if male==1
count if female==1
count if racesimp==1
count if racesimp==2
count if racesimp==3
count if racesimp==4
count if racesimp==5

**** Table 4 
*calculate percentages of major group share
prop majgrp [pweight=perwt]
 
*age
mean age if majgrp!=. [pweight=perwt]
mean age [pweight=perwt], over(majgrp)

*gender
mean male if majgrp!=. [pweight=perwt]
mean male [pweight=perwt], over(majgrp)
mean female if majgrp!=. [pweight=perwt]
mean female [pweight=perwt], over(majgrp)

*urban
mean urban if majgrp!=. [pweight=perwt]
mean urban [pweight=perwt], over(majgrp)

*married
mean married if majgrp!=. [pweight=perwt]
mean married [pweight=perwt], over(majgrp)

*race/ethnicity
mean white black hisplat asian otherrace if majgrp!=. [pweight=perwt]
mean white black hisplat asian otherrace [pweight=perwt], over(majgrp)

*kids
gen kids=.
replace kids=0 if nchild==0
replace kids=1 if nchild==1
replace kids=2 if nchild==2
replace kids=3 if nchild==3
replace kids=4 if nchild==4 | nchild==5 | nchild==6 | nchild==7 | nchild==8 | nchild==9
prop kids if majgrp!=. [pweight=perwt]
prop kids [pweight=perwt], over(majgrp)

* all wages
mean incwage if wkswork2>=5 & empstat==1 & majgrp!=. [pweight=perwt]
estat sd
mean incwage if wkswork2>=5 & empstat==1 [pweight=perwt], over(majgrp)
estat sd

* wages bachelor's only
mean incwage if wkswork2>=5 & empstat==1 & majgrp!=. & educd==101 [pweight=perwt]
estat sd
mean incwage if wkswork2>=5 & empstat==1 & educd==101 [pweight=perwt], over(majgrp)
estat sd

* calculate lfp/unemployment rate by major group
prop labforce if majgrp!=. [pweight=perwt]
prop labforce [pweight=perwt], over(majgrp)
prop empstat if majgrp!=. [pweight=perwt]
prop empstat [pweight=perwt], over(majgrp)

* educational attainment by major group
prop educatt if majgrp!=. [pweight=perwt]
prop educatt [pweight=perwt], over(majgrp)
prop educattd if majgrp!=. [pweight=perwt]
prop educattd [pweight=perwt], over(majgrp)

**** Figure 2 ****
graph hbar (mean) incwage [pweight = perwt] if wkswork2>=5 & empstat==1, over(majgrp)


**** Figure 3 ****
graph hbar (mean) incwage [aweight = perwt] if wkswork2>=5 & empstat==1 & educd==101, over(majgrp)

**** Generate 2-digit 1990occ codes ****
gen occ19902=.
replace occ19902=0 if occ1990>=3 & occ1990<=8 
replace occ19902=1 if occ1990>=13 & occ1990<=19
replace occ19902=2 if occ1990>=21 & occ1990<=29
replace occ19902=3 if occ1990>=33 & occ1990<=37
replace occ19902=4 if occ1990>=43 & occ1990<=48
replace occ19902=5 if occ1990>=53 & occ1990<=59
replace occ19902=6 if occ1990>=64 & occ1990<=69
replace occ19902=7 if occ1990>=73 & occ1990<=79
replace occ19902=8 if occ1990>=83 & occ1990<=89
replace occ19902=9 if occ1990>=95 & occ1990<=99
replace occ19902=10 if occ1990>=103 & occ1990<=106
replace occ19902=11 if occ1990>=113 & occ1990<=119
replace occ19902=12 if occ1990>=123 & occ1990<=128
replace occ19902=13 if occ1990>=139 & occ1990<=139
replace occ19902=14 if occ1990>=145 & occ1990<=149
replace occ19902=15 if occ1990>=150 & occ1990<=159
replace occ19902=16 if occ1990>=163 & occ1990<=169
replace occ19902=17 if occ1990>=173 & occ1990<=179
replace occ19902=18 if occ1990>=183 & occ1990<=189
replace occ19902=19 if occ1990>=193 & occ1990<=199
replace occ19902=20 if occ1990>=200 & occ1990<=208
replace occ19902=21 if occ1990>=213 & occ1990<=218
replace occ19902=22 if occ1990>=223 & occ1990<=229
replace occ19902=23 if occ1990>=233 & occ1990<=235
replace occ19902=24 if occ1990>=243 & occ1990<=243
replace occ19902=25 if occ1990>=253 & occ1990<=258
replace occ19902=27 if occ1990>=274 & occ1990<=277
replace occ19902=28 if occ1990>=283 & occ1990<=283
replace occ19902=30 if occ1990>=303 & occ1990<=308
replace occ19902=31 if occ1990>=313 & occ1990<=319
replace occ19902=32 if occ1990>=323 & occ1990<=329
replace occ19902=33 if occ1990>=335 & occ1990<=338
replace occ19902=34 if occ1990>=343 & occ1990<=349
replace occ19902=35 if occ1990>=354 & occ1990<=359
replace occ19902=36 if occ1990>=361 & occ1990<=368
replace occ19902=37 if occ1990>=373 & occ1990<=379
replace occ19902=38 if occ1990>=383 & occ1990<=389
replace occ19902=40 if occ1990>=405 & occ1990<=407
replace occ19902=41 if occ1990>=415 & occ1990<=418
replace occ19902=42 if occ1990>=423 & occ1990<=427
replace occ19902=43 if occ1990>=434 & occ1990<=439
replace occ19902=44 if occ1990>=443 & occ1990<=448
replace occ19902=45 if occ1990>=453 & occ1990<=459
replace occ19902=46 if occ1990>=461 & occ1990<=469
replace occ19902=47 if occ1990>=473 & occ1990<=479
replace occ19902=48 if occ1990>=483 & occ1990<=489
replace occ19902=49 if occ1990>=496 & occ1990<=498
replace occ19902=50 if occ1990>=503 & occ1990<=509
replace occ19902=51 if occ1990>=514 & occ1990<=519
replace occ19902=52 if occ1990>=523 & occ1990<=527
replace occ19902=53 if occ1990>=533 & occ1990<=539
replace occ19902=54 if occ1990>=543 & occ1990<=549
replace occ19902=55 if occ1990>=558 & occ1990<=558
replace occ19902=56 if occ1990>=563 & occ1990<=567
replace occ19902=57 if occ1990>=573 & occ1990<=579
replace occ19902=58 if occ1990>=583 & occ1990<=589
replace occ19902=59 if occ1990>=593 & occ1990<=599
replace occ19902=61 if occ1990>=614 & occ1990<=617
replace occ19902=62 if occ1990>=628 & occ1990<=628
replace occ19902=63 if occ1990>=634 & occ1990<=637
replace occ19902=64 if occ1990>=643 & occ1990<=649
replace occ19902=65 if occ1990>=653 & occ1990<=659
replace occ19902=66 if occ1990>=666 & occ1990<=669
replace occ19902=67 if occ1990>=674 & occ1990<=679
replace occ19902=68 if occ1990>=684 & occ1990<=688
replace occ19902=69 if occ1990>=693 & occ1990<=699
replace occ19902=70 if occ1990>=703 & occ1990<=709
replace occ19902=71 if occ1990>=713 & occ1990<=719
replace occ19902=72 if occ1990>=723 & occ1990<=729
replace occ19902=73 if occ1990>=733 & occ1990<=739
replace occ19902=74 if occ1990>=743 & occ1990<=749
replace occ19902=75 if occ1990>=753 & occ1990<=759
replace occ19902=76 if occ1990>=763 & occ1990<=769
replace occ19902=77 if occ1990>=773 & occ1990<=779
replace occ19902=78 if occ1990>=783 & occ1990<=789
replace occ19902=79 if occ1990>=796 & occ1990<=799
replace occ19902=80 if occ1990>=803 & occ1990<=809
replace occ19902=81 if occ1990>=813 & occ1990<=813
replace occ19902=82 if occ1990>=823 & occ1990<=829
replace occ19902=83 if occ1990>=834 & occ1990<=834
replace occ19902=84 if occ1990>=844 & occ1990<=848
replace occ19902=85 if occ1990>=853 & occ1990<=859
replace occ19902=86 if occ1990>=865 & occ1990<=869
replace occ19902=87 if occ1990>=874 & occ1990<=878
replace occ19902=88 if occ1990>=883 & occ1990<=889


**** Generate required education variable ****
replace occ1990=. if occ1990==999 | occ1990==905 |occ1990==991
gen educattd2=.
label var educattd2 "Educational Attainment-Detailed Version 3"
replace educattd2=1 if educattd==1 | educattd==2
replace educattd2=2 if educattd==3 | educattd==4
replace educattd2=3 if educattd==5
replace educattd2=4 if educattd==6 |educattd==7 | educattd==8
label define educattd2_lbl 1 `"High School or Less"'
label define educattd2_lbl 2 `"Some College"', add
label define educattd2_lbl 3 `"Bachelors"', add
label define educattd2_lbl 4 `"More Than Bachelors"', add
label values educattd2 educattd2_lbl

egen reqeduc= mode(educattd2) if labforce==2, by(occ19902)

* educational attainment indicators
gen highschoolorless=0
replace highschoolorless=1 if educattd2==1 
gen somecollege=0
replace somecollege=1 if educattd2==2
gen college=0
replace college=1 if educattd2==3
gen morecollege=0
replace morecollege=1 if educattd2==4

* mismatch variable
gen mismatch1=0
replace mismatch1=1 if educd==101 & reqeduc==1
gen mismatch2=0
replace mismatch2=1 if educd==101 & reqeduc==2
gen mismatch3=0
replace mismatch3=1 if educd>101 & reqeduc==1
gen mismatch4=0
replace mismatch4=1 if educd>101 & reqeduc==2

gen mismatch=0
replace mismatch=1 if educd==101 & reqeduc==1
replace mismatch=2 if educd==101 & reqeduc==2
replace mismatch=3 if educd>101 & reqeduc==1
replace mismatch=4 if educd>101 & reqeduc==2

gen mismatched=.
replace mismatched=0 if mismatch==0
replace mismatched=1 if mismatch==1 | mismatch==2 | mismatch==3 | mismatch==4
mean mismatched if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
mean mismatched if empstat==1 & age>=25 [pweight=perwt], over(majgrp)
graph hbar (mean) mismatched if empstat==1 & age>=25 [pweight=perwt], over(majgrp)

* alternative mismatch measures
gen mismatchedscor90=0
replace mismatchedscor90=1 if educd>=101 & edscor90<50
mean mismatchedscor90 if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
mean mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)
graph hbar (mean) mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)

drop mismatchedscor90
gen mismatchedscor90=0
replace mismatchedscor90=1 if educd>=101 & edscor90<66.67
mean mismatchedscor90 if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
mean mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)
graph hbar (mean) mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)

drop mismatchedscor90
gen mismatchedscor90=0
replace mismatchedscor90=1 if educd>=101 & edscor90<75
mean mismatchedscor90 if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
mean mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)
graph hbar (mean) mismatchedscor90 if empstat==1 & age>=25 [pweight=perwt], over(majgrp)


reg lnincwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatched indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 if wkswork2>=5 & empstat==1 [pweight=perwt], r

reg lnincwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatchedscor90 indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 if wkswork2>=5 & empstat==1 [pweight=perwt], r


**** Table 5 ****
prop mismatch if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
prop mismatch if empstat==1 & age>=25 [pweight=perwt], over(majgrp)

**** Figure 4 ****
gen averagemismatch=.
replace averagemismatch = 0 if mismatch==0
replace averagemismatch = 1 if mismatch==1 | mismatch==2 |mismatch==3 | mismatch==4

graph hbar (mean) averagemismatch if empstat==1 & age>=25, over(majgrp)

* majgrp indicators
gen indicmajgrp1=.
replace indicmajgrp1=1 if majgrp==1
replace indicmajgrp1=0 if majgrp!=1

gen indicmajgrp2=.
replace indicmajgrp2=1 if majgrp==2
replace indicmajgrp2=0 if majgrp!=2

gen indicmajgrp3=.
replace indicmajgrp3=1 if majgrp==3
replace indicmajgrp3=0 if majgrp!=3

gen indicmajgrp4=.
replace indicmajgrp4=1 if majgrp==4
replace indicmajgrp4=0 if majgrp!=4

gen indicmajgrp5=.
replace indicmajgrp5=1 if majgrp==5
replace indicmajgrp5=0 if majgrp!=5

gen indicmajgrp6=.
replace indicmajgrp6=1 if majgrp==6
replace indicmajgrp6=0 if majgrp!=6

gen indicmajgrp7=.
replace indicmajgrp7=1 if majgrp==7
replace indicmajgrp7=0 if majgrp!=7

gen indicmajgrp8=.
replace indicmajgrp8=1 if majgrp==8
replace indicmajgrp8=0 if majgrp!=8

gen indicmajgrp9=.
replace indicmajgrp9=1 if majgrp==9
replace indicmajgrp9=0 if majgrp!=9

gen indicmajgrp10=.
replace indicmajgrp10=1 if majgrp==10
replace indicmajgrp10=0 if majgrp!=10

gen indicmajgrp11=.
replace indicmajgrp11=1 if majgrp==11
replace indicmajgrp11=0 if majgrp!=11

gen indicmajgrp12=.
replace indicmajgrp12=1 if majgrp==12
replace indicmajgrp12=0 if majgrp!=12

gen indicmajgrp13=.
replace indicmajgrp13=1 if majgrp==13
replace indicmajgrp13=0 if majgrp!=13

gen indicmajgrp14=.
replace indicmajgrp14=1 if majgrp==14
replace indicmajgrp14=0 if majgrp!=14

gen indicmajgrp15=.
replace indicmajgrp15=1 if majgrp==15
replace indicmajgrp15=0 if majgrp!=15

* race indicators 
gen racew=0
replace racew=1 if racesimp==1

gen raceb=0
replace raceb=1 if racesimp==2

gen raceh=0
replace raceh=1 if racesimp==3

gen racea=0
replace racea=1 if racesimp==4

gen raceo=0
replace raceo=1 if racesimp==5

* cohort indicators
gen cohort90s = 0
replace cohort90s = 1 if birthyr >= 1990
gen cohort80s = 0
replace cohort80s = 1 if birthyr >= 1980 & birthyr<=1989
gen cohort70s = 0
replace cohort70s = 1 if birthyr >= 1970 & birthyr<=1979
gen cohort60s = 0
replace cohort60s = 1 if birthyr >= 1960 & birthyr<=1969
gen cohort50s = 0
replace cohort50s = 1 if birthyr >= 1950 & birthyr<=1959
gen cohort40s = 0
replace cohort40s = 1 if birthyr >= 1940 & birthyr<=1949
gen cohort30s = 0
replace cohort30s = 1 if birthyr >= 1930 & birthyr<=1939
gen cohort20s = 0
replace cohort20s = 1 if birthyr >= 1920 & birthyr<=1929
gen cohort10s = 0
replace cohort10s = 1 if birthyr >= 1910 & birthyr<=1919


**** Table 6 OLS Regression ****
gen lnincwage= ln(incwage)
gen agesq=age^2
reg lnincwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatch1 mismatch2 mismatch3 mismatch4 indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 if wkswork2>=5 & empstat==1 [pweight=perwt], r

**** OLS With State Dummies ****
reg lnincwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatch1 mismatch2 mismatch3 mismatch4 indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 state1 state2 state3 state4 state5 state6 state7 state8 state9 state10 state11 state12 state13 state14 state15 state16 state17 state18 state19 state20 state21 state22 state23 state24 state25 state26 state27 state28 state29 state30 state31 state32 state33 state34 state35 state36 state37 state38 state39 state40 state42 state43 state44 state45 state46 state47 state48 state49 state50 state51 if wkswork2>=5 & empstat==1 [pweight=perwt], r

**** Table 9 OLS for wages in levels ****
reg incwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatch1 mismatch2 mismatch3 mismatch4 indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 if wkswork2>=5 & empstat==1 [pweight=perwt], r

**** Table 10 Tobit ****
tobit incwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatch1 mismatch2 mismatch3 mismatch4 indicmajgrp1 indicmajgrp3 indicmajgrp4 indicmajgrp5 indicmajgrp6 indicmajgrp7 indicmajgrp8 indicmajgrp9 indicmajgrp10 indicmajgrp11 indicmajgrp12 indicmajgrp13 indicmajgrp14 indicmajgrp15 if wkswork2>=5 & empstat==1 [pweight=perwt], ll(0) vce(r)

**** Table 11 Alternative OLS Regression ****
/* Turn this on to gen and est alternaive major group specification
* majgrp indicators
gen indicmajgrpalt1=.
replace indicmajgrpalt1=1 if majgrpalt==1
replace indicmajgrpalt1=0 if majgrpalt!=1

gen indicmajgrpalt2=.
replace indicmajgrpalt2=1 if majgrpalt==2
replace indicmajgrpalt2=0 if majgrpalt!=2

gen indicmajgrpalt3=.
replace indicmajgrpalt3=1 if majgrpalt==3
replace indicmajgrpalt3=0 if majgrpalt!=3

gen indicmajgrpalt4=.
replace indicmajgrpalt4=1 if majgrpalt==4
replace indicmajgrpalt4=0 if majgrpalt!=4

gen indicmajgrpalt5=.
replace indicmajgrpalt5=1 if majgrpalt==5
replace indicmajgrpalt5=0 if majgrpalt!=5

gen indicmajgrpalt6=.
replace indicmajgrpalt6=1 if majgrpalt==6
replace indicmajgrpalt6=0 if majgrpalt!=6

gen indicmajgrpalt7=.
replace indicmajgrpalt7=1 if majgrpalt==7
replace indicmajgrpalt7=0 if majgrpalt!=7

gen indicmajgrpalt8=.
replace indicmajgrpalt8=1 if majgrpalt==8
replace indicmajgrpalt8=0 if majgrpalt!=8

gen indicmajgrpalt9=.
replace indicmajgrpalt9=1 if majgrpalt==9
replace indicmajgrpalt9=0 if majgrpalt!=9

gen indicmajgrpalt10=.
replace indicmajgrpalt10=1 if majgrpalt==10
replace indicmajgrpalt10=0 if majgrpalt!=10

gen indicmajgrpalt11=.
replace indicmajgrpalt11=1 if majgrpalt==11
replace indicmajgrpalt11=0 if majgrpalt!=11

gen indicmajgrpalt12=.
replace indicmajgrpalt12=1 if majgrpalt==12
replace indicmajgrpalt12=0 if majgrpalt!=12

gen indicmajgrpalt13=.
replace indicmajgrpalt13=1 if majgrpalt==13
replace indicmajgrpalt13=0 if majgrpalt!=13

gen indicmajgrpalt14=.
replace indicmajgrpalt14=1 if majgrpalt==14
replace indicmajgrpalt14=0 if majgrpalt!=14

gen indicmajgrpalt15=.
replace indicmajgrpalt15=1 if majgrpalt==15
replace indicmajgrpalt15=0 if majgrpalt!=15

reg lnincwage age agesq female raceb raceh racea raceo married urban nchild somecollege college morecolleg mismatch1 mismatch2 mismatch3 mismatch4 indicmajgrpalt1 indicmajgrpalt3 indicmajgrpalt4 indicmajgrpalt5 indicmajgrpalt6 indicmajgrpalt7 indicmajgrpalt8 indicmajgrpalt9 indicmajgrpalt10 indicmajgrpalt11 indicmajgrpalt12 indicmajgrpalt13 indicmajgrpalt14 indicmajgrpalt15 if wkswork2>=5 & empstat==1 [pweight=perwt], r */

**** Table 7 ****
mean incwage if empstat==1 & age>=25 & reqeduc==1 | reqeduc==2 & educattd<5 [pweight=perwt]
mean incwage if empstat==1 & age>=25 & mismatch==1 | mismatch==2 [pweight=perwt]
mean incwage if empstat==1 & age>=25 & mismatch==1 | mismatch==2 [pweight=perwt], over(majgrp)
mean incwage if empstat==1 & age>=25 & mismatch==3 | mismatch==4 [pweight=perwt], over(majgrp)


**** Table 8 ****

* Generate  stem variables 
gen stem=.
replace stem=1 if majgrp==3 | majgrp==6 | majgrp==8 | majgrp==13
replace stem=0 if majgrp==1 | majgrp==2 | majgrp==4 | majgrp==5 | majgrp==7 | majgrp==9 | majgrp==10 | majgrp==11 | majgrp==12 | majgrp==14 | majgrp==15

* Calculate percentages of major group share
mean stem [pweight=perwt]

*age sex urban married 
mean age if majgrp!=. [pweight=perwt]
mean age [pweight=perwt], over(stem)
mean male if majgrp!=. [pweight=perwt]
mean male [pweight=perwt], over(stem)
mean female if majgrp!=. [pweight=perwt]
mean female [pweight=perwt], over(stem)
mean urban if majgrp!=. [pweight=perwt]
mean urban [pweight=perwt], over(stem)
mean married if majgrp!=. [pweight=perwt]
mean married [pweight=perwt], over(stem)

*race/ethnicity & kids
prop racesimp [pweight=perwt], over(stem)

*kids
prop kids [pweight=perwt], over(stem)

* all wages
mean incwage if wkswork2>=5 & empstat==1 & majgrp!=. [pweight=perwt]
estat sd
mean incwage if wkswork2>=5 & empstat==1 [pweight=perwt], over(stem)
estat sd

* wages bachelor's only
mean incwage if wkswork2>=5 & empstat==1 & majgrp!=. & educd==101 [pweight=perwt]
estat sd
mean incwage if wkswork2>=5 & empstat==1 & educd==101 [pweight=perwt], over(stem)
estat sd

* calculate lfp/unemployment rate by major group
prop labforce if majgrp!=. [pweight=perwt]
prop labforce [pweight=perwt], over(stem)
prop empstat if majgrp!=. [pweight=perwt]
prop empstat [pweight=perwt], over(stem)

* educational attainment by major group
prop educatt if majgrp!=. [pweight=perwt]
prop educatt [pweight=perwt], over(stem)
prop educattd if majgrp!=. [pweight=perwt]
prop educattd [pweight=perwt], over(stem)

*mismatch
prop mismatch if empstat==1 & age>=25 & majgrp!=. [pweight=perwt]
prop mismatch if empstat==1 & age>=25 [pweight=perwt], over(stem)

*Figure 5 stem employed work more than 48 weeks
twoway (kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==1 [aweight=perwt], k(gau) sort)(kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==0 [aweight=perwt], k(gau) sort), title("Kernel Densities") legend(on order(1 "STEM" 2 "Non-STEM")) xtitle("Log Wage Inc")

*Figure 6 all four stem/non-stem/match/mismatch
twoway (kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==1 & mismatch==0 [aweight=perwt], k(gau) sort)(kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==1 & mismatch!=0 [aweight=perwt], k(gau) sort)(kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==0 & mismatch==0 [aweight=perwt], k(gau) sort)(kdensity lnincwage if wkswork2>=5 & empstat==1 & stem==0 & mismatch!=0 [aweight=perwt], k(gau) sort), title("Kernel Densities") legend(on order(1 "STEM Match" 2 "STEM Mismatch" 3 "Non-STEM Match" 4 "Non-STEM Mismatch")) xtitle("Log Wage Inc")


**** Table 9: OB Decomposition ****
oaxaca lnincwage age female raceb raceh racea raceo married urban nchild morecollege mismatch1 mismatch2 mismatch3 mismatch4 if empstat==1 & age>=25 , by(stem) vce(robust)

* w/o mimsmatch
oaxaca lnincwage age female raceb raceh racea raceo married urban nchild morecollege if empstat==1 & age>=25 , by(stem) vce(robust)

**** DFL Figure 7 ****
dfl stem age female morecollege raceb raceh racea raceo married urban nchild mismatch1 mismatch2 mismatch3 mismatch4 if wkswork2>=5 & empstat==1, outcome(lnincwage) gauss graph(ufactual) oaxaca

**** DFL Figure 8 ****
dfl stem female morecollege raceb raceh racea raceo married urban nchild if wkswork2>=5 & empstat==1, outcome(lnincwage) gauss step(age mismatched)

/*
dfl stem female morecollege age agesq raceb raceh racea raceo married urban nchild mismatch1 mismatch2 mismatch3 mismatch4 state1 state2 state3 state4 state5 state6 state7 state8 state9 state10 state11 state12 state13 state14 state15 state16 state17 state18 state19 state20 state21 state22 state23 state24 state25 state26 state27 state28 state29 state30 state31 state32 state33 state34 state35 state36 state37 state38 state39 state40 state42 state43 state44 state45 state46 state47 state48 state49 state50 state51 if wkswork2>=5 & empstat==1, outcome(lnincwage) graph(ufactual) gauss */



**** State Indicators ****
gen state1=0
replace state1=1 if stateicp==1 

gen state2=0
replace state2=1 if stateicp==2

gen state3=0
replace state3=1 if stateicp==3

gen state4=0
replace state4=1 if stateicp==4

gen state5=0
replace state5=1 if stateicp==5

gen state6=0
replace state6=1 if stateicp==6

gen state7=0
replace state7=1 if stateicp==11

gen state8=0
replace state8=1 if stateicp==12

gen state9=0
replace state9=1 if stateicp==13

gen state10=0
replace state10=1 if stateicp==14

gen state11=0
replace state11=1 if stateicp==21

gen state12=0
replace state12=1 if stateicp==22

gen state13=0
replace state13=1 if stateicp==23

gen state14=0
replace state14=1 if stateicp==24

gen state15=0
replace state15=1 if stateicp==25

gen state16=0
replace state16=1 if stateicp==31

gen state17=0
replace state17=1 if stateicp==32

gen state18=0
replace state18=1 if stateicp==33

gen state19=0
replace state19=1 if stateicp==34

gen state20=0
replace state20=1 if stateicp==35

gen state21=0
replace state21=1 if stateicp==36

gen state22=0
replace state22=1 if stateicp==37

gen state23=0
replace state23=1 if stateicp==40

gen state24=0
replace state24=1 if stateicp==41

gen state25=0
replace state25=1 if stateicp==42

gen state26=0
replace state26=1 if stateicp==43

gen state27=0
replace state27=1 if stateicp==44

gen state28=0
replace state28=1 if stateicp==45

gen state29=0
replace state29=1 if stateicp==46

gen state30=0
replace state30=1 if stateicp==47

gen state31=0
replace state31=1 if stateicp==48

gen state32=0
replace state32=1 if stateicp==49

gen state33=0
replace state33=1 if stateicp==51

gen state34=0
replace state34=1 if stateicp==52

gen state35=0
replace state35=1 if stateicp==53

gen state36=0
replace state36=1 if stateicp==54

gen state37=0
replace state37=1 if stateicp==56

gen state38=0
replace state38=1 if stateicp==61

gen state39=0
replace state39=1 if stateicp==62

gen state40=0
replace state40=1 if stateicp==63

gen state41=0
replace state41=1 if stateicp==64

gen state42=0
replace state42=1 if stateicp==65

gen state43=0
replace state43=1 if stateicp==66

gen state44=0
replace state44=1 if stateicp==67

gen state45=0
replace state45=1 if stateicp==68

gen state46=0
replace state46=1 if stateicp==71

gen state47=0
replace state47=1 if stateicp==72

gen state48=0
replace state48=1 if stateicp==73

gen state49=0
replace state49=1 if stateicp==81

gen state50=0
replace state50=1 if stateicp==82

gen state51=0
replace state51=1 if stateicp==98

log close

















