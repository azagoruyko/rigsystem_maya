//Maya ASCII 2026 scene
//Name: face_eyelids.ma
//Last modified: Tue, Nov 03, 2026 04:17:25 PM
//Codeset: 1251
requires maya "2026";
requires -nodeType "skeleposer" "skeleposer" "Unknown";
requires "stereoCamera" "10.0";
requires -nodeType "simpleSelector" -nodeType "renderSetupLayer" -nodeType "renderSetup"
		 -nodeType "collection" -nodeType "renderSettingsCollection" -nodeType "absOverride"
		 -nodeType "absUniqueOverride" "renderSetup.py" "1.0";
requires "Mayatomr" "2013.0 - 3.10.1.11 ";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "maya";
fileInfo "product" "Maya 2026";
fileInfo "version" "2026";
fileInfo "cutIdentifier" "202510291147-60ec9eda33";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "DEDA519A-44FE-88A6-B15C-60BE0C82673C";
createNode transform -s -n "persp";
	rename -uid "8DCF4356-4D3E-3DFF-4277-379CE6A38D01";
	setAttr ".v" no;
	setAttr -s 3 ".rlio";
	setAttr -s 3 ".rlio";
	setAttr ".t" -type "double3" 1.193922241746928 161.94583561959863 19.291429604897587 ;
	setAttr ".r" -type "double3" -10.660585098910081 -7.7119827447728238 7.0209669134023485e-16 ;
	setAttr ".s" -type "double3" 0.00095447319492794331 0.00095447319492794331 0.00095447319492794331 ;
	setAttr ".rp" -type "double3" 1.6845304834877758e-15 6.2791705623511449e-14 1.2873024250788868e-14 ;
	setAttr ".rpt" -type "double3" -4.3822704679452255e-14 1.2879062013619588e-14 -4.4159604867783264e-14 ;
	setAttr ".spt" -type "double3" 8.1644216971653221e-16 7.2340535421518455e-15 5.9283177406189179e-15 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "A6BC27AA-453E-F4CE-2D57-C0A1FFD6CDEF";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999979;
	setAttr ".coi" 9.7055251361344599;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" 3.6624749293909171 159.89567446058203 9.5068014066593527 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "E92F8C23-4F3A-E868-C85E-8B8043222547";
	setAttr ".v" no;
	setAttr -s 3 ".rlio";
	setAttr -s 3 ".rlio";
	setAttr ".t" -type "double3" -1.141674125413747 1000.3557456391165 -6.082828044891361 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "C3AC92C6-4307-296B-3C6B-34A50F96208D";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 934.91225030278179;
	setAttr ".ow" 51.675959123992293;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".tp" -type "double3" -1.141674125413747 65.443495336334777 -6.082828044891361 ;
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "FEE95FEF-40CA-0FB8-32A6-0BAF38C673DA";
	setAttr ".v" no;
	setAttr -s 3 ".rlio";
	setAttr -s 3 ".rlio";
	setAttr ".t" -type "double3" -1.141674125413747 65.443495336334777 1011.1412785720808 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "0A16C83E-48D3-25BB-BA81-C0B6AC04394F";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1017.2241066169721;
	setAttr ".ow" 179.32143665662738;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".tp" -type "double3" -1.141674125413747 65.443495336334777 -6.082828044891361 ;
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "57D74860-4E79-7BDA-38EE-6886F6C3628A";
	setAttr ".v" no;
	setAttr -s 3 ".rlio";
	setAttr -s 3 ".rlio";
	setAttr ".t" -type "double3" 1013.8306434074894 68.514802194916186 -3.6598611795067182 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "1EA002FB-4CCD-D526-2E72-B4A9FC670EB0";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1013.801152445841;
	setAttr ".ow" 102.19876399254161;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".tp" -type "double3" 0.029490961648489744 61.801393117675161 -17.026725336923008 ;
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "eyelids_others";
	rename -uid "250B3FBB-4316-4091-C9AF-EFBA6DF902C5";
	setAttr -l on -k off ".tx";
	setAttr -l on -k off ".ty";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode transform -n "L_eyelid_upper_main_curve" -p "eyelids_others";
	rename -uid "69C2897E-4C60-5EDB-C3D2-9295311DDBA7";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_main_curveShape" -p "L_eyelid_upper_main_curve";
	rename -uid "8A81E313-4C55-0014-C50E-458A8FDC2243";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_upper_main_curveShapeOrig" -p "L_eyelid_upper_main_curve";
	rename -uid "52AB1A89-4712-61B0-56E8-1FA48621DA94";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr -s 5 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[2].gtagnm" -type "string" "L_eyelids_inner_cluster";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[0:4]";
	setAttr ".gtag[3].gtagnm" -type "string" "L_eyelids_inner_cluster_1";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[0:5]";
	setAttr ".gtag[4].gtagnm" -type "string" "L_eyelids_outer_cluster";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "cv[4:8]";
	setAttr ".tw" yes;
createNode transform -n "L_eyelid_upper_major_curve" -p "eyelids_others";
	rename -uid "681A4660-44D8-7416-CF04-52A8DE289F52";
	setAttr ".v" no;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_major_curveShape" -p "L_eyelid_upper_major_curve";
	rename -uid "D5521DFA-4874-C9E8-75AA-43B8469876B8";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_upper_major_curveShapeOrig1" -p "L_eyelid_upper_major_curve";
	rename -uid "2D092F75-439D-3E2E-21AD-CBB6FEF34BCD";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".tw" yes;
createNode transform -n "L_eyelid_lower_main_curve" -p "eyelids_others";
	rename -uid "AD2AF700-4D63-023A-D1B5-6792915DAB0F";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_lower_main_curveShape" -p "L_eyelid_lower_main_curve";
	rename -uid "2AEE0C95-4053-EBD4-AC8C-22A2EB54FE89";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_lower_main_curveShapeOrig" -p "L_eyelid_lower_main_curve";
	rename -uid "67A6EB61-4E3D-EB3D-96CD-43BD629D69ED";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr -s 5 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[2].gtagnm" -type "string" "L_eyelids_inner_cluster";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[0:4]";
	setAttr ".gtag[3].gtagnm" -type "string" "L_eyelids_inner_cluster_1";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[0:5]";
	setAttr ".gtag[4].gtagnm" -type "string" "L_eyelids_outer_cluster";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "cv[4:8]";
	setAttr ".tw" yes;
createNode transform -n "L_eyelid_lower_major_curve" -p "eyelids_others";
	rename -uid "E0619393-4598-7029-C424-A6B68568D6E7";
	setAttr ".v" no;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_lower_major_curveShape" -p "L_eyelid_lower_major_curve";
	rename -uid "08B1402C-44E3-D44B-FC46-39A52876D3D6";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_lower_major_curveShapeOrig1" -p "L_eyelid_lower_major_curve";
	rename -uid "6DE06C53-44DF-FEB3-DF84-EFBF0447FA88";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".tw" yes;
createNode transform -n "R_eyelid_upper_main_curve" -p "eyelids_others";
	rename -uid "24295527-45F0-6DF7-8DC8-9C99B25175CF";
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_upper_main_curveShape" -p "R_eyelid_upper_main_curve";
	rename -uid "1A265EAD-4E21-140E-B759-B3A5E756D78B";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_upper_main_curveShapeOrig1" -p "R_eyelid_upper_main_curve";
	rename -uid "E975EE1F-4A3E-0E53-81CD-349F047DC152";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".tw" yes;
createNode transform -n "R_eyelid_upper_major_curve" -p "eyelids_others";
	rename -uid "3514F017-4F68-EBE8-4A96-E281FBBE1127";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_upper_major_curveShape" -p "R_eyelid_upper_major_curve";
	rename -uid "A68FC214-4DED-193B-334D-7AB24D2E33E4";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_upper_major_curveShapeOrig2" -p "R_eyelid_upper_major_curve";
	rename -uid "F9305538-40C9-053E-08D6-D89E8E543811";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".gtag[0].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".tw" yes;
createNode transform -n "R_eyelid_lower_main_curve" -p "eyelids_others";
	rename -uid "02A4B553-4A1F-3710-E023-B5AC9C4D86A8";
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_lower_main_curveShape" -p "R_eyelid_lower_main_curve";
	rename -uid "0B39DB1A-4CF9-25BC-E52F-1BB944DD8598";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_lower_main_curveShapeOrig1" -p "R_eyelid_lower_main_curve";
	rename -uid "11DB5193-4131-0DA2-B94A-FC9A52C4D1B7";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".tw" yes;
createNode transform -n "R_eyelid_lower_major_curve" -p "eyelids_others";
	rename -uid "B5C6579A-4FA5-61CE-756B-96914621F26C";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_lower_major_curveShape" -p "R_eyelid_lower_major_curve";
	rename -uid "7CEB5C23-4542-C8A2-56B2-229916079B39";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_lower_major_curveShapeOrig2" -p "R_eyelid_lower_major_curve";
	rename -uid "81725D7D-4081-4195-C123-0ABD12F4BAA5";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".gtag[0].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".tw" yes;
createNode transform -n "eyelids_internal";
	rename -uid "0EA42E59-49E7-0EC0-123D-D58840AB1035";
	setAttr -l on -k off ".tx";
	setAttr -l on -k off ".ty";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode transform -n "L_eyelid_upper_curve" -p "eyelids_internal";
	rename -uid "602B17B5-4855-8B09-6443-2685317C6640";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_curveShape" -p "L_eyelid_upper_curve";
	rename -uid "8F8C5411-4901-4CD3-9E02-50A75776771B";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_upper_curveShapeOrig" -p "L_eyelid_upper_curve";
	rename -uid "DDEF4BFC-42A6-62DD-BBD4-00B0C4F5163F";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		1.9300700426101685 159.01676940917969 9.7134771347045898
		1.9391100406646729 159.13117980957031 9.7296876907348633
		1.9840199947357178 159.381591796875 9.7947473526000977
		2.1608700752258301 159.79087829589844 9.9078168869018555
		2.5078599452972412 160.23246765136719 10.05329704284668
		2.9064300060272217 160.53038024902344 10.142777442932129
		3.4081199169158936 160.717529296875 10.148807525634766
		3.895050048828125 160.76513671875 10.031517028808594
		4.3662700653076172 160.72589111328125 9.8140172958374023
		4.7961897850036621 160.58627319335938 9.4876270294189453
		5.1275901794433594 160.37307739257812 9.1475677490234375
		5.3185701370239258 160.21199035644531 8.9187173843383789
		5.3948798179626465 160.14125061035156 8.8234472274780273
		;
createNode transform -n "L_eyelid_lower_curve" -p "eyelids_internal";
	rename -uid "EE61F3FE-48EC-41C0-F9CC-C6B3BC47EF0C";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_lower_curveShape" -p "L_eyelid_lower_curve";
	rename -uid "A08F320D-40BC-A164-7E9C-159201EF2262";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_lower_curveShapeOrig" -p "L_eyelid_lower_curve";
	rename -uid "70EEC4A3-44B4-FE95-E430-ED82092155B6";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		1.9300700426101685 159.01676940917969 9.7134771347045898
		2.0076799392700195 158.98654174804688 9.7040071487426758
		2.2436099052429199 158.89530944824219 9.6854276657104492
		2.5890800952911377 158.78559875488281 9.6566371917724609
		3.0129899978637695 158.6917724609375 9.6178369522094727
		3.5789000988006592 158.65280151367188 9.5263376235961914
		4.07427978515625 158.70249938964844 9.4061174392700195
		4.5142698287963867 158.87088012695312 9.2428874969482422
		4.8382601737976074 159.10865783691406 9.0996074676513672
		5.0426301956176758 159.36228942871094 8.9918670654296875
		5.2165298461914062 159.64884948730469 8.9035272598266602
		5.3286399841308594 159.9036865234375 8.8458776473999023
		5.3948798179626465 160.14125061035156 8.8234472274780273
		;
createNode transform -n "L_eyelid_upper_major_curveBaseWire" -p "eyelids_internal";
	rename -uid "056F7520-4FA8-4AE8-B4A0-CEBF15152221";
	setAttr ".v" no;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_major_curveBaseWireShape" -p "L_eyelid_upper_major_curveBaseWire";
	rename -uid "3A3EAA3E-4B77-13A9-8D1A-DCA389CF770D";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "L_eyelid_lower_major_curveBaseWire" -p "eyelids_internal";
	rename -uid "6433FD80-4695-2536-CFDC-9C88D7D76935";
	setAttr ".v" no;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_lower_major_curveBaseWireShape" -p "L_eyelid_lower_major_curveBaseWire";
	rename -uid "465EC4ED-40A2-ACD2-8A2D-A5B450B4722B";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "L_eyelids_avg_curve" -p "eyelids_internal";
	rename -uid "11211097-4705-14D0-B475-EF98AED3D29B";
	setAttr ".v" no;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelids_avg_curveShape" -p "L_eyelids_avg_curve";
	rename -uid "DDD564E0-4E65-D402-E2FC-1EA07248A3A9";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelids_avg_curveShapeOrig1" -p "L_eyelids_avg_curve";
	rename -uid "3DFB0954-4779-9112-9F3C-63A2F5B82602";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		1.9300700426101685 159.01676940917969 9.7134771347045898
		1.9733949899673462 159.05886077880859 9.7168474197387695
		2.1138149499893188 159.13845062255859 9.7400875091552734
		2.3749750852584839 159.28823852539062 9.7822270393371582
		2.7604249715805054 159.46212005615234 9.8355669975280762
		3.2426650524139404 159.59159088134766 9.8345575332641602
		3.7411998510360718 159.71001434326172 9.7774624824523926
		4.2046599388122559 159.81800842285156 9.637202262878418
		4.6022651195526123 159.91727447509766 9.4568123817443848
		4.9194099903106689 159.97428131103516 9.2397470474243164
		5.1720600128173828 160.01096343994141 9.0255475044250488
		5.3236050605773926 160.05783843994141 8.8822975158691406
		5.3948798179626465 160.14125061035156 8.8234472274780273
		;
createNode transform -n "R_eyelids_avg_curve" -p "eyelids_internal";
	rename -uid "0E8BC56B-4D41-B4FA-3436-B589D00E58A7";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelids_avg_curveShape" -p "R_eyelids_avg_curve";
	rename -uid "9CC07565-46FA-56D6-2109-48A6D65A146C";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelids_avg_curveShapeOrig1" -p "R_eyelids_avg_curve";
	rename -uid "F720A827-4A3D-CDA8-3236-8EB4D527F7CF";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		-1.9300700426101685 159.01676940917969 9.7134771347045898
		-1.9733943343162537 159.05886840820312 9.7168455123901367
		-2.1138136982917786 159.13848114013672 9.7400827407836914
		-2.3749735355377197 159.28830718994141 9.7822179794311523
		-2.7604235410690308 159.46222686767578 9.8355541229248047
		-3.2426638603210449 159.59169006347656 9.8345451354980469
		-3.7411988973617554 159.71006011962891 9.7774543762207031
		-4.204659104347229 159.81800842285156 9.6371989250183105
		-4.602264404296875 159.91724395751953 9.4568123817443848
		-4.9194092750549316 159.9742431640625 9.2397480010986328
		-5.1720592975616455 160.01091003417969 9.0255484580993652
		-5.3236043453216553 160.05780029296875 8.8822979927062988
		-5.3948798179626465 160.14125061035156 8.8234472274780273
		;
createNode transform -n "R_eyelid_upper_curve" -p "eyelids_internal";
	rename -uid "0D9F5DFA-47AC-6C35-2357-D1A10A6DC102";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_upper_curveShape" -p "R_eyelid_upper_curve";
	rename -uid "DDD69725-41A1-4EAA-9E16-D3AEB8F39ED7";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_upper_curveShapeOrig1" -p "R_eyelid_upper_curve";
	rename -uid "433BE38C-4826-170F-57E4-6DA4318B5ECD";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		-1.9300700426101696 159.01676940917969 9.7134771347045898
		-1.939110040664674 159.13117980957031 9.7296876907348633
		-1.9840199947357189 159.381591796875 9.7947473526000977
		-2.1608700752258314 159.79087829589844 9.9078168869018555
		-2.5078599452972425 160.23246765136719 10.05329704284668
		-2.906430006027223 160.53038024902344 10.142777442932129
		-3.4081199169158949 160.717529296875 10.148807525634766
		-3.8950500488281263 160.76513671875 10.031517028808594
		-4.3662700653076181 160.72589111328125 9.8140172958374023
		-4.796189785003663 160.58627319335938 9.4876270294189453
		-5.1275901794433603 160.37307739257812 9.1475677490234375
		-5.3185701370239267 160.21199035644531 8.9187173843383789
		-5.3948798179626474 160.14125061035156 8.8234472274780273
		;
createNode transform -n "R_eyelid_lower_curve" -p "eyelids_internal";
	rename -uid "BA8A38F2-49C7-E8BE-0046-5285D33CD154";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_lower_curveShape" -p "R_eyelid_lower_curve";
	rename -uid "F2E57F22-41FD-C8C8-2095-23B7B05B32F9";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_lower_curveShapeOrig1" -p "R_eyelid_lower_curve";
	rename -uid "1F71445C-4317-4853-AAC4-228B5E846D2D";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		-1.9300700426101696 159.01676940917969 9.7134771347045898
		-2.0076799392700209 158.98654174804688 9.7040071487426758
		-2.2436099052429213 158.89530944824219 9.6854276657104492
		-2.589080095291139 158.78559875488281 9.6566371917724609
		-3.0129899978637709 158.6917724609375 9.6178369522094727
		-3.5789000988006605 158.65280151367188 9.5263376235961914
		-4.0742797851562509 158.70249938964844 9.4061174392700195
		-4.5142698287963876 158.87088012695312 9.2428874969482422
		-4.8382601737976083 159.10865783691406 9.0996074676513672
		-5.0426301956176767 159.36228942871094 8.9918670654296875
		-5.2165298461914071 159.64884948730469 8.9035272598266602
		-5.3286399841308603 159.9036865234375 8.8458776473999023
		-5.3948798179626474 160.14125061035156 8.8234472274780273
		;
createNode transform -n "R_eyelid_upper_major_curveBaseWire" -p "eyelids_internal";
	rename -uid "64D4D6A7-4E84-0710-5787-9CB5A392E1C4";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_upper_major_curveBaseWireShape" -p "R_eyelid_upper_major_curveBaseWire";
	rename -uid "1F85665B-4D21-73D9-B23C-B1B3975E5AD4";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "R_eyelid_lower_major_curveBaseWire" -p "eyelids_internal";
	rename -uid "B4CE62E5-4F02-5524-EA5B-399192C7B54E";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_lower_major_curveBaseWireShape" -p "R_eyelid_lower_major_curveBaseWire";
	rename -uid "25E077B6-4D03-144D-95F1-28AACBFCD731";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "L_eyelid_upper_fold_curve" -p "eyelids_internal";
	rename -uid "EB05669B-467E-965F-1333-72A22895FD9C";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_fold_curveShape" -p "L_eyelid_upper_fold_curve";
	rename -uid "20105213-49A3-998D-02C5-8AB39EC45587";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_eyelid_upper_fold_curveShapeOrig" -p "L_eyelid_upper_fold_curve";
	rename -uid "083A3D3D-48B2-7B4E-B1A7-A49392DB3C8C";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 0.16666666666666666 0.33333333333333331 0.5 0.66666666666666663 0.83333333333333337
		 1 1 1
		9
		1.9567903280258179 160.07392883300781 10.037179946899414
		2.1128216826999093 160.2814849502532 10.058330138111062
		2.4318173441200566 160.71849299965479 10.123295395486938
		3.1737123976854882 161.0241553828364 10.18618891080779
		3.9631958122416031 161.15126744833833 10.056541092439859
		4.6581484091647676 160.99731032318456 9.693611371676937
		5.2537740247086822 160.73588220187753 9.2206363540228491
		5.49828603830644 160.38106906162659 8.9002520086479961
		5.5974702835083008 160.18218994140625 8.7589759826660156
		;
createNode transform -n "R_eyelid_upper_fold_curve" -p "eyelids_internal";
	rename -uid "50C26511-4065-FBAC-D6A6-D7B3EA172707";
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_eyelid_upper_fold_curveShape" -p "R_eyelid_upper_fold_curve";
	rename -uid "0B07EECB-4F4F-646C-8DE6-6DA2E082EDD9";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_eyelid_upper_fold_curveShapeOrig1" -p "R_eyelid_upper_fold_curve";
	rename -uid "850B941E-41EA-D7A2-14EF-44BB40B938C1";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 0.16666666666666666 0.33333333333333331 0.5 0.66666666666666663 0.83333333333333337
		 1 1 1
		9
		-1.9567903280258199 160.07392883300781 10.03717994689943
		-2.1128216826999107 160.2814849502532 10.058330138111074
		-2.431817344120057 160.71849299965481 10.123295395486945
		-3.1737123976854873 161.02415538283643 10.186188910807788
		-3.9631958122416022 161.15126744833836 10.056541092439858
		-4.6581484091647729 160.99731032318459 9.6936113716769405
		-5.2537740247086919 160.73588220187756 9.2206363540228544
		-5.4982860383064578 160.38106906162662 8.9002520086480086
		-5.5974702835083221 160.18218994140628 8.7589759826660298
		;
createNode joint -n "L_eyelids_joint";
	rename -uid "2FAC74E4-4A3C-9FCB-B78C-9FB5315E2E14";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr -k on ".t";
	setAttr -k on ".r";
	setAttr -k on ".s";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 11.654891448164706 17.922380116406082 8.8641170773635203 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.94011033615031259 0.14661421578272579 -0.307728496557863 0
		 -0.08949089223021979 0.97726425089461388 0.19221332974387476 0 0.32891326527093051 -0.1531628403164578 0.93185686040024918 0
		 3.0255667090717608 160.14829975760941 7.3534092757252818 1;
	setAttr ".ds" 3;
createNode parentConstraint -n "L_eyelids_joint_parentConstraint1" -p "L_eyelids_joint";
	rename -uid "5583DDFE-4CAB-5293-45CD-35BFF9FB1C10";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 5.773159728050814e-15 2.8421709430404007e-14 
		-8.8817841970012523e-16 ;
	setAttr ".tg[0].tor" -type "double3" 11.654891448164715 17.922380116406075 8.8641170773635167 ;
	setAttr ".lr" -type "double3" 8.1501713712502619e-15 -7.1562480332929135e-15 -1.9878466759146984e-15 ;
	setAttr ".rst" -type "double3" 3.0255667096694476 160.14829975760546 7.3534092755652836 ;
	setAttr ".rsrr" -type "double3" -1.5902773407317584e-15 -3.0811623476677822e-15 
		-7.9513867036587919e-16 ;
	setAttr ".rdta" -type "double3" -3.4694469519536142e-17 -1.0928757898653886e-16 
		3.4694469519536165e-18 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_main_joint" -p "L_eyelids_joint";
	rename -uid "7035C2A4-41D9-B036-A77D-30B88B105C3E";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -8.9150458492204105 -2.4658806027995999 -6.0427603810805675 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.95758444338997473 0.036292829450375819 -0.28585811919201848 0
		 -0.034776357547506374 0.99934119825537326 0.010381446201859351 0 0.28604656742083145 -7.2219112356997073e-09 0.9582157175014191 0
		 3.895050048088061 160.76532513256254 10.031730139191628 1;
createNode parentConstraint -n "L_eyelid_upper_main_joint_parentConstraint1" -p "L_eyelid_upper_main_joint";
	rename -uid "62206956-4077-EDFB-CAEC-958DBFE61F4E";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_main_controlW0" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 4.4408920985006262e-15 2.8421709430404007e-14 
		7.1054273576010019e-15 ;
	setAttr ".tg[0].tor" -type "double3" 4.1400757882504158e-07 -7.9513867036587919e-16 
		1.1769852972569456e-07 ;
	setAttr ".lr" -type "double3" 1.0526128982587532e-14 -2.3927696730866574 -2.0798825997130992 ;
	setAttr ".rst" -type "double3" 0.083717269050655574 1.0397698796235488 2.6871211859499429 ;
	setAttr ".rsrr" -type "double3" -2.0700377852607078e-07 -1.2368012501202258e-05 
		-5.8849266200890432e-08 ;
	setAttr ".rdta" -type "double3" -7.2257949338628532e-09 -2.1586254004293565e-07 
		-2.0542268848186517e-09 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_lower_main_joint" -p "L_eyelids_joint";
	rename -uid "F8623D9A-4752-EF87-8515-A9BEC0710B72";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -1.1526423311266616 1.3914355163996701 -8.5253753934697354 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.93472422098357999 0.0038364527021676445 -0.35535322193178953 0
		 0.043781482019598875 0.99108106104096805 0.12586306955606805 0 0.35266671594978621 -0.13320515033801111 0.92621950712809997 0
		 4.0744352278648419 158.70271630738094 9.4062754624519407 1;
createNode parentConstraint -n "L_eyelid_lower_main_joint_parentConstraint1" -p "L_eyelid_lower_main_joint";
	rename -uid "CD403176-4637-8066-D10E-51A5CA1DD34A";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_lower_main_controlW0" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 0 0.00010170025694833384 0.00042814027554172185 ;
	setAttr ".lr" -type "double3" -7.6700445052432666 -3.5968501282604763 0.26227938258005379 ;
	setAttr ".rst" -type "double3" 0.14242158265506077 -1.112218054616136 2.4792041458906251 ;
	setAttr ".rsrr" -type "double3" -1.9137487144674691e-09 -1.2279978918385022e-05 
		-10.226455325466064 ;
	setAttr ".rdta" -type "double3" -6.6802377438348998e-11 -2.1432606412118244e-07 
		-0.17848531623749106 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_major_1_joint" -p "L_eyelids_joint";
	rename -uid "E69AAFBF-4F25-B854-DA2D-BA88A170F545";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -10.484106850031285 -31.693786160963818 -0.8764538339230159 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.8985188859625951 0.37995896047950556 0.21976123388775975 0
		 -0.39586193173155421 0.91776092733856618 0.031752342534316053 0 -0.18962368674377028 -0.11552518600715508 0.97503681408637732 0
		 2.5140409796785295 160.22656428320465 10.051880067033146 1;
createNode parentConstraint -n "L_eyelid_upper_major_1_joint_parentConstraint1" -p
		 "L_eyelid_upper_major_1_joint";
	rename -uid "74AADE52-4801-1D3F-1CD1-289BC66694B2";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_major_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tor" -type "double3" 0 0 1.4579005486325084e-15 ;
	setAttr ".lr" -type "double3" 5.9382179206836119 -0.30365902649026361 20.533060258531741 ;
	setAttr ".rst" -type "double3" 3.8950500488281241 160.76513671875 10.031517028808599 ;
	setAttr ".rsrr" -type "double3" 6.5598940305185035e-15 9.425965155831452e-15 -1.1181637552020171e-15 ;
	setAttr ".rdta" -type "double3" 9.7144514654701197e-17 5.377642775528102e-17 -2.8622937353617317e-17 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_major_2_joint" -p "L_eyelids_joint";
	rename -uid "BB0BEF68-4EF9-4ECD-2326-CE8EB2818E64";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -9.635255736414468 22.327995938674274 -10.119747760590146 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.7286919776432077 -0.23044526957281014 -0.64490540348949288 0
		 0.16205673077691166 0.97296338898829871 -0.16455959315185384 0 0.66539132676067436 0.015401994024113658 0.74633582310629476 0
		 4.7904300965275768 160.57842200109096 9.4851362607845466 1;
createNode parentConstraint -n "L_eyelid_upper_major_2_joint_parentConstraint1" -p
		 "L_eyelid_upper_major_2_joint";
	rename -uid "3D44A39D-4BCC-C9D4-3533-869F5200249A";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_major_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 2.3172897605761764e-14 -5.3293864092020312e-15 -15.208346321771032 ;
	setAttr ".rst" -type "double3" 3.8950500488281241 160.76513671875 10.031517028808599 ;
	setAttr ".rsrr" -type "double3" 3.0314661807699147e-15 -6.4185705559026931e-15 2.5096564283423067e-15 ;
	setAttr ".rdta" -type "double3" 9.7144514654701197e-17 5.377642775528102e-17 -2.8622937353617317e-17 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_lower_major_1_joint" -p "L_eyelids_joint";
	rename -uid "19102A39-4312-1591-1AD5-809B3C07924D";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -1.1980577224198055 -10.93135394940343 -9.2659961058529596 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.98752858492191464 -0.041471184760164606 -0.15187967209837228 0
		 0.060021488627181901 0.99099802734890818 0.11966758413851647 0 0.14554969895227496 -0.12729120403688607 0.98112804185271441 0
		 3.0136264639443988 158.69908706294007 9.6143748741644934 1;
createNode parentConstraint -n "L_eyelid_lower_major_1_joint_parentConstraint1" -p
		 "L_eyelid_lower_major_1_joint";
	rename -uid "BFEB1101-44CF-F2F6-28CF-DFB6E5B59895";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_major_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 0 0 1.7763568394002505e-15 ;
	setAttr ".tg[0].tor" -type "double3" -7.9513867036587919e-16 -1.5902773407317584e-15 
		7.1562480332929135e-15 ;
	setAttr ".lr" -type "double3" 1.3815534397607149e-14 3.0314661807699151e-15 -1.249858597481366e-14 ;
	setAttr ".rst" -type "double3" 3.0129897594451904 158.69175720214844 9.6173725128173828 ;
	setAttr ".rsrr" -type "double3" 1.2175560889977523e-15 1.2175560889977523e-15 -6.460501696722767e-15 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_lower_major_2_joint" -p "L_eyelids_joint";
	rename -uid "AD38DF49-4FF1-132A-384E-F890030CB44F";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" 2.8053925275713865 21.993659896537149 -7.4149676528585111 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.60181563042532993 0.71228278526797006 -0.36120794673797729 0
		 -0.45543162717087748 0.67761761332949499 0.57742220521739984 0 0.65604876339205886 -0.18299618552456509 0.73219697905359393 0
		 5.042758762509818 159.36287408599392 8.9929819012288359 1;
createNode parentConstraint -n "L_eyelid_lower_major_2_joint_parentConstraint1" -p
		 "L_eyelid_lower_major_2_joint";
	rename -uid "57FDE83D-4B34-6EF2-89EA-9AAA883F39D2";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_major_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 1.7763568394002505e-15 0 0 ;
	setAttr ".tg[0].tor" -type "double3" -3.180554681463516e-15 1.2722218725854064e-14 
		-2.3854160110976372e-15 ;
	setAttr ".lr" -type "double3" 2.8330392464528402e-14 4.4908012998494954e-14 42.040275833180097 ;
	setAttr ".rst" -type "double3" 5.0426301956176776 159.36227416992188 8.9914035797119123 ;
	setAttr ".rsrr" -type "double3" 5.5908187760100865e-15 -2.4848083448933715e-16 -1.2123155725845767e-32 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelids_corner_inner_joint" -p "L_eyelids_joint";
	rename -uid "144AAB52-4EF0-1C9D-004E-B6BEE84542AC";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -8.8463571755328552 -5.1569857400848083 -7.7306924774227381 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.96934876657752567 2.4614665092639876e-08 -0.24568876395681805 0
		 -2.539299129994399e-08 0.99999999999999922 2.4980018054066022e-16 0 0.24568876395681799 6.238772221056621e-09 0.96934876657752589 0
		 1.9463516466569155 159.02409893627083 9.6970171569108494 1;
createNode parentConstraint -n "L_eyelids_corner_inner_joint_parentConstraint1" -p
		 "L_eyelids_corner_inner_joint";
	rename -uid "23159346-457A-23F4-AE26-3FB5ACF5DB36";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelids_corner_inner_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 0.10427772998809681 0.049652099609346578 -0.11746692657471058 ;
	setAttr ".tg[0].tor" -type "double3" 0 14.222541180413742 1.4547017852491876e-06 ;
	setAttr ".lr" -type "double3" -3.0177805683817634e-08 1.2374889959329669e-05 1.1906612457680083e-07 ;
	setAttr ".rst" -type "double3" 1.9463516473770128 159.02391052246091 9.6968040466308558 ;
	setAttr ".rsrr" -type "double3" -4.7393957994334661e-23 7.8406726410132397e-47 1.895758319773386e-22 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelids_corner_outer_joint" -p "L_eyelids_joint";
	rename -uid "81CE2D15-45BB-2A0A-3DA1-3F9606D6D14F";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -10.178588558344074 29.921123117867193 -13.649768827326362 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.64603215178084472 1.6404689454074806e-08 -0.76331019832399138 0
		 -2.5392991417905186e-08 0.99999999999999922 3.3306690738754696e-16 0 0.76331019832399138 1.9382729060657411e-08 0.64603215178084472 0
		 5.3948869698446194 160.14162212963475 8.8238796830331054 1;
createNode parentConstraint -n "L_eyelids_corner_outer_joint_parentConstraint1" -p
		 "L_eyelids_corner_outer_joint";
	rename -uid "342C0A64-45A2-C502-4C35-CD8F3DC1786A";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelids_corner_outer_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" -0.38714103307531156 -0.078598022460909078 
		-0.036795774009778626 ;
	setAttr ".tg[0].tor" -type "double3" -6.28225351547066e-07 27.16043472443307 1.0562555103794874e-06 ;
	setAttr ".lr" -type "double3" 1.0166676770389956e-06 -0.48907732634291246 -8.6910950703287985e-07 ;
	setAttr ".rst" -type "double3" 5.3948869705200186 160.14143371582031 8.8236665725708008 ;
	setAttr ".rsrr" -type "double3" 1.1103887082007465e-06 2.1828698198566294e-14 -9.3978412452407717e-07 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_fold_main_1_joint" -p "L_eyelids_joint";
	rename -uid "71D0E24A-4FBB-2792-041A-4B948C9FE76C";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.6245552336697993 -13.754000678692984 46.986628131479264 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.63660081385459666 0.75566018913151201 0.15400351412027119 0
		 -0.74373209334620605 0.54875091882380911 0.38175254081262533 0 0.20396562731630938 -0.3575613341117187 0.91134401584786418 0
		 1.9567903272863552 160.07411724681776 10.037393057179969 1;
createNode parentConstraint -n "L_eyelid_upper_fold_main_1_joint_parentConstraint1" 
		-p "L_eyelid_upper_fold_main_1_joint";
	rename -uid "CC33E285-4EAD-BBF0-795D-B09AAACBCEA0";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_fold_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -0.011989600767054256 0.037052297272962519 0.064244644827038636 ;
	setAttr ".rst" -type "double3" 1.9567903280258072 160.07392883300781 10.037179946899419 ;
	setAttr ".rsrr" -type "double3" 5.6653630263568893e-15 3.1805546814635168e-15 2.9817700138720489e-16 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_fold_main_2_joint" -p "L_eyelids_joint";
	rename -uid "B32432F2-49F1-76DD-AB57-BDA51948D6E4";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -9.2539332083865773 -9.020994768634095 -6.1234862514062209 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.98418489917200147 0.017002205397214632 -0.17632642811963375 0
		 -0.017272840611174775 0.99985081336028336 1.8596235662471372e-15 0 0.17630012257232938 0.003045658288446218 0.98433174831789882 0
		 3.8551003925534215 161.11848817141779 10.05707784884526 1;
createNode parentConstraint -n "L_eyelid_upper_fold_main_2_joint_parentConstraint1" 
		-p "L_eyelid_upper_fold_main_2_joint";
	rename -uid "C7B7A2DB-45AB-1AFA-A37F-86955BC51707";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_fold_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -2.4556161323487944e-07 1.2373043786496672e-05 1.5859603015381602e-07 ;
	setAttr ".rst" -type "double3" 3.8551003932952868 161.115234375 10.056864738464348 ;
	setAttr ".rsrr" -type "double3" -3.1681306397390503e-15 -1.5902773407317584e-15 
		5.9635400277440939e-16 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_eyelid_upper_fold_main_3_joint" -p "L_eyelids_joint";
	rename -uid "96A2293C-42BE-CB7D-1E54-0EA14B8F9D93";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -1.6490709828617762 10.011847592023315 -45.701975667594297 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.65190905618347672 -0.56244459320589069 -0.50859675779484492 0
		 0.59781445256683641 0.79382722476834278 -0.11160742591245724 0 0.46651094603254739 -0.23128860064873583 0.85374066345803568 0
		 5.5087399475937522 160.36029583568958 8.8855747819161017 1;
createNode parentConstraint -n "L_eyelid_upper_fold_main_3_joint_parentConstraint1" 
		-p "L_eyelid_upper_fold_main_3_joint";
	rename -uid "71B0DF05-427D-3A4E-CCA0-769CB7059196";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eyelid_upper_fold_3_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -0.023136472838273837 -0.025798762957897008 -0.072831385677002772 ;
	setAttr ".rst" -type "double3" 5.5087399482726882 160.36010742187497 8.8853616714477575 ;
	setAttr ".rsrr" -type "double3" 4.7708320221952752e-15 2.3854160110976372e-15 1.2324649390671129e-14 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelids_joint";
	rename -uid "787C304A-4341-6D99-CD13-1DBE0B6B109A";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr -k on ".t";
	setAttr -k on ".r";
	setAttr -k on ".s";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -168.34510855183524 -17.922380116406082 -8.8641170773635274 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.94011046970796264 -0.14661421174502606 0.30772809046276334 0
		 -0.089490971062433103 -0.97726425127897043 -0.19221329108689597 0 0.32891286208322229 0.15316284172911418 -0.93185700247928882 0
		 -3.0255700005976873 160.14799999999605 7.3534099998401103 1;
	setAttr ".ds" 3;
createNode joint -n "R_eyelid_upper_main_joint" -p "R_eyelids_joint";
	rename -uid "4BBE4D21-41CD-C706-0BF2-1EBA67EC35D9";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -8.9150458492204461 -2.4658806027995612 -6.0427603810804866 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.95758444350287997 -0.036292825337627947 0.28585811933596067 0
		 -0.034776357739838233 -0.99934119840473501 -0.010381431179679435 0 0.2860465670194815 -7.2219079605417846e-09 -0.95821571762123003 0
		 -3.8950500007400661 160.76518841380232 10.031713109971211 1;
createNode parentConstraint -n "R_eyelid_upper_main_joint_parentConstraint1" -p "R_eyelid_upper_main_joint";
	rename -uid "20A5C97C-47D6-7595-AD5D-378CEF873C2A";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_main_controlW0" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" -1.4084384325485644e-07 -0.00013680376491720381 
		-1.633123916278123e-05 ;
	setAttr ".tg[0].tor" -type "double3" 4.1347210859025721e-14 1.9878466759146984e-15 
		8.0507790374545285e-14 ;
	setAttr ".lr" -type "double3" -3.8050743870901186e-15 -2.3927696730866881 -2.0798825997131902 ;
	setAttr ".rst" -type "double3" -0.083744097464101941 -1.0399260121630789 -2.6870785872144829 ;
	setAttr ".rsrr" -type "double3" -4.2390830363880942e-14 -2.5842006786891375e-15 
		-8.0135069122811277e-14 ;
	setAttr ".rdta" -type "double3" -7.9363599025938937e-17 4.0766001685454967e-16 -7.8496237287950533e-17 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_lower_main_joint" -p "R_eyelids_joint";
	rename -uid "9B1E97E8-4FB6-930B-47C4-5F9C6B54B38A";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -1.1526424176639685 1.3914600096465009 -8.5253789572100942 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.93472422098367225 -0.0038364526953336173 0.35535322193162089 0
		 0.043781481979711871 -0.99108106105844207 -0.12586306943234954 0 0.35266671595449373 0.13320515020819862 -0.92621950714497669 0
		 -4.074435229273476 158.70271630737025 9.4062754620211617 1;
createNode parentConstraint -n "R_eyelid_lower_main_joint_parentConstraint1" -p "R_eyelid_lower_main_joint";
	rename -uid "F0570A75-471C-2660-5247-778C79FCC699";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_lower_main_controlW0" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 9.1038288019262836e-15 0.00010170025876732325 
		0.00042814027510651442 ;
	setAttr ".tg[0].tor" -type "double3" -2.5302878357625829e-07 2.3655375443384907e-14 
		-4.2676583323543671e-15 ;
	setAttr ".lr" -type "double3" -7.6700446178929438 -3.5968746879610509 0.26228245890849833 ;
	setAttr ".rst" -type "double3" -0.14246364051770044 1.1119251196116409 -2.4791563476505605 ;
	setAttr ".rsrr" -type "double3" 2.5302878370049865e-07 -2.3680223532773176e-14 2.6898049810589471e-15 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_upper_major_1_joint" -p "R_eyelids_joint";
	rename -uid "37E943DA-461A-BB0C-D239-75A16B603E5A";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -15.598264472136774 -26.239545509115754 21.803604903071651 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" -0.89851888598682139 0.37995896047716166 0.21976123379276014 0
		 -0.39586193274591269 -0.91776092671811371 -0.031752347821529636 0 0.18962368451138217 -0.11552519094389523 0.97503681393560926 0
		 -2.5140408000654495 160.22656428401416 10.051880022393101 1;
createNode parentConstraint -n "R_eyelid_upper_major_1_joint_parentConstraint1" -p
		 "R_eyelid_upper_major_1_joint";
	rename -uid "A61765E4-4EC2-2D8A-05A2-80B2C2381BEA";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_major_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 2.5444437451708134e-14 179.99999999999994 -2.5444437451708134e-14 ;
	setAttr ".rst" -type "double3" 1.2997327455795293 -0.64101204639504772 -2.3341366020176597 ;
	setAttr ".rsrr" -type "double3" 5.9382182289151295 -0.30365902649029397 20.533060258531741 ;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_upper_major_2_joint" -p "R_eyelids_joint";
	rename -uid "A23F9EF4-46EE-C4F8-6000-F1A5FB9D9865";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -15.275278174375305 19.025419615656944 -25.996759802492679 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" -0.7286919767756237 -0.23044527437056908 -0.64490540275540176 0
		 0.16205673621095493 -0.97296338789496906 0.16455959426480268 0 -0.66539132638732734 0.015401991306861845 0.74633582349522554 0
		 -4.7904299853234953 160.57842199340914 9.4851363816230112 1;
createNode parentConstraint -n "R_eyelid_upper_major_2_joint_parentConstraint1" -p
		 "R_eyelid_upper_major_2_joint";
	rename -uid "809C80E4-4B19-EE45-B392-0F8CA1117434";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_major_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -1.5991111405262425e-07 -179.99999999999997 0 ;
	setAttr ".rst" -type "double3" -1.0663147909629522 -0.67221812533273351 -2.500855048813925 ;
	setAttr ".rsrr" -type "double3" 1.5991105143973473e-07 2.1907321910307513e-14 -15.208346321771044 ;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_lower_major_1_joint" -p "R_eyelids_joint";
	rename -uid "1EA280B7-4491-B5EE-6F2C-26921EF13BDF";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -1.1980577224197551 -10.931353949403457 -9.2659961058529383 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" -0.98752858490574869 -0.041471184762741239 -0.15187967220278212 0
		 0.0600214913453379 -0.99099802498490108 -0.11966760235212587 0 -0.14554969794105202 -0.12729122244051072 0.9811280396150488 0
		 -3.0136263910227288 158.69908706304292 9.6143748629739285 1;
createNode parentConstraint -n "R_eyelid_lower_major_1_joint_parentConstraint1" -p
		 "R_eyelid_lower_major_1_joint";
	rename -uid "81430BD4-42D2-2B02-32CA-9E9F4335905F";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_lower_major_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -4.3315098918203296e-07 -179.99999999999997 -2.5444437451708134e-14 ;
	setAttr ".rst" -type "double3" 0.91938437937250939 0.98053952775549647 -2.3247172963775 ;
	setAttr ".rsrr" -type "double3" 4.3315098321849295e-07 1.7418506539123311e-14 -1.0958004735138597e-14 ;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_lower_major_2_joint" -p "R_eyelids_joint";
	rename -uid "EC3FCB7B-4C8F-63DB-CBC4-1291F23722E6";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" 17.076358336539776 14.34407514537445 36.244621634492241 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" -0.60181563038899855 0.71228278526639976 -0.36120794680160656 0
		 -0.45543162683475474 -0.67761761325444902 -0.57742220557057955 0 -0.65604876365872489 -0.18299618580856697 0.73219697874368161 0
		 -5.0427584423007854 159.36287408173501 8.9929823283103829 1;
createNode parentConstraint -n "R_eyelid_lower_major_2_joint_parentConstraint1" -p
		 "R_eyelid_lower_major_2_joint";
	rename -uid "A7E62BB7-4350-80B4-2617-22AFB2100C83";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_lower_major_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" -2.3869070551323077e-08 179.99999999999997 0 ;
	setAttr ".rst" -type "double3" -1.2767645978150277 0.63287308662296482 -2.3114087086494557 ;
	setAttr ".rsrr" -type "double3" 2.3869071620743562e-08 6.6689852949237428e-15 42.040275833180104 ;
	setAttr -k on ".w0";
createNode parentConstraint -n "R_eyelids_joint_parentConstraint1" -p "R_eyelids_joint";
	rename -uid "14C0BB52-4683-11E5-6297-A2B82F31DE4E";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 3.2903305582365761e-06 -0.00029975760543266006 
		7.2443471577088303e-07 ;
	setAttr ".tg[0].tor" -type "double3" 11.654891448164772 17.922380116406071 8.8641170773635096 ;
	setAttr ".lr" -type "double3" 2.7631068795214301e-14 -1.5902773407317581e-14 -1.3517357396219949e-14 ;
	setAttr ".rst" -type "double3" -3.02557 160.148 7.35341 ;
	setAttr ".rsrr" -type "double3" -1.7890620083232284e-15 -3.1805546814635168e-15 
		4.965644585306429e-32 ;
	setAttr ".rdta" -type "double3" -2.7755575615628914e-17 -5.3776427755281026e-17 
		-1.3877787807814457e-17 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_upper_fold_main_1_joint" -p "R_eyelids_joint";
	rename -uid "A8A4A8A2-4274-188E-CEB7-20882816A968";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 1.6245759721124811 -13.753986744793316 46.986619639015125 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.63660081902590249 -0.75566017925121787 -0.15400354122411389 0
		 -0.74373208019673631 -0.54875089375251829 -0.3817526024692533 0 0.20396565912374962 0.35756139346947047 -0.91134398544039597 0
		 -1.9567903287652706 160.07411724681262 10.037393056973073 1;
createNode parentConstraint -n "R_eyelid_upper_fold_main_1_joint_parentConstraint1" 
		-p "R_eyelid_upper_fold_main_1_joint";
	rename -uid "79D5093A-4088-CD5E-0357-03A1C4DAB62F";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_fold_1_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" -1.4210854715202004e-14 0 0 ;
	setAttr ".tg[0].tor" -type "double3" 1.6473266021800016e-07 -2.2263882770244617e-14 
		-3.4290355159528539e-15 ;
	setAttr ".lr" -type "double3" -0.017065367856130338 0.039139612645856865 0.064172607221834405 ;
	setAttr ".rst" -type "double3" 1.8415022461961534 -0.53911528116228169 -2.1606993876421363 ;
	setAttr ".rsrr" -type "double3" -1.6473265842893804e-07 1.7493050760765905e-14 8.845917682673028e-15 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_upper_fold_main_2_joint" -p "R_eyelids_joint";
	rename -uid "7E7F7037-4F9E-5A28-F424-BE9A498B62A4";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -9.2539326831350763 -9.0209702936009393 -6.1234899636856301 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.98418489917215757 -0.017002205390018996 0.17632642811945562 0
		 -0.01727284060386481 -0.9998508133604096 9.7144514654701197e-16 0 0.17630012257217356 -0.0030456582871570825 -0.9843317483179308 0
		 -3.8551003940371515 161.11848817140776 10.057077848437673 1;
createNode parentConstraint -n "R_eyelid_upper_fold_main_2_joint_parentConstraint1" 
		-p "R_eyelid_upper_fold_main_2_joint";
	rename -uid "E8B72D5A-4C04-BD37-5835-FC92E9F10FB7";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_fold_2_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 1.7763568394002505e-15 -2.8421709430404007e-14 
		-1.7763568394002505e-15 ;
	setAttr ".tg[0].tor" -type "double3" 1.5902773407317584e-15 -1.7493050748049341e-14 
		5.963540027744093e-16 ;
	setAttr ".lr" -type "double3" -1.887420053276819e-07 -1.2373043780355106e-05 -1.5859609373769218e-07 ;
	setAttr ".rst" -type "double3" -0.08973154882366785 -1.3906480294552921 -2.6439320792761247 ;
	setAttr ".rsrr" -type "double3" -1.0933156717530838e-15 2.0574213095717126e-14 3.3793393490549872e-15 ;
	setAttr ".rdta" -type "double3" -1.9081958235744875e-17 3.5908775952719912e-16 5.8980598183211454e-17 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelid_upper_fold_main_3_joint" -p "R_eyelids_joint";
	rename -uid "560B4059-4D00-3C11-5E04-01B67032685E";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -1.6490860761664521 10.011867060019888 -45.701981853420051 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.65190904719817444 0.56244459068102326 0.50859677210421284 0
		 0.59781448831099337 -0.79382720662346218 0.11160736351090832 0 0.46651091278407802 0.23128866906540638 -0.85374066309115149 0
		 -5.5087399489516535 160.36029583567517 8.885574781333677 1;
createNode parentConstraint -n "R_eyelid_upper_fold_main_3_joint_parentConstraint1" 
		-p "R_eyelid_upper_fold_main_3_joint";
	rename -uid "1891413F-4AA8-6603-3239-D9AA049F6465";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelid_upper_fold_3_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 0 -5.6843418860808015e-14 3.1974423109204508e-14 ;
	setAttr ".tg[0].tor" -type "double3" -3.1946740701526174e-07 1.5902773407317587e-14 
		-3.5681847832668833e-14 ;
	setAttr ".lr" -type "double3" -0.028657148023682206 -0.027181880583743514 -0.07268463959779578 ;
	setAttr ".rst" -type "double3" -1.8941274663621677 -0.27952518339156995 -2.211819451739478 ;
	setAttr ".rsrr" -type "double3" 3.1946740781040042e-07 -1.1529510847629854e-14 4.5670777346997302e-14 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelids_corner_inner_joint" -p "R_eyelids_joint";
	rename -uid "94D4A516-463A-519F-A38A-B8A317341B28";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -8.8463575859094377 -5.156961248100103 -7.7306960627896073 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.96934876657757008 -2.4607577985696905e-08 0.2456887639566433 0
		 -2.8268513793672234e-08 -0.99999999999999933 1.1374028136001968e-08 0 0.24568876395664285 -1.7970656351895542e-08 -0.96934876657757008 0
		 -1.9463500007200973 159.02418841380469 9.697013110074213 1;
createNode parentConstraint -n "R_eyelids_corner_inner_joint_parentConstraint1" -p
		 "R_eyelids_corner_inner_joint";
	rename -uid "A64A450B-47CD-B708-AAE4-C3A5C90617B3";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelids_corner_inner_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" 0.10427608261108379 0.049741577148409988 -0.11747097320557032 ;
	setAttr ".tg[0].tor" -type "double3" -6.7229037071613969e-07 14.222541180413753 
		1.4547017834707515e-06 ;
	setAttr ".lr" -type "double3" 7.0246832129510439e-07 -1.237488994137354e-05 -1.1906628032768835e-07 ;
	setAttr ".rst" -type "double3" -1.9463499999999998 159.02399999999997 9.6967999999999961 ;
	setAttr ".rsrr" -type "double3" 6.7229037071613958e-07 -1.5902773407317584e-15 -9.3299031100355032e-24 ;
	setAttr ".rdta" -type "double3" -8.2718061255302767e-25 1.3684555315672042e-48 3.3087224502121107e-24 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_eyelids_corner_outer_joint" -p "R_eyelids_joint";
	rename -uid "22009EF6-4D70-66BA-34FF-E7A97BC35C62";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".jo" -type "double3" -10.17859049851417 29.921147506173995 -13.64977369341066 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.64603215178098217 -1.6399966024094326e-08 0.76331019832387537 0
		 -1.6398671698336642e-08 -0.99999999999999967 -7.6062089959805235e-09 0 0.76331019832387548 -7.6034177010075865e-09 -0.64603215178098206 0
		 -5.3948900006753995 160.14118841380025 8.8238831098919075 1;
createNode parentConstraint -n "R_eyelids_corner_outer_joint_parentConstraint1" -p
		 "R_eyelids_corner_outer_joint";
	rename -uid "AA445E8E-44A0-9D15-C0B2-489B93C794DB";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eyelids_corner_outer_controlW0" 
		-dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".tg[0].tot" -type "double3" -0.38713955310590253 -0.079031738281230446 
		-0.036791445648612253 ;
	setAttr ".tg[0].tor" -type "double3" 4.6359710635754859e-08 27.160434724433109 1.056255506779512e-06 ;
	setAttr ".lr" -type "double3" 5.2958112131594149e-07 -0.48910207612282725 -1.0236575199803951e-06 ;
	setAttr ".rst" -type "double3" -5.3948899999999984 160.141 8.8236699999999981 ;
	setAttr ".rsrr" -type "double3" 4.3580364437459673e-07 3.5740969795478841e-15 -9.3978412132106464e-07 ;
	setAttr ".rdta" -type "double3" 1.9379938935069587e-08 3.8098265498913679e-16 -1.6402327230917535e-08 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_upper_tuner_curve";
	rename -uid "DEF11193-4207-EDDB-D54B-69BB65A8366E";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_upper_tuner_curveShape" -p "L_eyelid_upper_tuner_curve";
	rename -uid "25EABA52-4A56-2E94-3A62-649D4DFE03B1";
	setAttr -k off ".v";
	setAttr -s 5 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_eyelids_inner_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0:4]";
	setAttr ".gtag[1].gtagnm" -type "string" "L_eyelids_inner_cluster_1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[0:5]";
	setAttr ".gtag[2].gtagnm" -type "string" "L_eyelids_outer_cluster";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[4:8]";
	setAttr ".gtag[3].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[4].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 0.16666666666666666 0.33333333333333331 0.5 0.66666666666666663 0.83333333333333326
		 1 1 1
		9
		1.9300700418724068 159.01676940921843 9.7134771348066451
		1.9522235353830046 159.29714446999623 9.7532028557144415
		2.1194226979658901 159.80640169187151 9.9162642924790561
		2.6726453979937355 160.44202536228636 10.12472640585316
		3.460149948559712 160.7745795119456 10.190155590632214
		4.2880023705688224 160.76953475575667 9.9001806850165224
		4.9251766195076456 160.55574765558649 9.396592192485544
		5.2449330130202449 160.28025262357016 9.0106509372831507
		5.3948798169094276 160.14125061927874 8.8234472226864895
		

		"gtag" 5
		"L_eyelids_inner_cluster" 1 "cv[0:4]"
		"L_eyelids_inner_cluster_1" 1 "cv[0:5]"
		"L_eyelids_outer_cluster" 1 "cv[4:8]"
		"softMod1" 1 "cv[0]"
		"softMod1_1" 1 "cv[0]";
createNode transform -n "L_eyelid_lower_tuner_curve";
	rename -uid "BE2702C5-425F-9EE6-FD4F-D1AEDFAAEEA8";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_eyelid_lower_tuner_curveShape" -p "L_eyelid_lower_tuner_curve";
	rename -uid "292B1472-4CD6-2F2E-00BF-60A1FE8A9DA3";
	setAttr -k off ".v";
	setAttr -s 5 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_eyelids_inner_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[0:4]";
	setAttr ".gtag[1].gtagnm" -type "string" "L_eyelids_inner_cluster_1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[0:5]";
	setAttr ".gtag[2].gtagnm" -type "string" "L_eyelids_outer_cluster";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[4:8]";
	setAttr ".gtag[3].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".gtag[4].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "cv[0]";
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 0.16666666666666666 0.33333333333333331 0.5 0.66666666666666663 0.83333333333333337
		 1 1 1
		9
		1.930070041872407 159.01676940921843 9.7134771348066451
		2.1540565547755355 158.9295306840929 9.6861462243846574
		2.610962007128343 158.7544041560752 9.6639334194161677
		3.3274988070880478 158.64489492357106 9.5800592687150168
		4.0468171739197185 158.6642956371694 9.4287430031091777
		4.6920474107190593 158.92975460206037 9.1780340844962289
		5.1559520461524144 159.46051551037891 8.9322760391011506
		5.3298366339203964 159.90797725201776 8.845472106311707
		5.394880134804497 160.14125061543496 8.823446716032878
		

		"gtag" 5
		"L_eyelids_inner_cluster" 1 "cv[0:4]"
		"L_eyelids_inner_cluster_1" 1 "cv[0:5]"
		"L_eyelids_outer_cluster" 1 "cv[4:8]"
		"softMod1" 1 "cv[0]"
		"softMod1_1" 1 "cv[0]";
createNode transform -n "eyelids_controls";
	rename -uid "65042F44-4842-4FF5-12CA-CA808BF6414A";
	setAttr -k on ".t";
	setAttr -k on ".r";
	setAttr -k on ".s";
createNode transform -n "L_eyelid_lower_major_1_control_transform" -p "eyelids_controls";
	rename -uid "15709E90-45E8-6543-A92A-5BA0DC6D897E";
	setAttr ".s" -type "double3" 0.99999999999999967 1.0000000000000002 0.99999999999999989 ;
createNode transform -n "L_eyelid_lower_major_1_control" -p "L_eyelid_lower_major_1_control_transform";
	rename -uid "7DABE550-46AB-7D83-C993-5F856603C148";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "L_eyelid_lower_major_1_controlShape" -p "L_eyelid_lower_major_1_control";
	rename -uid "0229CC3F-4D6D-4978-4A77-9D8B17F3D511";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		-0.177045348544901 1.3419172865094541e-14 0.22863239210032002
		-0.12519002778115726 1.3411507195089278e-14 0.35382241988147717
		-5.5419704263131975e-16 1.3408331969954287e-14 0.40567774064522061
		0.12519002778115698 1.3411507195089278e-14 0.35382241988147717
		0.17704534854490017 1.3419172865094541e-14 0.22863239210032024
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		;
createNode nurbsCurve -n "L_eyelid_lower_major_1_controlShape1" -p "L_eyelid_lower_major_1_control";
	rename -uid "07CB2203-4105-938B-3ACC-FDA0707DA4E2";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		-0.177045348544901 1.3341290174115952e-14 0.2286323921003201
		-0.12519002778115726 0.12519002778117058 0.22863239210032019
		-5.5419704263131975e-16 0.17704534854491411 0.2286323921003201
		0.12519002778115698 0.12519002778117058 0.2286323921003201
		0.17704534854490017 1.3487685007857976e-14 0.2286323921003201
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		;
createNode nurbsCurve -n "L_eyelid_lower_major_1_controlShape2" -p "L_eyelid_lower_major_1_control";
	rename -uid "10C398F6-43D1-B792-6308-31B89D2E920D";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		-5.00849752838054e-16 -0.17704534854488724 0.22863239210032002
		-5.00849752838054e-16 -0.12519002778114383 0.35382241988147717
		-4.9000885769779717e-16 1.336582557530127e-14 0.40567774064522061
		-5.0749457619342127e-16 0.12519002778117058 0.35382241988147717
		-5.00849752838054e-16 0.17704534854491411 0.22863239210032024
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		;
createNode transform -n "L_eyelid_lower_major_1_joint_basis" -p "L_eyelid_lower_major_1_control_transform";
	rename -uid "F4FFF793-4F10-E453-0944-6BA946FCE8FE";
	setAttr ".t" -type "double3" 1.7763568394002505e-15 2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr ".r" -type "double3" -4.6962877718484755e-15 6.472925738447237e-15 3.7396365590645269e-15 ;
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr ".s" -type "double3" 1 1.0000000000000002 1 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode orientConstraint -n "L_eyelid_lower_major_1_control_orientConstraint1" 
		-p "L_eyelid_lower_major_1_control_transform";
	rename -uid "41496E47-4E7B-59C2-1EA3-089EB436A685";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".o" -type "double3" 6.9539835668489012 8.7358720509824828 -2.4047187572807243 ;
	setAttr ".rsrr" -type "double3" 6.9539835668489012 8.7358720509824845 -2.4047187572807243 ;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_lower_major_2_control_transform" -p "eyelids_controls";
	rename -uid "5C80A747-4ADA-A987-3EA8-7BB614E44E7A";
	setAttr ".s" -type "double3" 0.99999999999999978 0.99999999999999978 0.99999999999999967 ;
createNode transform -n "L_eyelid_lower_major_2_control" -p "L_eyelid_lower_major_2_control_transform";
	rename -uid "E95257F0-41BB-09B9-2D3B-E2AF39B61F20";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "L_eyelid_lower_major_2_controlShape" -p "L_eyelid_lower_major_2_control";
	rename -uid "862E0439-42E9-510B-C12C-A5A396FEBB53";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		-0.177045348544901 5.6084114391004655e-15 0.22863239210031944
		-0.12519002778115726 5.6007457690952011e-15 0.35382241988147695
		-5.5419704263131975e-16 5.5975705439602047e-15 0.40567774064522039
		0.12519002778115698 5.6007457690952011e-15 0.35382241988147695
		0.17704534854490017 5.6084114391004655e-15 0.22863239210031969
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		;
createNode nurbsCurve -n "L_eyelid_lower_major_2_controlShape1" -p "L_eyelid_lower_major_2_control";
	rename -uid "DDBF131C-459E-7FC4-BC0F-70A00084956F";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		-0.177045348544901 5.5305287481218671e-15 0.22863239210031952
		-0.12519002778115726 0.12519002778116273 0.2286323921003196
		-5.5419704263131975e-16 0.17704534854490611 0.22863239210031952
		0.12519002778115698 0.12519002778116273 0.22863239210031952
		0.17704534854490017 5.6769235818639057e-15 0.22863239210031952
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		;
createNode nurbsCurve -n "L_eyelid_lower_major_2_controlShape2" -p "L_eyelid_lower_major_2_control";
	rename -uid "72156B26-40AB-C9A8-6B5E-16AF23E7F60D";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		-5.00849752838054e-16 -0.17704534854489501 0.22863239210031944
		-5.00849752838054e-16 -0.12519002778115162 0.35382241988147695
		-4.9000885769779717e-16 5.5550641493071885e-15 0.40567774064522039
		-5.0749457619342127e-16 0.12519002778116273 0.35382241988147695
		-5.00849752838054e-16 0.17704534854490611 0.22863239210031969
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		;
createNode transform -n "L_eyelid_lower_major_2_joint_basis" -p "L_eyelid_lower_major_2_control_transform";
	rename -uid "D546DA03-487A-7873-5CA5-3096D4B34264";
	setAttr ".t" -type "double3" 1.7763568394002505e-15 2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr ".r" -type "double3" -4.6962877718484755e-15 6.472925738447237e-15 3.7396365590645269e-15 ;
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr ".s" -type "double3" 1 1.0000000000000002 1 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode orientConstraint -n "L_eyelid_lower_major_2_control_orientConstraint1" 
		-p "L_eyelid_lower_major_2_control_transform";
	rename -uid "5DD076DF-4684-4FBA-8927-C78E67B841D9";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".o" -type "double3" 38.259874976131023 21.174398712302061 49.805161992388413 ;
	setAttr ".rsrr" -type "double3" 38.259874976131023 21.174398712302057 49.805161992388406 ;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_upper_major_1_control_transform" -p "eyelids_controls";
	rename -uid "83F0838B-4F29-9125-3CAA-8D98D795C9E9";
	setAttr ".s" -type "double3" 0.99999999999999967 1 0.99999999999999989 ;
createNode transform -n "L_eyelid_upper_major_1_control" -p "L_eyelid_upper_major_1_control_transform";
	rename -uid "333FF8AA-4268-1B7C-6B14-3DA3122EAA6B";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "L_eyelid_upper_major_1_controlShape" -p "L_eyelid_upper_major_1_control";
	rename -uid "678C1ADE-4006-354B-7AED-09837BA35982";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115368 -0.20841784446107572 0.10344236431916805
		-3.8419597575215251e-15 -0.20841784446107572 0.051587043555424317
		-0.12519002778116056 -0.20841784446107572 0.10344236431916805
		-0.17704534854490431 -0.20841784446107575 0.22863239210032449
		-0.12519002778116056 -0.20841784446107575 0.35382241988148166
		-3.8751082969544197e-15 -0.20841784446107575 0.4056777406452251
		0.12519002778115368 -0.20841784446107575 0.35382241988148166
		0.17704534854489687 -0.20841784446107575 0.22863239210032471
		0.12519002778115368 -0.20841784446107572 0.10344236431916805
		-3.8419597575215251e-15 -0.20841784446107572 0.051587043555424317
		-0.12519002778116056 -0.20841784446107572 0.10344236431916805
		;
createNode nurbsCurve -n "L_eyelid_upper_major_1_controlShape1" -p "L_eyelid_upper_major_1_control";
	rename -uid "8C1A2B21-402F-0AFA-B344-FAA143E4C6B2";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115368 -0.33360787224223293 0.22863239210032457
		-3.8419597575215251e-15 -0.38546319300597637 0.22863239210032457
		-0.12519002778116056 -0.33360787224223293 0.22863239210032457
		-0.17704534854490431 -0.20841784446107581 0.22863239210032457
		-0.12519002778116056 -0.083227816679918576 0.22863239210032466
		-3.8751082969544197e-15 -0.031372495916175053 0.22863239210032457
		0.12519002778115368 -0.083227816679918576 0.22863239210032457
		0.17704534854489687 -0.20841784446107567 0.22863239210032457
		0.12519002778115368 -0.33360787224223293 0.22863239210032457
		-3.8419597575215251e-15 -0.38546319300597637 0.22863239210032457
		-0.12519002778116056 -0.33360787224223293 0.22863239210032457
		;
createNode nurbsCurve -n "L_eyelid_upper_major_1_controlShape2" -p "L_eyelid_upper_major_1_control";
	rename -uid "900BD11E-423A-5194-E62B-F0B723057A7C";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-3.8084713604504182e-15 -0.083227816679918576 0.10344236431916805
		-3.8326019023014098e-15 -0.20841784446107575 0.051587043555424317
		-3.8217610071611545e-15 -0.33360787224223293 0.10344236431916805
		-3.8217610071611545e-15 -0.38546319300597637 0.22863239210032449
		-3.8217610071611545e-15 -0.33360787224223293 0.35382241988148166
		-3.8109201120208975e-15 -0.20841784446107581 0.4056777406452251
		-3.8284058305165218e-15 -0.083227816679918576 0.35382241988148166
		-3.8217610071611545e-15 -0.031372495916175053 0.22863239210032471
		-3.8084713604504182e-15 -0.083227816679918576 0.10344236431916805
		-3.8326019023014098e-15 -0.20841784446107575 0.051587043555424317
		-3.8217610071611545e-15 -0.33360787224223293 0.10344236431916805
		;
createNode transform -n "L_eyelid_upper_major_1_joint_basis" -p "L_eyelid_upper_major_1_control_transform";
	rename -uid "935D58F0-4D19-1654-1EFD-CCB1A4EE7B27";
	setAttr ".t" -type "double3" 1.7763568394002505e-15 2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr ".r" -type "double3" -4.6962877718484755e-15 6.472925738447237e-15 3.7396365590645269e-15 ;
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr ".s" -type "double3" 1 1.0000000000000002 1 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode orientConstraint -n "L_eyelid_upper_major_1_control_orientConstraint1" 
		-p "L_eyelid_upper_major_1_control_transform";
	rename -uid "53828546-4668-8A2F-E47D-72B72F293958";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".o" -type "double3" 1.865193691768549 -12.695009501191707 22.922167103242369 ;
	setAttr ".rsrr" -type "double3" 1.8651936917685494 -12.695009501191706 22.922167103242369 ;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_upper_major_2_control_transform" -p "eyelids_controls";
	rename -uid "6B104126-4976-35AC-76E0-20AA56B541A6";
	setAttr ".s" -type "double3" 0.99999999999999978 0.99999999999999989 0.99999999999999978 ;
createNode transform -n "L_eyelid_upper_major_2_control" -p "L_eyelid_upper_major_2_control_transform";
	rename -uid "2BF201C5-4189-0E81-8A2B-8A90D633C155";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 2.9976021664879227e-15 -1.1018963519404679e-14 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "L_eyelid_upper_major_2_controlShape" -p "L_eyelid_upper_major_2_control";
	rename -uid "BB96530A-4452-DE2F-AB16-579E6F128180";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.18088171632272707 -0.24293614462148796 0.10344236431916444
		0.055691688541569542 -0.24293614462148796 0.051587043555420639
		-0.069498339239587176 -0.24293614462148796 0.10344236431916444
		-0.12135366000333095 -0.24293614462148796 0.22863239210032191
		-0.069498339239587176 -0.24293614462148796 0.35382241988147939
		0.055691688541569508 -0.24293614462148796 0.40567774064522283
		0.18088171632272707 -0.24293614462148796 0.35382241988147939
		0.23273703708647023 -0.24293614462148796 0.22863239210032218
		0.18088171632272707 -0.24293614462148796 0.10344236431916444
		0.055691688541569542 -0.24293614462148796 0.051587043555420639
		-0.069498339239587176 -0.24293614462148796 0.10344236431916444
		;
createNode nurbsCurve -n "L_eyelid_upper_major_2_controlShape1" -p "L_eyelid_upper_major_2_control";
	rename -uid "1D8B90C6-43E2-C1E9-2299-F391D15B7779";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.18088171632272707 -0.36812617240264545 0.22863239210032202
		0.055691688541569542 -0.41998149316638866 0.22863239210032202
		-0.069498339239587176 -0.36812617240264545 0.22863239210032202
		-0.12135366000333095 -0.24293614462148808 0.22863239210032202
		-0.069498339239587176 -0.11774611684033083 0.22863239210032207
		0.055691688541569508 -0.06589079607658746 0.22863239210032202
		0.18088171632272707 -0.11774611684033083 0.22863239210032202
		0.23273703708647023 -0.24293614462148785 0.22863239210032202
		0.18088171632272707 -0.36812617240264545 0.22863239210032202
		0.055691688541569542 -0.41998149316638866 0.22863239210032202
		-0.069498339239587176 -0.36812617240264545 0.22863239210032202
		;
createNode nurbsCurve -n "L_eyelid_upper_major_2_controlShape2" -p "L_eyelid_upper_major_2_control";
	rename -uid "D59E12FB-4A86-39D2-BA46-AEBBB8E306E2";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.055691688541569577 -0.11774611684033083 0.10344236431916444
		0.055691688541569549 -0.24293614462148796 0.051587043555420639
		0.055691688541569563 -0.36812617240264545 0.10344236431916444
		0.055691688541569563 -0.41998149316638866 0.22863239210032191
		0.055691688541569563 -0.36812617240264545 0.35382241988147939
		0.055691688541569577 -0.24293614462148802 0.40567774064522283
		0.055691688541569556 -0.11774611684033083 0.35382241988147939
		0.055691688541569563 -0.06589079607658746 0.22863239210032218
		0.055691688541569577 -0.11774611684033083 0.10344236431916444
		0.055691688541569549 -0.24293614462148796 0.051587043555420639
		0.055691688541569563 -0.36812617240264545 0.10344236431916444
		;
createNode transform -n "L_eyelid_upper_major_2_joint_basis" -p "L_eyelid_upper_major_2_control_transform";
	rename -uid "2E4FBC7F-45C1-8C9A-DBF5-BCA4CEEBDD4A";
	setAttr ".t" -type "double3" 1.7763568394002505e-15 2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr ".r" -type "double3" -4.6962877718484755e-15 6.472925738447237e-15 3.7396365590645269e-15 ;
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr ".s" -type "double3" 1 1.0000000000000002 1 ;
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode orientConstraint -n "L_eyelid_upper_major_2_control_orientConstraint1" 
		-p "L_eyelid_upper_major_2_control_transform";
	rename -uid "3597E275-49B7-4AE8-D724-0DB2D11C7B84";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".o" -type "double3" -12.434195159910931 40.158583321831365 -17.549303646245921 ;
	setAttr ".rsrr" -type "double3" -12.434195159910937 40.158583321831379 -17.549303646245928 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_lower_major_1_control_transform" -p "eyelids_controls";
	rename -uid "555A9EC4-45BA-F526-03E3-78AC59CD6C00";
	setAttr ".ovc" 13;
	setAttr ".s" -type "double3" 0.99999999999999944 0.99999999999999989 -0.99999999999999989 ;
createNode transform -n "R_eyelid_lower_major_1_control" -p "R_eyelid_lower_major_1_control_transform";
	rename -uid "6B2816E6-4C70-127A-095C-88A81DB3C6C3";
	setAttr -l on -k off ".v";
	setAttr ".ovc" 13;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "R_eyelid_lower_major_1_controlShape" -p "R_eyelid_lower_major_1_control";
	rename -uid "8BBB1A29-46C2-C9A0-C00D-CAA562E1FEC0";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		-0.177045348544901 1.3419172865094541e-14 0.22863239210032002
		-0.12519002778115726 1.3411507195089278e-14 0.35382241988147717
		-5.5419704263131975e-16 1.3408331969954287e-14 0.40567774064522061
		0.12519002778115698 1.3411507195089278e-14 0.35382241988147717
		0.17704534854490017 1.3419172865094541e-14 0.22863239210032024
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		;
createNode nurbsCurve -n "R_eyelid_lower_major_1_controlShape1" -p "R_eyelid_lower_major_1_control";
	rename -uid "C811F23E-4C22-5208-51D4-6EAAFF00C33F";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		-0.177045348544901 1.3341290174115952e-14 0.2286323921003201
		-0.12519002778115726 0.12519002778117058 0.22863239210032019
		-5.5419704263131975e-16 0.17704534854491411 0.2286323921003201
		0.12519002778115698 0.12519002778117058 0.2286323921003201
		0.17704534854490017 1.3487685007857976e-14 0.2286323921003201
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		;
createNode nurbsCurve -n "R_eyelid_lower_major_1_controlShape2" -p "R_eyelid_lower_major_1_control";
	rename -uid "6AAAFAE6-4530-A897-8825-B285DD4344D6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		-5.00849752838054e-16 -0.17704534854488724 0.22863239210032002
		-5.00849752838054e-16 -0.12519002778114383 0.35382241988147717
		-4.9000885769779717e-16 1.336582557530127e-14 0.40567774064522061
		-5.0749457619342127e-16 0.12519002778117058 0.35382241988147717
		-5.00849752838054e-16 0.17704534854491411 0.22863239210032024
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		;
createNode orientConstraint -n "R_eyelid_lower_major_1_control_orientConstraint1" 
		-p "R_eyelid_lower_major_1_control_transform";
	rename -uid "70F7B737-4186-5F2B-E821-538ACB6C2A09";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 180 0 0 ;
	setAttr ".o" -type "double3" -173.046016 8.7358720509824828 -2.404718757280722 ;
	setAttr ".rsrr" -type "double3" 6.9539840000000028 -8.7358720509824845 2.4047187572807225 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_lower_major_1_joint_basis" -p "R_eyelid_lower_major_1_control_transform";
	rename -uid "BF9892C4-4455-1CA3-3D5C-A4AF244C25DC";
	setAttr ".ovc" 13;
	setAttr -k on ".t" -type "double3" -4.4399865828381735e-07 0.00010043964002193206 
		-1.411700941744698e-05 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" 0 0 -179.99999999999989 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s" -type "double3" 0.99999999999999956 0.99999999999999956 -0.99999999999999967 ;
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "R_eyelid_lower_major_2_control_transform" -p "eyelids_controls";
	rename -uid "0B5EE169-43CE-DF56-4321-1D925CB79A43";
	setAttr ".ovc" 13;
	setAttr ".s" -type "double3" 1 0.99999999999999978 -0.99999999999999978 ;
createNode transform -n "R_eyelid_lower_major_2_control" -p "R_eyelid_lower_major_2_control_transform";
	rename -uid "CCCBB9CE-4141-1395-DBD2-2982D8CC3800";
	setAttr -l on -k off ".v";
	setAttr ".ovc" 13;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "R_eyelid_lower_major_2_controlShape" -p "R_eyelid_lower_major_2_control";
	rename -uid "8F8E0D04-4040-4D16-10B0-12BACF7481A4";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		-0.177045348544901 5.6084114391004655e-15 0.22863239210031944
		-0.12519002778115726 5.6007457690952011e-15 0.35382241988147695
		-5.5419704263131975e-16 5.5975705439602047e-15 0.40567774064522039
		0.12519002778115698 5.6007457690952011e-15 0.35382241988147695
		0.17704534854490017 5.6084114391004655e-15 0.22863239210031969
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		;
createNode nurbsCurve -n "R_eyelid_lower_major_2_controlShape1" -p "R_eyelid_lower_major_2_control";
	rename -uid "7BCBBBFA-4312-25A9-9B3F-39BF7FD50801";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		-0.177045348544901 5.5305287481218671e-15 0.22863239210031952
		-0.12519002778115726 0.12519002778116273 0.2286323921003196
		-5.5419704263131975e-16 0.17704534854490611 0.22863239210031952
		0.12519002778115698 0.12519002778116273 0.22863239210031952
		0.17704534854490017 5.6769235818639057e-15 0.22863239210031952
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		;
createNode nurbsCurve -n "R_eyelid_lower_major_2_controlShape2" -p "R_eyelid_lower_major_2_control";
	rename -uid "C2961502-406F-78A6-FFC3-C8BB5BE4364F";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		-5.00849752838054e-16 -0.17704534854489501 0.22863239210031944
		-5.00849752838054e-16 -0.12519002778115162 0.35382241988147695
		-4.9000885769779717e-16 5.5550641493071885e-15 0.40567774064522039
		-5.0749457619342127e-16 0.12519002778116273 0.35382241988147695
		-5.00849752838054e-16 0.17704534854490611 0.22863239210031969
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		;
createNode orientConstraint -n "R_eyelid_lower_major_2_control_orientConstraint1" 
		-p "R_eyelid_lower_major_2_control_transform";
	rename -uid "464BA9B5-4734-4517-30E6-7FBF0D8967CC";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 180 0 0 ;
	setAttr ".o" -type "double3" -141.740125 21.17439871230205 49.805161992388427 ;
	setAttr ".rsrr" -type "double3" 38.259875000000008 -21.174398712302047 -49.805161992388435 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_lower_major_2_joint_basis" -p "R_eyelid_lower_major_2_control_transform";
	rename -uid "3A6A58E8-4F99-5CAC-E911-D5974E0EFD2C";
	setAttr ".ovc" 13;
	setAttr -k on ".t" -type "double3" 0.00022437335265124148 0.00021293376710218581 
		-5.5875456034470972e-05 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" 0 0 -180 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s" -type "double3" 1.0000000000000004 0.99999999999999956 -0.99999999999999967 ;
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "R_eyelid_upper_major_1_control_transform" -p "eyelids_controls";
	rename -uid "68974C56-4891-E9AB-3014-48822B44D1B4";
	setAttr ".ovc" 13;
	setAttr ".s" -type "double3" 0.99999999999999978 0.99999999999999989 -0.99999999999999967 ;
createNode transform -n "R_eyelid_upper_major_1_control" -p "R_eyelid_upper_major_1_control_transform";
	rename -uid "DEC1BFFC-41F8-9BF3-34A6-3D934F88DF0E";
	setAttr -l on -k off ".v";
	setAttr ".ovc" 13;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "R_eyelid_upper_major_1_controlShape" -p "R_eyelid_upper_major_1_control";
	rename -uid "F7C93E10-4912-7568-5430-ABB6249DF069";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		-0.177045348544901 1.3419172865094541e-14 0.22863239210032002
		-0.12519002778115726 1.3411507195089278e-14 0.35382241988147717
		-5.5419704263131975e-16 1.3408331969954287e-14 0.40567774064522061
		0.12519002778115698 1.3411507195089278e-14 0.35382241988147717
		0.17704534854490017 1.3419172865094541e-14 0.22863239210032024
		0.12519002778115698 1.3426838535099797e-14 0.10344236431916359
		-5.2104850319842602e-16 1.3430013760234787e-14 0.051587043555419848
		-0.12519002778115726 1.3426838535099797e-14 0.10344236431916359
		;
createNode nurbsCurve -n "R_eyelid_upper_major_1_controlShape1" -p "R_eyelid_upper_major_1_control";
	rename -uid "E9550604-44A0-CB8B-594D-A4A39CD3A2D6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		-0.177045348544901 1.3341290174115952e-14 0.2286323921003201
		-0.12519002778115726 0.12519002778117058 0.22863239210032019
		-5.5419704263131975e-16 0.17704534854491411 0.2286323921003201
		0.12519002778115698 0.12519002778117058 0.2286323921003201
		0.17704534854490017 1.3487685007857976e-14 0.2286323921003201
		0.12519002778115698 -0.12519002778114383 0.2286323921003201
		-5.2104850319842602e-16 -0.17704534854488724 0.2286323921003201
		-0.12519002778115726 -0.12519002778114383 0.2286323921003201
		;
createNode nurbsCurve -n "R_eyelid_upper_major_1_controlShape2" -p "R_eyelid_upper_major_1_control";
	rename -uid "2F9165B1-4A3E-7F66-A462-9AB513E38902";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		-5.00849752838054e-16 -0.17704534854488724 0.22863239210032002
		-5.00849752838054e-16 -0.12519002778114383 0.35382241988147717
		-4.9000885769779717e-16 1.336582557530127e-14 0.40567774064522061
		-5.0749457619342127e-16 0.12519002778117058 0.35382241988147717
		-5.00849752838054e-16 0.17704534854491411 0.22863239210032024
		-4.8756010612731799e-16 0.12519002778117058 0.10344236431916359
		-5.1169064797831015e-16 1.3398974114734175e-14 0.051587043555419848
		-5.00849752838054e-16 -0.12519002778114383 0.10344236431916359
		;
createNode orientConstraint -n "R_eyelid_upper_major_1_control_orientConstraint1" 
		-p "R_eyelid_upper_major_1_control_transform";
	rename -uid "8AA39EF0-4454-2E2D-5271-6DB9B0D9C507";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 180 0 0 ;
	setAttr ".o" -type "double3" -178.134806 -12.695009501191704 22.922167103242369 ;
	setAttr ".rsrr" -type "double3" 1.8651940000000149 12.695009501191697 -22.922167103242369 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_upper_major_1_joint_basis" -p "R_eyelid_upper_major_1_control_transform";
	rename -uid "77410382-4947-F5D8-5D8B-E6A8C988F605";
	setAttr ".ovc" 13;
	setAttr -k on ".t" -type "double3" -0.00013643476964375623 -0.00034352114391822397 
		7.5824714727446008e-05 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" 0 0 179.99999999999986 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s" -type "double3" 0.99999999999999911 1.0000000000000007 -0.99999999999999967 ;
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "R_eyelid_upper_major_2_control_transform" -p "eyelids_controls";
	rename -uid "6EFB43F9-41DD-665B-DCB2-9B92CC23AC14";
	setAttr ".ovc" 13;
	setAttr ".s" -type "double3" 0.99999999999999978 1 -0.99999999999999989 ;
createNode transform -n "R_eyelid_upper_major_2_control" -p "R_eyelid_upper_major_2_control_transform";
	rename -uid "150A8A04-42A4-13C3-408F-55A2BD3F8C73";
	setAttr -l on -k off ".v";
	setAttr ".ovc" 13;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sx";
createNode nurbsCurve -n "R_eyelid_upper_major_2_controlShape" -p "R_eyelid_upper_major_2_control";
	rename -uid "1B3CBDDA-4DB4-BB7F-1F6D-C4B2A07168BF";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		-0.177045348544901 5.6084114391004655e-15 0.22863239210031944
		-0.12519002778115726 5.6007457690952011e-15 0.35382241988147695
		-5.5419704263131975e-16 5.5975705439602047e-15 0.40567774064522039
		0.12519002778115698 5.6007457690952011e-15 0.35382241988147695
		0.17704534854490017 5.6084114391004655e-15 0.22863239210031969
		0.12519002778115698 5.6160771091057213e-15 0.10344236431916207
		-5.2104850319842602e-16 5.6192523342407272e-15 0.051587043555418273
		-0.12519002778115726 5.6160771091057213e-15 0.10344236431916207
		;
createNode nurbsCurve -n "R_eyelid_upper_major_2_controlShape1" -p "R_eyelid_upper_major_2_control";
	rename -uid "0B2FEA23-4D17-BBF2-3AEC-45BCCE069923";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		-0.177045348544901 5.5305287481218671e-15 0.22863239210031952
		-0.12519002778115726 0.12519002778116273 0.2286323921003196
		-5.5419704263131975e-16 0.17704534854490611 0.22863239210031952
		0.12519002778115698 0.12519002778116273 0.22863239210031952
		0.17704534854490017 5.6769235818639057e-15 0.22863239210031952
		0.12519002778115698 -0.12519002778115162 0.22863239210031952
		-5.2104850319842602e-16 -0.17704534854489501 0.22863239210031952
		-0.12519002778115726 -0.12519002778115162 0.22863239210031952
		;
createNode nurbsCurve -n "R_eyelid_upper_major_2_controlShape2" -p "R_eyelid_upper_major_2_control";
	rename -uid "50392EED-49A9-5755-C850-6D8975BB76C9";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		-5.00849752838054e-16 -0.17704534854489501 0.22863239210031944
		-5.00849752838054e-16 -0.12519002778115162 0.35382241988147695
		-4.9000885769779717e-16 5.5550641493071885e-15 0.40567774064522039
		-5.0749457619342127e-16 0.12519002778116273 0.35382241988147695
		-5.00849752838054e-16 0.17704534854490611 0.22863239210031969
		-4.8756010612731799e-16 0.12519002778116273 0.10344236431916207
		-5.1169064797831015e-16 5.5882126887400965e-15 0.051587043555418273
		-5.00849752838054e-16 -0.12519002778115162 0.10344236431916207
		;
createNode orientConstraint -n "R_eyelid_upper_major_2_control_orientConstraint1" 
		-p "R_eyelid_upper_major_2_control_transform";
	rename -uid "3ABF28B0-40EB-D761-EFDE-F49E5B66D152";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".lr" -type "double3" 180 0 0 ;
	setAttr ".o" -type "double3" -192.43419499999996 40.158583321831387 -17.549303646245939 ;
	setAttr ".rsrr" -type "double3" -12.434194999999972 -40.158583321831394 17.549303646245942 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_upper_major_2_joint_basis" -p "R_eyelid_upper_major_2_control_transform";
	rename -uid "95B7EB00-4087-9C8A-1708-078FABE0D5BD";
	setAttr ".ovc" 13;
	setAttr -k on ".t" -type "double3" 5.5789920743620769e-05 -0.00022676505344065845 
		-6.0148930618453278e-06 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" 0 0 -179.99999999999986 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s" -type "double3" 0.99999999999999933 1.0000000000000011 -1.0000000000000004 ;
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "L_eye_transform_control" -p "eyelids_controls";
	rename -uid "4E3D0D3D-4226-AF52-EC83-7CA6C4471FAF";
	setAttr -l on -k off ".v";
createNode nurbsCurve -n "L_eye_transform_controlShape" -p "L_eye_transform_control";
	rename -uid "034A5F9C-492A-9094-EF0C-10874C47A35D";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		2.5688928681485494 0.12743034726783475 2.8013541099860531
		3.1130380701403029 0.12743034726783475 2.9099616526267535
		3.1130380701403029 0.67376405717834242 2.9099616526267535
		3.346211038057521 0.67376405717834242 2.9565013316738775
		3.346211038057521 0.12743034726783475 2.9565013316738775
		3.8903562400492735 0.12743034726783475 3.0651088743145753
		3.8903562400492735 -0.12743034726766495 3.0651088743145753
		3.346211038057521 -0.12743034726766495 2.9565013316738775
		3.346211038057521 -0.67376405717817189 2.9565013316738775
		3.1130380701403029 -0.67376405717817189 2.9099616526267535
		3.1130380701403029 -0.12743034726766495 2.9099616526267535
		2.5688928681485494 -0.12743034726766495 2.8013541099860531
		2.5688928681485494 0.12743034726783475 2.8013541099860531
		;
createNode transform -n "L_eyelid_upper_fold_main_1_control_transform" -p "L_eye_transform_control";
	rename -uid "1AE6178E-446B-DB84-4BC5-15AE33B02C3F";
	setAttr ".t" -type "double3" -1.0687763816436235 -0.074370924597616295 2.6837706713341296 ;
createNode aimConstraint -n "L_eyelid_upper_fold_main_1_control_aimConstraint1" -p
		 "L_eyelid_upper_fold_main_1_control_transform";
	rename -uid "22755162-47ED-D04C-9FA9-E4B507EE3836";
	addAttr -dcb 0 -ci true -sn "w0" -ln "L_eyelid_upper_fold_2_controlW0" -dv 1 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".wut" 1;
	setAttr ".o" -type "double3" 126.04367550954488 -19.047626641389598 -12.350883147637758 ;
	setAttr ".rsrr" -type "double3" 22.751797164732668 -8.8683305747324237 49.813299512351172 ;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_upper_fold_main_1_control" -p "L_eyelid_upper_fold_main_1_control_transform";
	rename -uid "A2390F3A-4BEE-E48F-2551-80957C5799F1";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_1_controlShape" -p "L_eyelid_upper_fold_main_1_control";
	rename -uid "9E266D90-42FF-BD6D-635E-DB8FB466BD8D";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_1_controlShape1" -p "L_eyelid_upper_fold_main_1_control";
	rename -uid "620BA3B9-4C11-1234-5D64-2CB4FEB383DF";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_1_controlShape2" -p "L_eyelid_upper_fold_main_1_control";
	rename -uid "043B9AA0-46F0-F034-A0BD-E082A181C6BE";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode transform -n "L_eyelid_upper_fold_main_3_control_transform" -p "L_eye_transform_control";
	rename -uid "2667C112-4BEB-9B5D-74E2-3DB4BF2E6A3A";
	setAttr ".t" -type "double3" 2.4831732386032637 0.21180766426957121 1.5319523958824695 ;
createNode aimConstraint -n "L_eyelid_upper_fold_main_3_control_aimConstraint1" -p
		 "L_eyelid_upper_fold_main_3_control_transform";
	rename -uid "FDD2A9AF-473C-3129-6867-BFAE91E64C75";
	addAttr -dcb 0 -ci true -sn "w0" -ln "L_eyelid_upper_fold_2_controlW0" -dv 1 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".a" -type "double3" -1 0 0 ;
	setAttr ".wut" 1;
	setAttr ".o" -type "double3" 118.16614710595704 12.908461777703408 5.22936009463512 ;
	setAttr ".rsrr" -type "double3" -7.3840303194675396 30.605384530217041 -40.706457324863472 ;
	setAttr -k on ".w0";
createNode transform -n "L_eyelid_upper_fold_main_3_control" -p "L_eyelid_upper_fold_main_3_control_transform";
	rename -uid "7364A85E-4ED3-53F0-E414-0EB8B4D7F280";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 1.4210854715202004e-14 -2.8421709430404007e-14 1.7763568394002505e-14 ;
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_3_controlShape" -p "L_eyelid_upper_fold_main_3_control";
	rename -uid "FF9B2668-4967-2C98-99CE-1F92A25346AA";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_3_controlShape1" -p "L_eyelid_upper_fold_main_3_control";
	rename -uid "9B86D3A0-4C14-458A-49F9-53A6E76FE5F0";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_3_controlShape2" -p "L_eyelid_upper_fold_main_3_control";
	rename -uid "FE228BF1-40EC-EA17-544D-41A4192E9DE6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode transform -n "L_eyelid_lower_main_control" -p "L_eye_transform_control";
	rename -uid "643E9A51-42BD-9CCB-16FD-DEACBF303678";
	addAttr -ci true -sn "eyelashInner" -ln "eyelashInner" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "eyelashOuter" -ln "eyelashOuter" -min -10 -max 10 -at "double";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -k on ".eyelashInner";
	setAttr -k on ".eyelashOuter";
createNode nurbsCurve -n "L_eyelid_lower_main_controlShape3" -p "L_eyelid_lower_main_control";
	rename -uid "B936B0E0-4B8E-F5EB-6672-27A6431EA075";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.66062404365084892 -0.29949532023276015 0.35733805993491879
		0.64126856123366327 -0.18042427949055861 0.497777917800726
		0.6093710785129629 0.24487916573790905 0.43288019485660717
		-0.69252152637154918 0.12580812499570745 0.29244033699079997
		-0.66062404365084892 -0.29949532023276015 0.35733805993491879
		;
createNode transform -n "L_eyelid_upper_main_control" -p "L_eye_transform_control";
	rename -uid "234DD680-4720-969C-8F2D-348DF7B2DD8E";
	addAttr -ci true -sn "eyelashInner" -ln "eyelashInner" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "eyelashOuter" -ln "eyelashOuter" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "blink" -ln "blink" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "blinkLine" -ln "blinkLine" -dv 0.5 -min 0 -max 1 -at "double";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -k on ".eyelashInner";
	setAttr -k on ".eyelashOuter";
	setAttr -k on ".blink";
	setAttr -k on ".blinkLine";
createNode nurbsCurve -n "L_eyelid_upper_main_controlShape3" -p "L_eyelid_upper_main_control";
	rename -uid "234F1F41-47E8-0A60-F721-21AACDCA8CBD";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.68586735107650765 -0.57505556966192128 0.23731847273804971
		0.62609530790481149 -0.62270179340347331 0.31018437611966126
		0.64175229546237245 -0.19157879110473769 0.31018437611966121
		-0.67021036351894669 -0.14393256736318566 0.23731847273804968
		-0.68586735107650765 -0.57505556966192128 0.23731847273804971
		;
createNode transform -n "L_eyelid_upper_fold_main_2_control_transform" -p "L_eye_transform_control";
	rename -uid "CEE0A849-4992-70EF-F56C-E4B335DED5F4";
	setAttr ".mntl" -type "double3" -1 0 -1 ;
	setAttr ".mtye" yes;
createNode transform -n "L_eyelid_upper_fold_main_2_control" -p "L_eyelid_upper_fold_main_2_control_transform";
	rename -uid "29854F13-4FC4-BFDD-02E8-11928C2DFB0C";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sz";
	setAttr ".opm" -type "matrix" 0.9841848991720793 0.017002205393616628 -0.17632642811954499 0
		 -0.017272840607519786 0.99985081336034665 2.1684043449710079e-19 0 0.17630012257225181 0.0030456582878021967 0.98433174831791492 0
		 0.82953368362584667 0.96999999999994202 2.7034554628990675 1;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_2_controlShape" -p "L_eyelid_upper_fold_main_2_control";
	rename -uid "8569DE59-4A98-4BAC-AF21-0BA5758BB980";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_2_controlShape1" -p "L_eyelid_upper_fold_main_2_control";
	rename -uid "2BFCED1C-4383-B409-39D6-81A534209F3B";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "L_eyelid_upper_fold_main_main_2_controlShape2" -p "L_eyelid_upper_fold_main_2_control";
	rename -uid "0AADC0B5-4770-7622-21A2-B498BA7E30EF";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode transform -n "L_eyelids_corner_inner_control_transform" -p "L_eye_transform_control";
	rename -uid "7521E03D-4F3F-7E48-97F6-8AA2D414B6B8";
	setAttr ".t" -type "double3" -4.4408920985006262e-16 -0.098413773653106773 -8.8817841970012523e-16 ;
	setAttr ".r" -type "double3" 7.0817037829461117e-16 3.211614785774684e-15 -5.9635400277440939e-16 ;
createNode transform -n "L_eyelids_corner_inner_control" -p "L_eyelids_corner_inner_control_transform";
	rename -uid "C73CAEA5-4F5D-1AF5-CB1C-D4A8AA4CC36B";
	setAttr -l on -k off ".v";
	setAttr -k on ".t" -type "double3" 0 -2.2204460492503131e-16 0 ;
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sy";
createNode nurbsCurve -n "L_eyelids_corner_inner_controlShape" -p "L_eyelids_corner_inner_control";
	rename -uid "778FBC07-4DC2-7074-7763-EA8DC8611679";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		1 3 0 no 3
		4 0 1 2 3
		4
		-0.2887865741773159 -0.27898811392946787 0.65065019189434092
		-0.39122414046856335 0.40791604333292808 0.54056738157031492
		0.15807733315611558 0.064409704436729331 0.14924535258598459
		-0.2887865741773159 -0.27898811392946787 0.65065019189434092
		;
createNode parentConstraint -n "L_eyelids_corner_inner_control_transform_parentConstraint1" 
		-p "L_eyelids_corner_inner_control_transform";
	rename -uid "EC640731-4379-FC06-2E2E-63A98746E7E1";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "L_eyelid_lower_main_controlW1" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr -s 2 ".tg";
	setAttr ".tg[1].tot" -type "double3" -0.24543928963299444 1.128704578308259 -2.4632644549928102 ;
	setAttr ".tg[1].tor" -type "double3" -8.1839327271862778 -20.650510385400057 2.6817130064736121 ;
	setAttr ".lr" -type "double3" 7.0817037829461117e-16 3.211614785774684e-15 -5.9635400277440939e-16 ;
	setAttr ".rst" -type "double3" -4.4408920985006262e-16 -2.8421709430404007e-14 -8.8817841970012523e-16 ;
	setAttr ".rsrr" -type "double3" 7.0817037829461117e-16 3.211614785774684e-15 -5.9635400277440939e-16 ;
	setAttr ".int" 2;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
	setAttr -k on ".w1" 0.45;
createNode transform -n "L_eyelids_corner_inner_tuner" -p "L_eyelids_corner_inner_control_transform";
	rename -uid "3B7C92FD-431F-F261-2A2F-BCA884EB45AA";
	setAttr ".t" -type "double3" -1.1834927922805254 -1.1740413347538947 2.4608616976402802 ;
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "L_eyelids_corner_inner_tunerShape" -p "L_eyelids_corner_inner_tuner";
	rename -uid "DFDC8683-4DDF-6A4B-D96D-E4AB29BC97A0";
	setAttr -k off ".v";
createNode transform -n "L_eyelids_corner_outer_control_transform" -p "L_eye_transform_control";
	rename -uid "9E9C0508-4C3F-15F5-25C2-E5972489E34A";
	setAttr ".t" -type "double3" 4.4408920985006262e-16 0.0012176680029938325 -8.8817841970012523e-16 ;
	setAttr ".r" -type "double3" -6.1765236001635255e-16 -9.6508181252555086e-18 -8.5193428967772765e-17 ;
createNode transform -n "L_eyelids_corner_outer_control" -p "L_eyelids_corner_outer_control_transform";
	rename -uid "3EAE7271-483F-2FC3-26F6-4B89236EE96E";
	setAttr -l on -k off ".v";
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sy";
createNode nurbsCurve -n "L_eyelids_corner_outer_controlShape" -p "L_eyelids_corner_outer_control";
	rename -uid "246C0FCE-40AF-C2D6-A2B9-4AB5199A2111";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		1 3 0 no 3
		4 0 1 2 3
		4
		0.40430322506003652 0.5565359458366359 0.25557928610788766
		0.64428999596038516 -0.096526386222101301 0.15377092879032642
		-0.10005395537257203 0.02216572750124092 0.08502568596981637
		0.40430322506003652 0.5565359458366359 0.25557928610788766
		;
createNode parentConstraint -n "L_eyelids_corner_outer_control_transform_parentConstraint1" 
		-p "L_eyelids_corner_outer_control_transform";
	rename -uid "D5DDE17B-47F4-05F5-09E3-809FDDECF51B";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "L_eyelid_upper_main_controlW1" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr -s 2 ".tg";
	setAttr ".tg[1].tot" -type "double3" -0.089431631246820409 -0.61399573580425226 
		-2.8149176669020548 ;
	setAttr ".tg[1].tor" -type "double3" 1.2912491014832563e-15 -16.621417090885949 
		-2.0798825997130916 ;
	setAttr ".lr" -type "double3" -6.1765236001635255e-16 -9.6508181252555086e-18 -8.5193428967772765e-17 ;
	setAttr ".rst" -type "double3" 4.4408920985006262e-16 0 -8.8817841970012523e-16 ;
	setAttr ".rsrr" -type "double3" -7.2059442001907804e-16 -1.1259287812798094e-17 
		-9.9392333795734899e-17 ;
	setAttr ".int" 2;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
	setAttr -k on ".w1" 0.75;
createNode transform -n "L_eyelids_corner_outer_tuner" -p "L_eyelids_corner_outer_control_transform";
	rename -uid "D74BA923-4452-A333-5A08-7E9FAEAB109F";
	setAttr ".t" -type "double3" 2.7408803575913026 0.071731980675792784 1.3554740099571783 ;
	setAttr ".r" -type "double3" 0 22.107368731061026 0 ;
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "L_eyelids_corner_outer_tunerShape" -p "L_eyelids_corner_outer_tuner";
	rename -uid "44375340-4E69-1AA3-4B08-6881F7582D1B";
	setAttr -k off ".v";
createNode transform -n "L_eyelids_upper_main_tuner" -p "L_eye_transform_control";
	rename -uid "43ACA018-4781-C57E-54E6-46BE818BF546";
	setAttr ".t" -type "double3" 0.86948333915867915 0.61683696114457121 2.6781077532433208 ;
	setAttr ".r" -type "double3" 0 14.228647417799271 0 ;
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "L_eyelids_upper_main_tunerShape" -p "L_eyelids_upper_main_tuner";
	rename -uid "8D9DB780-4439-4A8E-72A1-D7B5A566ADE1";
	setAttr -k off ".v";
createNode transform -n "L_eyelids_lower_main_tuner" -p "L_eye_transform_control";
	rename -uid "6BCB8B06-4922-2F0F-0AFE-0EBFFB4E5240";
	setAttr ".t" -type "double3" 1.048713075486801 -1.4458156267460254 2.0522437243126532 ;
	setAttr ".r" -type "double3" 0 17.215550802426399 0 ;
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "L_eyelids_lower_main_tunerShape" -p "L_eyelids_lower_main_tuner";
	rename -uid "5C5E3E96-4E40-A59C-E907-D1B999EED58B";
	setAttr -k off ".v";
createNode transform -n "R_eye_transform_control" -p "eyelids_controls";
	rename -uid "BAB13040-48EF-55FF-CFC8-8699E4F27476";
	setAttr -l on -k off ".v";
	setAttr ".ovc" 13;
createNode nurbsCurve -n "R_eye_transform_controlShape" -p "R_eye_transform_control";
	rename -uid "DF48591B-4052-9384-5344-92BAB1057669";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		1 12 0 no 3
		13 0 1 2 3 4 5 6 7 8 9 10 11 12
		13
		2.5688928681485494 0.12743034726783475 2.8013541099860531
		3.1130380701403029 0.12743034726783475 2.9099616526267535
		3.1130380701403029 0.67376405717834242 2.9099616526267535
		3.346211038057521 0.67376405717834242 2.9565013316738775
		3.346211038057521 0.12743034726783475 2.9565013316738775
		3.8903562400492735 0.12743034726783475 3.0651088743145753
		3.8903562400492735 -0.12743034726766495 3.0651088743145753
		3.346211038057521 -0.12743034726766495 2.9565013316738775
		3.346211038057521 -0.67376405717817189 2.9565013316738775
		3.1130380701403029 -0.67376405717817189 2.9099616526267535
		3.1130380701403029 -0.12743034726766495 2.9099616526267535
		2.5688928681485494 -0.12743034726766495 2.8013541099860531
		2.5688928681485494 0.12743034726783475 2.8013541099860531
		;
createNode transform -n "R_eyelid_upper_fold_main_1_control_transform" -p "R_eye_transform_control";
	rename -uid "16E64F58-43F3-9F89-BC42-3489FE0DE70F";
	setAttr ".s" -type "double3" 0.99999999999999989 0.99999999999999967 0.99999999999999967 ;
createNode transform -n "R_eyelid_upper_fold_main_1_control" -p "R_eyelid_upper_fold_main_1_control_transform";
	rename -uid "3755A68C-4DAF-84E7-5639-58B1D410559F";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_1_controlShape" -p "R_eyelid_upper_fold_main_1_control";
	rename -uid "CDBBF6D5-4900-3191-06BB-9A83ED6A660E";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_1_controlShape1" -p "R_eyelid_upper_fold_main_1_control";
	rename -uid "584730F7-4C46-27F1-54E0-0F886D872121";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_1_controlShape2" -p "R_eyelid_upper_fold_main_1_control";
	rename -uid "44E7F549-44F5-B515-2505-53970386105E";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode aimConstraint -n "R_eyelid_upper_fold_main_1_control_aimConstraint1" -p
		 "R_eyelid_upper_fold_main_1_control_transform";
	rename -uid "8329E6BB-4F8F-4414-18D8-FFB31E75E69F";
	addAttr -dcb 0 -ci true -sn "w0" -ln "R_eyelid_upper_fold_2_controlW0" -dv 1 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".wut" 1;
	setAttr ".rsrr" -type "double3" 22.751797000000021 -8.8683305747324326 49.813299512351207 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_upper_fold_main_3_control_transform" -p "R_eye_transform_control";
	rename -uid "5DCA880E-42AE-AD9E-7C44-0A8A845B938E";
	setAttr ".s" -type "double3" 0.99999999999999989 0.99999999999999989 0.99999999999999978 ;
createNode transform -n "R_eyelid_upper_fold_main_3_control" -p "R_eyelid_upper_fold_main_3_control_transform";
	rename -uid "919D82ED-4B97-0FCE-A28B-D9A7A84BA3BD";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 1.4210854715202004e-14 2.8421709430404007e-14 0 ;
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_3_controlShape" -p "R_eyelid_upper_fold_main_3_control";
	rename -uid "0D306F0E-42B0-3775-B000-BDAAB1CA825B";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_3_controlShape1" -p "R_eyelid_upper_fold_main_3_control";
	rename -uid "B0A4F100-4B72-4980-5B5A-8D8BC679E91E";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_3_controlShape2" -p "R_eyelid_upper_fold_main_3_control";
	rename -uid "6D512549-4C26-51C0-FAD5-AD8762F118F4";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode aimConstraint -n "R_eyelid_upper_fold_main_3_control_aimConstraint1" -p
		 "R_eyelid_upper_fold_main_3_control_transform";
	rename -uid "31B21215-4036-BE7D-0AE4-1EB259F642C7";
	addAttr -dcb 0 -ci true -sn "w0" -ln "R_eyelid_upper_fold_2_controlW0" -dv 1 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".a" -type "double3" -1 0 0 ;
	setAttr ".wut" 1;
	setAttr ".rsrr" -type "double3" -7.3840299999999912 30.605384530217016 -40.706457324863479 ;
	setAttr -k on ".w0";
createNode transform -n "R_eyelid_lower_main_control" -p "R_eye_transform_control";
	rename -uid "86121414-4AD3-64B5-D5BC-FBAE9B1EC312";
	addAttr -ci true -sn "eyelashInner" -ln "eyelashInner" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "eyelashOuter" -ln "eyelashOuter" -min -10 -max 10 -at "double";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -k on ".eyelashInner";
	setAttr -k on ".eyelashOuter";
createNode nurbsCurve -n "R_eyelid_lower_main_controlShape3" -p "R_eyelid_lower_main_control";
	rename -uid "C3E93396-4CA5-0A20-4FEE-EDA0E2A9ADC7";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.68668048989358399 -0.22809502210183824 0.35733805993491508
		0.62041329722866834 -0.25275468679586505 0.49777791780072222
		0.63542752475568565 0.17347886760698641 0.43288019485660345
		-0.67166626236656668 0.19813853230101325 0.2924403369907963
		-0.68668048989358399 -0.22809502210183824 0.35733805993491508
		;
createNode transform -n "R_eyelid_upper_main_control" -p "R_eye_transform_control";
	rename -uid "F652F2E1-4737-641A-AC6F-82B01C2D10B4";
	addAttr -ci true -sn "eyelashInner" -ln "eyelashInner" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "eyelashOuter" -ln "eyelashOuter" -min -10 -max 10 -at "double";
	addAttr -ci true -sn "blink" -ln "blink" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "blinkLine" -ln "blinkLine" -dv 0.5 -min 0 -max 1 -at "double";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr -k on ".eyelashInner";
	setAttr -k on ".eyelashOuter";
	setAttr -k on ".blink";
	setAttr -k on ".blinkLine";
createNode nurbsCurve -n "R_eyelid_upper_main_controlShape3" -p "R_eyelid_upper_main_control";
	rename -uid "A58C6E5F-4BA6-093A-EDDB-6897D9CB6297";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.6858673510765082 -0.57505556966192106 0.23731847273804965
		0.62609530790481027 -0.62270179340347309 0.31018437611966121
		0.64175229546237123 -0.19157879110473763 0.31018437611966115
		-0.67021036351894725 -0.1439325673631856 0.23731847273804962
		-0.6858673510765082 -0.57505556966192106 0.23731847273804965
		;
createNode transform -n "R_eyelid_upper_fold_main_2_control_transform" -p "R_eye_transform_control";
	rename -uid "9691745F-4F57-D851-26C9-03AEE16ABBD0";
	setAttr ".mntl" -type "double3" -1 0 -1 ;
	setAttr ".mtye" yes;
createNode transform -n "R_eyelid_upper_fold_main_2_control" -p "R_eyelid_upper_fold_main_2_control_transform";
	rename -uid "A7875EE1-411C-DB9B-36E9-35879B9875D8";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 1.6653345369377348e-16 -9.9920072216264089e-16 4.4408920985006262e-16 ;
	setAttr -l on -k off ".rx";
	setAttr ".s" -type "double3" 0.99999999999999989 0.99999999999999978 1 ;
	setAttr -l on -k off ".sz";
	setAttr ".opm" -type "matrix" 0.9841848991720793 0.017002205393616614 -0.1763264281195446 0
		 -0.017272840607519772 0.99985081336034665 2.1684043449710084e-19 0 0.17630012257225139 0.0030456582878021863 0.9843317483179147 0
		 0.82953368362584534 0.96999999999999997 2.703455462899071 1;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_2_controlShape" -p "R_eyelid_upper_fold_main_2_control";
	rename -uid "E6149193-44BA-758A-1339-4E833AF621EE";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-0.15595308142680053 2.7671689552574416e-33 0.071961299357257105
		-0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		-4.6991769608216332e-17 -9.5493669641314808e-18 0.22791438078405768
		0.11027553537463761 -6.752421728934314e-18 0.18223683473189475
		0.15595308142680053 -5.1289781124327856e-33 0.07196129935725723
		0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		-1.7792375713682334e-17 9.5493669641314808e-18 -0.083991782069543386
		-0.11027553537463761 6.752421728934314e-18 -0.03831423601738046
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_2_controlShape1" -p "R_eyelid_upper_fold_main_2_control";
	rename -uid "A114C081-4380-40D3-DAC7-A4A1F8675F6B";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-0.15595308142680053 -6.8604149997438088e-17 0.071961299357257175
		-0.11027553537463761 0.11027553537463761 0.071961299357257189
		-4.6991769608216332e-17 0.15595308142680053 0.071961299357257147
		0.11027553537463761 0.11027553537463761 0.071961299357257175
		0.15595308142680053 6.0349960430627771e-17 0.071961299357257175
		0.11027553537463761 -0.11027553537463761 0.071961299357257175
		-1.7792375713682334e-17 -0.15595308142680053 0.071961299357257147
		-0.11027553537463761 -0.11027553537463761 0.071961299357257175
		;
createNode nurbsCurve -n "R_eyelid_upper_fold_main_main_2_controlShape2" -p "R_eyelid_upper_fold_main_2_control";
	rename -uid "9037DC8A-4193-0348-DE45-AF8573C9B4EE";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		-3.3638000345718391e-34 -0.15595308142680053 0.071961299357257105
		-3.3638000345718391e-34 -0.11027553537463761 0.18223683473189475
		9.5493669641314808e-18 -4.6991769608216332e-17 0.22791438078405768
		-5.8531934689240155e-18 0.11027553537463761 0.18223683473189475
		-3.3638000345718391e-34 0.15595308142680053 0.07196129935725723
		1.1706386937848031e-17 0.11027553537463761 -0.03831423601738046
		-9.5493669641314808e-18 -1.7792375713682334e-17 -0.083991782069543386
		-3.3638000345718391e-34 -0.11027553537463761 -0.03831423601738046
		;
createNode transform -n "R_eyelids_corner_inner_control_transform" -p "R_eye_transform_control";
	rename -uid "E4819281-4153-6DF3-5A37-8B86CAE79CC9";
	setAttr ".t" -type "double3" 0 -0.098413776978048872 8.8817841970012523e-16 ;
	setAttr ".r" -type "double3" 7.4544250346801169e-16 1.6089134033184587e-15 -3.975693351829396e-16 ;
createNode transform -n "R_eyelids_corner_inner_control" -p "R_eyelids_corner_inner_control_transform";
	rename -uid "B16462E0-473A-9749-22AD-6DA75065616C";
	setAttr -l on -k off ".v";
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sy";
createNode nurbsCurve -n "R_eyelids_corner_inner_controlShape" -p "R_eyelids_corner_inner_control";
	rename -uid "39A171B7-49E9-1F2F-4DF8-118A28D1994E";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		1 3 0 no 3
		4 0 1 2 3
		4
		-0.2887865741773159 -0.27898811392946787 0.65065019189434092
		-0.39122414046856335 0.40791604333292808 0.54056738157031492
		0.15807733315611558 0.064409704436729331 0.14924535258598459
		-0.2887865741773159 -0.27898811392946787 0.65065019189434092
		;
createNode parentConstraint -n "R_eyelids_corner_inner_control_transform_parentConstraint1" 
		-p "R_eyelids_corner_inner_control_transform";
	rename -uid "069A8F4C-41F6-65B8-A570-E2A7A4B4D076";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "R_eyelid_lower_main_controlW1" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr -s 2 ".tg";
	setAttr ".tg[0].tot" -type "double3" -4.4408920985006262e-16 -2.8421709430404007e-14 
		-8.8817841970012523e-16 ;
	setAttr ".tg[1].tot" -type "double3" -0.24543928963299488 1.1287045675945251 -2.4632644599020015 ;
	setAttr ".tg[1].tor" -type "double3" -8.1839329932080993 -20.650510373740421 2.6817131002906511 ;
	setAttr ".lr" -type "double3" 7.4544250346801169e-16 1.6089134033184587e-15 -3.975693351829396e-16 ;
	setAttr ".rst" -type "double3" 0 -2.8421709430404007e-14 8.8817841970012523e-16 ;
	setAttr ".rsrr" -type "double3" 7.4544250346801169e-16 1.6089134033184587e-15 -3.975693351829396e-16 ;
	setAttr ".int" 2;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
	setAttr -k on ".w1";
createNode transform -n "R_eyelids_corner_outer_control_transform" -p "R_eye_transform_control";
	rename -uid "4E992BD7-44CC-F769-593D-BB89C1EEC356";
	setAttr ".t" -type "double3" 8.8817841970012523e-16 0.0012176680029369891 -1.7763568394002505e-15 ;
	setAttr ".r" -type "double3" -1.1430118386509513e-15 -3.1984142414424379e-15 -4.4415949164969038e-16 ;
createNode transform -n "R_eyelids_corner_outer_control" -p "R_eyelids_corner_outer_control_transform";
	rename -uid "B041E118-436F-9778-8DC4-69AE819B8851";
	setAttr -l on -k off ".v";
	setAttr -k on ".t" -type "double3" 8.8817841970012523e-16 0 0 ;
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sz";
	setAttr -l on -k off ".sy";
createNode nurbsCurve -n "R_eyelids_corner_outer_controlShape" -p "R_eyelids_corner_outer_control";
	rename -uid "32380506-4531-22DE-7C6A-2385BE5933E9";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		1 3 0 no 3
		4 0 1 2 3
		4
		0.40430322506003652 0.5565359458366359 0.25557928610788766
		0.64428999596038516 -0.096526386222101301 0.15377092879032642
		-0.10005395537257203 0.02216572750124092 0.08502568596981637
		0.40430322506003652 0.5565359458366359 0.25557928610788766
		;
createNode parentConstraint -n "R_eyelids_corner_outer_control_transform_parentConstraint1" 
		-p "R_eyelids_corner_outer_control_transform";
	rename -uid "2F204B5B-4DAC-D9A0-2D13-E6A08E7C0CEC";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_eye_transform_controlW0" -dv 1 
		-min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "R_eyelid_upper_main_controlW1" -dv 
		1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr -s 2 ".tg";
	setAttr ".tg[0].tot" -type "double3" -4.4408920985006262e-16 -2.8421709430404007e-14 
		-8.8817841970012523e-16 ;
	setAttr ".tg[1].tot" -type "double3" -0.089431631246820409 -0.61399573580430911 
		-2.8149176669020513 ;
	setAttr ".tg[1].tor" -type "double3" 1.9865370792050099e-15 -16.621417090885945 
		-2.0798825997130925 ;
	setAttr ".lr" -type "double3" -1.1430118386509513e-15 -3.1984142414424379e-15 -4.4415949164969038e-16 ;
	setAttr ".rst" -type "double3" 8.8817841970012523e-16 -2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr ".rsrr" -type "double3" -1.1430118386509513e-15 -3.1984142414424379e-15 
		-4.4415949164969038e-16 ;
	setAttr ".int" 2;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
	setAttr -k on ".w1";
createNode transform -n "L_eyelids_transform_tuner";
	rename -uid "1D86E294-4D41-38AE-BD84-7CA60E4112BB";
	setAttr ".t" -type "double3" 3.0255651473999023 160.14830017089844 7.3534097671508789 ;
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "L_eyelids_transform_tunerShape" -p "L_eyelids_transform_tuner";
	rename -uid "CDD81405-4C47-B88F-706C-0588A9390D47";
	setAttr -k off ".v";
createNode transform -n "R_eyelids_transform_tuner";
	rename -uid "987C7561-41E1-C76F-9C0D-BC99D912BD14";
	setAttr ".r" -type "double3" 0 180 0 ;
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr ".s" -type "double3" 1 1 -1 ;
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode locator -n "R_eyelids_transform_tunerShape" -p "R_eyelids_transform_tuner";
	rename -uid "998E0529-49B0-EA80-B313-75BCA9D1466A";
	setAttr -k off ".v";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "092BF6B0-4E1C-3490-987C-268FEC3291E1";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "DD5D53A1-4E53-6E69-C82B-98AFF2B94043";
	setAttr -s 9 ".bsdt";
	setAttr ".bsdt[0].bscd" -type "Int32Array" 2 4 5 ;
	setAttr ".bsdt[1].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[2].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[2].bspi" 1;
	setAttr ".bsdt[3].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[3].bspi" 2;
	setAttr ".bsdt[4].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[4].bspi" 3;
	setAttr ".bsdt[5].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[5].bspi" 4;
	setAttr ".bsdt[6].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[6].bspi" 5;
	setAttr ".bsdt[7].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[7].bspi" 6;
	setAttr ".bsdt[8].bscd" -type "Int32Array" 0 ;
	setAttr ".bsdt[8].bspi" 7;
	setAttr -s 2 ".bspr";
	setAttr -s 2 ".obsv";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "3D6B12E0-4B1C-78A5-07A0-4594BE7DA0C0";
	setAttr -s 2 ".tpdt";
	setAttr ".tpdt[0].tpcd" -type "Int32Array" 1 -1 ;
	setAttr ".tpdt[1].tpcd" -type "Int32Array" 0 ;
	setAttr ".tpdt[1].tpdn" -type "string" "chr_abendis_MDL_Model_v010_fix";
createNode displayLayerManager -n "layerManager";
	rename -uid "E81F95A1-4F1E-EDA9-090A-C1AE90EF2D48";
createNode displayLayer -n "defaultLayer";
	rename -uid "9E8B42AB-4BF5-DAB9-7C6A-E5AA0822CA3A";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "BA39A7FC-467D-67A8-4344-7DA48D6907BA";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "4CFE04FF-4860-69A8-4D68-BD989CFA5CAF";
	setAttr ".g" yes;
createNode renderLayerManager -n "renderLayerManager1";
	rename -uid "D1EF412F-4282-B546-2AD1-D9A382F0A4C7";
	setAttr -s 5 ".rlmi[1:4]"  1 2 3 4;
	setAttr -s 4 ".rlmi";
createNode renderLayer -n "defaultRenderLayer1";
	rename -uid "390A05B6-4472-ADE2-BBA9-0589475045E7";
	setAttr ".g" yes;
	setAttr ".rndr" no;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "C10C713A-4421-4A67-A3DC-978D6580A999";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 625 -ast 0 -aet 625 ";
	setAttr ".st" 6;
createNode objectSet -s -n "lightEditorRoot";
	rename -uid "CA7A23C3-413C-59E8-F323-428CA569D21B";
	addAttr -ci true -sn "isolate" -ln "isolate" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "wasEnabled" -ln "wasEnabled" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "childIndex" -ln "childIndex" -dv -1 -at "long";
	addAttr -ci true -sn "lightGroup" -ln "lightGroup" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "visibility" -ln "visibility" -dv 1 -min 0 -max 1 -at "bool";
lockNode -l 1 ;
createNode renderSetup -n "renderSetup";
	rename -uid "25BE708A-4095-F459-7FC0-6BB5189D1DD5";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
createNode renderSetupLayer -n "shades";
	rename -uid "BEA605C9-4441-8641-DEEC-12899DF16134";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderLayer -n "rs_shades";
	rename -uid "5F8DFE7E-4676-25FF-774D-FC984251C461";
	setAttr ".do" 1;
createNode collection -n "collection1";
	rename -uid "99697E5D-42F4-FDCA-7FBB-0E8D98F03C35";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection1Selector";
	rename -uid "F1DCDCC0-4FA6-D3B1-7436-AFA832450D79";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "floatConstant1_col";
	rename -uid "DEF0DBBE-4F41-50F0-B52C-5A9BCDCD818A";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_colSelector";
	rename -uid "D6534548-473A-EE76-D6C0-32832AB0EFB9";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "chr_shared_SHD_baseShading:shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat";
	rename -uid "63F29ACD-4FF8-7F02-69DF-888A468B069D";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr ".es" yes;
createNode collection -n "FILTER_BOX";
	rename -uid "921085EE-4C60-C348-75DB-52A612EB9B0A";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "FILTER_BOXSelector";
	rename -uid "0DDEECAF-4BE0-D400-D88C-F693D04C3935";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride2";
	rename -uid "1D2DD636-4EAB-0C4E-3425-B2AE72D309A5";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "box";
	setAttr ".es" yes;
createNode renderSetupLayer -n "lines";
	rename -uid "4D54D3E8-48FC-359D-F1E4-1AA645DE286F";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderLayer -n "rs_lines";
	rename -uid "22BDE1B0-478C-3FA7-7BC0-B39713ADAEA7";
	setAttr ".do" 2;
createNode collection -n "collection2";
	rename -uid "A703AE36-40DD-E667-4361-C2987F447778";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection2Selector";
	rename -uid "FAF194CB-4DB3-EED6-3ECE-08AECE0F8D7C";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "floatConstant1_col1";
	rename -uid "91E3A06F-47CA-9F30-6FAF-DFADBCEE881D";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_col1Selector";
	rename -uid "1851E126-4225-3ACD-B5C4-8185F4B18435";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "chr_shared_SHD_baseShading:shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat1";
	rename -uid "80AC5F46-497A-0C82-EF25-0798DF53E6CA";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 1;
	setAttr ".es" yes;
createNode collection -n "FILTER_CON";
	rename -uid "6095C7DA-4C9D-CCFF-F19B-D59ACC33B41F";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
createNode simpleSelector -n "FILTER_CONSelector";
	rename -uid "EC7A13CC-47D5-9DBE-63BC-41AEB96A8DBE";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride1";
	rename -uid "3A5F1DD7-4786-3A5B-E84F-62B222C0EED4";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "contour";
	setAttr ".es" yes;
createNode absOverride -n "inFloat2";
	rename -uid "24925FB8-45C4-A499-F431-1C94006F14AC";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 1;
	setAttr ".es" yes;
createNode collection -n "floatConstant1_col2";
	rename -uid "0C251292-469D-D4ED-AE10-86BD3FEFF4C9";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_col1Selector1";
	rename -uid "52B76B38-4209-2B18-E66F-25B025CF359F";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode collection -n "collection3";
	rename -uid "314C5B40-46C8-D7E2-CC4E-85910FF2B542";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection2Selector1";
	rename -uid "057C028E-407F-AEB6-5F0C-17AEA3A838C5";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode renderSetupLayer -n "lines1";
	rename -uid "AE607AE8-402C-E31D-9677-31BD3CAC7642";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderLayer -n "rs_lines1";
	rename -uid "CC04AA51-4D00-1348-7BD4-D4B6B64E2CDB";
	setAttr ".do" 3;
createNode renderSetupLayer -n "shades1";
	rename -uid "A8E97945-44F9-AB46-9D09-0F813D84EF34";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderSetup -n "renderSetup1";
	rename -uid "69CFAF42-4CF0-9666-F4E5-12B8AC357FE1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
createNode collection -n "collection4";
	rename -uid "2114D003-4814-2E90-EACF-2D88F6536675";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection1Selector1";
	rename -uid "D3D9643F-4EE3-9C79-4DDD-22A16313FC7D";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "FILTER_BOX1";
	rename -uid "0E5B2980-43A3-C780-6ACF-0FBDEBFC6A80";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "FILTER_BOXSelector1";
	rename -uid "1D05DBD5-4771-65C3-AF01-288728323D9E";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode collection -n "floatConstant1_col3";
	rename -uid "E3DBF799-4D9F-4DD2-B6BA-1E865515FDF9";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_colSelector1";
	rename -uid "5D509B31-4B0F-58F7-F131-E4819F39A51D";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat3";
	rename -uid "353A8E27-41C3-1F7F-86AA-338940D41E2D";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr ".es" yes;
createNode absOverride -n "absOverride3";
	rename -uid "2E1B1167-4D01-FD14-9114-D8A571FBBF40";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "box";
	setAttr ".es" yes;
createNode collection -n "FILTER_CON1";
	rename -uid "450C3D29-4B5D-70BC-5031-C08A099F918F";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
createNode simpleSelector -n "FILTER_CONSelector1";
	rename -uid "33253B78-4EF5-7418-9A29-8EA52829F404";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride4";
	rename -uid "8BD60392-41B3-9F34-5BB4-F3A513B68AB4";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "contour";
	setAttr ".es" yes;
createNode collection -n "HIDE_NOLINE";
	rename -uid "1D883A43-40FC-E107-CF59-6A820C183F96";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "collection6Selector";
	rename -uid "DDDD1576-433C-79F4-D59F-AEB8DD6D2C75";
	setAttr ".pat" -type "string" "*_noline*";
	setAttr ".ppa" -type "string" "*_noline*";
createNode absOverride -n "visibility1";
	rename -uid "354BC1AB-4849-F92E-6BCC-1683C4530B56";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr ".es" yes;
createNode collection -n "HIDE_PLANKS";
	rename -uid "6912F090-46A0-B7C6-7368-B3BF0BCE60C8";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "collection7Selector";
	rename -uid "FFC6C0DA-49EB-8854-115A-9CA2B511FA8D";
	setAttr ".pat" -type "string" "*_plank*";
	setAttr ".ppa" -type "string" "*_plank*";
createNode absOverride -n "visibility2";
	rename -uid "5243DAB7-4AB5-18FF-2585-2BBEDEDF9758";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr -k on ".atv" yes;
	setAttr ".es" yes;
createNode absOverride -n "inFloat4";
	rename -uid "5920476E-48BC-DD0B-4724-2188E9BCC6D0";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 2.5999999046325684;
	setAttr ".es" yes;
createNode collection -n "threshold_multiplier_var";
	rename -uid "F9605967-4810-FD9C-2CFB-A5B00BF99453";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "threshold_multiplier1_floatConstantSelector";
	rename -uid "861CA69D-4BDF-CAF0-422D-4EA30B00476D";
	setAttr ".pat" -type "string" "*threshold_multiplier*";
	setAttr ".ppa" -type "string" "*threshold_multiplier*";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode renderSettingsCollection -n "RenderSettingsCollection";
	rename -uid "CA85EDC3-4E89-908C-D314-C39270603049";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "RenderSettingsCollectionSelector";
	rename -uid "88D07957-4AB1-C606-921C-919447BDAB3E";
	setAttr ".ssl" -type "string" "defaultArnoldFilter\ndefaultArnoldRenderOptions\ndefaultArnoldDriver\ndefaultResolution\ndefaultRenderGlobals\ndefaultRenderQuality";
	setAttr ".tf" 0;
createNode absUniqueOverride -n "enableAdaptiveSampling";
	rename -uid "9D2F31D6-45AE-1FD4-DB25-DE8683E9B05F";
	addAttr -ci true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "enableAdaptiveSampling";
	setAttr ".tgName" -type "string" "defaultArnoldRenderOptions";
	setAttr ".es" yes;
createNode renderLayerManager -n "renderLayerManager2";
	rename -uid "9E85547A-4719-B259-1FD7-C5BD0670120F";
	setAttr -s 5 ".rlmi[1:4]"  1 2 3 4;
createNode renderLayer -n "defaultRenderLayer2";
	rename -uid "2FE03BC0-44AD-E93D-5426-96A5F1FE823A";
	setAttr ".g" yes;
	setAttr ".rndr" no;
createNode renderSetup -n "renderSetup2";
	rename -uid "B6C57268-4B2D-7114-C515-698B48144AD6";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
createNode renderSetupLayer -n "shades2";
	rename -uid "965A2C1E-4099-6DFA-12A8-AFB381B5816A";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode collection -n "collection8";
	rename -uid "CD46CA45-4D63-7E8A-9785-89948DA12584";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection1Selector2";
	rename -uid "7C1B490B-45C6-2A96-2055-F38C6FE7DB10";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "floatConstant1_col4";
	rename -uid "B7811DF4-451B-CE55-0FF3-D09687BFB53C";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "floatConstant1_colSelector2";
	rename -uid "1ADBB839-487B-FB38-C056-E58C8073658B";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat5";
	rename -uid "930C5600-48B2-8B3F-3A90-BEA541E8A608";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr ".es" yes;
createNode collection -n "FILTER_BOX2";
	rename -uid "FEB1B5E0-4514-2773-4E92-6FA1900DE4DF";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
createNode simpleSelector -n "FILTER_BOXSelector2";
	rename -uid "89BDBB1A-42F0-7070-50F9-EA8675F2B1F3";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride6";
	rename -uid "1A77D2A2-4179-FEC7-A103-19B4C94A9BFA";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "box";
	setAttr ".es" yes;
createNode renderSetupLayer -n "lines2";
	rename -uid "4A1B8083-42D1-3FBE-5D74-FB952F528F1A";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode collection -n "collection9";
	rename -uid "DE97B354-4375-9D27-AE94-A4ACFDCD91BA";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection2Selector2";
	rename -uid "9E4FD745-4051-4C46-7942-1FA8669C0A7C";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "floatConstant1_col5";
	rename -uid "0A958045-43A0-29E2-9267-5C9A8AB22896";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_col1Selector2";
	rename -uid "E55FDE61-4E16-EF51-0447-0AB4B1F6B213";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat6";
	rename -uid "92B4E6DF-4421-7E32-CC78-DAABFD6B9BAD";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 1;
	setAttr ".es" yes;
createNode collection -n "FILTER_CON2";
	rename -uid "029A4C7D-46EC-6315-3217-218166CB7E25";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "FILTER_CONSelector2";
	rename -uid "A01A601C-4070-22EE-0E92-94953A056DE7";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride5";
	rename -uid "8255480C-4141-993E-C515-53AA6AE7CA84";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "contour";
	setAttr ".es" yes;
createNode absOverride -n "inFloat7";
	rename -uid "0ADF96F4-430B-11E5-3F00-999362B2923E";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 1;
	setAttr ".es" yes;
createNode collection -n "floatConstant1_col6";
	rename -uid "D0E029D7-41D7-0C60-2E54-A794B85C86AD";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_col1Selector3";
	rename -uid "36658F2E-41D1-4F91-9486-5A8009FDC0A4";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode collection -n "collection10";
	rename -uid "CEC1616C-4A59-D03B-6A91-5CA15A083F91";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection2Selector3";
	rename -uid "5DA58168-4F2A-F1AE-E6D7-25AF919D8135";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode renderSetupLayer -n "lines3";
	rename -uid "55EAC7B5-4BB8-1F64-07C0-6FA1789D2426";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderSetupLayer -n "shades3";
	rename -uid "2AA91CCC-483C-0E56-4FED-D2BE0844071A";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderSetup -n "renderSetup3";
	rename -uid "B39B9E69-4D77-2A59-EA05-80A641742F42";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
createNode collection -n "FILTER_CON3";
	rename -uid "5C16691B-4C06-3F0A-E010-81B573A206CB";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
createNode simpleSelector -n "FILTER_CONSelector3";
	rename -uid "1E8652E6-4884-7301-2618-1D991D49B759";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride7";
	rename -uid "BA967133-4137-9BA6-0C72-65BAC3402987";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "contour";
	setAttr ".es" yes;
createNode collection -n "HIDE_NOLINE1";
	rename -uid "0019B037-4118-1263-5F13-17AFA768BE4F";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection6Selector1";
	rename -uid "AB248817-4B04-3B97-564C-E8BB182D28E3";
	setAttr ".pat" -type "string" "*_noline*";
	setAttr ".ppa" -type "string" "*_noline*";
createNode absOverride -n "visibility3";
	rename -uid "1140BFEE-45E9-F47E-2F7C-328783EBA011";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr ".es" yes;
createNode collection -n "HIDE_PLANKS1";
	rename -uid "D8B5ADA6-4628-5D88-81EA-64A897C0ADBB";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection7Selector1";
	rename -uid "9B1C4697-42A6-94DA-8B29-CC976985A563";
	setAttr ".pat" -type "string" "*_plank*";
	setAttr ".ppa" -type "string" "*_plank*";
createNode absOverride -n "visibility4";
	rename -uid "B88E795F-4B42-C0F2-CF62-7EBB55C2B514";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr ".es" yes;
createNode absOverride -n "inFloat8";
	rename -uid "5F7876D8-4E12-5DDD-30AD-1BAD53CFC4A9";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr -k on ".atv" 2.5999999046325684;
	setAttr ".es" yes;
createNode collection -n "threshold_multiplier_var1";
	rename -uid "B6EB99EB-45C8-A331-7193-6894C50C33D1";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "threshold_multiplier1_floatConstantSelector1";
	rename -uid "148388B2-4E45-D036-69ED-8FA3D16B8885";
	setAttr ".pat" -type "string" "*threshold_multiplier*";
	setAttr ".ppa" -type "string" "*threshold_multiplier*";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode renderSettingsCollection -n "RenderSettingsCollection1";
	rename -uid "329FBAC8-4827-6B2D-EC65-8EA88DA96442";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "RenderSettingsCollectionSelector1";
	rename -uid "7D34FE3D-4694-5CC9-AE0B-2D94BCD6ACB3";
	setAttr ".ssl" -type "string" "defaultArnoldFilter\ndefaultArnoldRenderOptions\ndefaultArnoldDriver\ndefaultResolution\ndefaultRenderGlobals\ndefaultRenderQuality";
	setAttr ".tf" 0;
createNode absUniqueOverride -n "enableAdaptiveSampling1";
	rename -uid "4548076D-4CD6-0CE5-57C2-EFB40FF3B853";
	addAttr -ci true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "enableAdaptiveSampling";
	setAttr ".tgName" -type "string" "defaultArnoldRenderOptions";
	setAttr ".es" yes;
createNode collection -n "_untitled_";
	rename -uid "D4281545-43BC-EC73-1422-5CBD928B2481";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "_untitled_Selector";
	rename -uid "C8BC4B21-4607-08A7-1CE5-E2A592357F53";
	setAttr ".ssl" -type "string" (
		"|group\n|geo|Base|Body\n|Help\n|geo|Base|GN_Duplicate:Hair_orig_geo\n|geo|Base|GN_Duplicate:Hair_orig_geo\n|Hair_Divided_Hair_geo14\n|Hair_Divided_Hair_geo14\n|geo|Armor|GN_Duplicate:Waist_geo1\n|geo|Armor|GN_Duplicate:Waist_geo1\n|geo|Armor|GN_Duplicate:Throusers_inner_geo2\n|geo|Armor|GN_Duplicate:Throusers_inner_geo2\n|geo|Armor|GN_Duplicate:BeltSmall_geo\n|geo|Armor|GN_Duplicate:BeltSmall_geo\n|geo|Armor|GN_Duplicate:Belt_geo\n|geo|Armor|GN_Duplicate:Belt_geo\n|geo|Armor|GN_Duplicate:HipArmor_geo\n|geo|Armor|GN_Duplicate:HipArmor_geo\n|geo|Roderik1\n|geo|Roderik1|Head\n|geo|Roderik1|Head|nose_lines_camera_rig_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|nose_camera_rig_R_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_planks_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|nose_camera_rig_F_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_skincap_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_chin_line_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|nose_camera_rig_L_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_chin_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|nose_camera_rig_R_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_plank_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|nose_camera_rig_F_R_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_skincap_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|nose_camera_rig_L_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|nose_camera_rig_R_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_skintone_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|nose_camera_rig_F_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_skintone_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|nose_camera_rig_L_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_skintone_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|Camera_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|Camera_grp|nose_camera_rig_view\n"
		+ "|geo|Roderik1|Head|Lashes_geo_noline\n|geo|Roderik1|Head|Tongue_geo\n|geo|Roderik1|Head|Teeth_geo\n|geo|Roderik1|Head|Eyebrows_geo2\n|geo|Roderik1|Head|EyeShadow_geo_noline\n|geo|Roderik1|Head|Eyes_geo_noline\n|geo|Roderik1|Head|EyesShine_geo_noline\n|geo|Roderik1|Head|Eyefolds_geo_plank_noline\n|geo|Roderik1|Head|Lip_line_geo_plank\n|geo|Roderik1|Head|Eyebrows_geo3\n|geo|Roderik1|Throusers_geo\n|geo|Roderik1|Boots_old\n|geo|Roderik1|Boots_old|Boots_geo1\n|geo|Roderik1|Boots_old|Boots_geo\n|geo|Roderik1|Boots_old|Bootsbelt_geo1\n|geo|Roderik1|Boots_old|Boots_armor_geo1\n|geo|Roderik1|Boots_old|Boostnose_geo2\n|geo|Roderik1|Boots_old|Boostnose_geo6\n|geo|Roderik1|Boots_old|Boostnose_geo5\n|geo|Roderik1|Boots_old|Boostnose_geo5_2\n|geo|Roderik1|Boots_old|Boots_Upper_geo2\n|geo|Roderik1|Waist\n|geo|Roderik1|Waist|WaistBelt1_geo\n|geo|Roderik1|Waist|WaistBelt1_geo1\n|geo|Roderik1|Waist|WaistBelt2_geo\n|geo|Roderik1|Waist|WaistBelt2_geo1\n|geo|Roderik1|Waist|WaistBelt3_geo\n|geo|Roderik1|Waist|WaistBelt3_geo1\n|geo|Roderik1|Waist|WaistBelt4_geo\n"
		+ "|geo|Roderik1|Waist|Wast_upper_geo\n|geo|Roderik1|Waist|Wast_upper_geo1\n|geo|Roderik1|Waist|Waist_Details_geo\n|geo|Roderik1|Shirt\n|geo|Roderik1|Shirt|Shirt_Collar_Geo\n|geo|Roderik1|Shirt|Knot\n|geo|Roderik1|Shirt|Shirt_geo4_5\n|geo|Roderik1|Body\n|geo|Roderik1|Body|Body_torso_geo6\n|geo|Roderik1|Body|Body_legs_geo\n|geo|Roderik1|Body|Body_Head_geo\n|geo|Roderik1|Hair_orig_geo\n|geo|Roderik1|Hair_Divided\n|geo|Roderik1|Hair_Divided|pSphere1\n|geo|Roderik1|Hair_Divided|Hair_Divided_Hair_geo9\n|geo|Roderik1|Hair_Divided|Hair_Divided_Hair_geo8\n|geo|Roderik1|Hair_Divided|Recovered_Tool1\n|geo|Roderik1|Hair_Divided|Hair_Divided_Hair_geo14\n|geo|Roderik1|Hair_Divided|Hair_Divided_Hair_geo15\n|geo|Roderik1|Body_Head_geo1\n|geo|Armor1\n|geo|Armor1|Boots\n|geo|Armor1|Boots|Boots_geo1\n|geo|Armor1|Boots|Boots_geo\n|geo|Armor1|Mantle\n|geo|Armor1|Mantle|Transit_Maya_Mantle_geo\n|geo|Armor1|Mantle|Scarf_geo\n|geo|Armor1|Mantle|Transit_Maya_Cloak_geo\n|geo|Armor1|Mantle|Cloak_geo\n|geo|Armor1|Mantle|Mantle_geo\n|geo|Armor1|Collar_geo\n|geo|Armor1|Medallion_chain_geo\n"
		+ "|geo|Armor1|Medallion_geo1\n|geo|Armor1|Quirass_geo\n|geo|Armor1|QuirassDecor_geo\n|geo|Armor1|Boots1\n|geo|Armor1|Boots1|Boots_armor_geo1\n|geo|Armor1|Boots1|Boostnose_geo2\n|geo|Armor1|Boots1|Boostnose_geo6\n|geo|Armor1|Boots1|boots_geo3\n|geo|Armor1|Boots1|Boostnose_geo5\n|geo|Armor1|Boots1|Bootsbelt_geo1\n|geo|Armor1|Boots1|boots_geo5\n|geo|Armor1|Boots1|boots_geo6\n|geo|Armor1|Arms1\n|geo|Armor1|Arms1|Shoulderpads_geo\n|geo|Armor1|Arms1|Elbow_cloth_geo\n|geo|Armor1|Arms1|Forearms_armor_geo\n|geo|Armor1|Arms1|Sleeves_geo\n|geo|Armor1|Arms1|Cloth_buttons_geo\n|geo|Armor1|Arms1|ArmBelts_geo\n|geo|Armor1|Arms1|Hands_armor_geo1\n|geo|Armor1|Arms1|Hands_armor_geo\n|geo|Armor1|Arms1|Hands_armor_geo3\n|geo|Armor1|Arms1|Hands_armor_geo2\n|geo|Armor1|Arms1|Glove2\n|geo|Armor1|Arms1|Hands_armor_geo4\n|geo|Armor1|Arms1|Shoulderpads_amall_geo\n|geo|Armor1|Belt_geo\n|geo|Armor1|BeltClip_geo\n|geo|Armor1|BeltSmall_geo\n|geo|Armor1|Chain_geo\n|geo|Armor1|Bootsclips_geo2\n|geo|Armor1|Buckle_geo1\n|geo|Armor1|Buckle_geo\n|geo|Armor1|GoldBelt_geo1\n|geo|Armor1|HipArmor_geo\n"
		+ "|geo|Armor1|Pendants_geo\n|geo|Armor1|Waist_geo\n|geo|Armor1|Boots2\n|geo|Armor1|Boots2|boots_geo4\n|geo|Armor1|Boots2|Boots_knee_belts_geo\n|geo|Armor1|Waist_geo1\n|geo|Armor1|Throusers_inner_geo2\n|geo|Armor1|WaistCloth_geo\n|geo|Armor1|Throusers_geo1\n|geo|Armor|Arms|GN_Duplicate:Sleeves_geo\n|geo|Armor|Arms|GN_Duplicate:Sleeves_geo\n|geo|Armor|Boots2|GN_Duplicate:Boots_knee_belts_geo\n|geo|Armor|Boots2|GN_Duplicate:Boots_knee_belts_geo\n|geo|Armor|Boots1|GN_Duplicate:Boostnose_geo6\n|geo|Armor|Boots1|GN_Duplicate:Boostnose_geo6\n|geo|Armor|Boots1|GN_Duplicate:Boostnose_geo5\n|geo|Armor|Boots1|GN_Duplicate:Boostnose_geo5\n|geo|Armor|Boots2|GN_Duplicate:boots_geo4\n|geo|Armor|Boots2|GN_Duplicate:boots_geo4\n|geo|Armor|GN_Duplicate:boots_geo5\n|geo|Armor|GN_Duplicate:boots_geo5\n|geo|Armor|GN_Duplicate:boots_geo7\n|geo|Armor|GN_Duplicate:boots_geo7\n|geo|Armor|GN_Duplicate:Quirass_geo2\n|geo|Armor|GN_Duplicate:Quirass_geo2\n|geo|Base|Hair_Divided|GN_Duplicate:Hair_Divided_Hair_geo20\n|geo|Base|Hair_Divided|GN_Duplicate:Hair_Divided_Hair_geo20\n"
		+ "|Hair_Divided_Hair_geo20\n|Hair_Divided_Hair_geo20\n|geo|Armor|Boots1|Bootsbelt_geo2\n|geo|Armor|Boots1|Boots_armor_geo2\n|geo|Armor|Boots1|boots_geo8\n|geo|Armor|Boots1|Boostnose_geo7\n|geo|Armor|Boots1|Boostnose_geo8\n|geo|Armor|Boots1|Boostnose_geo9\n|geo|Base|Boots_old|group1\n|Help\n|geo|Base|Head\n|geo|Base|Head|nose_lines_camera_rig_grp1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_profile_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_profile_grp|Profile_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_profile_grp|Profile_skincap_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_profile_grp|Profile_Nostrils_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|nose_camera_rig_R_d_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_skincap_geo\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_Nostrils_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_planks_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|nose_camera_rig_F_d_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_Nostrils_old\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_skincap_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_chin_line_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|nose_camera_rig_L_d_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_Nostrils_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_chin_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_skincap_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|nose_camera_rig_R_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_Nostrils_plank_geo\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_skincap_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_Nostrils_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_skincap_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|nose_camera_rig_F_R_nose_line_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_Nostrils_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_skincap_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|nose_camera_rig_L_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_Nostrils_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_skincap_geo\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|nose_camera_rig_R_u_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_skintone_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|nose_camera_rig_F_u_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_skintone_geo\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|nose_camera_rig_L_u_nose_proxy\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_skintone_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|Camera_grp\n|geo|Base|Head|nose_lines_camera_rig_grp1|Camera_grp|nose_camera_rig_view\n|geo|Base|Head|Lashes_geo_noline\n|geo|Base|Head|Tongue_geo\n|geo|Base|Head|Teeth_geo\n|geo|Base|Head|EyeShadow_geo_noline\n|geo|Base|Head|Eyes_geo_noline\n|geo|Base|Head|EyesShine_geo_noline\n|geo|Base|Head|Eyefolds_geo_plank\n|geo|Base|Head|Lip_line_geo_plank\n|geo|Base|Head|Eyebrows_geo\n|geo|Base|Head|Head_OLD\n|New_head_meshses\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_plank_geo\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|Camera_grp|nose_camera_rig_view|nose_camera_rig_viewShape->|imagePlane1\n|geo|Base|Head|CheekLines_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_nosewings_plank_geo\n|geo|Base|Head|GN_Duplicate:Head_geo\n|geo|Base|Head|GN_Duplicate:Head_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|GN_Duplicate:F_D_nosewings_plank_geo\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|GN_Duplicate:F_D_nosewings_plank_geo\n|geo|Base|Head|GN_Duplicate:Eyebrows_geo3\n|geo|Base|Head|GN_Duplicate:Eyebrows_geo3\n|geo|Base|Head|GN_Duplicate:Eyes_geo_noline\n|geo|Base|Head|GN_Duplicate:Eyes_geo_noline\n|geo|Base|GN_Duplicate:Hair_Divided_Hair_geo21\n|geo|Base|GN_Duplicate:Hair_Divided_Hair_geo21\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|GN_Duplicate:F_L_plank_geo1\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|GN_Duplicate:F_L_plank_geo1\n|geo|Base|Head|GN_Duplicate:Lashes_geo_noline\n|geo|Base|Head|GN_Duplicate:Lashes_geo_noline\n|geo|Base|Head|GN_Duplicate:EyeShadow_geo_noline\n|geo|Base|Head|GN_Duplicate:EyeShadow_geo_noline\n|geo|Base|Head|GN_Duplicate:Eyefolds_geo_plank\n|geo|Base|Head|GN_Duplicate:Eyefolds_geo_plank\n|geo|Base|Hair\n|geo|Cloth|trousers_geo1");
createNode collection -n "_untitled_1";
	rename -uid "9FF4CAF8-42E7-DBCE-BAF9-DF805ABC9F0E";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "_untitled_1Selector";
	rename -uid "A1AAEE3B-4E8D-4DFD-B6F2-9A994B70446C";
	setAttr ".ssl" -type "string" (
		"|geo|Roderik1|Head|EyesShine_geo1\n|geo|Armor|Boots1|GN_Duplicate:boots_geo4\n|geo|Armor|Boots1|GN_Duplicate:boots_geo4\n|OLD_char_roderic_rotate1|Armor|boots_geo6\n|Help\n|OLD_char_roderic_rotate1|Armor|Arms1|Sleeves_geo1\n|geo|Roderik1\n|geo|Roderik1|Body_Head_geo\n|geo|Roderik1|Head\n|geo|Roderik1|Head|nose_lines_camera_rig_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_profile_grp|Profile_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|nose_camera_rig_R_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_skincap_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_d_nose_grp|R_D_planks_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|nose_camera_rig_F_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_chin_line_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_d_nose_grp|F_D_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|nose_camera_rig_L_d_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_chin_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|nose_camera_rig_R_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_Nostrils_plank_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_nose_grp|R_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|nose_camera_rig_F_L_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_L_nose_line_grp|F_L_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|nose_camera_rig_F_R_nose_line_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_nose_grp|nose_camera_rig_F_R_nose_line_grp|F_R_skincap_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|nose_camera_rig_L_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_Nostrils_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_skincap_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|nose_camera_rig_R_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_R_u_nose_grp|R_U_skintone_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|nose_camera_rig_F_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_F_u_nose_grp|F_U_skintone_geo\n"
		+ "|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|nose_camera_rig_L_u_nose_proxy\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_skintone_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|nose_camera_rig_no_profile_grp|nose_camera_rig_L_u_nose_grp|L_U_plank_geo\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|Camera_grp\n|geo|Roderik1|Head|nose_lines_camera_rig_grp|Camera_grp|nose_camera_rig_view\n|geo|Roderik1|Head|Lashes_geo2\n|geo|Roderik1|Head|Tongue_geo\n|geo|Roderik1|Head|Teeth_geo\n|geo|Roderik1|Head|Eyebrows_geo2\n|geo|Roderik1|Head|EyeShadow_geo_noline\n|geo|Roderik1|Head|Eyes_geo_noline\n|geo|Roderik1|Head|EyesShine_geo_noline\n|geo|Roderik1|Head|Eyefolds_geo_plank\n|geo|Roderik1|Head|Lip_line_geo\n|geo|Roderik1|Hair\n|geo|Roderik1|Hair|Hair_geo2\n|geo|Roderik1|Hair|Hair_geo3\n|geo|Roderik1|Hair|Hair_geo5\n"
		+ "|geo|Roderik1|Hair|Hair_geo6\n|geo|Roderik1|Hair|Hair_geo7\n|geo|Roderik1|Hair|Hair_geo4\n|geo|Roderik1|Hair|Hair_geo8\n|geo|Roderik1|Throusers_geo\n|geo|Roderik1|Boots_old\n|geo|Roderik1|Boots_old|Boots_geo1\n|geo|Roderik1|Boots_old|Boots_geo\n|geo|Roderik1|Boots_old|Bootsbelt_geo1\n|geo|Roderik1|Boots_old|Boots_armor_geo1\n|geo|Roderik1|Boots_old|Boostnose_geo2\n|geo|Roderik1|Boots_old|Boostnose_geo6\n|geo|Roderik1|Boots_old|Boostnose_geo5\n|geo|Roderik1|Boots_old|Boostnose_geo5_2\n|geo|Roderik1|Boots_old|Boots_Upper_geo2\n|geo|Roderik1|Waist\n|geo|Roderik1|Waist|WaistBelt1_geo\n|geo|Roderik1|Waist|WaistBelt1_geo1\n|geo|Roderik1|Waist|WaistBelt2_geo\n|geo|Roderik1|Waist|WaistBelt2_geo1\n|geo|Roderik1|Waist|WaistBelt3_geo\n|geo|Roderik1|Waist|WaistBelt3_geo1\n|geo|Roderik1|Waist|WaistBelt4_geo\n|geo|Roderik1|Waist|Wast_upper_geo\n|geo|Roderik1|Waist|Wast_upper_geo1\n|geo|Roderik1|Waist|Waist_Details_geo\n|geo|Roderik1|Shirt\n|geo|Roderik1|Shirt|Shirt_Collar_Geo\n|geo|Roderik1|Shirt|Knot\n|geo|Roderik1|Shirt|Shirt_geo4_5\n|geo|Roderik1|Body\n"
		+ "|geo|Roderik1|Body|Body_torso_geo6\n|geo|Roderik1|Body|Body_legs_geo\n|geo|Armor1\n|geo|Armor1|Belt_geo\n|geo|Armor1|BeltClip_geo\n|geo|Armor1|BeltSmall_geo\n|geo|Armor1|Chain_geo\n|geo|Armor1|WaistCloth_geo\n|geo|Armor1|Boots\n|geo|Armor1|Boots|Boots_geo1\n|geo|Armor1|Boots|Boots_geo\n|geo|Armor1|Mantle\n|geo|Armor1|Mantle|Transit_Maya_Mantle_geo\n|geo|Armor1|Mantle|Scarf_geo\n|geo|Armor1|Mantle|Transit_Maya_Cloak_geo\n|geo|Armor1|Mantle|Cloak_geo\n|geo|Armor1|Mantle|Mantle_geo\n|geo|Armor1|Bootsclips_geo\n|geo|Armor1|Buckle_geo1\n|geo|Armor1|Buckle_geo\n|geo|Armor1|Collar_geo\n|geo|Armor1|GoldBelt_geo\n|geo|Armor1|HipArmor_geo\n|geo|Armor1|Medallion_chain_geo\n|geo|Armor1|Medallion_geo1\n|geo|Armor1|Medallion_geo\n|geo|Armor1|Pendants_geo\n|geo|Armor1|Quirass_geo\n|geo|Armor1|QuirassDecor_geo\n|geo|Armor1|Shoulderpads_amall_geo\n|geo|Armor1|Waist_geo\n|geo|Armor1|Boots1\n|geo|Armor1|Boots1|Boots_armor_geo1\n|geo|Armor1|Boots1|Boostnose_geo2\n|geo|Armor1|Boots1|Boostnose_geo6\n|geo|Armor1|Boots1|boots_geo4\n|geo|Armor1|Boots1|boots_geo3\n|geo|Armor1|Boots1|Boots_knee_belts_geo\n"
		+ "|geo|Armor1|Boots1|Boostnose_geo5\n|geo|Armor1|Boots1|Bootsbelt_geo1\n|geo|Armor1|Boots1|boots_geo5\n|geo|Armor1|Boots1|boots_geo6\n|geo|Armor1|Arms1\n|geo|Armor1|Arms1|Shoulderpads_geo\n|geo|Armor1|Arms1|Elbow_cloth_geo\n|geo|Armor1|Arms1|Forearms_armor_geo\n|geo|Armor1|Arms1|Sleeves_geo\n|geo|Armor1|Arms1|Cloth_buttons_geo\n|geo|Armor1|Arms1|ArmBelts_geo\n|geo|Armor1|Arms1|Hands_armor_geo1\n|geo|Armor1|Arms1|Hands_armor_geo\n|geo|Armor1|Arms1|Hands_armor_geo3\n|geo|Armor1|Arms1|Hands_armor_geo2\n|geo|Armor1|Arms1|Glove2\n|geo|Armor1|Arms1|Hands_armor_geo4\n|geo|Armor1|Waist_geo1\n|geo|WaistCloth_geo1\n|geo|Throusers_geo3\n|geo|Throusers_geo4\n|geo|Base|Hair_Divided\n|geo|Base|Hair_Divided|Hair_geo2\n|geo|Base|Hair_Divided|Hair_geo3\n|geo|Base|Hair_Divided|Hair_geo5\n|geo|Base|Hair_Divided|Hair_geo6\n|geo|Base|Hair_Divided|Hair_geo7\n|geo|Base|Hair_Divided|Hair_geo4\n|geo|Base|Hair_Divided|Hair_geo8\n|pSphere\n|Hair_Divided_Hair_geo2\n|transform2\n|transform3\n|transform4\n|transform5\n|Hair_Divided_Hair_geo8\n|geo|Base|Body|GN_Duplicate:Body_torso_geo6\n"
		+ "|geo|Base|Body|GN_Duplicate:Body_torso_geo6\n|geo|Base|Body|GN_Duplicate:Body_legs_geo\n|geo|Base|Body|GN_Duplicate:Body_legs_geo\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo4\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo4\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo8\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo8\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo7\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo7\n|Hair_geo8\n|transform6\n|geo|Base|Hair_orig|Hair_geo9\n|Hair_geo9\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo9\n|geo|Base|Hair_orig|GN_Duplicate:Hair_geo9\n|geo|Base|Hair_orig|Hair_geo10\n|Hair_Divided_Hair_geo13\n|Hair_Divided_Hair_geo13\n|Hair_Divided_Hair_geo13\n|Hair_Divided_Hair_geo13\n|Hair_Divided_Hair_geo13\n|Hair_Divided_Hair_geo13\n|geo|Base|Hair_orig|GN_Duplicate:Hair_Divided_Hair_geo9\n|geo|Base|Hair_orig|GN_Duplicate:Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n"
		+ "|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo9\n|Hair_Divided_Hair_geo10\n|Hair_Divided_Hair_geo10\n|geo|Base|Hair_orig|Hair_Divided_Hair_geo16\n|geo|Base|Hair_orig|Hair_Divided_Hair_geo17\n|geo|Base|Hair_orig|Recovered_Tool1\n|Recovered_Tool1\n|Roderik_Hair_orig_Recovered_Tool\n|geo|Base|Hair_orig_geo1\n|geo|Base|pasted__Hair_orig|GN_Duplicate:pasted__Hair_geo9\n|geo|Base|pasted__Hair_orig|GN_Duplicate:pasted__Hair_geo9\n|geo|Armor|GN_Duplicate:boots_geo7\n|geo|Armor|GN_Duplicate:boots_geo7\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_nose_grp|L_Nostrils_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_chin_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_Nostrils_plank_geo1\n|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_skincap_geo1\n"
		+ "|geo|Base|Head|nose_lines_camera_rig_grp1|nose_camera_rig_no_profile_grp|nose_camera_rig_L_d_nose_grp|L_D_plank_geo1\n|geo|Base|Body|Neck2\n|geo|Base|Body|Askard_body_full_no_head_no_neck1\n|geo|Base|Body|Askard_body_full_no_head_no_neck2\n|geo|Base|Body|Neck3\n|Neck1\n|bluePencil\n|Neck2\n|Askard_body_full_no_head_no_neck2\n|Neck3");
createNode collection -n "collection11";
	rename -uid "4EA6FFF4-4FF1-84EE-CA80-25928246E499";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "collection1Selector3";
	rename -uid "C5B36672-4EB8-73B7-6514-8FA74E441D6B";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "floatConstant1_col7";
	rename -uid "C8D4A817-4444-E898-9DBC-5AB2115CC60C";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "floatConstant1_colSelector3";
	rename -uid "9717FB5C-4FB1-6F6A-EF09-8FAB9CADA9A4";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "inFloat9";
	rename -uid "D0D359FB-4599-C607-7E6B-E5B1AF3357B0";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr ".es" yes;
createNode collection -n "FILTER_BOX3";
	rename -uid "135FB230-48EB-F1A3-0426-51B5A5AC5803";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "FILTER_BOXSelector3";
	rename -uid "9B2B9519-4A39-B993-B1F1-EABFDB00E2F7";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "absOverride8";
	rename -uid "1CD87339-45F9-1FB3-046D-6798978B0F6F";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "box";
	setAttr ".es" yes;
createNode simpleSelector -n "HIDE_PLANKSSelector1";
	rename -uid "D2B14835-4505-B5E8-5E74-7B8309000CFD";
	setAttr ".pat" -type "string" "*_plank*";
	setAttr ".ppa" -type "string" "*_plank*";
createNode absOverride -n "visibility5";
	rename -uid "F09CBD35-4CC1-FB41-3052-0DA3FA592E76";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr ".es" yes;
createNode renderLayerManager -n "template_Nose_System_dummy_renderLayerManager";
	rename -uid "7E49F42E-496E-A3C3-0445-91A08D93A34A";
	setAttr -s 5 ".rlmi[1:4]"  1 2 3 4;
createNode renderLayer -n "template_Nose_System_dummy_defaultRenderLayer";
	rename -uid "4F7CAA8D-4D83-9453-436B-0C816C693ACD";
	setAttr ".g" yes;
	setAttr ".rndr" no;
createNode renderSetupLayer -n "template_Nose_System_dummy_lines1";
	rename -uid "0757B77D-44C5-B037-E69F-1F827BDFE0E9";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderSetupLayer -n "template_Nose_System_dummy_shades1";
	rename -uid "22D0A67B-4476-6EB8-F55C-5990C4399FDB";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode renderSetup -n "template_Nose_System_dummy_renderSetup1";
	rename -uid "A52A3289-4B4D-73A1-49FD-1B8531F34DA8";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
createNode collection -n "template_dummy_collection1";
	rename -uid "213F681A-46F5-C7B1-A290-79BA0ABDB40E";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "template_dummy_collection1Selector";
	rename -uid "F8F9DC90-436B-68B3-FAC0-7AB35F1773AD";
	setAttr ".pat" -type "string" "*";
	setAttr ".ppa" -type "string" "*";
createNode collection -n "template_dummy_floatConstant1_col";
	rename -uid "48283846-42DA-4F82-B68A-A5A10C5C6559";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "template_dummy_floatConstant1_colSelector";
	rename -uid "87A40930-4E80-A382-5247-3B865D1625C0";
	setAttr ".pat" -type "string" "*shaderswitcher*";
	setAttr ".ppa" -type "string" "*shaderswitcher*";
	setAttr ".ssl" -type "string" "shaderswitcher";
	setAttr ".tf" 8;
	setAttr ".cfv" -type "string" "floatConstant";
createNode absOverride -n "template_dummy_inFloat";
	rename -uid "85CA8792-43C6-2450-314F-ABABC6C358D7";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -at "float";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "inFloat";
	setAttr ".es" yes;
createNode collection -n "template_dummy_FILTER_BOX";
	rename -uid "5A30FA1A-415D-FA1D-4551-7F9669B68055";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "template_dummy_FILTER_BOXSelector";
	rename -uid "B9E60CA3-4BB5-8D69-C187-D9ACE158E166";
	setAttr ".pat" -type "string" "defaultArnoldFilter";
	setAttr ".ppa" -type "string" "defaultArnoldFilter";
	setAttr ".tf" 0;
createNode absOverride -n "template_dummy_absOverride2";
	rename -uid "4850C09A-4C12-32C2-FFAF-C596ABC4BE70";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "atv" -ln "attrValue" -dt "string";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "aiTranslator";
	setAttr ".atv" -type "string" "box";
	setAttr ".es" yes;
createNode simpleSelector -n "HIDE_PLANKSSelector";
	rename -uid "A0DD96AF-4039-3C51-8754-7A9380435FAE";
	setAttr ".pat" -type "string" "*_plank*";
	setAttr ".ppa" -type "string" "*_plank*";
createNode absOverride -n "template_dummy_visibility2";
	rename -uid "50B17578-4A98-24F7-B388-4BBE24C2F87E";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	addAttr -ci true -sn "lc" -ln "labelColor" -dt "string";
	addAttr -ci true -sn "imp" -ln "imported" -dv 1 -min 0 -max 1 -at "bool";
	addAttr -ci true -k true -sn "atv" -ln "attrValue" -min 0 -max 1 -at "bool";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".atr" -type "string" "visibility";
	setAttr ".es" yes;
createNode collection -n "_untitled_2";
	rename -uid "91BB407A-4AC9-4C5C-D789-0DACA053D22A";
	addAttr -ci true -sn "es" -ln "expandedState" -min 0 -max 1 -at "bool";
	setAttr ".es" yes;
createNode simpleSelector -n "_untitled_2Selector";
	rename -uid "DFF22CB9-4DCE-FB3A-0865-32874514DA4E";
	setAttr ".ssl" -type "string" (
		"|Geometry|planks_grp|nose_front_plank4\n|Geometry|planks_grp|eye_plan_geo7\n|BS2\n|BS2|eyelashes_geo_noline1\n|BS2|body_geo2\n|BS2|eye_plan_geo2\n|BS2|eyes_shadows_geo_noline3\n|BS2|group3\n|BS2|group3|eyes_shadows_geo_noline1\n|BS2|group3|eye_plan_geo1\n|BS2|group3|eyelashes_geo_noline2\n|BS2|group3|body_geo1\n|BS2|group3|group4\n|BS2|group3|group4|hair_geo2\n|BS2|group3|group4|glare_geo_noline1\n|BS2|group3|group4|eyes_geo_noline1\n|BS2|group3|group4|brows_geo3\n|BS2|group3|nose_front_plank2\n|BS_03|group5\n|BS_03|group6\n|Geometry|brows_geo_new\n|Geometry|brows_geo7\n|Geometry|body_geo6\n|Geometry|body_geo7\n|Geometry|bsh_L02\n|Geometry|eyes_grp|eyelashes_geo_noline8\n|Geometry|planks_grp|eye_plan_geo8\n|Geometry|eyes_grp|eyes_shadows_geo_noline4\n|Geometry|eye_plan_geo9\n|Geometry|bsh_R02\n|Geometry|bsh_L01\n|Geometry|bsh_L01|body_geo6\n|Geometry|bsh_L01|eye_plan_geo9\n|Geometry|bsh_L01|eyelashes_geo_noline8\n|Geometry|bsh_L01|eyes_shadows_geo_noline4\n|Geometry|bsh_R01\n|Geometry|bsh_R01|body_geo6\n|Geometry|bsh_R01|eye_plan_geo9\n|Geometry|bsh_R01|eyelashes_geo_noline\n"
		+ "|Geometry|bsh_R01|eyes_shadows_geo_noline\n|Geometry|group10\n|Geometry|group10|body_geo6\n|Geometry|group10|eye_plan_geo9\n|Geometry|group10|eyelashes_geo_noline8\n|Geometry|group10|eyes_shadows_geo_noline4\n|Geometry|bsh\n|eyelashes_geo_noline7\n|transform1\n|transform2\n|transform3\n|transform4\n|transform5\n|transform6\n|transform7\n|Geometry|bsh|bst_test02\n|Geometry|bsh|bst_test02|body_geo\n|Geometry|bsh|bst_test02|eye_plan_geo9\n|Geometry|bsh|bst_test02|eyelashes_geo_noline8\n|Geometry|bsh|bst_test02|eyes_shadows_geo_noline4");
createNode skeleposer -n "body_skeleposer";
	rename -uid "3CFC332B-4B71-23AD-3344-2285CBAC8D81";
	addAttr -s false -ci true -sn "dagPose" -ln "dagPose" -at "message";
	addAttr -ci true -sn "connectionsData" -ln "connectionsData" -dt "string";
	addAttr -ci true -sn "splitPosesData" -ln "splitPosesData" -dt "string";
	setAttr ".cch" no;
	setAttr ".fzn" no;
	setAttr ".ihi" 2;
	setAttr ".nds" 0;
	setAttr -s 20 ".baseMatrices";
	setAttr ".baseMatrices[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0.34387171483078305 -4.5604522683327868 0 1;
	setAttr ".baseMatrices[1]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 1.4210854715202004e-14 7.1054273576010019e-15 -3.5527136788005009e-14 1;
	setAttr ".baseMatrices[2]" -type "matrix" 0.999999999999997 -5.1698788284564241e-26 -7.758052071165325e-08 0
		 -9.1540607455696582e-10 0.99993038427968872 -0.011799431947090057 0 7.7575119887821779e-08 0.011799431947090091 0.99993038427968572 0
		 -17.295086794536488 1.025827245371147e-08 3.0753484736578685e-07 1;
	setAttr ".baseMatrices[3]" -type "matrix" 0.98605726453441955 -0.16640634320511261 -2.0587651684940631e-19 0
		 0.16640634320511261 0.98605726453441955 -1.8600519234648496e-18 0 5.1253047379182148e-19 1.7998585532230199e-18 1 0
		 -0.49922280483818327 -2.9581941640599467 2.1316282072803006e-14 1;
	setAttr ".baseMatrices[4]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 -1.7763568394002505e-15 -8.8817841970012523e-16 1;
	setAttr ".baseMatrices[5]" -type "matrix" 0.99913415042071263 -0.041604680783302178 0 0
		 0.041604680783302178 0.99913415042071263 0 0 0 0 1 0 0.18779704740524039 4.5099358985119933 8.8817841970012523e-16 1;
	setAttr ".baseMatrices[6]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 33.923253880095373 -2.4980018054066022e-16 3.5527136788005009e-15 1;
	setAttr ".baseMatrices[7]" -type "matrix" 0.99913415042071263 -0.041604680783302178 0 0
		 0.041604680783302178 0.99913415042071263 0 0 0 0 1 0 -0.18599651324028343 -4.4666961682863588 -2.6645352591003757e-15 1;
	setAttr ".baseMatrices[10]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0.3438717148307161 3.6088802562769589 0.6099587491636127 1;
	setAttr ".baseMatrices[11]" -type "matrix" 0.99999999999999056 2.3768157941805867e-08 -1.3422688839061223e-07 0
		 -2.3768074544744946e-08 0.99999999999980671 6.2131408655463616e-07 0 1.342269031580776e-07 -6.2131408336431568e-07 0.99999999999979783 0
		 -0.34371943612941891 -3.6088561973584454 -0.61001866734908816 1;
	setAttr ".baseMatrices[12]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 14.363123245911318 -1.7763568394002505e-15 1.7763568394002505e-15 1;
	setAttr ".baseMatrices[13]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 -14.363123245911318 -1.7763568394002505e-15 3.5527136788005009e-15 1;
	setAttr ".baseMatrices[38]" -type "matrix" 1 2.4054412149933172e-21 -1.3578996937248224e-20 0
		 -2.4054412149933172e-21 1 6.28921963336318e-20 0 1.3578996937248224e-20 -6.28921963336318e-20 1 0
		 -0.3441484180751786 4.5604182918902847 0.00011523384354461541 1;
	setAttr ".baseMatrices[39]" -type "matrix" 0.99999999999999811 -2.2182621451096481e-08 5.6917486989252091e-08 0
		 2.2852706404800793e-08 0.99993037694834186 -0.011800053217920534 0 -5.665176810647919e-08 0.011800053217921798 0.99993037694833919 0
		 17.295084979850358 -2.011809030477707e-07 7.4006923256320079e-07 1;
	setAttr ".baseMatrices[40]" -type "matrix" 0.98605726453441944 -0.16640634320511233 -2.9168643870004428e-19 0
		 0.16640634320511236 0.98605726453441955 2.1787628836371974e-18 0 -7.4940432330739349e-20 -2.1969234427350153e-18 1 0
		 0.49922298251046016 2.9581952168745858 2.1316282072803006e-14 1;
	setAttr ".baseMatrices[41]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 -2.8421709430404007e-14 -7.1054273576010019e-15 -7.1054273576010019e-15 1;
	setAttr ".baseMatrices[42]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 -33.923253880095402 1.8873791418627661e-14 -2.6645352591003757e-15 1;
	setAttr ".baseMatrices[43]" -type "matrix" 0.99913415042071263 -0.041604680783302074 0 0
		 0.041604680783302074 0.99913415042071263 0 0 0 0 1 0 0.18599651324026922 4.4666961682863562 4.4408920985006262e-15 1;
	setAttr ".baseMatrices[44]" -type "matrix" 0.99913415042071263 -0.041604680783302074 0 0
		 0.041604680783302074 0.99913415042071263 0 0 0 0 1 0 -0.18779704740523329 -4.5099358985119951 -8.8817841970012523e-16 1;
	setAttr ".baseMatrices[45]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 7.1054273576010019e-15 0 8.8817841970012523e-16 1;
	setAttr -s 20 ".jointOrients";
	setAttr ".jointOrients[0]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[1]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[2]" -type "double3" -0.67607333973708195 4.4450364092050057e-06 
		-2.9621223746459248e-24 ;
	setAttr ".jointOrients[3]" -type "double3" -0.33803648364814604 0.028325478412690043 
		-9.5789415515191347 ;
	setAttr ".jointOrients[4]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[5]" -type "double3" 0 0 -2.3844608514136669 ;
	setAttr ".jointOrients[6]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[7]" -type "double3" 0 0 -2.3844608514136669 ;
	setAttr ".jointOrients[10]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[11]" -type "double3" 3.5598674911609192e-05 7.6906342019556501e-06 
		1.3618151368658374e-06 ;
	setAttr ".jointOrients[12]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[13]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[38]" -type "double3" 3.5598674894116152e-05 7.6906341933085194e-06 
		1.3618151209630663e-06 ;
	setAttr ".jointOrients[39]" -type "double3" -0.67610893841195996 -3.2611317849749215e-06 
		-1.2709705876841965e-06 ;
	setAttr ".jointOrients[40]" -type "double3" -0.33805460582787983 0.028323118587999699 
		-9.5789415515191383 ;
	setAttr ".jointOrients[41]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[42]" -type "double3" 0 0 0 ;
	setAttr ".jointOrients[43]" -type "double3" 0 0 -2.3844608514136607 ;
	setAttr ".jointOrients[44]" -type "double3" 0 0 -2.3844608514136607 ;
	setAttr ".jointOrients[45]" -type "double3" 0 0 0 ;
	setAttr -s 4 ".poses";
	setAttr ".poses[0].poseName" -type "string" "L_arm_2_rz120";
	setAttr ".poses[0].poseWeight" 0;
	setAttr ".poses[0].poseEnabled" yes;
	setAttr ".poses[0].poseDirectoryIndex" 1;
	setAttr ".poses[0].poseBlendMode" 0;
	setAttr -s 5 ".poses[0].poseDeltaMatrices";
	setAttr ".poses[0].poseDeltaMatrices[0]" -type "matrix" 0.86912685028641745 -0.49458924180698799 0 0
		 0.49458924180698799 0.86912685028641745 0 0 0 0 3.8208007233274084 0 1.7992712482484681 -8.0200709174193374 4.1601355530674288e-14 1;
	setAttr ".poses[0].poseDeltaMatrices[1]" -type "matrix" 1.1414311694123436 3.0812154700173498e-22 -4.2351647362715008e-22 0
		 -1.1538361751547787e-22 1.1414311694123442 0 0 0 -1.6940658945086007e-21 1.5607926407890018 0
		 0 0 0 1;
	setAttr ".poses[0].poseDeltaMatrices[2]" -type "matrix" 1 -9.2644228605939123e-23 -2.6469779601696891e-23 0
		 2.6469779601696886e-23 0.92589844294080881 0 0 0 5.5511151231257827e-17 1.437673708376797 0
		 0 0 0 1;
	setAttr ".poses[0].poseDeltaMatrices[3]" -type "matrix" 1.3332326899372746 -1.0162581183151226e-08 5.4263232953055594e-05 0
		 5.5744574487522355e-09 0.99999999873394341 5.032011848733492e-05 0 -8.5137182076375564e-05 -0.00010525947746698876 2.0917970977117371 0
		 0.97540934367257393 0.36316019792080567 -0.00056491142780856762 1;
	setAttr ".poses[0].poseDeltaMatrices[10]" -type "matrix" 1 0 0 0 1.3877787807814457e-17 1 0 0
		 0 0 1 0 -1.7612966535009087 11.864666734604313 3.9879714419978605 1;
	setAttr ".poses[1].poseName" -type "string" "L_leg_2_rz120";
	setAttr ".poses[1].poseWeight" 0;
	setAttr ".poses[1].poseEnabled" yes;
	setAttr ".poses[1].poseDirectoryIndex" 1;
	setAttr ".poses[1].poseBlendMode" 0;
	setAttr -s 5 ".poses[1].poseDeltaMatrices";
	setAttr ".poses[1].poseDeltaMatrices[4]" -type "matrix" 1.0562395057508707 3.2263275063835865e-23 -3.3087224502121107e-24 0
		 1.1622904921393414e-22 0.9056330087357739 0 0 6.6174449004242207e-24 0 1.4243112976635934 0
		 0 0 0 1;
	setAttr ".poses[1].poseDeltaMatrices[5]" -type "matrix" 0.99817994358992967 -0.060305888723408765 2.9170390497568568e-07 0
		 0.060305888723412887 0.9981799435899722 -5.2130479358950085e-09 0 -5.6377466206009487e-07 4.4183861237906977e-08 1.9383117529362146 0
		 -0.9219577142228097 0.80275337260005131 5.9201311941592394e-07 1;
	setAttr ".poses[1].poseDeltaMatrices[6]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1.1399999976158142 0
		 0 0 0 1;
	setAttr ".poses[1].poseDeltaMatrices[7]" -type "matrix" 1.7366734337784662 -0.10492259989684785 5.0751813393360452e-07 0
		 0.060305888723412901 0.9981799435899722 -5.2130479358949564e-09 0 -4.7616154524276556e-07 3.7317490582063783e-08 1.6370893932475823 0
		 0.25337933401122825 -0.25940138524777723 -8.7624316691403692e-08 1;
	setAttr ".poses[1].poseDeltaMatrices[12]" -type "matrix" 1 0 -2.0679515313825692e-25 0
		 0 0.93488054041409863 0 0 0 0 1.2470357448365674 0 0 0 0 1;
	setAttr ".poses[42].poseName" -type "string" "R_arm_2_rz120";
	setAttr ".poses[42].poseWeight" 0;
	setAttr ".poses[42].poseEnabled" yes;
	setAttr ".poses[42].poseDirectoryIndex" 1;
	setAttr ".poses[42].poseBlendMode" 0;
	setAttr -s 5 ".poses[42].poseDeltaMatrices";
	setAttr ".poses[42].poseDeltaMatrices[11]" -type "matrix" 1.0000000000000004 1.1102201887548941e-16 -4.4235448637408571e-16 -4.9221364448682779e-25
		 -4.7066940238398458e-17 0.99999999999999978 1.5693402930254053e-18 -5.5511151231263571e-17
		 2.6038201227296447e-15 4.0245499939367199e-16 0.99999999999999867 8.0200805375905678e-24
		 1.7612964002081668 -11.864664214956427 -3.9879790500950207 1.0000000000000007;
	setAttr ".poses[42].poseDeltaMatrices[38]" -type "matrix" 0.8691268502864703 -0.49458924180713426 8.8898783142604867e-08 0
		 0.49458924180664177 0.86912685028755654 -1.9003037293032566e-06 0 7.0348930772115081e-07 -1.7675293636697724e-06 3.8208007233262142 0
		 -1.7992714388701074 8.0200708746524327 5.2244935702105977e-06 1;
	setAttr ".poses[42].poseDeltaMatrices[39]" -type "matrix" 1.0000000000000069 1.7612147172287139e-09 5.8747587998318618e-08 -9.6895107174316519e-19
		 1.7612148860395565e-09 0.92589844294100621 -3.1797318010909343e-07 3.962731916941644e-20
		 5.8747588805312927e-08 -3.179731799217434e-07 1.437673708376592 -1.5385483422387652e-19
		 -1.4210854715202004e-14 0 -7.1054273576010019e-15 1;
	setAttr ".poses[42].poseDeltaMatrices[40]" -type "matrix" 1.333232689937274 -1.0162582296217386e-08 5.4263232954676083e-05 -5.6091777146521835e-18
		 5.5744563965155239e-09 0.99999999873394319 5.0320118487840016e-05 5.5598134025403492e-17
		 -8.5137182076420694e-05 -0.00010525947746619598 2.0917970977117379 2.591629734232344e-19
		 -0.97540934367258103 -0.36316019792079857 0.00056491142783698933 1;
	setAttr ".poses[42].poseDeltaMatrices[41]" -type "matrix" 1.1414311694123433 -8.1280580304732049e-18 7.1713072912194737e-16 0
		 1.1859625850016684e-16 1.1414311694123433 -8.1165449590165634e-17 0 -5.4197328448937883e-16 4.1698774665284455e-16 1.5607926407890025 0
		 -2.8421709430404007e-14 -3.5527136788005009e-15 0 1;
	setAttr ".poses[43].poseName" -type "string" "R_leg_2_rz120";
	setAttr ".poses[43].poseWeight" 0;
	setAttr ".poses[43].poseEnabled" yes;
	setAttr ".poses[43].poseDirectoryIndex" 1;
	setAttr ".poses[43].poseBlendMode" 0;
	setAttr -s 5 ".poses[43].poseDeltaMatrices";
	setAttr ".poses[43].poseDeltaMatrices[13]" -type "matrix" 1.0000000000000002 -1.3384830453314586e-17 6.888235893940743e-17 3.4741011897763467e-18
		 -3.7066067709853225e-17 0.93488054041409863 1.0174610498576343e-15 -1.2252756601985205e-19
		 7.6505344992008676e-16 9.918930153876698e-16 1.247035744836567 2.6869695095345052e-20
		 -7.1054273576010019e-15 -8.8817841970012523e-16 2.6645352591003757e-15 1;
	setAttr ".poses[43].poseDeltaMatrices[42]" -type "matrix" 1 -3.469446951953615e-18 -1.3918445389282663e-17 0
		 -5.6495161280180569e-31 1 4.5883435939586548e-16 0 2.1296397834310965e-15 4.2315109739369294e-16 1.1399999976158142 0
		 -1.4210854715202004e-14 2.2204460492503131e-16 -2.6645352591003757e-15 1;
	setAttr ".poses[43].poseDeltaMatrices[43]" -type "matrix" 1.7366734337784659 -0.10492259989684777 5.0751813427526468e-07 4.1235563348454235e-18
		 0.060305888723412873 0.9981799435899722 -5.2130458615055031e-09 2.801121780644357e-17
		 -4.7616154436098346e-07 3.7317492924689081e-08 1.6370893932475816 3.527323070884371e-20
		 -0.25337933401123536 0.25940138524777812 8.7624320244117371e-08 1;
	setAttr ".poses[43].poseDeltaMatrices[44]" -type "matrix" 0.99817994358992967 -0.060305888723408745 2.9170390532894718e-07 3.469398879280225e-18
		 0.060305888723412866 0.9981799435899722 -5.2130448779172914e-09 2.232215390446379e-19
		 -5.6377466032375747e-07 4.4183864242507389e-08 1.9383117529362148 4.1762557801426981e-20
		 0.92195771422280615 -0.80275337260005131 -5.920131176395671e-07 1;
	setAttr ".poses[43].poseDeltaMatrices[45]" -type "matrix" 1.0562395057508702 1.0136383869729946e-18 1.597177142137204e-16 7.1435841133942234e-18
		 2.6774913774978468e-17 0.90563300873577401 1.6897471639202932e-15 -2.4975658834877219e-19
		 5.5550380592776317e-17 1.7354925859842993e-15 1.424311297663593 5.2236277632083357e-20
		 -1.4210854715202004e-14 -2.6645352591003757e-15 8.8817841970012523e-16 1;
	setAttr -s 2 ".directories";
	setAttr ".directories[0].directoryName" -type "string" "";
	setAttr ".directories[0].directoryWeight" 1;
	setAttr ".directories[0].directoryParentIndex" 0;
	setAttr ".directories[0].directoryChildrenIndices" -type "Int32Array" 1 -1 ;
	setAttr ".directories[1].directoryName" -type "string" "muscles";
	setAttr ".directories[1].directoryWeight" 0.69999998807907104;
	setAttr ".directories[1].directoryParentIndex" 0;
	setAttr ".directories[1].directoryChildrenIndices" -type "Int32Array" 4 0
		 1 42 43 ;
	setAttr ".outputTranslates[0]" -type "double3" 0 0 0;
	setAttr ".connectionsData" -type "string" "";
	setAttr ".splitPosesData" -type "string" "[]";
createNode remapValue -n "L_arm_2_joint_rotateZ_pos_remapValue";
	rename -uid "C4D6B983-4C13-06CA-784A-83AFE7725104";
	setAttr ".imx" 120;
	setAttr -s 3 ".vl[0:2]"  0 0 3 1 1 2 0.76521736 0.18000001 
		3;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "L_leg_2_joint_rotateZ_pos_remapValue";
	rename -uid "DB9579E2-40DC-252E-081E-E3BE510725CD";
	setAttr ".imx" 120;
	setAttr -s 3 ".vl[0:2]"  0 0 3 1 1 3 0.76521736 0.30000001 
		3;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "R_arm_2_joint_rz_pos_remapValue";
	rename -uid "CD052230-44D6-076B-C91A-E49CDF89A32F";
	setAttr ".imx" 120;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "R_leg_2_joint_rz_pos_remapValue";
	rename -uid "AB06C5F6-48CA-B124-E00E-64A43C3B167C";
	setAttr ".imx" 120;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode multDL -n "lip_upper_jaw_up_multDL";
	rename -uid "65CBAB56-49DA-42CB-3460-1E8406240AEE";
createNode multDL -n "lips_corners_jaw_up_multDL";
	rename -uid "75E75E69-4021-8BBD-6EEA-7DA3B5EE4355";
createNode remapValue -n "lips_corners_jaw_open_drop_remapValue";
	rename -uid "80FA17E8-4B1F-0A99-30FB-3F88A2DC4E3D";
	setAttr ".omn" 0.5;
	setAttr ".omx" 0;
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode remapValue -n "lip_upper_jaw_open_drop_remapValue";
	rename -uid "5B12AF49-4A55-A0A2-E7B6-4BBC53CAC285";
	setAttr ".imx" 1.2999999523162842;
	setAttr ".omn" 1;
	setAttr ".omx" 0;
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 1 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].clp" 0;
	setAttr ".cl[0].clc" -type "float3" 0 0 0 ;
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode skinCluster -n "skinCluster42";
	rename -uid "2F86057C-49E1-4881-A217-E3A12BFA8440";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 5 1
		2 1 0.15000000000000002 5 0.85
		2 1 0.44999999999999996 5 0.55
		2 1 0.8 5 0.2
		1 1 1
		1 1 1
		2 1 0.69393621021909035 6 0.30606378978090965
		2 1 0.30000000000000004 6 0.7
		1 6 1;
	setAttr -s 5 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.94011040292915948 -0.089490931646328709 0.32891306367708406 0
		 0.14661421376387562 0.97726425108679271 -0.15316284102278457 0 -0.30772829351032061 0.19221331041538803 0.9318569314397912 0
		 -24.061531705246523 -157.64987058152863 16.681294756857433 1;
	setAttr ".pm[1]" -type "matrix" 0.95758444344642746 -0.034776357643672519 0.28604656722015592 0
		 0.03629282739400156 0.99934119833005441 1.214306433183765e-17 0 -0.28585811926398902 0.010381438690767771 0.95821571756132495 0
		 -6.6968700998898107 -160.6279103036826 -10.726522983606468 1;
	setAttr ".pm[2]" -type "matrix" 0.93472422098362595 0.043781482023210361 0.35266671594921589 0
		 0.0038364526987505069 0.99108106104080862 -0.13320515033929994 0 -0.35535322193170543 0.12586306955607163 0.92621950712813184 0
		 -1.0748534739135185 -158.64933042739648 10.990997960141447 1;
	setAttr ".pm[5]" -type "matrix" 0.96934876657754776 -2.5389361486798314e-08 0.24568876395672601 0
		 2.4611121390849533e-08 0.99999999999999956 6.2378744947189091e-09 0 -0.24568876395673075 0 0.96934876657754854 0
		 0.49569831807950793 -159.02391047304431 -9.8777827647862058 1;
	setAttr ".pm[6]" -type "matrix" 0.64603215198108832 -2.5486502863831115e-08 0.76331019815451417 0
		 1.0734991718469589e-08 0.99999999999999878 2.4303809666170739e-08 0 -0.76331019815451462 -7.506914270882195e-09 0.64603215198108765 0
		 3.2499225252119626 -160.14143350316331 -9.8183484423441758 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 5 ".dpf";
	setAttr ".dpf[0]" 8;
	setAttr ".dpf[1]" 8;
	setAttr ".dpf[2]" 8;
	setAttr ".dpf[5]" 8;
	setAttr ".dpf[6]" 8;
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster43";
	rename -uid "44155F40-4989-B967-9BFD-9DAEC30393D1";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 3 1
		2 1 0.30000000000000004 3 0.7
		2 1 0.75 3 0.25
		2 1 0.95 3 0.050000000000000044
		1 1 1
		2 1 0.82 4 0.18000000000000005
		2 1 0.47 4 0.53
		2 1 0.16000000000000003 4 0.84
		1 4 1;
	setAttr -s 5 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.94011040292915948 -0.089490931646328709 0.32891306367708406 0
		 0.14661421376387562 0.97726425108679271 -0.15316284102278457 0 -0.30772829351032061 0.19221331041538803 0.9318569314397912 0
		 -24.061531705246523 -157.64987058152863 16.681294756857433 1;
	setAttr ".pm[1]" -type "matrix" 0.93472422098362595 0.043781482023210361 0.35266671594921589 0
		 0.0038364526987505069 0.99108106104080862 -0.13320515033929994 0 -0.35535322193170543 0.12586306955607163 0.92621950712813184 0
		 -1.0748534739135185 -158.64933042739648 10.990997960141447 1;
	setAttr ".pm[2]" -type "matrix" 0.95758450519314364 -0.034776357643673081 0.28604636051353821 0
		 0.036292827394000686 0.99934119833005375 -7.8342620030147359e-09 0 -0.28585791242110364 0.010381438690771126 0.95821577926736279 0
		 -6.6968718089701502 -160.62791032383879 -10.726521552871223 1;
	setAttr ".pm[3]" -type "matrix" 0.96934876657754776 -2.5389361486798314e-08 0.24568876395672601 0
		 2.4611121390849533e-08 0.99999999999999956 6.2378744947189091e-09 0 -0.24568876395673075 0 0.96934876657754854 0
		 0.49569831807950793 -159.02391047304431 -9.8777827647862058 1;
	setAttr ".pm[4]" -type "matrix" 0.64603231664260097 -2.3245537123693439e-08 0.76331005879222713 2.7755575641478308e-17
		 1.5017359598912261e-08 0.99999999999999856 1.774355156552998e-08 -8.6736173798840355e-19
		 -0.76331005879222857 -1.6963870181504027e-15 0.64603231664260075 3.0814879110195774e-33
		 3.2499203135476695 -160.14143358533366 -9.8183481774775974 1.0000000000000002;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 5 ".dpf[0:4]"  8 8 8 8 8;
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
createNode wire -n "L_eyelid_upper_curve_wire";
	rename -uid "882E7300-4963-4553-45D7-5F9F8A8034C9";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode skinCluster -n "skinCluster44";
	rename -uid "2D68E3BF-4E1A-6862-5D26-BC845D0022D1";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 2 1
		2 0 0.25119116813153208 2 0.74880883186846792
		2 0 0.63275614823668103 2 0.36724385176331892
		3 0 0.9999999306016657 1 6.0333121783134016e-08 2 9.0652123948077396e-09
		2 0 0.49963375600696458 1 0.50036624399303542
		3 0 0.00031452915468375433 1 0.99967664467697515 2 8.8261683411427137e-06
		3 0 3.0146900078103369e-10 1 0.99999999957567876 2 1.2285233529688154e-10
		2 1 0.33818344605651374 2 0.66181655394348626
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster45";
	rename -uid "844DC40B-4949-76AD-16AE-908A36B4ACC6";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 2 1
		2 0 0.50845922777040764 2 0.49154077222959236
		1 0 1
		3 0 0.9999994334337321 1 5.2788945040943774e-07 2 3.8676817609573746e-08
		3 0 0.49880999329711445 1 0.5 2 0.0011900067028855761
		3 0 0.0001593428477436413 1 0.99983640112839067 2 4.2560238655775156e-06
		3 0 4.468569024298007e-10 1 0.99999999940929452 2 1.4384856980949081e-10
		2 1 0.42961507191526394 2 0.57038492808473606
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode wire -n "L_eyelid_lower_curve_wire";
	rename -uid "9BCE39CE-4FC9-2718-2DF7-E489578BD88B";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode wire -n "R_eyelid_upper_curve_wire";
	rename -uid "8CC6FE46-443E-3409-5A67-2C8ECB3F41B3";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode wire -n "R_eyelid_lower_curve_wire";
	rename -uid "CAF2C4D2-4CF1-31DE-F1EC-469D9ECE9CB2";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode pointOnCurveInfo -n "R_eyelid_upper_fin_curve_pointOnCurveInfo";
	rename -uid "3AFFC167-4FB3-7927-AB7B-C09346249D81";
createNode nearestPointOnCurve -n "attachToCurve_cpos_tmp";
	rename -uid "2A01241B-49B8-E6A3-BD20-029A49FAD65A";
createNode skinCluster -n "skinCluster46";
	rename -uid "E46294A4-43B4-F748-86F3-A9BF09A33CA5";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 3 1
		2 0 0.15000000000000002 3 0.85
		2 0 0.44999999999999996 3 0.55
		2 0 0.8 3 0.2
		1 0 1
		1 0 1
		2 0 0.69393621021909035 4 0.30606378978090965
		2 0 0.30000000000000004 4 0.7
		1 4 1;
	setAttr -s 5 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.95758444344642712 -0.034776357643673581 0.28604656722015631 0
		 -0.036292827394002879 -0.99934119833005419 6.1756155744774323e-16 0 0.28585811926398941 -0.010381438690768782 -0.95821571756132473 0
		 6.6968699590461638 160.62777349991762 10.726506652367197 1;
	setAttr ".pm[1]" -type "matrix" 0.94011040292915971 -0.089490931646328264 0.32891306367708412 0
		 -0.14661421376387551 -0.9772642510867926 0.15316284102278571 0 0.30772829351032055 -0.19221331041538908 -0.93185693143979098 0
		 24.06149062686579 157.64957748392811 -16.681247087828933 1;
	setAttr ".pm[2]" -type "matrix" 0.93472422098362595 0.04378148197610042 0.35266671595506449 0
		 -0.0038364526987503559 -0.99108106105860283 0.13320515020690898 0 0.35535322193170554 -0.12586306943234513 -0.92621950714494539 0
		 1.0748534739134994 158.64933042886469 -10.990997938948686 1;
	setAttr ".pm[3]" -type "matrix" 0.96934871351303342 -3.0415960070801631e-08 0.24568897331916675 2.5849394142282115e-26
		 -2.6689215519484083e-08 -1.0000000000000002 -1.8498264482691429e-08 8.6736173798840355e-19
		 0.24568897331916698 1.1374027090548433e-08 -0.96934871351303353 -1.2924697071141057e-26
		 -0.4957002880240568 159.0239998281946 9.8777806309719516 0.99999999999999989;
	setAttr ".pm[4]" -type "matrix" 0.64603198691919661 -1.8546121727201256e-08 0.76331033785560287 0
		 -1.7787293332682808e-08 -1.0000000000000004 -9.2425968267750847e-09 0 0.76331033785560332 -7.6062117609765966e-09 -0.6460319869191965 0
		 -3.2499235786732119 160.14099997213987 9.8183497625376894 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 5 ".dpf[0:4]"  8 8 8 8 8;
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster47";
	rename -uid "3CEBCC37-42A2-1CF4-AC2B-C6B9812E969E";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 3 1
		2 1 0.30000000000000004 3 0.7
		2 1 0.75 3 0.25
		2 1 0.95 3 0.050000000000000044
		1 1 1
		2 1 0.82 4 0.18000000000000005
		2 1 0.47 4 0.53
		2 1 0.16000000000000003 4 0.84
		1 4 1;
	setAttr -s 5 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.94011040292915971 -0.089490931646328264 0.32891306367708412 0
		 -0.14661421376387551 -0.9772642510867926 0.15316284102278571 0 0.30772829351032055 -0.19221331041538908 -0.93185693143979098 0
		 24.06149062686579 157.64957748392811 -16.681247087828933 1;
	setAttr ".pm[1]" -type "matrix" 0.93472422098362595 0.04378148197610042 0.35266671595506449 0
		 -0.0038364526987503559 -0.99108106105860283 0.13320515020690898 0 0.35535322193170554 -0.12586306943234513 -0.92621950714494539 0
		 1.0748534739134994 158.64933042886469 -10.990997938948686 1;
	setAttr ".pm[2]" -type "matrix" 0.95758444351786554 -0.034776357743490319 0.28604656696886982 0
		 -0.036292825341128293 -0.99934119840460844 -7.2210326763216848e-09 0 0.28585811928531557 -0.010381431179682026 -0.95821571763633917 0
		 6.696869629080112 160.62777343616713 10.726507813030357 1;
	setAttr ".pm[3]" -type "matrix" 0.96934871351303342 -3.0415960070801631e-08 0.24568897331916675 2.5849394142282115e-26
		 -2.6689215519484083e-08 -1.0000000000000002 -1.8498264482691429e-08 8.6736173798840355e-19
		 0.24568897331916698 1.1374027090548433e-08 -0.96934871351303353 -1.2924697071141057e-26
		 -0.4957002880240568 159.0239998281946 9.8777806309719516 0.99999999999999989;
	setAttr ".pm[4]" -type "matrix" 0.64603198691919661 -1.8546121727201256e-08 0.76331033785560287 0
		 -1.7787293332682808e-08 -1.0000000000000004 -9.2425968267750847e-09 0 0.76331033785560332 -7.6062117609765966e-09 -0.6460319869191965 0
		 -3.2499235786732119 160.14099997213987 9.8183497625376894 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 5 ".dpf[0:4]"  8 8 8 8 8;
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster48";
	rename -uid "BF4492B2-412D-46ED-17AE-F1942D027931";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 2 1
		2 0 0.25119116813153208 2 0.74880883186846792
		2 0 0.63275614823668103 2 0.36724385176331892
		3 0 0.9999999306016657 1 6.0333121783134016e-08 2 9.0652123948077396e-09
		2 0 0.49963375600696458 1 0.50036624399303542
		3 0 0.00031452915468375433 1 0.99967664467697515 2 8.8261683411427137e-06
		3 0 3.0146900078103369e-10 1 0.99999999957567876 2 1.2285233529688154e-10
		2 1 0.33818344605651374 2 0.66181655394348626
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster49";
	rename -uid "25EED264-4D59-A419-D161-EAB0014857AC";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 2 1
		2 0 0.50845922777040764 2 0.49154077222959236
		1 0 1
		3 0 0.9999994334337321 1 5.2788945040943774e-07 2 3.8676817609573746e-08
		3 0 0.49880999329711445 1 0.5 2 0.0011900067028855761
		3 0 0.0001593428477436413 1 0.99983640112839067 2 4.2560238655775156e-06
		3 0 4.468569024298007e-10 1 0.99999999940929452 2 1.4384856980949081e-10
		2 1 0.42961507191526394 2 0.57038492808473606
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster57";
	rename -uid "DDF9999D-4DDD-26A1-89FB-B28D3B149778";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 0 1
		2 0 0.8 1 0.2
		2 0 0.5 1 0.5
		1 1 1
		1 1 1
		2 1 0.7 2 0.3
		2 1 0.5 2 0.5
		2 1 0.13712022748031363 2 0.86287977251968639
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.63660081386372436 -0.74373209332530699 0.20396562736402579 0
		 0.75566018913068078 0.54875091882477678 -0.35756133411199226 0 0.15400351408662016 0.38175254085195093 0.91134401583707803 0
		 -123.75295063556601 -90.217106707860722 47.689805702716022 1;
	setAttr ".pm[1]" -type "matrix" 0.9841848991720793 -0.017272840607519852 0.17630012257225189 0
		 0.017002205393616715 0.99985081336034709 0.0030456582878021863 0 -0.17632642811954516 -1.3704315460216779e-16 0.98433174831791503 0
		 -4.7602069796078625 -161.02767452525856 -11.069657207449048 1;
	setAttr ".pm[2]" -type "matrix" 0.65190905615585437 0.59781445256198062 0.4665109460773692 0
		 -0.56244459320674112 0.79382722476755885 -0.23128860064936141 0 -0.50859675782931058 -0.11160742594404446 0.85374066343337462 0
		 91.121544063438421 -129.59975104988541 26.933782792396538 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode skinCluster -n "skinCluster58";
	rename -uid "AB964AB9-48AC-0078-54AB-E5B9544611E7";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 0 1
		2 0 0.8 1 0.2
		2 0 0.5 1 0.5
		1 1 1
		1 1 1
		2 1 0.7 2 0.3
		2 1 0.5 2 0.5
		2 1 0.13712022748031363 2 0.86287977251968639
		1 2 1;
	setAttr -s 3 ".pm";
	setAttr ".pm[0]" -type "matrix" 0.63756619851705565 -0.74297489089759083 0.20370972977308482 0
		 -0.75481303425101776 -0.54952278511137487 0.35816475534062442 0 -0.15416428196337156 -0.38211650074179027 -0.91116428487269352 0
		 123.62090253721639 90.34584420840423 -47.788709724148241 1;
	setAttr ".pm[1]" -type "matrix" 0.98418489917207952 -0.017272840607519734 0.1763001225722515 0
		 -0.017002205393616597 -0.99985081336034676 -0.0030456582878020618 0 0.17632642811954469 -1.2099696244938227e-16 -0.98433174831791481 0
		 4.7601442718353733 161.02437526672622 11.069681797225957 1;
	setAttr ".pm[2]" -type "matrix" 0.65245855559763966 0.59717387039998104 0.46656318086508725 0
		 0.56133084065174044 -0.79444794116130324 0.23186236459972598 0 0.50912230412804749 0.11061571902795896 -0.8535564668744976 0
		 -90.944524019557349 129.70448694623155 -27.027117041745317 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 3 ".ma";
	setAttr -s 3 ".dpf[0:2]"  8 8 8;
	setAttr -s 3 ".lw";
	setAttr -s 3 ".lw";
	setAttr ".mi" 5;
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr ".wd" 1;
	setAttr -s 3 ".ifcl";
	setAttr -s 3 ".ifcl";
createNode blendShape -n "L_eyelids_avg_blendShape";
	rename -uid "7D176390-4A98-44D7-DFFE-8A878525CB9F";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -s 2 ".w";
	setAttr -s 2 ".w";
	setAttr -s 2 ".it[0].itg";
	setAttr ".mlid" 4;
	setAttr ".mlpr" 0;
	setAttr -s 2 ".pndr[0:1]"  0 0;
	setAttr -s 2 ".tgvs[0:1]" yes yes;
	setAttr -s 2 ".tpvs[0:1]" yes yes;
	setAttr ".tgdt[0].cid" -type "Int32Array" 2 0 1 ;
	setAttr ".aal" -type "attributeAlias" 4 "L_eyelid_upper_curve" "weight[0]" "L_eyelid_lower_curve" "weight[1]" ;
createNode reverse -n "L_eyelids_blinkLine_reverse";
	rename -uid "1240AB09-422B-7A56-9EDC-C3906604134E";
createNode reverse -n "R_eyelids_blinkLine_reverse";
	rename -uid "D97CC870-48D6-FB80-9642-8DB5B24651B8";
createNode blendShape -n "R_eyelids_avg_blendShape";
	rename -uid "CEB6C6F4-4AC1-23A7-D7E2-FE97E8F0666F";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -s 2 ".w";
	setAttr -s 2 ".w";
	setAttr -s 2 ".it[0].itg";
	setAttr ".mlid" 5;
	setAttr ".mlpr" 0;
	setAttr -s 2 ".pndr[0:1]"  0 0;
	setAttr -s 2 ".tgvs[0:1]" yes yes;
	setAttr -s 2 ".tpvs[0:1]" yes yes;
	setAttr ".tgdt[0].cid" -type "Int32Array" 2 0 1 ;
	setAttr ".aal" -type "attributeAlias" 4 "R_eyelid_upper_curve" "weight[0]" "R_eyelid_lower_curve" "weight[1]" ;
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo";
	rename -uid "76A35C88-4409-8BFE-1200-CEA5AEB4725D";
	setAttr ".def" no;
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -622.61902287839052 -383.33331810103573 ;
	setAttr ".tgi[0].vh" -type "double2" 476.19045726836748 401.19046024859961 ;
createNode nodeGraphEditorInfo -n "hyperShadePrimaryNodeEditorSavedTabsInfo1";
	rename -uid "21131C81-4CCB-AFAB-6E8F-A292D49C94A0";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -90.016341075687166 -630.95235588058699 ;
	setAttr ".tgi[0].vh" -type "double2" 663.82584208407013 44.047617297324017 ;
createNode pointMatrixMultDL -n "R_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "F9A2ED09-422E-DD13-209B-2C995F25CCEA";
createNode pointOnCurveInfo -n "R_eyelid_lower_major_2_control_pointOnCurveInfo";
	rename -uid "B3C71C13-4B2E-96F1-B25E-5AB8B6BC1870";
	setAttr ".pr" 0.79882566034212743;
createNode pointMatrixMultDL -n "R_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "2B2342CF-4250-CA4D-BBFE-599ADC324B99";
createNode pointOnCurveInfo -n "R_eyelid_lower_major_1_control_pointOnCurveInfo";
	rename -uid "CBA84253-4D1A-49B3-8180-E590AA1AACA1";
	setAttr ".pr" 0.26020537462369747;
createNode pointMatrixMultDL -n "R_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "EA585740-4ACF-82F5-89F0-36A796513E11";
createNode pointOnCurveInfo -n "R_eyelid_upper_major_2_control_pointOnCurveInfo";
	rename -uid "9077663C-44E0-D510-6B2A-4FAA801AC872";
	setAttr ".pr" 0.80180489831365165;
createNode pointMatrixMultDL -n "R_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "D55FD5A1-45FC-B9A8-AD78-FE84CD64B67C";
createNode pointOnCurveInfo -n "R_eyelid_upper_major_1_control_pointOnCurveInfo";
	rename -uid "458C21C7-4A4A-2150-688F-B9AF5A6C95E6";
	setAttr ".pr" 0.28126434408252166;
createNode pointMatrixMultDL -n "L_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "6D6FF94E-424D-58E5-0CE2-7E996C9EBCC5";
createNode pointOnCurveInfo -n "L_eyelid_lower_major_2_control_pointOnCurveInfo";
	rename -uid "7BC9CDA2-4175-B17B-2EDE-1FBE7966BF77";
	setAttr ".pr" 0.79882566034212976;
createNode pointMatrixMultDL -n "L_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "C49CBC0E-4C98-FCB8-A38C-9CA0A18416DA";
createNode pointOnCurveInfo -n "L_eyelid_lower_major_1_control_pointOnCurveInfo";
	rename -uid "9DCE9CF5-4F9B-40AB-9158-BA9470FD44F6";
	setAttr ".pr" 0.26020537462369775;
createNode pointMatrixMultDL -n "L_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "852D2F2C-442F-77E7-F91C-9F9FA80AA53B";
createNode pointOnCurveInfo -n "L_eyelid_upper_major_2_control_pointOnCurveInfo";
	rename -uid "4E153843-4AD9-C6DF-17B0-8A9C7F065E3E";
	setAttr ".pr" 0.8018048983136522;
createNode pointMatrixMultDL -n "L_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "C3548E67-4588-4181-8381-9B85B7DAC368";
createNode pointOnCurveInfo -n "L_eyelid_upper_major_1_control_pointOnCurveInfo";
	rename -uid "00390F93-40F9-2906-2387-7DBF3F6E5D26";
	setAttr ".pr" 0.28126434408252643;
createNode transformGeometry -n "L_eyelid_upper_tuner_transformGeometry";
	rename -uid "061880BE-4492-D9F7-811F-F0BE6A4E398D";
	setAttr ".txf" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode transformGeometry -n "L_eyelid_lower_tuner_transformGeometry";
	rename -uid "E5E7B7AC-476E-1B65-6AD2-AD97CAE9CB95";
	setAttr ".txf" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode multDL -n "R_eyelids_transform_tuner_tx_multDL";
	rename -uid "6B41DB2B-40A8-3406-AAA2-869171DD7507";
	setAttr ".i2" -1;
createNode nodeGraphEditorInfo -n "MayaNodeEditorSavedTabsInfo";
	rename -uid "34BA48FC-4752-589B-EEB9-1DBC5B093F57";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -816.07139614366497 -455.95236283446189 ;
	setAttr ".tgi[0].vh" -type "double2" 817.26187228683591 454.76188669129107 ;
	setAttr -s 3 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" -537.142822265625;
	setAttr ".tgi[0].ni[0].y" 221.42855834960938;
	setAttr ".tgi[0].ni[0].nvs" 18304;
	setAttr ".tgi[0].ni[1].x" -491.66665649414062;
	setAttr ".tgi[0].ni[1].y" 347.6190185546875;
	setAttr ".tgi[0].ni[1].nvs" 18304;
	setAttr ".tgi[0].ni[2].x" -235.11903381347656;
	setAttr ".tgi[0].ni[2].y" 58.333332061767578;
	setAttr ".tgi[0].ni[2].nvs" 18304;
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -av -k on ".fzn";
	setAttr -av -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 0;
	setAttr -av -k on ".unw";
	setAttr -av -k on ".etw";
	setAttr -av -k on ".tps";
	setAttr -av -k on ".tms";
select -ne :hardwareRenderingGlobals;
	setAttr -av -k on ".cch";
	setAttr -k on ".fzn";
	setAttr -av -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".rm";
	setAttr -av -k on ".lm";
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr -k on ".hom";
	setAttr -k on ".hodm";
	setAttr -k on ".xry";
	setAttr -k on ".jxr";
	setAttr -av -k on ".sslt";
	setAttr -k on ".cbr";
	setAttr -k on ".bbr";
	setAttr -av -k on ".mhl";
	setAttr -k on ".cons";
	setAttr -k on ".vac";
	setAttr -av -k on ".hwi";
	setAttr -k on ".csvd";
	setAttr -av -k on ".ta";
	setAttr -av -k on ".tq";
	setAttr -k on ".ts";
	setAttr -av -k on ".etmr";
	setAttr -k on ".tmrm";
	setAttr -av -k on ".tmr";
	setAttr -av -k on ".aoon";
	setAttr -av -k on ".aoam";
	setAttr -av -k on ".aora";
	setAttr -k on ".aofr";
	setAttr -av -k on ".aosm";
	setAttr -av -k on ".hff";
	setAttr -av -k on ".hfd";
	setAttr -av -k on ".hfs";
	setAttr -av -k on ".hfe";
	setAttr -av ".hfc";
	setAttr -av -k on ".hfcr";
	setAttr -av -k on ".hfcg";
	setAttr -av -k on ".hfcb";
	setAttr -av -k on ".hfa";
	setAttr -av -k on ".mbe";
	setAttr -k on ".mbt";
	setAttr -av -k on ".mbsof";
	setAttr -k on ".mbsc";
	setAttr -k on ".mbc";
	setAttr -k on ".mbfa";
	setAttr -k on ".mbftb";
	setAttr -k on ".mbftg";
	setAttr -k on ".mbftr";
	setAttr -av -k on ".mbfta";
	setAttr -k on ".mbfe";
	setAttr -k on ".mbme";
	setAttr -av -k on ".mbcsx";
	setAttr -av -k on ".mbcsy";
	setAttr -av -k on ".mbasx";
	setAttr -av -k on ".mbasy";
	setAttr -av -k on ".blen";
	setAttr -av -k on ".blth";
	setAttr -av -k on ".blfr";
	setAttr -av -k on ".blfa";
	setAttr -av -k on ".blat";
	setAttr -av -k on ".msaa" yes;
	setAttr -av -k on ".aasc";
	setAttr -av -k on ".aasq";
	setAttr -k on ".laa";
	setAttr ".dli" 1;
	setAttr -k on ".gamm";
	setAttr -k on ".gmmv";
	setAttr -k on ".fprt" yes;
	setAttr -k on ".rtfm" 1;
select -ne :renderPartition;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 7 ".u";
select -ne :defaultRenderingList1;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 7 ".r";
select -ne :standardSurface1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :openPBR_shader1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :initialShadingGroup;
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -av -k on ".cch";
	setAttr -k on ".fzn";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".bbx";
	setAttr -k on ".vwm";
	setAttr -k on ".tpv";
	setAttr -k on ".uit";
	setAttr -k on ".mwc";
	setAttr -av -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
	setAttr -k on ".hio";
	setAttr ".aal" -type "attributeAlias" 16 "ai_aov_shades_mask" "aiCustomAOVs[0]" "ai_aov_diffuse_shadow" "aiCustomAOVs[1].aovName" "ai_aov_hair_spec" "aiCustomAOVs[2].aovName" "ai_aov_face_mask" "aiCustomAOVs[3].aovName" "ai_aov_Z" "aiCustomAOVs[4].aovName" "ai_aov_diffuse_albedo" "aiCustomAOVs[5].aovName" "ai_aov_crypto_object" "aiCustomAOVs[6].aovName" "ai_aov_crypto_material" "aiCustomAOVs[7].aovName" ;
select -ne :initialParticleSE;
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -av -k on ".cch";
	setAttr -k on ".fzn";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".bbx";
	setAttr -k on ".vwm";
	setAttr -k on ".tpv";
	setAttr -k on ".uit";
	setAttr -k on ".mwc";
	setAttr -av -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
	setAttr -k on ".hio";
	setAttr ".aal" -type "attributeAlias" 16 "ai_aov_shades_mask" "aiCustomAOVs[0]" "ai_aov_diffuse_shadow" "aiCustomAOVs[1].aovName" "ai_aov_hair_spec" "aiCustomAOVs[2].aovName" "ai_aov_face_mask" "aiCustomAOVs[3].aovName" "ai_aov_Z" "aiCustomAOVs[4].aovName" "ai_aov_diffuse_albedo" "aiCustomAOVs[5].aovName" "ai_aov_crypto_object" "aiCustomAOVs[6].aovName" "ai_aov_crypto_material" "aiCustomAOVs[7].aovName" ;
lockNode -l 0 -lu 1;
select -ne :defaultRenderGlobals;
	addAttr -ci true -h true -sn "dss" -ln "defaultSurfaceShader" -dt "string";
	setAttr -av -k on ".cch";
	setAttr -av -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -av -k on ".macc";
	setAttr -av -k on ".macd";
	setAttr -av -k on ".macq";
	setAttr -av -k on ".mcfr";
	setAttr -cb on ".ifg";
	setAttr -av -k on ".clip";
	setAttr -av -k on ".edm";
	setAttr -av -k on ".edl";
	setAttr -av -cb on ".ren";
	setAttr -av -k on ".esr";
	setAttr -av -k on ".ors";
	setAttr -cb on ".sdf" -type "string" "";
	setAttr -av -k on ".outf" 51;
	setAttr -av -cb on ".imfkey" -type "string" "exr";
	setAttr -av -k on ".gama";
	setAttr -av -k on ".exrc";
	setAttr -av -k on ".expt";
	setAttr -av -k on ".an" yes;
	setAttr -cb on ".ar";
	setAttr -av -k on ".fs" 2.5;
	setAttr -av -k on ".ef" 30;
	setAttr -av -k on ".bfs";
	setAttr -av -cb on ".me";
	setAttr -cb on ".se";
	setAttr -av -k on ".be";
	setAttr -av -cb on ".ep";
	setAttr -av -k on ".fec";
	setAttr -av -k on ".ofc";
	setAttr -cb on ".ofe" -type "string" "";
	setAttr -cb on ".efe" -type "string" "";
	setAttr -cb on ".oft" -type "string" "";
	setAttr -cb on ".umfn";
	setAttr -cb on ".ufe";
	setAttr -av -cb on ".pff" yes;
	setAttr -av -cb on ".peie";
	setAttr -av -cb on ".ifp" -type "string" "k:\\Shared drives\\DarkKnight\\_library\\templates\\shading_templates\\render\\<RenderLayer>\\char_template";
	setAttr -k on ".rv" -type "string" "";
	setAttr -av -k on ".comp";
	setAttr -av -k on ".cth";
	setAttr -av -k on ".soll";
	setAttr -av -cb on ".sosl";
	setAttr -av -k on ".rd";
	setAttr -av -k on ".lp";
	setAttr -av -k on ".sp";
	setAttr -av -k on ".shs";
	setAttr -av -k on ".lpr";
	setAttr -cb on ".gv";
	setAttr -cb on ".sv";
	setAttr -av -k on ".mm";
	setAttr -av -k on ".npu";
	setAttr -av -k on ".itf";
	setAttr -av -k on ".shp";
	setAttr -cb on ".isp";
	setAttr -av -k on ".uf";
	setAttr -av -k on ".oi";
	setAttr -av -k on ".rut";
	setAttr -av -k on ".mot";
	setAttr -av -k on ".mb";
	setAttr -av -k on ".mbf";
	setAttr -av -k on ".mbso";
	setAttr -av -k on ".mbsc";
	setAttr -av -k on ".afp";
	setAttr -av -k on ".pfb";
	setAttr -av -k on ".pram" -type "string" "";
	setAttr -av -k on ".poam" -type "string" "";
	setAttr -av -k on ".prlm" -type "string" "";
	setAttr -av -k on ".polm" -type "string" "";
	setAttr -av -cb on ".prm" -type "string" "";
	setAttr -av -cb on ".pom" -type "string" "";
	setAttr -cb on ".pfrm" -type "string" "";
	setAttr -cb on ".pfom" -type "string" "";
	setAttr -av -k on ".bll";
	setAttr -av -k on ".bls";
	setAttr -av -k on ".smv";
	setAttr -av -k on ".ubc";
	setAttr -av -k on ".mbc";
	setAttr -cb on ".mbt";
	setAttr -av -k on ".udbx";
	setAttr -av -k on ".smc";
	setAttr -av -k on ".kmv";
	setAttr -cb on ".isl";
	setAttr -cb on ".ism";
	setAttr -cb on ".imb";
	setAttr -av -k on ".rlen";
	setAttr -av -k on ".frts";
	setAttr -av -k on ".tlwd";
	setAttr -av -k on ".tlht";
	setAttr -av -k on ".jfc";
	setAttr -cb on ".rsb";
	setAttr -av -k on ".ope";
	setAttr -av -k on ".oppf";
	setAttr -av -k on ".rcp";
	setAttr -av -k on ".icp";
	setAttr -av -k on ".ocp";
	setAttr -cb on ".hbl" -type "string" "";
	setAttr ".dss" -type "string" "lambert1";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -av -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av -k on ".w" 1000;
	setAttr -av -k on ".h" 1000;
	setAttr -av -k on ".pa" 1;
	setAttr -av -k on ".al";
	setAttr -av -k on ".dar" 1;
	setAttr -av -k on ".ldar";
	setAttr -av -k on ".dpi";
	setAttr -av -k on ".off";
	setAttr -av -k on ".fld";
	setAttr -av -k on ".zsl";
	setAttr -av -k on ".isu";
	setAttr -av -k on ".pdu";
select -ne :defaultColorMgtGlobals;
	setAttr ".cfe" yes;
	setAttr ".cfp" -type "string" "<MAYA_RESOURCES>/OCIO-configs/Maya-legacy/config.ocio";
	setAttr ".vtn" -type "string" "sRGB gamma (legacy)";
	setAttr ".vn" -type "string" "sRGB gamma";
	setAttr ".dn" -type "string" "legacy";
	setAttr ".wsn" -type "string" "scene-linear Rec 709/sRGB";
	setAttr ".otn" -type "string" "sRGB gamma (legacy)";
	setAttr ".potn" -type "string" "sRGB gamma (legacy)";
select -ne :hardwareRenderGlobals;
	setAttr -av -k on ".cch";
	setAttr -av -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -av -k off -cb on ".ctrs" 256;
	setAttr -av -k off -cb on ".btrs" 512;
	setAttr -av -k off -cb on ".fbfm";
	setAttr -av -k off -cb on ".ehql";
	setAttr -av -k off -cb on ".eams";
	setAttr -av -k off -cb on ".eeaa";
	setAttr -av -k off -cb on ".engm";
	setAttr -av -k off -cb on ".mes";
	setAttr -av -k off -cb on ".emb";
	setAttr -av -k off -cb on ".mbbf";
	setAttr -av -k off -cb on ".mbs";
	setAttr -av -k off -cb on ".trm";
	setAttr -av -k off -cb on ".tshc";
	setAttr -av -k off -cb on ".enpt";
	setAttr -av -k off -cb on ".clmt";
	setAttr -av -k off -cb on ".tcov";
	setAttr -av -k off -cb on ".lith";
	setAttr -av -k off -cb on ".sobc";
	setAttr -av -k off -cb on ".cuth";
	setAttr -av -k off -cb on ".hgcd";
	setAttr -av -k off -cb on ".hgci";
	setAttr -av -k off -cb on ".mgcs";
	setAttr -av -k off -cb on ".twa";
	setAttr -av -k off -cb on ".twz";
	setAttr -av -k on ".hwcc";
	setAttr -av -k on ".hwdp";
	setAttr -av -k on ".hwql";
	setAttr -av -k on ".hwfr";
	setAttr -av -k on ".soll";
	setAttr -av -k on ".sosl";
	setAttr -av -k on ".bswa";
	setAttr -av -k on ".shml";
	setAttr -av -k on ".hwel";
connectAttr "rs_lines.ri" ":persp.rlio[0]";
connectAttr "rs_lines1.ri" ":persp.rlio[1]";
connectAttr "rs_shades.ri" ":persp.rlio[2]";
connectAttr "rs_lines.ri" ":top.rlio[0]";
connectAttr "rs_lines1.ri" ":top.rlio[1]";
connectAttr "rs_shades.ri" ":top.rlio[2]";
connectAttr "rs_lines.ri" ":front.rlio[0]";
connectAttr "rs_lines1.ri" ":front.rlio[1]";
connectAttr "rs_shades.ri" ":front.rlio[2]";
connectAttr "rs_lines.ri" ":side.rlio[0]";
connectAttr "rs_lines1.ri" ":side.rlio[1]";
connectAttr "rs_shades.ri" ":side.rlio[2]";
connectAttr "skinCluster42.og[0]" "L_eyelid_upper_main_curveShape.cr";
connectAttr "L_eyelid_upper_tuner_curveShape.l" "L_eyelid_upper_main_curveShapeOrig.cr"
		;
connectAttr "skinCluster44.og[0]" "L_eyelid_upper_major_curveShape.cr";
connectAttr "L_eyelid_upper_main_curveShape.l" "L_eyelid_upper_major_curveShapeOrig1.cr"
		;
connectAttr "skinCluster43.og[0]" "L_eyelid_lower_main_curveShape.cr";
connectAttr "L_eyelid_lower_tuner_curveShape.l" "L_eyelid_lower_main_curveShapeOrig.cr"
		;
connectAttr "skinCluster45.og[0]" "L_eyelid_lower_major_curveShape.cr";
connectAttr "L_eyelid_lower_main_curveShape.l" "L_eyelid_lower_major_curveShapeOrig1.cr"
		;
connectAttr "skinCluster46.og[0]" "R_eyelid_upper_main_curveShape.cr";
connectAttr "L_eyelid_upper_tuner_transformGeometry.og" "R_eyelid_upper_main_curveShapeOrig1.cr"
		;
connectAttr "skinCluster48.og[0]" "R_eyelid_upper_major_curveShape.cr";
connectAttr "R_eyelid_upper_main_curveShape.l" "R_eyelid_upper_major_curveShapeOrig2.cr"
		;
connectAttr "skinCluster47.og[0]" "R_eyelid_lower_main_curveShape.cr";
connectAttr "L_eyelid_lower_tuner_transformGeometry.og" "R_eyelid_lower_main_curveShapeOrig1.cr"
		;
connectAttr "skinCluster49.og[0]" "R_eyelid_lower_major_curveShape.cr";
connectAttr "R_eyelid_lower_main_curveShape.l" "R_eyelid_lower_major_curveShapeOrig2.cr"
		;
connectAttr "L_eyelid_upper_curve_wire.og[0]" "L_eyelid_upper_curveShape.cr";
connectAttr "L_eyelid_lower_curve_wire.og[0]" "L_eyelid_lower_curveShape.cr";
connectAttr "L_eyelid_upper_tuner_curveShape.l" "L_eyelid_upper_major_curveBaseWireShape.cr"
		;
connectAttr "L_eyelid_lower_tuner_curveShape.l" "L_eyelid_lower_major_curveBaseWireShape.cr"
		;
connectAttr "L_eyelids_avg_blendShape.og[0]" "L_eyelids_avg_curveShape.cr";
connectAttr "R_eyelids_avg_blendShape.og[0]" "R_eyelids_avg_curveShape.cr";
connectAttr "R_eyelid_upper_curve_wire.og[0]" "R_eyelid_upper_curveShape.cr";
connectAttr "R_eyelid_lower_curve_wire.og[0]" "R_eyelid_lower_curveShape.cr";
connectAttr "L_eyelid_upper_tuner_transformGeometry.og" "R_eyelid_upper_major_curveBaseWireShape.cr"
		;
connectAttr "L_eyelid_lower_tuner_transformGeometry.og" "R_eyelid_lower_major_curveBaseWireShape.cr"
		;
connectAttr "skinCluster57.og[0]" "L_eyelid_upper_fold_curveShape.cr";
connectAttr "skinCluster58.og[0]" "R_eyelid_upper_fold_curveShape.cr";
connectAttr "L_eyelids_joint_parentConstraint1.ctx" "L_eyelids_joint.tx";
connectAttr "L_eyelids_joint_parentConstraint1.cty" "L_eyelids_joint.ty";
connectAttr "L_eyelids_joint_parentConstraint1.ctz" "L_eyelids_joint.tz";
connectAttr "L_eyelids_joint_parentConstraint1.crx" "L_eyelids_joint.rx";
connectAttr "L_eyelids_joint_parentConstraint1.cry" "L_eyelids_joint.ry";
connectAttr "L_eyelids_joint_parentConstraint1.crz" "L_eyelids_joint.rz";
connectAttr "L_eye_transform_control.s" "L_eyelids_joint.s";
connectAttr "L_eyelids_joint.ro" "L_eyelids_joint_parentConstraint1.cro";
connectAttr "L_eyelids_joint.pim" "L_eyelids_joint_parentConstraint1.cpim";
connectAttr "L_eyelids_joint.rp" "L_eyelids_joint_parentConstraint1.crp";
connectAttr "L_eyelids_joint.rpt" "L_eyelids_joint_parentConstraint1.crt";
connectAttr "L_eyelids_joint.jo" "L_eyelids_joint_parentConstraint1.cjo";
connectAttr "L_eye_transform_control.t" "L_eyelids_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eye_transform_control.rp" "L_eyelids_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eye_transform_control.rpt" "L_eyelids_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eye_transform_control.r" "L_eyelids_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelids_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.s" "L_eyelids_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelids_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelids_joint_parentConstraint1.w0" "L_eyelids_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_main_joint.is";
connectAttr "L_eyelid_upper_main_control.s" "L_eyelid_upper_main_joint.s";
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.ctx" "L_eyelid_upper_main_joint.tx"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.cty" "L_eyelid_upper_main_joint.ty"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.ctz" "L_eyelid_upper_main_joint.tz"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.crx" "L_eyelid_upper_main_joint.rx"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.cry" "L_eyelid_upper_main_joint.ry"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.crz" "L_eyelid_upper_main_joint.rz"
		;
connectAttr "L_eyelid_upper_main_joint.ro" "L_eyelid_upper_main_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_main_joint.pim" "L_eyelid_upper_main_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_main_joint.rp" "L_eyelid_upper_main_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_main_joint.rpt" "L_eyelid_upper_main_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_main_joint.jo" "L_eyelid_upper_main_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_main_control.t" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_main_control.rp" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_main_control.rpt" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_main_control.r" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_main_control.ro" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_main_control.s" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_main_control.pm" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_main_joint_parentConstraint1.w0" "L_eyelid_upper_main_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_lower_main_joint.is";
connectAttr "L_eyelid_lower_main_control.s" "L_eyelid_lower_main_joint.s";
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.ctx" "L_eyelid_lower_main_joint.tx"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.cty" "L_eyelid_lower_main_joint.ty"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.ctz" "L_eyelid_lower_main_joint.tz"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.crx" "L_eyelid_lower_main_joint.rx"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.cry" "L_eyelid_lower_main_joint.ry"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.crz" "L_eyelid_lower_main_joint.rz"
		;
connectAttr "L_eyelid_lower_main_joint.ro" "L_eyelid_lower_main_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_lower_main_joint.pim" "L_eyelid_lower_main_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_lower_main_joint.rp" "L_eyelid_lower_main_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_lower_main_joint.rpt" "L_eyelid_lower_main_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_lower_main_joint.jo" "L_eyelid_lower_main_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_lower_main_control.t" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_lower_main_control.rp" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_lower_main_control.rpt" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_lower_main_control.r" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_lower_main_control.ro" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_lower_main_control.s" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_lower_main_control.pm" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_lower_main_joint_parentConstraint1.w0" "L_eyelid_lower_main_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_major_1_joint.is";
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.ctx" "L_eyelid_upper_major_1_joint.tx"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.cty" "L_eyelid_upper_major_1_joint.ty"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.ctz" "L_eyelid_upper_major_1_joint.tz"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.crx" "L_eyelid_upper_major_1_joint.rx"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.cry" "L_eyelid_upper_major_1_joint.ry"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.crz" "L_eyelid_upper_major_1_joint.rz"
		;
connectAttr "L_eyelid_upper_major_1_joint.ro" "L_eyelid_upper_major_1_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_major_1_joint.pim" "L_eyelid_upper_major_1_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_major_1_joint.rp" "L_eyelid_upper_major_1_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_major_1_joint.rpt" "L_eyelid_upper_major_1_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_major_1_joint.jo" "L_eyelid_upper_major_1_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_major_1_control.t" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_major_1_control.rp" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_major_1_control.rpt" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_major_1_control.r" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_major_1_control.ro" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_major_1_control.s" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_major_1_control.pm" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_major_1_joint_parentConstraint1.w0" "L_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_major_2_joint.is";
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.ctx" "L_eyelid_upper_major_2_joint.tx"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.cty" "L_eyelid_upper_major_2_joint.ty"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.ctz" "L_eyelid_upper_major_2_joint.tz"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.crx" "L_eyelid_upper_major_2_joint.rx"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.cry" "L_eyelid_upper_major_2_joint.ry"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.crz" "L_eyelid_upper_major_2_joint.rz"
		;
connectAttr "L_eyelid_upper_major_2_joint.ro" "L_eyelid_upper_major_2_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_major_2_joint.pim" "L_eyelid_upper_major_2_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_major_2_joint.rp" "L_eyelid_upper_major_2_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_major_2_joint.rpt" "L_eyelid_upper_major_2_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_major_2_joint.jo" "L_eyelid_upper_major_2_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_major_2_control.t" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_major_2_control.rp" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_major_2_control.rpt" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_major_2_control.r" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_major_2_control.ro" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_major_2_control.s" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_major_2_control.pm" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_major_2_joint_parentConstraint1.w0" "L_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_lower_major_1_joint.is";
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.ctx" "L_eyelid_lower_major_1_joint.tx"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.cty" "L_eyelid_lower_major_1_joint.ty"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.ctz" "L_eyelid_lower_major_1_joint.tz"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.crx" "L_eyelid_lower_major_1_joint.rx"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.cry" "L_eyelid_lower_major_1_joint.ry"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.crz" "L_eyelid_lower_major_1_joint.rz"
		;
connectAttr "L_eyelid_lower_major_1_joint.ro" "L_eyelid_lower_major_1_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_lower_major_1_joint.pim" "L_eyelid_lower_major_1_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_lower_major_1_joint.rp" "L_eyelid_lower_major_1_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_lower_major_1_joint.rpt" "L_eyelid_lower_major_1_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_lower_major_1_joint.jo" "L_eyelid_lower_major_1_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_lower_major_1_control.t" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_lower_major_1_control.rp" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_lower_major_1_control.rpt" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_lower_major_1_control.r" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_lower_major_1_control.ro" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_lower_major_1_control.s" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_lower_major_1_control.pm" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_lower_major_1_joint_parentConstraint1.w0" "L_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_lower_major_2_joint.is";
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.ctx" "L_eyelid_lower_major_2_joint.tx"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.cty" "L_eyelid_lower_major_2_joint.ty"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.ctz" "L_eyelid_lower_major_2_joint.tz"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.crx" "L_eyelid_lower_major_2_joint.rx"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.cry" "L_eyelid_lower_major_2_joint.ry"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.crz" "L_eyelid_lower_major_2_joint.rz"
		;
connectAttr "L_eyelid_lower_major_2_joint.ro" "L_eyelid_lower_major_2_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_lower_major_2_joint.pim" "L_eyelid_lower_major_2_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_lower_major_2_joint.rp" "L_eyelid_lower_major_2_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_lower_major_2_joint.rpt" "L_eyelid_lower_major_2_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_lower_major_2_joint.jo" "L_eyelid_lower_major_2_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_lower_major_2_control.t" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_lower_major_2_control.rp" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_lower_major_2_control.rpt" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_lower_major_2_control.r" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_lower_major_2_control.ro" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_lower_major_2_control.s" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_lower_major_2_control.pm" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_lower_major_2_joint_parentConstraint1.w0" "L_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelids_corner_inner_joint.is";
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.ctx" "L_eyelids_corner_inner_joint.tx"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.cty" "L_eyelids_corner_inner_joint.ty"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.ctz" "L_eyelids_corner_inner_joint.tz"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.crx" "L_eyelids_corner_inner_joint.rx"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.cry" "L_eyelids_corner_inner_joint.ry"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.crz" "L_eyelids_corner_inner_joint.rz"
		;
connectAttr "L_eyelids_corner_inner_joint.ro" "L_eyelids_corner_inner_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelids_corner_inner_joint.pim" "L_eyelids_corner_inner_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelids_corner_inner_joint.rp" "L_eyelids_corner_inner_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelids_corner_inner_joint.rpt" "L_eyelids_corner_inner_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelids_corner_inner_joint.jo" "L_eyelids_corner_inner_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelids_corner_inner_control.t" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelids_corner_inner_control.rp" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelids_corner_inner_control.rpt" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelids_corner_inner_control.r" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelids_corner_inner_control.ro" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelids_corner_inner_control.s" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelids_corner_inner_control.pm" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelids_corner_inner_joint_parentConstraint1.w0" "L_eyelids_corner_inner_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.s" "L_eyelids_corner_outer_joint.is";
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.ctx" "L_eyelids_corner_outer_joint.tx"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.cty" "L_eyelids_corner_outer_joint.ty"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.ctz" "L_eyelids_corner_outer_joint.tz"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.crx" "L_eyelids_corner_outer_joint.rx"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.cry" "L_eyelids_corner_outer_joint.ry"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.crz" "L_eyelids_corner_outer_joint.rz"
		;
connectAttr "L_eyelids_corner_outer_joint.ro" "L_eyelids_corner_outer_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelids_corner_outer_joint.pim" "L_eyelids_corner_outer_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelids_corner_outer_joint.rp" "L_eyelids_corner_outer_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelids_corner_outer_joint.rpt" "L_eyelids_corner_outer_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelids_corner_outer_joint.jo" "L_eyelids_corner_outer_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelids_corner_outer_control.t" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelids_corner_outer_control.rp" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelids_corner_outer_control.rpt" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelids_corner_outer_control.r" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelids_corner_outer_control.ro" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelids_corner_outer_control.s" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelids_corner_outer_control.pm" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelids_corner_outer_joint_parentConstraint1.w0" "L_eyelids_corner_outer_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.ctx" "L_eyelid_upper_fold_main_1_joint.tx"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.cty" "L_eyelid_upper_fold_main_1_joint.ty"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.ctz" "L_eyelid_upper_fold_main_1_joint.tz"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.crx" "L_eyelid_upper_fold_main_1_joint.rx"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.cry" "L_eyelid_upper_fold_main_1_joint.ry"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.crz" "L_eyelid_upper_fold_main_1_joint.rz"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.s" "L_eyelid_upper_fold_main_1_joint.s"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_fold_main_1_joint.is";
connectAttr "L_eyelid_upper_fold_main_1_joint.ro" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint.pim" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint.rp" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint.rpt" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint.jo" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.t" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.rp" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.rpt" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.r" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.ro" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.s" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_fold_main_1_control.pm" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_fold_main_1_joint_parentConstraint1.w0" "L_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.ctx" "L_eyelid_upper_fold_main_2_joint.tx"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.cty" "L_eyelid_upper_fold_main_2_joint.ty"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.ctz" "L_eyelid_upper_fold_main_2_joint.tz"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.crx" "L_eyelid_upper_fold_main_2_joint.rx"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.cry" "L_eyelid_upper_fold_main_2_joint.ry"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.crz" "L_eyelid_upper_fold_main_2_joint.rz"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.s" "L_eyelid_upper_fold_main_2_joint.s"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_fold_main_2_joint.is";
connectAttr "L_eyelid_upper_fold_main_2_joint.ro" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint.pim" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint.rp" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint.rpt" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint.jo" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.t" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rp" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rpt" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.r" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.ro" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.s" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.pm" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_fold_main_2_joint_parentConstraint1.w0" "L_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.ctx" "L_eyelid_upper_fold_main_3_joint.tx"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.cty" "L_eyelid_upper_fold_main_3_joint.ty"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.ctz" "L_eyelid_upper_fold_main_3_joint.tz"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.crx" "L_eyelid_upper_fold_main_3_joint.rx"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.cry" "L_eyelid_upper_fold_main_3_joint.ry"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.crz" "L_eyelid_upper_fold_main_3_joint.rz"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.s" "L_eyelid_upper_fold_main_3_joint.s"
		;
connectAttr "L_eyelids_joint.s" "L_eyelid_upper_fold_main_3_joint.is";
connectAttr "L_eyelid_upper_fold_main_3_joint.ro" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.cro"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint.pim" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint.rp" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.crp"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint.rpt" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.crt"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint.jo" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.cjo"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.t" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.rp" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.rpt" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.r" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.ro" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.s" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eyelid_upper_fold_main_3_control.pm" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_fold_main_3_joint_parentConstraint1.w0" "L_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint_parentConstraint1.ctx" "R_eyelids_joint.tx";
connectAttr "R_eyelids_joint_parentConstraint1.cty" "R_eyelids_joint.ty";
connectAttr "R_eyelids_joint_parentConstraint1.ctz" "R_eyelids_joint.tz";
connectAttr "R_eyelids_joint_parentConstraint1.crx" "R_eyelids_joint.rx";
connectAttr "R_eyelids_joint_parentConstraint1.cry" "R_eyelids_joint.ry";
connectAttr "R_eyelids_joint_parentConstraint1.crz" "R_eyelids_joint.rz";
connectAttr "R_eye_transform_control.s" "R_eyelids_joint.s";
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_main_joint.is";
connectAttr "R_eyelid_upper_main_control.s" "R_eyelid_upper_main_joint.s";
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.ctx" "R_eyelid_upper_main_joint.tx"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.cty" "R_eyelid_upper_main_joint.ty"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.ctz" "R_eyelid_upper_main_joint.tz"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.crx" "R_eyelid_upper_main_joint.rx"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.cry" "R_eyelid_upper_main_joint.ry"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.crz" "R_eyelid_upper_main_joint.rz"
		;
connectAttr "R_eyelid_upper_main_joint.ro" "R_eyelid_upper_main_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_main_joint.pim" "R_eyelid_upper_main_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_main_joint.rp" "R_eyelid_upper_main_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_main_joint.rpt" "R_eyelid_upper_main_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_main_joint.jo" "R_eyelid_upper_main_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_main_control.t" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_main_control.rp" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_main_control.rpt" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_main_control.r" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_main_control.ro" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_main_control.s" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_main_control.pm" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_main_joint_parentConstraint1.w0" "R_eyelid_upper_main_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_lower_main_joint.is";
connectAttr "R_eyelid_lower_main_control.s" "R_eyelid_lower_main_joint.s";
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.ctx" "R_eyelid_lower_main_joint.tx"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.cty" "R_eyelid_lower_main_joint.ty"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.ctz" "R_eyelid_lower_main_joint.tz"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.crx" "R_eyelid_lower_main_joint.rx"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.cry" "R_eyelid_lower_main_joint.ry"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.crz" "R_eyelid_lower_main_joint.rz"
		;
connectAttr "R_eyelid_lower_main_joint.ro" "R_eyelid_lower_main_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_lower_main_joint.pim" "R_eyelid_lower_main_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_lower_main_joint.rp" "R_eyelid_lower_main_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_lower_main_joint.rpt" "R_eyelid_lower_main_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_lower_main_joint.jo" "R_eyelid_lower_main_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_lower_main_control.t" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_lower_main_control.rp" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_lower_main_control.rpt" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_lower_main_control.r" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_lower_main_control.ro" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_lower_main_control.s" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_lower_main_control.pm" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_lower_main_joint_parentConstraint1.w0" "R_eyelid_lower_main_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_major_1_joint.is";
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.ctx" "R_eyelid_upper_major_1_joint.tx"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.cty" "R_eyelid_upper_major_1_joint.ty"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.ctz" "R_eyelid_upper_major_1_joint.tz"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.crx" "R_eyelid_upper_major_1_joint.rx"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.cry" "R_eyelid_upper_major_1_joint.ry"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.crz" "R_eyelid_upper_major_1_joint.rz"
		;
connectAttr "R_eyelid_upper_major_1_joint.ro" "R_eyelid_upper_major_1_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_major_1_joint.pim" "R_eyelid_upper_major_1_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_major_1_joint.rp" "R_eyelid_upper_major_1_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_major_1_joint.rpt" "R_eyelid_upper_major_1_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_major_1_joint.jo" "R_eyelid_upper_major_1_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_major_1_control.t" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_major_1_control.rp" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_major_1_control.rpt" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_major_1_control.r" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_major_1_control.ro" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_major_1_control.s" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_major_1_control.pm" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_major_1_joint_parentConstraint1.w0" "R_eyelid_upper_major_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_major_2_joint.is";
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.ctx" "R_eyelid_upper_major_2_joint.tx"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.cty" "R_eyelid_upper_major_2_joint.ty"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.ctz" "R_eyelid_upper_major_2_joint.tz"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.crx" "R_eyelid_upper_major_2_joint.rx"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.cry" "R_eyelid_upper_major_2_joint.ry"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.crz" "R_eyelid_upper_major_2_joint.rz"
		;
connectAttr "R_eyelid_upper_major_2_joint.ro" "R_eyelid_upper_major_2_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_major_2_joint.pim" "R_eyelid_upper_major_2_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_major_2_joint.rp" "R_eyelid_upper_major_2_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_major_2_joint.rpt" "R_eyelid_upper_major_2_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_major_2_joint.jo" "R_eyelid_upper_major_2_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_major_2_control.t" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_major_2_control.rp" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_major_2_control.rpt" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_major_2_control.r" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_major_2_control.ro" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_major_2_control.s" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_major_2_control.pm" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_major_2_joint_parentConstraint1.w0" "R_eyelid_upper_major_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_lower_major_1_joint.is";
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.ctx" "R_eyelid_lower_major_1_joint.tx"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.cty" "R_eyelid_lower_major_1_joint.ty"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.ctz" "R_eyelid_lower_major_1_joint.tz"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.crx" "R_eyelid_lower_major_1_joint.rx"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.cry" "R_eyelid_lower_major_1_joint.ry"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.crz" "R_eyelid_lower_major_1_joint.rz"
		;
connectAttr "R_eyelid_lower_major_1_joint.ro" "R_eyelid_lower_major_1_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_lower_major_1_joint.pim" "R_eyelid_lower_major_1_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_lower_major_1_joint.rp" "R_eyelid_lower_major_1_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_lower_major_1_joint.rpt" "R_eyelid_lower_major_1_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_lower_major_1_joint.jo" "R_eyelid_lower_major_1_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_lower_major_1_control.t" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_lower_major_1_control.rp" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_lower_major_1_control.rpt" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_lower_major_1_control.r" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_lower_major_1_control.ro" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_lower_major_1_control.s" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_lower_major_1_control.pm" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_lower_major_1_joint_parentConstraint1.w0" "R_eyelid_lower_major_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_lower_major_2_joint.is";
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.ctx" "R_eyelid_lower_major_2_joint.tx"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.cty" "R_eyelid_lower_major_2_joint.ty"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.ctz" "R_eyelid_lower_major_2_joint.tz"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.crx" "R_eyelid_lower_major_2_joint.rx"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.cry" "R_eyelid_lower_major_2_joint.ry"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.crz" "R_eyelid_lower_major_2_joint.rz"
		;
connectAttr "R_eyelid_lower_major_2_joint.ro" "R_eyelid_lower_major_2_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_lower_major_2_joint.pim" "R_eyelid_lower_major_2_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_lower_major_2_joint.rp" "R_eyelid_lower_major_2_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_lower_major_2_joint.rpt" "R_eyelid_lower_major_2_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_lower_major_2_joint.jo" "R_eyelid_lower_major_2_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_lower_major_2_control.t" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_lower_major_2_control.rp" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_lower_major_2_control.rpt" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_lower_major_2_control.r" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_lower_major_2_control.ro" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_lower_major_2_control.s" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_lower_major_2_control.pm" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_lower_major_2_joint_parentConstraint1.w0" "R_eyelid_lower_major_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.ro" "R_eyelids_joint_parentConstraint1.cro";
connectAttr "R_eyelids_joint.pim" "R_eyelids_joint_parentConstraint1.cpim";
connectAttr "R_eyelids_joint.rp" "R_eyelids_joint_parentConstraint1.crp";
connectAttr "R_eyelids_joint.rpt" "R_eyelids_joint_parentConstraint1.crt";
connectAttr "R_eyelids_joint.jo" "R_eyelids_joint_parentConstraint1.cjo";
connectAttr "R_eye_transform_control.t" "R_eyelids_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eye_transform_control.rp" "R_eyelids_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eye_transform_control.rpt" "R_eyelids_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eye_transform_control.r" "R_eyelids_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelids_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.s" "R_eyelids_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelids_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelids_joint_parentConstraint1.w0" "R_eyelids_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.ctx" "R_eyelid_upper_fold_main_1_joint.tx"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.cty" "R_eyelid_upper_fold_main_1_joint.ty"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.ctz" "R_eyelid_upper_fold_main_1_joint.tz"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.crx" "R_eyelid_upper_fold_main_1_joint.rx"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.cry" "R_eyelid_upper_fold_main_1_joint.ry"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.crz" "R_eyelid_upper_fold_main_1_joint.rz"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_fold_main_1_joint.is";
connectAttr "R_eyelid_upper_fold_main_1_joint.ro" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint.pim" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint.rp" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint.rpt" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint.jo" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.t" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.rp" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.rpt" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.r" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.ro" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.s" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_fold_main_1_control.pm" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_fold_main_1_joint_parentConstraint1.w0" "R_eyelid_upper_fold_main_1_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.ctx" "R_eyelid_upper_fold_main_2_joint.tx"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.cty" "R_eyelid_upper_fold_main_2_joint.ty"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.ctz" "R_eyelid_upper_fold_main_2_joint.tz"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.crx" "R_eyelid_upper_fold_main_2_joint.rx"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.cry" "R_eyelid_upper_fold_main_2_joint.ry"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.crz" "R_eyelid_upper_fold_main_2_joint.rz"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.s" "R_eyelid_upper_fold_main_2_joint.s"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_fold_main_2_joint.is";
connectAttr "R_eyelid_upper_fold_main_2_joint.ro" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint.pim" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint.rp" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint.rpt" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint.jo" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.t" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rp" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rpt" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.r" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.ro" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.s" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.pm" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_fold_main_2_joint_parentConstraint1.w0" "R_eyelid_upper_fold_main_2_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.ctx" "R_eyelid_upper_fold_main_3_joint.tx"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.cty" "R_eyelid_upper_fold_main_3_joint.ty"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.ctz" "R_eyelid_upper_fold_main_3_joint.tz"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.crx" "R_eyelid_upper_fold_main_3_joint.rx"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.cry" "R_eyelid_upper_fold_main_3_joint.ry"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.crz" "R_eyelid_upper_fold_main_3_joint.rz"
		;
connectAttr "R_eyelids_joint.s" "R_eyelid_upper_fold_main_3_joint.is";
connectAttr "R_eyelid_upper_fold_main_3_joint.ro" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint.pim" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint.rp" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint.rpt" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint.jo" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.t" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.rp" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.rpt" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.r" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.ro" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.s" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelid_upper_fold_main_3_control.pm" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_fold_main_3_joint_parentConstraint1.w0" "R_eyelid_upper_fold_main_3_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelids_corner_inner_joint.is";
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.ctx" "R_eyelids_corner_inner_joint.tx"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.cty" "R_eyelids_corner_inner_joint.ty"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.ctz" "R_eyelids_corner_inner_joint.tz"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.crx" "R_eyelids_corner_inner_joint.rx"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.cry" "R_eyelids_corner_inner_joint.ry"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.crz" "R_eyelids_corner_inner_joint.rz"
		;
connectAttr "R_eyelids_corner_inner_joint.ro" "R_eyelids_corner_inner_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelids_corner_inner_joint.pim" "R_eyelids_corner_inner_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelids_corner_inner_joint.rp" "R_eyelids_corner_inner_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelids_corner_inner_joint.rpt" "R_eyelids_corner_inner_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelids_corner_inner_joint.jo" "R_eyelids_corner_inner_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelids_corner_inner_control.t" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelids_corner_inner_control.rp" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelids_corner_inner_control.rpt" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelids_corner_inner_control.r" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelids_corner_inner_control.ro" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelids_corner_inner_control.s" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelids_corner_inner_control.pm" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelids_corner_inner_joint_parentConstraint1.w0" "R_eyelids_corner_inner_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.s" "R_eyelids_corner_outer_joint.is";
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.ctx" "R_eyelids_corner_outer_joint.tx"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.cty" "R_eyelids_corner_outer_joint.ty"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.ctz" "R_eyelids_corner_outer_joint.tz"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.crx" "R_eyelids_corner_outer_joint.rx"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.cry" "R_eyelids_corner_outer_joint.ry"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.crz" "R_eyelids_corner_outer_joint.rz"
		;
connectAttr "R_eyelids_corner_outer_joint.ro" "R_eyelids_corner_outer_joint_parentConstraint1.cro"
		;
connectAttr "R_eyelids_corner_outer_joint.pim" "R_eyelids_corner_outer_joint_parentConstraint1.cpim"
		;
connectAttr "R_eyelids_corner_outer_joint.rp" "R_eyelids_corner_outer_joint_parentConstraint1.crp"
		;
connectAttr "R_eyelids_corner_outer_joint.rpt" "R_eyelids_corner_outer_joint_parentConstraint1.crt"
		;
connectAttr "R_eyelids_corner_outer_joint.jo" "R_eyelids_corner_outer_joint_parentConstraint1.cjo"
		;
connectAttr "R_eyelids_corner_outer_control.t" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eyelids_corner_outer_control.rp" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eyelids_corner_outer_control.rpt" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eyelids_corner_outer_control.r" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eyelids_corner_outer_control.ro" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eyelids_corner_outer_control.s" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eyelids_corner_outer_control.pm" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelids_corner_outer_joint_parentConstraint1.w0" "R_eyelids_corner_outer_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_lower_major_1_control_orientConstraint1.crx" "L_eyelid_lower_major_1_control_transform.rx"
		;
connectAttr "L_eyelid_lower_major_1_control_orientConstraint1.cry" "L_eyelid_lower_major_1_control_transform.ry"
		;
connectAttr "L_eyelid_lower_major_1_control_orientConstraint1.crz" "L_eyelid_lower_major_1_control_transform.rz"
		;
connectAttr "L_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.o" "L_eyelid_lower_major_1_control_transform.t"
		;
connectAttr "L_eyelid_lower_major_1_control_transform.ro" "L_eyelid_lower_major_1_control_orientConstraint1.cro"
		;
connectAttr "L_eyelid_lower_major_1_control_transform.pim" "L_eyelid_lower_major_1_control_orientConstraint1.cpim"
		;
connectAttr "L_eye_transform_control.r" "L_eyelid_lower_major_1_control_orientConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelid_lower_major_1_control_orientConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelid_lower_major_1_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_lower_major_1_control_orientConstraint1.w0" "L_eyelid_lower_major_1_control_orientConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_lower_major_2_control_orientConstraint1.crx" "L_eyelid_lower_major_2_control_transform.rx"
		;
connectAttr "L_eyelid_lower_major_2_control_orientConstraint1.cry" "L_eyelid_lower_major_2_control_transform.ry"
		;
connectAttr "L_eyelid_lower_major_2_control_orientConstraint1.crz" "L_eyelid_lower_major_2_control_transform.rz"
		;
connectAttr "L_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.o" "L_eyelid_lower_major_2_control_transform.t"
		;
connectAttr "L_eyelid_lower_major_2_control_transform.ro" "L_eyelid_lower_major_2_control_orientConstraint1.cro"
		;
connectAttr "L_eyelid_lower_major_2_control_transform.pim" "L_eyelid_lower_major_2_control_orientConstraint1.cpim"
		;
connectAttr "L_eye_transform_control.r" "L_eyelid_lower_major_2_control_orientConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelid_lower_major_2_control_orientConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelid_lower_major_2_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_lower_major_2_control_orientConstraint1.w0" "L_eyelid_lower_major_2_control_orientConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_major_1_control_orientConstraint1.crx" "L_eyelid_upper_major_1_control_transform.rx"
		;
connectAttr "L_eyelid_upper_major_1_control_orientConstraint1.cry" "L_eyelid_upper_major_1_control_transform.ry"
		;
connectAttr "L_eyelid_upper_major_1_control_orientConstraint1.crz" "L_eyelid_upper_major_1_control_transform.rz"
		;
connectAttr "L_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.o" "L_eyelid_upper_major_1_control_transform.t"
		;
connectAttr "L_eyelid_upper_major_1_control_transform.ro" "L_eyelid_upper_major_1_control_orientConstraint1.cro"
		;
connectAttr "L_eyelid_upper_major_1_control_transform.pim" "L_eyelid_upper_major_1_control_orientConstraint1.cpim"
		;
connectAttr "L_eye_transform_control.r" "L_eyelid_upper_major_1_control_orientConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelid_upper_major_1_control_orientConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelid_upper_major_1_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_major_1_control_orientConstraint1.w0" "L_eyelid_upper_major_1_control_orientConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_major_2_control_orientConstraint1.crx" "L_eyelid_upper_major_2_control_transform.rx"
		;
connectAttr "L_eyelid_upper_major_2_control_orientConstraint1.cry" "L_eyelid_upper_major_2_control_transform.ry"
		;
connectAttr "L_eyelid_upper_major_2_control_orientConstraint1.crz" "L_eyelid_upper_major_2_control_transform.rz"
		;
connectAttr "L_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.o" "L_eyelid_upper_major_2_control_transform.t"
		;
connectAttr "L_eyelid_upper_major_2_control_transform.ro" "L_eyelid_upper_major_2_control_orientConstraint1.cro"
		;
connectAttr "L_eyelid_upper_major_2_control_transform.pim" "L_eyelid_upper_major_2_control_orientConstraint1.cpim"
		;
connectAttr "L_eye_transform_control.r" "L_eyelid_upper_major_2_control_orientConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelid_upper_major_2_control_orientConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelid_upper_major_2_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_major_2_control_orientConstraint1.w0" "L_eyelid_upper_major_2_control_orientConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_lower_major_1_control_orientConstraint1.crx" "R_eyelid_lower_major_1_control_transform.rx"
		;
connectAttr "R_eyelid_lower_major_1_control_orientConstraint1.cry" "R_eyelid_lower_major_1_control_transform.ry"
		;
connectAttr "R_eyelid_lower_major_1_control_orientConstraint1.crz" "R_eyelid_lower_major_1_control_transform.rz"
		;
connectAttr "R_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.o" "R_eyelid_lower_major_1_control_transform.t"
		;
connectAttr "R_eyelid_lower_major_1_control_transform.ro" "R_eyelid_lower_major_1_control_orientConstraint1.cro"
		;
connectAttr "R_eyelid_lower_major_1_control_transform.pim" "R_eyelid_lower_major_1_control_orientConstraint1.cpim"
		;
connectAttr "R_eye_transform_control.r" "R_eyelid_lower_major_1_control_orientConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelid_lower_major_1_control_orientConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelid_lower_major_1_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_lower_major_1_control_orientConstraint1.w0" "R_eyelid_lower_major_1_control_orientConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_lower_major_2_control_orientConstraint1.crx" "R_eyelid_lower_major_2_control_transform.rx"
		;
connectAttr "R_eyelid_lower_major_2_control_orientConstraint1.cry" "R_eyelid_lower_major_2_control_transform.ry"
		;
connectAttr "R_eyelid_lower_major_2_control_orientConstraint1.crz" "R_eyelid_lower_major_2_control_transform.rz"
		;
connectAttr "R_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.o" "R_eyelid_lower_major_2_control_transform.t"
		;
connectAttr "R_eyelid_lower_major_2_control_transform.ro" "R_eyelid_lower_major_2_control_orientConstraint1.cro"
		;
connectAttr "R_eyelid_lower_major_2_control_transform.pim" "R_eyelid_lower_major_2_control_orientConstraint1.cpim"
		;
connectAttr "R_eye_transform_control.r" "R_eyelid_lower_major_2_control_orientConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelid_lower_major_2_control_orientConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelid_lower_major_2_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_lower_major_2_control_orientConstraint1.w0" "R_eyelid_lower_major_2_control_orientConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_major_1_control_orientConstraint1.crx" "R_eyelid_upper_major_1_control_transform.rx"
		;
connectAttr "R_eyelid_upper_major_1_control_orientConstraint1.cry" "R_eyelid_upper_major_1_control_transform.ry"
		;
connectAttr "R_eyelid_upper_major_1_control_orientConstraint1.crz" "R_eyelid_upper_major_1_control_transform.rz"
		;
connectAttr "R_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.o" "R_eyelid_upper_major_1_control_transform.t"
		;
connectAttr "R_eyelid_upper_major_1_control_transform.ro" "R_eyelid_upper_major_1_control_orientConstraint1.cro"
		;
connectAttr "R_eyelid_upper_major_1_control_transform.pim" "R_eyelid_upper_major_1_control_orientConstraint1.cpim"
		;
connectAttr "R_eye_transform_control.r" "R_eyelid_upper_major_1_control_orientConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelid_upper_major_1_control_orientConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelid_upper_major_1_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_major_1_control_orientConstraint1.w0" "R_eyelid_upper_major_1_control_orientConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_major_2_control_orientConstraint1.crx" "R_eyelid_upper_major_2_control_transform.rx"
		;
connectAttr "R_eyelid_upper_major_2_control_orientConstraint1.cry" "R_eyelid_upper_major_2_control_transform.ry"
		;
connectAttr "R_eyelid_upper_major_2_control_orientConstraint1.crz" "R_eyelid_upper_major_2_control_transform.rz"
		;
connectAttr "R_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.o" "R_eyelid_upper_major_2_control_transform.t"
		;
connectAttr "R_eyelid_upper_major_2_control_transform.ro" "R_eyelid_upper_major_2_control_orientConstraint1.cro"
		;
connectAttr "R_eyelid_upper_major_2_control_transform.pim" "R_eyelid_upper_major_2_control_orientConstraint1.cpim"
		;
connectAttr "R_eye_transform_control.r" "R_eyelid_upper_major_2_control_orientConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelid_upper_major_2_control_orientConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelid_upper_major_2_control_orientConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_major_2_control_orientConstraint1.w0" "R_eyelid_upper_major_2_control_orientConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_transform_tuner.m" "L_eye_transform_control.opm";
connectAttr "L_eyelid_upper_fold_main_1_control_aimConstraint1.crx" "L_eyelid_upper_fold_main_1_control_transform.rx"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_aimConstraint1.cry" "L_eyelid_upper_fold_main_1_control_transform.ry"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_aimConstraint1.crz" "L_eyelid_upper_fold_main_1_control_transform.rz"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.pim" "L_eyelid_upper_fold_main_1_control_aimConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.t" "L_eyelid_upper_fold_main_1_control_aimConstraint1.ct"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.rp" "L_eyelid_upper_fold_main_1_control_aimConstraint1.crp"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.rpt" "L_eyelid_upper_fold_main_1_control_aimConstraint1.crt"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.ro" "L_eyelid_upper_fold_main_1_control_aimConstraint1.cro"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.t" "L_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rp" "L_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rpt" "L_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.pm" "L_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_aimConstraint1.w0" "L_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.wm" "L_eyelid_upper_fold_main_1_control_aimConstraint1.wum"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_aimConstraint1.crx" "L_eyelid_upper_fold_main_3_control_transform.rx"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_aimConstraint1.cry" "L_eyelid_upper_fold_main_3_control_transform.ry"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_aimConstraint1.crz" "L_eyelid_upper_fold_main_3_control_transform.rz"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.pim" "L_eyelid_upper_fold_main_3_control_aimConstraint1.cpim"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.t" "L_eyelid_upper_fold_main_3_control_aimConstraint1.ct"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.rp" "L_eyelid_upper_fold_main_3_control_aimConstraint1.crp"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.rpt" "L_eyelid_upper_fold_main_3_control_aimConstraint1.crt"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.ro" "L_eyelid_upper_fold_main_3_control_aimConstraint1.cro"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.t" "L_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rp" "L_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].trp"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.rpt" "L_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].trt"
		;
connectAttr "L_eyelid_upper_fold_main_2_control.pm" "L_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_aimConstraint1.w0" "L_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tw"
		;
connectAttr "L_eyelids_joint.wm" "L_eyelid_upper_fold_main_3_control_aimConstraint1.wum"
		;
connectAttr "L_eyelids_lower_main_tuner.m" "L_eyelid_lower_main_control.opm";
connectAttr "L_eyelids_upper_main_tuner.m" "L_eyelid_upper_main_control.opm";
connectAttr "L_eyelids_corner_inner_control_transform_parentConstraint1.cty" "L_eyelids_corner_inner_control_transform.ty"
		;
connectAttr "L_eyelids_corner_inner_tuner.m" "L_eyelids_corner_inner_control.opm"
		;
connectAttr "L_eyelids_corner_inner_control_transform.ro" "L_eyelids_corner_inner_control_transform_parentConstraint1.cro"
		;
connectAttr "L_eyelids_corner_inner_control_transform.pim" "L_eyelids_corner_inner_control_transform_parentConstraint1.cpim"
		;
connectAttr "L_eyelids_corner_inner_control_transform.rp" "L_eyelids_corner_inner_control_transform_parentConstraint1.crp"
		;
connectAttr "L_eyelids_corner_inner_control_transform.rpt" "L_eyelids_corner_inner_control_transform_parentConstraint1.crt"
		;
connectAttr "L_eye_transform_control.t" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eye_transform_control.rp" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eye_transform_control.rpt" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eye_transform_control.r" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.s" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelids_corner_inner_control_transform_parentConstraint1.w0" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_lower_main_control.t" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tt"
		;
connectAttr "L_eyelid_lower_main_control.rp" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].trp"
		;
connectAttr "L_eyelid_lower_main_control.rpt" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].trt"
		;
connectAttr "L_eyelid_lower_main_control.r" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tr"
		;
connectAttr "L_eyelid_lower_main_control.ro" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tro"
		;
connectAttr "L_eyelid_lower_main_control.s" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].ts"
		;
connectAttr "L_eyelid_lower_main_control.pm" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tpm"
		;
connectAttr "L_eyelids_corner_inner_control_transform_parentConstraint1.w1" "L_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tw"
		;
connectAttr "L_eyelids_corner_outer_control_transform_parentConstraint1.cty" "L_eyelids_corner_outer_control_transform.ty"
		;
connectAttr "L_eyelids_corner_outer_tuner.m" "L_eyelids_corner_outer_control.opm"
		;
connectAttr "L_eyelids_corner_outer_control_transform.ro" "L_eyelids_corner_outer_control_transform_parentConstraint1.cro"
		;
connectAttr "L_eyelids_corner_outer_control_transform.pim" "L_eyelids_corner_outer_control_transform_parentConstraint1.cpim"
		;
connectAttr "L_eyelids_corner_outer_control_transform.rp" "L_eyelids_corner_outer_control_transform_parentConstraint1.crp"
		;
connectAttr "L_eyelids_corner_outer_control_transform.rpt" "L_eyelids_corner_outer_control_transform_parentConstraint1.crt"
		;
connectAttr "L_eye_transform_control.t" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tt"
		;
connectAttr "L_eye_transform_control.rp" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].trp"
		;
connectAttr "L_eye_transform_control.rpt" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].trt"
		;
connectAttr "L_eye_transform_control.r" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tr"
		;
connectAttr "L_eye_transform_control.ro" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tro"
		;
connectAttr "L_eye_transform_control.s" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].ts"
		;
connectAttr "L_eye_transform_control.pm" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_eyelids_corner_outer_control_transform_parentConstraint1.w0" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tw"
		;
connectAttr "L_eyelid_upper_main_control.t" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tt"
		;
connectAttr "L_eyelid_upper_main_control.rp" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].trp"
		;
connectAttr "L_eyelid_upper_main_control.rpt" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].trt"
		;
connectAttr "L_eyelid_upper_main_control.r" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tr"
		;
connectAttr "L_eyelid_upper_main_control.ro" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tro"
		;
connectAttr "L_eyelid_upper_main_control.s" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].ts"
		;
connectAttr "L_eyelid_upper_main_control.pm" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tpm"
		;
connectAttr "L_eyelids_corner_outer_control_transform_parentConstraint1.w1" "L_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tw"
		;
connectAttr "R_eyelids_transform_tuner.m" "R_eye_transform_control.opm";
connectAttr "R_eyelid_upper_fold_main_1_control_aimConstraint1.crx" "R_eyelid_upper_fold_main_1_control_transform.rx"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_aimConstraint1.cry" "R_eyelid_upper_fold_main_1_control_transform.ry"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_aimConstraint1.crz" "R_eyelid_upper_fold_main_1_control_transform.rz"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_transform.t" "R_eyelid_upper_fold_main_1_control_transform.t"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_transform.pim" "R_eyelid_upper_fold_main_1_control_aimConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_transform.t" "R_eyelid_upper_fold_main_1_control_aimConstraint1.ct"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_transform.rp" "R_eyelid_upper_fold_main_1_control_aimConstraint1.crp"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_transform.rpt" "R_eyelid_upper_fold_main_1_control_aimConstraint1.crt"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_transform.ro" "R_eyelid_upper_fold_main_1_control_aimConstraint1.cro"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.t" "R_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rp" "R_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rpt" "R_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.pm" "R_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_fold_main_1_control_aimConstraint1.w0" "R_eyelid_upper_fold_main_1_control_aimConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.wm" "R_eyelid_upper_fold_main_1_control_aimConstraint1.wum"
		;
connectAttr "L_eyelid_upper_fold_main_1_control_aimConstraint1.o" "R_eyelid_upper_fold_main_1_control_aimConstraint1.o"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_aimConstraint1.crx" "R_eyelid_upper_fold_main_3_control_transform.rx"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_aimConstraint1.cry" "R_eyelid_upper_fold_main_3_control_transform.ry"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_aimConstraint1.crz" "R_eyelid_upper_fold_main_3_control_transform.rz"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_transform.t" "R_eyelid_upper_fold_main_3_control_transform.t"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_transform.pim" "R_eyelid_upper_fold_main_3_control_aimConstraint1.cpim"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_transform.t" "R_eyelid_upper_fold_main_3_control_aimConstraint1.ct"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_transform.rp" "R_eyelid_upper_fold_main_3_control_aimConstraint1.crp"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_transform.rpt" "R_eyelid_upper_fold_main_3_control_aimConstraint1.crt"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_transform.ro" "R_eyelid_upper_fold_main_3_control_aimConstraint1.cro"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.t" "R_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rp" "R_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].trp"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.rpt" "R_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].trt"
		;
connectAttr "R_eyelid_upper_fold_main_2_control.pm" "R_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelid_upper_fold_main_3_control_aimConstraint1.w0" "R_eyelid_upper_fold_main_3_control_aimConstraint1.tg[0].tw"
		;
connectAttr "R_eyelids_joint.wm" "R_eyelid_upper_fold_main_3_control_aimConstraint1.wum"
		;
connectAttr "L_eyelid_upper_fold_main_3_control_aimConstraint1.o" "R_eyelid_upper_fold_main_3_control_aimConstraint1.o"
		;
connectAttr "L_eyelid_lower_main_control.opm" "R_eyelid_lower_main_control.opm";
connectAttr "L_eyelid_upper_main_control.opm" "R_eyelid_upper_main_control.opm";
connectAttr "R_eyelids_corner_inner_control_transform_parentConstraint1.cty" "R_eyelids_corner_inner_control_transform.ty"
		;
connectAttr "L_eyelids_corner_inner_control.opm" "R_eyelids_corner_inner_control.opm"
		;
connectAttr "R_eyelids_corner_inner_control_transform.ro" "R_eyelids_corner_inner_control_transform_parentConstraint1.cro"
		;
connectAttr "R_eyelids_corner_inner_control_transform.pim" "R_eyelids_corner_inner_control_transform_parentConstraint1.cpim"
		;
connectAttr "R_eyelids_corner_inner_control_transform.rp" "R_eyelids_corner_inner_control_transform_parentConstraint1.crp"
		;
connectAttr "R_eyelids_corner_inner_control_transform.rpt" "R_eyelids_corner_inner_control_transform_parentConstraint1.crt"
		;
connectAttr "R_eye_transform_control.t" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eye_transform_control.rp" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eye_transform_control.rpt" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eye_transform_control.r" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.s" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelids_corner_inner_control_transform_parentConstraint1.w0" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_lower_main_control.t" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tt"
		;
connectAttr "R_eyelid_lower_main_control.rp" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].trp"
		;
connectAttr "R_eyelid_lower_main_control.rpt" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].trt"
		;
connectAttr "R_eyelid_lower_main_control.r" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tr"
		;
connectAttr "R_eyelid_lower_main_control.ro" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tro"
		;
connectAttr "R_eyelid_lower_main_control.s" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].ts"
		;
connectAttr "R_eyelid_lower_main_control.pm" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tpm"
		;
connectAttr "R_eyelids_corner_inner_control_transform_parentConstraint1.w1" "R_eyelids_corner_inner_control_transform_parentConstraint1.tg[1].tw"
		;
connectAttr "L_eyelids_corner_inner_control_transform_parentConstraint1.w0" "R_eyelids_corner_inner_control_transform_parentConstraint1.w0"
		;
connectAttr "L_eyelids_corner_inner_control_transform_parentConstraint1.w1" "R_eyelids_corner_inner_control_transform_parentConstraint1.w1"
		;
connectAttr "R_eyelids_corner_outer_control_transform_parentConstraint1.cty" "R_eyelids_corner_outer_control_transform.ty"
		;
connectAttr "L_eyelids_corner_outer_control.opm" "R_eyelids_corner_outer_control.opm"
		;
connectAttr "R_eyelids_corner_outer_control_transform.ro" "R_eyelids_corner_outer_control_transform_parentConstraint1.cro"
		;
connectAttr "R_eyelids_corner_outer_control_transform.pim" "R_eyelids_corner_outer_control_transform_parentConstraint1.cpim"
		;
connectAttr "R_eyelids_corner_outer_control_transform.rp" "R_eyelids_corner_outer_control_transform_parentConstraint1.crp"
		;
connectAttr "R_eyelids_corner_outer_control_transform.rpt" "R_eyelids_corner_outer_control_transform_parentConstraint1.crt"
		;
connectAttr "R_eye_transform_control.t" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tt"
		;
connectAttr "R_eye_transform_control.rp" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].trp"
		;
connectAttr "R_eye_transform_control.rpt" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].trt"
		;
connectAttr "R_eye_transform_control.r" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tr"
		;
connectAttr "R_eye_transform_control.ro" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tro"
		;
connectAttr "R_eye_transform_control.s" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].ts"
		;
connectAttr "R_eye_transform_control.pm" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_eyelids_corner_outer_control_transform_parentConstraint1.w0" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[0].tw"
		;
connectAttr "R_eyelid_upper_main_control.t" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tt"
		;
connectAttr "R_eyelid_upper_main_control.rp" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].trp"
		;
connectAttr "R_eyelid_upper_main_control.rpt" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].trt"
		;
connectAttr "R_eyelid_upper_main_control.r" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tr"
		;
connectAttr "R_eyelid_upper_main_control.ro" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tro"
		;
connectAttr "R_eyelid_upper_main_control.s" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].ts"
		;
connectAttr "R_eyelid_upper_main_control.pm" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tpm"
		;
connectAttr "R_eyelids_corner_outer_control_transform_parentConstraint1.w1" "R_eyelids_corner_outer_control_transform_parentConstraint1.tg[1].tw"
		;
connectAttr "L_eyelids_corner_outer_control_transform_parentConstraint1.w0" "R_eyelids_corner_outer_control_transform_parentConstraint1.w0"
		;
connectAttr "L_eyelids_corner_outer_control_transform_parentConstraint1.w1" "R_eyelids_corner_outer_control_transform_parentConstraint1.w1"
		;
connectAttr "L_eyelids_transform_tuner.ty" "R_eyelids_transform_tuner.ty";
connectAttr "L_eyelids_transform_tuner.tz" "R_eyelids_transform_tuner.tz";
connectAttr "R_eyelids_transform_tuner_tx_multDL.o" "R_eyelids_transform_tuner.tx"
		;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "L_eyelids_avg_blendShape.mlpr" "shapeEditorManager.bspr[4]";
connectAttr "R_eyelids_avg_blendShape.mlpr" "shapeEditorManager.bspr[5]";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "renderLayerManager1.rlmi[0]" "defaultRenderLayer1.rlid";
connectAttr "shades.msg" "renderSetup.frl";
connectAttr "lines.msg" "renderSetup.lrl";
connectAttr "rs_shades.msg" "shades.lrl";
connectAttr "renderSetup.lit" "shades.pls";
connectAttr "_untitled_2.msg" "shades.cl";
connectAttr "HIDE_PLANKS.msg" "shades.ch";
connectAttr "renderLayerManager1.rlmi[1]" "rs_shades.rlid";
connectAttr "collection1Selector.c" "collection1.sel";
connectAttr "shades.lit" "collection1.pls";
connectAttr "shades.nic" "collection1.pic";
connectAttr "_untitled_2.nxt" "collection1.prv";
connectAttr "floatConstant1_colSelector.c" "floatConstant1_col.sel";
connectAttr "collection1.nxt" "floatConstant1_col.prv";
connectAttr "shades.lit" "floatConstant1_col.pls";
connectAttr "shades.nic" "floatConstant1_col.pic";
connectAttr "inFloat.msg" "floatConstant1_col.cl";
connectAttr "inFloat.msg" "floatConstant1_col.ch";
connectAttr "floatConstant1_col.lit" "inFloat.pls";
connectAttr "floatConstant1_col.en" "inFloat.pen";
connectAttr "FILTER_BOXSelector.c" "FILTER_BOX.sel";
connectAttr "floatConstant1_col.nxt" "FILTER_BOX.prv";
connectAttr "shades.lit" "FILTER_BOX.pls";
connectAttr "shades.nic" "FILTER_BOX.pic";
connectAttr "absOverride2.msg" "FILTER_BOX.cl";
connectAttr "absOverride2.msg" "FILTER_BOX.ch";
connectAttr "FILTER_BOX.lit" "absOverride2.pls";
connectAttr "FILTER_BOX.en" "absOverride2.pen";
connectAttr "rs_lines.msg" "lines.lrl";
connectAttr "shades.nxt" "lines.prv";
connectAttr "renderSetup.lit" "lines.pls";
connectAttr "RenderSettingsCollection.msg" "lines.cl";
connectAttr "threshold_multiplier_var.msg" "lines.ch";
connectAttr "renderLayerManager1.rlmi[2]" "rs_lines.rlid";
connectAttr "collection2Selector.c" "collection2.sel";
connectAttr "lines.lit" "collection2.pls";
connectAttr "lines.nic" "collection2.pic";
connectAttr "RenderSettingsCollection.nxt" "collection2.prv";
connectAttr "floatConstant1_col1Selector.c" "floatConstant1_col1.sel";
connectAttr "collection2.nxt" "floatConstant1_col1.prv";
connectAttr "lines.lit" "floatConstant1_col1.pls";
connectAttr "lines.nic" "floatConstant1_col1.pic";
connectAttr "inFloat1.msg" "floatConstant1_col1.cl";
connectAttr "inFloat1.msg" "floatConstant1_col1.ch";
connectAttr "floatConstant1_col1.lit" "inFloat1.pls";
connectAttr "floatConstant1_col1.en" "inFloat1.pen";
connectAttr "FILTER_CONSelector.c" "FILTER_CON.sel";
connectAttr "floatConstant1_col1.nxt" "FILTER_CON.prv";
connectAttr "lines.lit" "FILTER_CON.pls";
connectAttr "lines.nic" "FILTER_CON.pic";
connectAttr "absOverride1.msg" "FILTER_CON.cl";
connectAttr "absOverride1.msg" "FILTER_CON.ch";
connectAttr "FILTER_CON.lit" "absOverride1.pls";
connectAttr "FILTER_CON.en" "absOverride1.pen";
connectAttr "floatConstant1_col2.lit" "inFloat2.pls";
connectAttr "floatConstant1_col2.en" "inFloat2.pen";
connectAttr "floatConstant1_col1Selector1.c" "floatConstant1_col2.sel";
connectAttr "collection3.nxt" "floatConstant1_col2.prv";
connectAttr "lines1.lit" "floatConstant1_col2.pls";
connectAttr "lines1.nic" "floatConstant1_col2.pic";
connectAttr "inFloat2.msg" "floatConstant1_col2.cl";
connectAttr "inFloat2.msg" "floatConstant1_col2.ch";
connectAttr "collection2Selector1.c" "collection3.sel";
connectAttr "lines1.lit" "collection3.pls";
connectAttr "lines1.nic" "collection3.pic";
connectAttr "rs_lines1.msg" "lines1.lrl";
connectAttr "shades1.nxt" "lines1.prv";
connectAttr "renderSetup1.lit" "lines1.pls";
connectAttr "collection3.msg" "lines1.cl";
connectAttr "FILTER_CON1.msg" "lines1.ch";
connectAttr "renderLayerManager1.rlmi[3]" "rs_lines1.rlid";
connectAttr "renderSetup1.lit" "shades1.pls";
connectAttr "collection4.msg" "shades1.cl";
connectAttr "FILTER_BOX1.msg" "shades1.ch";
connectAttr "shades1.msg" "renderSetup1.frl";
connectAttr "lines1.msg" "renderSetup1.lrl";
connectAttr "collection1Selector1.c" "collection4.sel";
connectAttr "shades1.lit" "collection4.pls";
connectAttr "shades1.nic" "collection4.pic";
connectAttr "FILTER_BOXSelector1.c" "FILTER_BOX1.sel";
connectAttr "floatConstant1_col3.nxt" "FILTER_BOX1.prv";
connectAttr "shades1.lit" "FILTER_BOX1.pls";
connectAttr "shades1.nic" "FILTER_BOX1.pic";
connectAttr "absOverride3.msg" "FILTER_BOX1.cl";
connectAttr "absOverride3.msg" "FILTER_BOX1.ch";
connectAttr "floatConstant1_colSelector1.c" "floatConstant1_col3.sel";
connectAttr "collection4.nxt" "floatConstant1_col3.prv";
connectAttr "shades1.lit" "floatConstant1_col3.pls";
connectAttr "shades1.nic" "floatConstant1_col3.pic";
connectAttr "inFloat3.msg" "floatConstant1_col3.cl";
connectAttr "inFloat3.msg" "floatConstant1_col3.ch";
connectAttr "floatConstant1_col3.lit" "inFloat3.pls";
connectAttr "floatConstant1_col3.en" "inFloat3.pen";
connectAttr "FILTER_BOX1.lit" "absOverride3.pls";
connectAttr "FILTER_BOX1.en" "absOverride3.pen";
connectAttr "FILTER_CONSelector1.c" "FILTER_CON1.sel";
connectAttr "floatConstant1_col2.nxt" "FILTER_CON1.prv";
connectAttr "lines1.lit" "FILTER_CON1.pls";
connectAttr "lines1.nic" "FILTER_CON1.pic";
connectAttr "absOverride4.msg" "FILTER_CON1.cl";
connectAttr "absOverride4.msg" "FILTER_CON1.ch";
connectAttr "FILTER_CON1.lit" "absOverride4.pls";
connectAttr "FILTER_CON1.en" "absOverride4.pen";
connectAttr "collection6Selector.c" "HIDE_NOLINE.sel";
connectAttr "FILTER_CON.nxt" "HIDE_NOLINE.prv";
connectAttr "lines.lit" "HIDE_NOLINE.pls";
connectAttr "lines.nic" "HIDE_NOLINE.pic";
connectAttr "visibility1.msg" "HIDE_NOLINE.cl";
connectAttr "visibility1.msg" "HIDE_NOLINE.ch";
connectAttr "HIDE_NOLINE.lit" "visibility1.pls";
connectAttr "HIDE_NOLINE.en" "visibility1.pen";
connectAttr "collection7Selector.c" "HIDE_PLANKS.sel";
connectAttr "FILTER_BOX.nxt" "HIDE_PLANKS.prv";
connectAttr "shades.lit" "HIDE_PLANKS.pls";
connectAttr "shades.nic" "HIDE_PLANKS.pic";
connectAttr "visibility2.msg" "HIDE_PLANKS.cl";
connectAttr "visibility2.msg" "HIDE_PLANKS.ch";
connectAttr "HIDE_PLANKS.lit" "visibility2.pls";
connectAttr "HIDE_PLANKS.en" "visibility2.pen";
connectAttr "threshold_multiplier_var.lit" "inFloat4.pls";
connectAttr "threshold_multiplier_var.en" "inFloat4.pen";
connectAttr "threshold_multiplier1_floatConstantSelector.c" "threshold_multiplier_var.sel"
		;
connectAttr "lines.lit" "threshold_multiplier_var.pls";
connectAttr "lines.nic" "threshold_multiplier_var.pic";
connectAttr "inFloat4.msg" "threshold_multiplier_var.cl";
connectAttr "inFloat4.msg" "threshold_multiplier_var.ch";
connectAttr "HIDE_NOLINE.nxt" "threshold_multiplier_var.prv";
connectAttr "RenderSettingsCollectionSelector.c" "RenderSettingsCollection.sel";
connectAttr "lines.lit" "RenderSettingsCollection.pls";
connectAttr "lines.nic" "RenderSettingsCollection.pic";
connectAttr "enableAdaptiveSampling.msg" "RenderSettingsCollection.cl";
connectAttr "enableAdaptiveSampling.msg" "RenderSettingsCollection.ch";
connectAttr "RenderSettingsCollection.lit" "enableAdaptiveSampling.pls";
connectAttr "RenderSettingsCollection.en" "enableAdaptiveSampling.pen";
connectAttr "renderLayerManager2.rlmi[0]" "defaultRenderLayer2.rlid";
connectAttr "shades2.msg" "renderSetup2.frl";
connectAttr "lines2.msg" "renderSetup2.lrl";
connectAttr "renderSetup2.lit" "shades2.pls";
connectAttr "_untitled_.msg" "shades2.cl";
connectAttr "HIDE_PLANKS1.msg" "shades2.ch";
connectAttr "collection1Selector2.c" "collection8.sel";
connectAttr "shades2.lit" "collection8.pls";
connectAttr "shades2.nic" "collection8.pic";
connectAttr "_untitled_.nxt" "collection8.prv";
connectAttr "floatConstant1_colSelector2.c" "floatConstant1_col4.sel";
connectAttr "collection8.nxt" "floatConstant1_col4.prv";
connectAttr "shades2.lit" "floatConstant1_col4.pls";
connectAttr "shades2.nic" "floatConstant1_col4.pic";
connectAttr "inFloat5.msg" "floatConstant1_col4.cl";
connectAttr "inFloat5.msg" "floatConstant1_col4.ch";
connectAttr "floatConstant1_col4.lit" "inFloat5.pls";
connectAttr "floatConstant1_col4.en" "inFloat5.pen";
connectAttr "FILTER_BOXSelector2.c" "FILTER_BOX2.sel";
connectAttr "floatConstant1_col4.nxt" "FILTER_BOX2.prv";
connectAttr "shades2.lit" "FILTER_BOX2.pls";
connectAttr "shades2.nic" "FILTER_BOX2.pic";
connectAttr "absOverride6.msg" "FILTER_BOX2.cl";
connectAttr "absOverride6.msg" "FILTER_BOX2.ch";
connectAttr "FILTER_BOX2.lit" "absOverride6.pls";
connectAttr "FILTER_BOX2.en" "absOverride6.pen";
connectAttr "shades2.nxt" "lines2.prv";
connectAttr "renderSetup2.lit" "lines2.pls";
connectAttr "RenderSettingsCollection1.msg" "lines2.cl";
connectAttr "threshold_multiplier_var1.msg" "lines2.ch";
connectAttr "collection2Selector2.c" "collection9.sel";
connectAttr "lines2.lit" "collection9.pls";
connectAttr "lines2.nic" "collection9.pic";
connectAttr "_untitled_1.nxt" "collection9.prv";
connectAttr "floatConstant1_col1Selector2.c" "floatConstant1_col5.sel";
connectAttr "collection9.nxt" "floatConstant1_col5.prv";
connectAttr "lines2.lit" "floatConstant1_col5.pls";
connectAttr "lines2.nic" "floatConstant1_col5.pic";
connectAttr "inFloat6.msg" "floatConstant1_col5.cl";
connectAttr "inFloat6.msg" "floatConstant1_col5.ch";
connectAttr "floatConstant1_col5.lit" "inFloat6.pls";
connectAttr "floatConstant1_col5.en" "inFloat6.pen";
connectAttr "FILTER_CONSelector2.c" "FILTER_CON2.sel";
connectAttr "floatConstant1_col5.nxt" "FILTER_CON2.prv";
connectAttr "lines2.lit" "FILTER_CON2.pls";
connectAttr "lines2.nic" "FILTER_CON2.pic";
connectAttr "absOverride5.msg" "FILTER_CON2.cl";
connectAttr "absOverride5.msg" "FILTER_CON2.ch";
connectAttr "FILTER_CON2.lit" "absOverride5.pls";
connectAttr "FILTER_CON2.en" "absOverride5.pen";
connectAttr "floatConstant1_col6.lit" "inFloat7.pls";
connectAttr "floatConstant1_col6.en" "inFloat7.pen";
connectAttr "floatConstant1_col1Selector3.c" "floatConstant1_col6.sel";
connectAttr "collection10.nxt" "floatConstant1_col6.prv";
connectAttr "lines3.lit" "floatConstant1_col6.pls";
connectAttr "lines3.nic" "floatConstant1_col6.pic";
connectAttr "inFloat7.msg" "floatConstant1_col6.cl";
connectAttr "inFloat7.msg" "floatConstant1_col6.ch";
connectAttr "collection2Selector3.c" "collection10.sel";
connectAttr "lines3.lit" "collection10.pls";
connectAttr "lines3.nic" "collection10.pic";
connectAttr "renderSetup3.lit" "lines3.pls";
connectAttr "collection10.msg" "lines3.cl";
connectAttr "FILTER_CON3.msg" "lines3.ch";
connectAttr "lines3.msg" "renderSetup3.frl";
connectAttr "lines3.msg" "renderSetup3.lrl";
connectAttr "FILTER_CONSelector3.c" "FILTER_CON3.sel";
connectAttr "floatConstant1_col6.nxt" "FILTER_CON3.prv";
connectAttr "lines3.lit" "FILTER_CON3.pls";
connectAttr "lines3.nic" "FILTER_CON3.pic";
connectAttr "absOverride7.msg" "FILTER_CON3.cl";
connectAttr "absOverride7.msg" "FILTER_CON3.ch";
connectAttr "FILTER_CON3.lit" "absOverride7.pls";
connectAttr "FILTER_CON3.en" "absOverride7.pen";
connectAttr "collection6Selector1.c" "HIDE_NOLINE1.sel";
connectAttr "FILTER_CON2.nxt" "HIDE_NOLINE1.prv";
connectAttr "lines2.lit" "HIDE_NOLINE1.pls";
connectAttr "lines2.nic" "HIDE_NOLINE1.pic";
connectAttr "visibility3.msg" "HIDE_NOLINE1.cl";
connectAttr "visibility3.msg" "HIDE_NOLINE1.ch";
connectAttr "HIDE_NOLINE1.lit" "visibility3.pls";
connectAttr "HIDE_NOLINE1.en" "visibility3.pen";
connectAttr "collection7Selector1.c" "HIDE_PLANKS1.sel";
connectAttr "FILTER_BOX2.nxt" "HIDE_PLANKS1.prv";
connectAttr "shades2.lit" "HIDE_PLANKS1.pls";
connectAttr "shades2.nic" "HIDE_PLANKS1.pic";
connectAttr "visibility4.msg" "HIDE_PLANKS1.cl";
connectAttr "visibility4.msg" "HIDE_PLANKS1.ch";
connectAttr "HIDE_PLANKS1.lit" "visibility4.pls";
connectAttr "HIDE_PLANKS1.en" "visibility4.pen";
connectAttr "threshold_multiplier_var1.lit" "inFloat8.pls";
connectAttr "threshold_multiplier_var1.en" "inFloat8.pen";
connectAttr "threshold_multiplier1_floatConstantSelector1.c" "threshold_multiplier_var1.sel"
		;
connectAttr "lines2.lit" "threshold_multiplier_var1.pls";
connectAttr "lines2.nic" "threshold_multiplier_var1.pic";
connectAttr "inFloat8.msg" "threshold_multiplier_var1.cl";
connectAttr "inFloat8.msg" "threshold_multiplier_var1.ch";
connectAttr "HIDE_NOLINE1.nxt" "threshold_multiplier_var1.prv";
connectAttr "RenderSettingsCollectionSelector1.c" "RenderSettingsCollection1.sel"
		;
connectAttr "lines2.lit" "RenderSettingsCollection1.pls";
connectAttr "lines2.nic" "RenderSettingsCollection1.pic";
connectAttr "enableAdaptiveSampling1.msg" "RenderSettingsCollection1.cl";
connectAttr "enableAdaptiveSampling1.msg" "RenderSettingsCollection1.ch";
connectAttr "RenderSettingsCollection1.lit" "enableAdaptiveSampling1.pls";
connectAttr "RenderSettingsCollection1.en" "enableAdaptiveSampling1.pen";
connectAttr "_untitled_Selector.c" "_untitled_.sel";
connectAttr "shades2.lit" "_untitled_.pls";
connectAttr "shades2.nic" "_untitled_.pic";
connectAttr "_untitled_1Selector.c" "_untitled_1.sel";
connectAttr "RenderSettingsCollection1.nxt" "_untitled_1.prv";
connectAttr "lines2.lit" "_untitled_1.pls";
connectAttr "lines2.nic" "_untitled_1.pic";
connectAttr "template_Nose_System_dummy_renderLayerManager.rlmi[0]" "template_Nose_System_dummy_defaultRenderLayer.rlid"
		;
connectAttr "_untitled_2Selector.c" "_untitled_2.sel";
connectAttr "shades.lit" "_untitled_2.pls";
connectAttr "shades.nic" "_untitled_2.pic";
connectAttr "L_arm_2_joint_rotateZ_pos_remapValue.ov" "body_skeleposer.poses[0].poseWeight"
		;
connectAttr "L_leg_2_joint_rotateZ_pos_remapValue.ov" "body_skeleposer.poses[1].poseWeight"
		;
connectAttr "R_arm_2_joint_rz_pos_remapValue.ov" "body_skeleposer.poses[42].poseWeight"
		;
connectAttr "R_leg_2_joint_rz_pos_remapValue.ov" "body_skeleposer.poses[43].poseWeight"
		;
connectAttr "L_arm_2_joint_rotateZ_pos_remapValue.vl" "R_arm_2_joint_rz_pos_remapValue.vl"
		;
connectAttr "L_leg_2_joint_rotateZ_pos_remapValue.vl" "R_leg_2_joint_rz_pos_remapValue.vl"
		;
connectAttr "lip_upper_jaw_open_drop_remapValue.ov" "lip_upper_jaw_up_multDL.i2"
		;
connectAttr "lips_corners_jaw_open_drop_remapValue.ov" "lips_corners_jaw_up_multDL.i2"
		;
connectAttr "L_eyelid_upper_main_curveShapeOrig.ws" "skinCluster42.ip[0].ig";
connectAttr "L_eyelid_upper_main_curveShapeOrig.l" "skinCluster42.orggeom[0]";
connectAttr "L_eyelid_upper_main_joint.wm" "skinCluster42.ma[1]";
connectAttr "L_eyelids_corner_inner_joint.wm" "skinCluster42.ma[5]";
connectAttr "L_eyelids_corner_outer_joint.wm" "skinCluster42.ma[6]";
connectAttr "L_eyelid_upper_main_joint.liw" "skinCluster42.lw[1]";
connectAttr "L_eyelids_corner_inner_joint.liw" "skinCluster42.lw[5]";
connectAttr "L_eyelids_corner_outer_joint.liw" "skinCluster42.lw[6]";
connectAttr "L_eyelid_upper_main_joint.obcc" "skinCluster42.ifcl[1]";
connectAttr "L_eyelids_corner_inner_joint.obcc" "skinCluster42.ifcl[5]";
connectAttr "L_eyelids_corner_outer_joint.obcc" "skinCluster42.ifcl[6]";
connectAttr "L_eyelid_lower_main_curveShapeOrig.ws" "skinCluster43.ip[0].ig";
connectAttr "L_eyelid_lower_main_curveShapeOrig.l" "skinCluster43.orggeom[0]";
connectAttr "L_eyelid_lower_main_joint.wm" "skinCluster43.ma[1]";
connectAttr "L_eyelids_corner_inner_joint.wm" "skinCluster43.ma[3]";
connectAttr "L_eyelids_corner_outer_joint.wm" "skinCluster43.ma[4]";
connectAttr "L_eyelid_lower_main_joint.liw" "skinCluster43.lw[1]";
connectAttr "L_eyelids_corner_inner_joint.liw" "skinCluster43.lw[3]";
connectAttr "L_eyelids_corner_outer_joint.liw" "skinCluster43.lw[4]";
connectAttr "L_eyelid_lower_main_joint.obcc" "skinCluster43.ifcl[1]";
connectAttr "L_eyelids_corner_inner_joint.obcc" "skinCluster43.ifcl[3]";
connectAttr "L_eyelids_corner_outer_joint.obcc" "skinCluster43.ifcl[4]";
connectAttr "L_eyelid_upper_curveShapeOrig.ws" "L_eyelid_upper_curve_wire.ip[0].ig"
		;
connectAttr "L_eyelid_upper_curveShapeOrig.l" "L_eyelid_upper_curve_wire.orggeom[0]"
		;
connectAttr "L_eyelid_upper_major_curveBaseWireShape.ws" "L_eyelid_upper_curve_wire.bw[0]"
		;
connectAttr "L_eyelid_upper_major_curveShape.ws" "L_eyelid_upper_curve_wire.dw[0]"
		;
connectAttr "L_eyelid_upper_major_curveShapeOrig1.ws" "skinCluster44.ip[0].ig";
connectAttr "L_eyelid_upper_main_curveShapeOrig.l" "skinCluster44.orggeom[0]";
connectAttr "L_eyelid_upper_major_1_joint.wm" "skinCluster44.ma[0]";
connectAttr "L_eyelid_upper_major_2_joint.wm" "skinCluster44.ma[1]";
connectAttr "L_eyelids_joint.wm" "skinCluster44.ma[2]";
connectAttr "L_eyelid_upper_major_1_joint.liw" "skinCluster44.lw[0]";
connectAttr "L_eyelid_upper_major_2_joint.liw" "skinCluster44.lw[1]";
connectAttr "L_eyelids_joint.liw" "skinCluster44.lw[2]";
connectAttr "L_eyelid_upper_major_1_joint.obcc" "skinCluster44.ifcl[0]";
connectAttr "L_eyelid_upper_major_2_joint.obcc" "skinCluster44.ifcl[1]";
connectAttr "L_eyelids_joint.obcc" "skinCluster44.ifcl[2]";
connectAttr "L_eyelid_upper_major_1_joint_basis.wim" "skinCluster44.pm[0]";
connectAttr "L_eyelid_upper_major_2_joint_basis.wim" "skinCluster44.pm[1]";
connectAttr "L_eyelids_joint.wim" "skinCluster44.pm[2]";
connectAttr "L_eyelid_lower_major_curveShapeOrig1.ws" "skinCluster45.ip[0].ig";
connectAttr "L_eyelid_lower_main_curveShapeOrig.l" "skinCluster45.orggeom[0]";
connectAttr "L_eyelid_lower_major_1_joint.wm" "skinCluster45.ma[0]";
connectAttr "L_eyelid_lower_major_2_joint.wm" "skinCluster45.ma[1]";
connectAttr "L_eyelids_joint.wm" "skinCluster45.ma[2]";
connectAttr "L_eyelid_lower_major_1_joint.liw" "skinCluster45.lw[0]";
connectAttr "L_eyelid_lower_major_2_joint.liw" "skinCluster45.lw[1]";
connectAttr "L_eyelids_joint.liw" "skinCluster45.lw[2]";
connectAttr "L_eyelid_lower_major_1_joint.obcc" "skinCluster45.ifcl[0]";
connectAttr "L_eyelid_lower_major_2_joint.obcc" "skinCluster45.ifcl[1]";
connectAttr "L_eyelids_joint.obcc" "skinCluster45.ifcl[2]";
connectAttr "L_eyelid_lower_major_1_joint_basis.wim" "skinCluster45.pm[0]";
connectAttr "L_eyelid_lower_major_2_joint_basis.wim" "skinCluster45.pm[1]";
connectAttr "L_eyelids_joint.wim" "skinCluster45.pm[2]";
connectAttr "L_eyelid_lower_curveShapeOrig.ws" "L_eyelid_lower_curve_wire.ip[0].ig"
		;
connectAttr "L_eyelid_lower_curveShapeOrig.l" "L_eyelid_lower_curve_wire.orggeom[0]"
		;
connectAttr "L_eyelid_lower_major_curveBaseWireShape.ws" "L_eyelid_lower_curve_wire.bw[0]"
		;
connectAttr "L_eyelid_lower_major_curveShape.ws" "L_eyelid_lower_curve_wire.dw[0]"
		;
connectAttr "R_eyelid_upper_curveShapeOrig1.ws" "R_eyelid_upper_curve_wire.ip[0].ig"
		;
connectAttr "R_eyelid_upper_curveShapeOrig1.l" "R_eyelid_upper_curve_wire.orggeom[0]"
		;
connectAttr "R_eyelid_upper_major_curveBaseWireShape.ws" "R_eyelid_upper_curve_wire.bw[0]"
		;
connectAttr "R_eyelid_upper_major_curveShape.ws" "R_eyelid_upper_curve_wire.dw[0]"
		;
connectAttr "R_eyelid_lower_curveShapeOrig1.ws" "R_eyelid_lower_curve_wire.ip[0].ig"
		;
connectAttr "R_eyelid_lower_curveShapeOrig1.l" "R_eyelid_lower_curve_wire.orggeom[0]"
		;
connectAttr "R_eyelid_lower_major_curveBaseWireShape.ws" "R_eyelid_lower_curve_wire.bw[0]"
		;
connectAttr "R_eyelid_lower_major_curveShape.ws" "R_eyelid_lower_curve_wire.dw[0]"
		;
connectAttr "R_eyelid_upper_main_curveShape.ws" "R_eyelid_upper_fin_curve_pointOnCurveInfo.ic"
		;
connectAttr "R_eyelid_upper_main_curveShape.ws" "attachToCurve_cpos_tmp.ic";
connectAttr "R_eyelid_upper_main_curveShapeOrig1.ws" "skinCluster46.ip[0].ig";
connectAttr "R_eyelid_upper_main_curveShapeOrig1.l" "skinCluster46.orggeom[0]";
connectAttr "R_eyelid_upper_main_joint.wm" "skinCluster46.ma[0]";
connectAttr "R_eyelids_corner_inner_joint.wm" "skinCluster46.ma[3]";
connectAttr "R_eyelids_corner_outer_joint.wm" "skinCluster46.ma[4]";
connectAttr "R_eyelid_upper_main_joint.liw" "skinCluster46.lw[0]";
connectAttr "R_eyelids_corner_inner_joint.liw" "skinCluster46.lw[3]";
connectAttr "R_eyelids_corner_outer_joint.liw" "skinCluster46.lw[4]";
connectAttr "R_eyelid_upper_main_joint.obcc" "skinCluster46.ifcl[0]";
connectAttr "R_eyelids_corner_inner_joint.obcc" "skinCluster46.ifcl[3]";
connectAttr "R_eyelids_corner_outer_joint.obcc" "skinCluster46.ifcl[4]";
connectAttr "R_eyelid_lower_main_curveShapeOrig1.ws" "skinCluster47.ip[0].ig";
connectAttr "R_eyelid_lower_main_curveShapeOrig1.l" "skinCluster47.orggeom[0]";
connectAttr "R_eyelid_lower_main_joint.wm" "skinCluster47.ma[1]";
connectAttr "R_eyelids_corner_inner_joint.wm" "skinCluster47.ma[3]";
connectAttr "R_eyelids_corner_outer_joint.wm" "skinCluster47.ma[4]";
connectAttr "R_eyelid_lower_main_joint.liw" "skinCluster47.lw[1]";
connectAttr "R_eyelids_corner_inner_joint.liw" "skinCluster47.lw[3]";
connectAttr "R_eyelids_corner_outer_joint.liw" "skinCluster47.lw[4]";
connectAttr "R_eyelid_lower_main_joint.obcc" "skinCluster47.ifcl[1]";
connectAttr "R_eyelids_corner_inner_joint.obcc" "skinCluster47.ifcl[3]";
connectAttr "R_eyelids_corner_outer_joint.obcc" "skinCluster47.ifcl[4]";
connectAttr "R_eyelid_upper_major_curveShapeOrig2.ws" "skinCluster48.ip[0].ig";
connectAttr "R_eyelid_upper_major_curveShapeOrig2.l" "skinCluster48.orggeom[0]";
connectAttr "R_eyelid_upper_major_1_joint.wm" "skinCluster48.ma[0]";
connectAttr "R_eyelid_upper_major_2_joint.wm" "skinCluster48.ma[1]";
connectAttr "R_eyelids_joint.wm" "skinCluster48.ma[2]";
connectAttr "R_eyelid_upper_major_1_joint.liw" "skinCluster48.lw[0]";
connectAttr "R_eyelid_upper_major_2_joint.liw" "skinCluster48.lw[1]";
connectAttr "R_eyelids_joint.liw" "skinCluster48.lw[2]";
connectAttr "R_eyelid_upper_major_1_joint.obcc" "skinCluster48.ifcl[0]";
connectAttr "R_eyelid_upper_major_2_joint.obcc" "skinCluster48.ifcl[1]";
connectAttr "R_eyelids_joint.obcc" "skinCluster48.ifcl[2]";
connectAttr "R_eyelid_upper_major_1_joint_basis.wim" "skinCluster48.pm[0]";
connectAttr "R_eyelid_upper_major_2_joint_basis.wim" "skinCluster48.pm[1]";
connectAttr "R_eyelids_joint.wim" "skinCluster48.pm[2]";
connectAttr "R_eyelid_lower_major_curveShapeOrig2.ws" "skinCluster49.ip[0].ig";
connectAttr "R_eyelid_lower_major_curveShapeOrig2.l" "skinCluster49.orggeom[0]";
connectAttr "R_eyelid_lower_major_1_joint.wm" "skinCluster49.ma[0]";
connectAttr "R_eyelid_lower_major_2_joint.wm" "skinCluster49.ma[1]";
connectAttr "R_eyelids_joint.wm" "skinCluster49.ma[2]";
connectAttr "R_eyelid_lower_major_1_joint.liw" "skinCluster49.lw[0]";
connectAttr "R_eyelid_lower_major_2_joint.liw" "skinCluster49.lw[1]";
connectAttr "R_eyelids_joint.liw" "skinCluster49.lw[2]";
connectAttr "R_eyelid_lower_major_1_joint.obcc" "skinCluster49.ifcl[0]";
connectAttr "R_eyelid_lower_major_2_joint.obcc" "skinCluster49.ifcl[1]";
connectAttr "R_eyelids_joint.obcc" "skinCluster49.ifcl[2]";
connectAttr "R_eyelid_lower_major_1_joint_basis.wim" "skinCluster49.pm[0]";
connectAttr "R_eyelid_lower_major_2_joint_basis.wim" "skinCluster49.pm[1]";
connectAttr "R_eyelids_joint.wim" "skinCluster49.pm[2]";
connectAttr "L_eyelid_upper_fold_curveShapeOrig.ws" "skinCluster57.ip[0].ig";
connectAttr "L_eyelid_upper_fold_curveShapeOrig.l" "skinCluster57.orggeom[0]";
connectAttr "L_eyelid_upper_fold_main_1_joint.wm" "skinCluster57.ma[0]";
connectAttr "L_eyelid_upper_fold_main_2_joint.wm" "skinCluster57.ma[1]";
connectAttr "L_eyelid_upper_fold_main_3_joint.wm" "skinCluster57.ma[2]";
connectAttr "L_eyelid_upper_fold_main_1_joint.liw" "skinCluster57.lw[0]";
connectAttr "L_eyelid_upper_fold_main_2_joint.liw" "skinCluster57.lw[1]";
connectAttr "L_eyelid_upper_fold_main_3_joint.liw" "skinCluster57.lw[2]";
connectAttr "L_eyelid_upper_fold_main_1_joint.obcc" "skinCluster57.ifcl[0]";
connectAttr "L_eyelid_upper_fold_main_2_joint.obcc" "skinCluster57.ifcl[1]";
connectAttr "L_eyelid_upper_fold_main_3_joint.obcc" "skinCluster57.ifcl[2]";
connectAttr "R_eyelid_upper_fold_curveShapeOrig1.ws" "skinCluster58.ip[0].ig";
connectAttr "R_eyelid_upper_fold_curveShapeOrig1.l" "skinCluster58.orggeom[0]";
connectAttr "R_eyelid_upper_fold_main_1_joint.wm" "skinCluster58.ma[0]";
connectAttr "R_eyelid_upper_fold_main_2_joint.wm" "skinCluster58.ma[1]";
connectAttr "R_eyelid_upper_fold_main_3_joint.wm" "skinCluster58.ma[2]";
connectAttr "R_eyelid_upper_fold_main_1_joint.liw" "skinCluster58.lw[0]";
connectAttr "R_eyelid_upper_fold_main_2_joint.liw" "skinCluster58.lw[1]";
connectAttr "R_eyelid_upper_fold_main_3_joint.liw" "skinCluster58.lw[2]";
connectAttr "R_eyelid_upper_fold_main_1_joint.obcc" "skinCluster58.ifcl[0]";
connectAttr "R_eyelid_upper_fold_main_2_joint.obcc" "skinCluster58.ifcl[1]";
connectAttr "R_eyelid_upper_fold_main_3_joint.obcc" "skinCluster58.ifcl[2]";
connectAttr "L_eyelids_avg_curveShapeOrig1.ws" "L_eyelids_avg_blendShape.ip[0].ig"
		;
connectAttr "L_eyelids_avg_curveShapeOrig1.l" "L_eyelids_avg_blendShape.orggeom[0]"
		;
connectAttr "shapeEditorManager.obsv[4]" "L_eyelids_avg_blendShape.tgdt[0].dpvs"
		;
connectAttr "L_eyelid_upper_curveShape.ws" "L_eyelids_avg_blendShape.it[0].itg[0].iti[6000].igt"
		;
connectAttr "L_eyelid_lower_curveShape.ws" "L_eyelids_avg_blendShape.it[0].itg[1].iti[6000].igt"
		;
connectAttr "L_eyelids_blinkLine_reverse.ox" "L_eyelids_avg_blendShape.w[0]";
connectAttr "L_eyelid_upper_main_control.blinkLine" "L_eyelids_avg_blendShape.w[1]"
		;
connectAttr "L_eyelid_upper_main_control.blinkLine" "L_eyelids_blinkLine_reverse.ix"
		;
connectAttr "R_eyelid_upper_main_control.blinkLine" "R_eyelids_blinkLine_reverse.ix"
		;
connectAttr "R_eyelids_avg_curveShapeOrig1.ws" "R_eyelids_avg_blendShape.ip[0].ig"
		;
connectAttr "R_eyelids_avg_curveShapeOrig1.l" "R_eyelids_avg_blendShape.orggeom[0]"
		;
connectAttr "shapeEditorManager.obsv[5]" "R_eyelids_avg_blendShape.tgdt[0].dpvs"
		;
connectAttr "R_eyelid_upper_curveShape.ws" "R_eyelids_avg_blendShape.it[0].itg[0].iti[6000].igt"
		;
connectAttr "R_eyelid_lower_curveShape.ws" "R_eyelids_avg_blendShape.it[0].itg[1].iti[6000].igt"
		;
connectAttr "R_eyelids_blinkLine_reverse.ox" "R_eyelids_avg_blendShape.w[0]";
connectAttr "R_eyelid_upper_main_control.blinkLine" "R_eyelids_avg_blendShape.w[1]"
		;
connectAttr "R_eyelid_lower_major_2_control_pointOnCurveInfo.p" "R_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_eyelid_lower_major_2_control_transform.pim" "R_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_eyelid_lower_main_curveShape.ws" "R_eyelid_lower_major_2_control_pointOnCurveInfo.ic"
		;
connectAttr "R_eyelid_lower_major_1_control_pointOnCurveInfo.p" "R_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_eyelid_lower_major_1_control_transform.pim" "R_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_eyelid_lower_main_curveShape.ws" "R_eyelid_lower_major_1_control_pointOnCurveInfo.ic"
		;
connectAttr "R_eyelid_upper_major_2_control_pointOnCurveInfo.p" "R_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_eyelid_upper_major_2_control_transform.pim" "R_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_eyelid_upper_main_curveShape.ws" "R_eyelid_upper_major_2_control_pointOnCurveInfo.ic"
		;
connectAttr "R_eyelid_upper_major_1_control_pointOnCurveInfo.p" "R_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_eyelid_upper_major_1_control_transform.pim" "R_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_eyelid_upper_main_curveShape.ws" "R_eyelid_upper_major_1_control_pointOnCurveInfo.ic"
		;
connectAttr "L_eyelid_lower_major_2_control_pointOnCurveInfo.p" "L_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_eyelid_lower_major_2_control_transform.pim" "L_eyelid_lower_major_2_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_eyelid_lower_main_curveShape.ws" "L_eyelid_lower_major_2_control_pointOnCurveInfo.ic"
		;
connectAttr "L_eyelid_lower_major_1_control_pointOnCurveInfo.p" "L_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_eyelid_lower_major_1_control_transform.pim" "L_eyelid_lower_major_1_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_eyelid_lower_main_curveShape.ws" "L_eyelid_lower_major_1_control_pointOnCurveInfo.ic"
		;
connectAttr "L_eyelid_upper_major_2_control_pointOnCurveInfo.p" "L_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_eyelid_upper_major_2_control_transform.pim" "L_eyelid_upper_major_2_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_eyelid_upper_main_curveShape.ws" "L_eyelid_upper_major_2_control_pointOnCurveInfo.ic"
		;
connectAttr "L_eyelid_upper_major_1_control_pointOnCurveInfo.p" "L_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_eyelid_upper_major_1_control_transform.pim" "L_eyelid_upper_major_1_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_eyelid_upper_main_curveShape.ws" "L_eyelid_upper_major_1_control_pointOnCurveInfo.ic"
		;
connectAttr "L_eyelid_upper_tuner_curveShape.l" "L_eyelid_upper_tuner_transformGeometry.ig"
		;
connectAttr "L_eyelid_lower_tuner_curveShape.l" "L_eyelid_lower_tuner_transformGeometry.ig"
		;
connectAttr "L_eyelids_transform_tuner.tx" "R_eyelids_transform_tuner_tx_multDL.i1"
		;
connectAttr "L_eyelid_lower_tuner_transformGeometry.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "L_eyelid_upper_tuner_transformGeometry.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "R_eyelids_transform_tuner_tx_multDL.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "lip_upper_jaw_up_multDL.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lips_corners_jaw_up_multDL.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "lips_corners_jaw_open_drop_remapValue.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "lip_upper_jaw_open_drop_remapValue.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "L_eyelids_blinkLine_reverse.msg" ":defaultRenderUtilityList1.u" -na
		;
connectAttr "R_eyelids_blinkLine_reverse.msg" ":defaultRenderUtilityList1.u" -na
		;
connectAttr "R_eyelids_transform_tuner_tx_multDL.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "defaultRenderLayer1.msg" ":defaultRenderingList1.r" -na;
connectAttr "rs_shades.msg" ":defaultRenderingList1.r" -na;
connectAttr "rs_lines.msg" ":defaultRenderingList1.r" -na;
connectAttr "rs_lines1.msg" ":defaultRenderingList1.r" -na;
connectAttr "defaultRenderLayer2.msg" ":defaultRenderingList1.r" -na;
connectAttr "template_Nose_System_dummy_defaultRenderLayer.msg" ":defaultRenderingList1.r"
		 -na;
dataStructure -fmt "raw" -as "name=IdStruct:int32=ID";
dataStructure -fmt "raw" -as "name=OffStruct:float=Offset";
dataStructure -fmt "raw" -as "name=idStructure:int32=ID";
dataStructure -fmt "raw" -as "name=DiffArea:float=value";
dataStructure -fmt "raw" -as "name=faceConnectMarkerStructure:bool=faceConnectMarker:string[200]=faceConnectOutputGroups";
dataStructure -fmt "raw" -as "name=Offset:float[3]=value";
dataStructure -fmt "raw" -as "name=faceConnectOutputStructure:bool=faceConnectOutput:string[200]=faceConnectOutputAttributes:string[200]=faceConnectOutputGroups";
dataStructure -fmt "raw" -as "name=DiffEdge:float=value";
dataStructure -fmt "raw" -as "name=OrgStruct:float[3]=Origin Point";
dataStructure -fmt "raw" -as "name=Curvature:float=mean:float=gaussian:float=ABS:float=RMS";
dataStructure -fmt "raw" -as "name=keyValueStructure:string=value";
// End of face_eyelids.ma
