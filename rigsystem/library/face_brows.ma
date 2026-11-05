//Maya ASCII 2026 scene
//Name: face_brows.ma
//Last modified: Tue, Nov 03, 2026 02:27:20 PM
//Codeset: 1251
requires maya "2026";
requires "stereoCamera" "10.0";
requires "Mayatomr" "2013.0 - 3.10.1.11 ";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "maya";
fileInfo "product" "Maya 2026";
fileInfo "version" "2026";
fileInfo "cutIdentifier" "202510291147-60ec9eda33";
fileInfo "osv" "Windows 11 Pro v2009 (Build: 26200)";
fileInfo "UUID" "011187B7-4B3C-9989-295A-2D84665A0B4E";
createNode transform -s -n "persp";
	rename -uid "77AE9653-40B9-4F94-7B80-3F95FE3E7DFF";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 3.0025702452997578 168.90666065409411 29.640273832936082 ;
	setAttr ".r" -type "double3" -18.338352729606076 8.9999999999992735 0 ;
	setAttr ".rp" -type "double3" -9.3258734068513149e-15 2.8421709430404007e-14 0 ;
	setAttr ".rpt" -type "double3" -3.2444650141844978e-15 -3.0391213835245794e-15 -1.2206279012975552e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "65C3BDD6-45B3-50A3-1670-8AB70A156D08";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 19.799243509766875;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" 1.153522461385295 160.94349670410151 11.454307307072844 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "0F310FA2-463D-2AB6-BB11-678145E802A2";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -90 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "A5054AAE-4682-F981-B611-0CB2839A6204";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "3C5A664D-4898-A8C1-82AE-9E9AF0D39220";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "AA94DB18-442F-BE5D-6871-5984863614A5";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "2798294C-4796-EBC2-072F-1AA69E3A2BF1";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 90 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "E6DE4863-473A-61A0-080D-A5B94D7D663F";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "L_brow_main_control";
	rename -uid "7C35260D-4E62-F47E-B141-F9B572CFBBE7";
	setAttr -l on -k off ".v";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr ".mxtl" -type "double3" 0 1 1 ;
	setAttr ".mtxe" yes;
	setAttr ".mtye" yes;
	setAttr ".xtxe" yes;
	setAttr ".xtye" yes;
createNode nurbsCurve -n "L_brow_main_controlShape" -p "L_brow_main_control";
	rename -uid "E064081D-46CF-97FD-4D66-D4A058554944";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-1.6363585654888109 -0.18028873271248358 0.45562558078935689
		1.6363590021691681 -0.18028854169611858 0.36639425960558936
		1.636358565488816 0.18028873271246548 0.36187965344066186
		-1.6363590021691632 0.18028854169610045 0.45111097462442939
		-1.6363585654888109 -0.18028873271248358 0.45562558078935689
		;
createNode transform -n "L_brow_major_inner_control_transform";
	rename -uid "56FF4FFE-4F5F-87A5-C308-4AB2AC14AEF7";
	setAttr ".r" -type "double3" 8.1817546857800796 -2.4749779958950639e-05 3.7915166395471256e-22 ;
	setAttr ".sh" -type "double3" 0 0 0.35275066147230716 ;
createNode transform -n "L_brow_major_inner_control" -p "L_brow_major_inner_control_transform";
	rename -uid "E909F33F-4186-09B3-8A69-56807BFA1D3B";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" -2.5030331811132928e-16 -3.1308289294429414e-14 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_brow_major_inner_controlShape" -p "L_brow_major_inner_control";
	rename -uid "0D125787-498B-1C8A-6326-9EA7196C2FB6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-0.27330017230924097 4.8493286914347377e-33 -7.9195453639315792e-17
		-0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		-8.2350785335842731e-17 -1.6734800062070489e-17 0.27330017230924097
		0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		0.27330017230924097 -8.9882840984847358e-33 1.4678996650018188e-16
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		;
createNode nurbsCurve -n "L_brow_major_inner_controlShape1" -p "L_brow_major_inner_control";
	rename -uid "0BEEDC7C-4A91-B8E0-BB72-18867B8DBAC4";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-0.27330017230924097 -1.202254283396718e-16 4.1029598083903049e-17
		-0.19325249968547878 0.19325249968547878 8.2059567893256332e-17
		-8.2350785335842731e-17 0.27330017230924097 0
		0.19325249968547878 0.19325249968547878 4.1029598083903049e-17
		0.27330017230924097 1.0576036352502626e-16 4.1029598083903049e-17
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		;
createNode nurbsCurve -n "L_brow_major_inner_controlShape2" -p "L_brow_major_inner_control";
	rename -uid "F47127A4-45C5-52E8-86F0-B9BBAAAEA42C";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		-5.894895571485172e-34 -0.27330017230924097 -7.9195453639315792e-17
		-5.894895571485172e-34 -0.19325249968547878 0.19325249968547878
		1.6734800062070489e-17 -8.2350785335842731e-17 0.27330017230924097
		-1.0257436204408037e-17 0.19325249968547878 0.19325249968547878
		-5.894895571485172e-34 0.27330017230924097 1.4678996650018188e-16
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		;
createNode transform -n "L_brow_major_inner_joint_basis" -p "L_brow_major_inner_control_transform";
	rename -uid "893E3A98-41CD-2F00-16B6-B4A93DC82245";
	setAttr ".t" -type "double3" 6.6613381477509392e-16 -8.5265128291212022e-14 1.7763568394002505e-15 ;
	setAttr ".s" -type "double3" 1.0000000000000002 1 1 ;
createNode transform -n "L_brow_major_mid_control_transform";
	rename -uid "3F1652EC-4CB3-50C0-8AC8-6CA5F14EC02B";
	setAttr ".r" -type "double3" 0 23.574424774437006 0 ;
createNode transform -n "L_brow_major_mid_control" -p "L_brow_major_mid_control_transform";
	rename -uid "C340E0EE-4E1F-6D04-1423-A7869139EFD3";
	setAttr -l on -k off ".v";
	setAttr -k on ".t" -type "double3" 0 0 3.5521838806727473e-16 ;
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_brow_major_mid_controlShape" -p "L_brow_major_mid_control";
	rename -uid "275F6EC2-4E64-4EC1-851F-B4980CEDCE3C";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-0.27330017230924097 4.8493286914347377e-33 -7.9195453639315792e-17
		-0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		-8.2350785335842731e-17 -1.6734800062070489e-17 0.27330017230924097
		0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		0.27330017230924097 -8.9882840984847358e-33 1.4678996650018188e-16
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		;
createNode nurbsCurve -n "L_brow_major_mid_controlShape1" -p "L_brow_major_mid_control";
	rename -uid "789BD57E-4453-EB3A-25FE-F396816513AF";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-0.27330017230924097 -1.202254283396718e-16 4.1029598083903049e-17
		-0.19325249968547878 0.19325249968547878 8.2059567893256332e-17
		-8.2350785335842731e-17 0.27330017230924097 0
		0.19325249968547878 0.19325249968547878 4.1029598083903049e-17
		0.27330017230924097 1.0576036352502626e-16 4.1029598083903049e-17
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		;
createNode nurbsCurve -n "L_brow_major_mid_controlShape2" -p "L_brow_major_mid_control";
	rename -uid "97A63059-4E0E-7B1F-C234-21818CFB008F";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		-5.894895571485172e-34 -0.27330017230924097 -7.9195453639315792e-17
		-5.894895571485172e-34 -0.19325249968547878 0.19325249968547878
		1.6734800062070489e-17 -8.2350785335842731e-17 0.27330017230924097
		-1.0257436204408037e-17 0.19325249968547878 0.19325249968547878
		-5.894895571485172e-34 0.27330017230924097 1.4678996650018188e-16
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		;
createNode transform -n "L_brow_major_mid_joint_basis" -p "L_brow_major_mid_control_transform";
	rename -uid "4FEC8B4B-4AAD-BDFD-B2C2-9F9EB3E384DF";
createNode transform -n "L_brow_major_outer_control_transform";
	rename -uid "53036B71-4748-B7CF-D753-5E9A68A55BBB";
	setAttr ".r" -type "double3" 0 60.570847151931446 0 ;
createNode transform -n "L_brow_major_outer_control" -p "L_brow_major_outer_control_transform";
	rename -uid "030511DD-4083-8358-9BBF-778C698192AB";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 0 -2.8421709430404007e-14 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_brow_major_outer_controlShape" -p "L_brow_major_outer_control";
	rename -uid "400409AD-49C4-E4C6-6B95-7A893831CA77";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547883
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547883
		-0.27330017230924097 4.8493286914347377e-33 -1.4122106414096674e-15
		-0.19325249968547878 -1.1833289891669146e-17 0.1932524996854787
		-8.2350785335842731e-17 -1.6734800062070489e-17 0.27330017230924097
		0.19325249968547878 -1.1833289891669146e-17 0.1932524996854787
		0.27330017230924097 -8.9882840984847358e-33 -1.1862252212701708e-15
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547883
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547883
		;
createNode nurbsCurve -n "L_brow_major_outer_controlShape1" -p "L_brow_major_outer_control";
	rename -uid "1F638B51-422E-2BCC-FA52-57BC239E5CA1";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 -0.19325249968547878 -1.2919855896864482e-15
		-3.1180271039546686e-17 -0.27330017230924097 -1.3330151877703519e-15
		-0.19325249968547878 -0.19325249968547878 -1.2919855896864482e-15
		-0.27330017230924097 -1.202254283396718e-16 -1.2919855896864482e-15
		-0.19325249968547878 0.19325249968547878 -1.2509556198770946e-15
		-8.2350785335842731e-17 0.27330017230924097 -1.3330151877703519e-15
		0.19325249968547878 0.19325249968547878 -1.2919855896864482e-15
		0.27330017230924097 1.0576036352502626e-16 -1.2919855896864482e-15
		0.19325249968547878 -0.19325249968547878 -1.2919855896864482e-15
		-3.1180271039546686e-17 -0.27330017230924097 -1.3330151877703519e-15
		-0.19325249968547878 -0.19325249968547878 -1.2919855896864482e-15
		;
createNode nurbsCurve -n "L_brow_major_outer_controlShape2" -p "L_brow_major_outer_control";
	rename -uid "4372EFB7-4636-5D8F-78EE-6DA3147C234D";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547883
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547883
		-5.894895571485172e-34 -0.27330017230924097 -1.4122106414096674e-15
		-5.894895571485172e-34 -0.19325249968547878 0.1932524996854787
		1.6734800062070489e-17 -8.2350785335842731e-17 0.27330017230924097
		-1.0257436204408037e-17 0.19325249968547878 0.1932524996854787
		-5.894895571485172e-34 0.27330017230924097 -1.1862252212701708e-15
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547883
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547883
		;
createNode transform -n "L_brow_major_outer_joint_basis" -p "L_brow_major_outer_control_transform";
	rename -uid "20C5B4B8-49E6-8A50-2511-4CB7F05F73C2";
createNode transform -n "L_brow_curv_control_transform";
	rename -uid "F3579412-4998-7476-7325-0A92654036F5";
	setAttr ".r" -type "double3" 0 13.275611973175454 0 ;
	setAttr ".s" -type "double3" 0.99999999999999989 1 0.99999999999999989 ;
	setAttr ".sh" -type "double3" 0 0 0.23775602012661454 ;
createNode transform -n "L_brow_curv_control" -p "L_brow_curv_control_transform";
	rename -uid "C65F6A50-4103-A24B-A79C-E39CC7D02E1F";
	setAttr -l on -k off ".v";
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -k on ".s";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "L_brow_curv_controlShape1" -p "L_brow_curv_control";
	rename -uid "2BF7F6AF-438F-B4CE-2890-11B2369BC723";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.02130907551171984 0.62129788072718017 0.12807507062398235
		0.128871099337732 0.11790953835115937 0.15057789250912995
		-0.02130907551171984 -0.38839537368280613 0.12807507062398235
		-0.17034302606034676 0.11115094392951798 0.10574399764848706
		-0.021004016093825944 0.62027535325408756 0.12812078037063929
		;
createNode transform -n "L_brow_curv_compensation_transform" -p "L_brow_curv_control";
	rename -uid "583839FE-4163-2381-6669-3484E27556BF";
	setAttr ".t" -type "double3" -6.2172489379008766e-15 5.6843418860808015e-14 6.4392935428259079e-15 ;
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "L_brow_curv_transform" -p "L_brow_curv_compensation_transform";
	rename -uid "DA530C69-4AA5-DB92-A877-1EA08CB85FBA";
createNode pointConstraint -n "L_brow_curv_control_pointConstraint1" -p "L_brow_curv_control_transform";
	rename -uid "2712ECB9-4C55-E11C-D863-CC9267D217F8";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_brow_major_mid_controlW0" -dv 1 
		-min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "L_brow_major_inner_controlW1" -dv 
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
	setAttr ".o" -type "double3" -0.20129318415968678 0.05737053691908045 0.37946501728637827 ;
	setAttr ".rst" -type "double3" 2.2919741965719096 161.40818660509368 11.523748405732167 ;
	setAttr -k on ".w0";
	setAttr -k on ".w1";
createNode transform -n "R_brow_main_control";
	rename -uid "D714A8DE-41F7-DFA8-E085-87A787D72894";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" -2.588913115886271e-06 -2.5437429940211587e-12 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
	setAttr ".mxtl" -type "double3" 0 1 1 ;
	setAttr ".mtxe" yes;
	setAttr ".mtye" yes;
	setAttr ".xtxe" yes;
	setAttr ".xtye" yes;
createNode nurbsCurve -n "R_brow_main_controlShape" -p "R_brow_main_control";
	rename -uid "92446B52-4D43-2955-8DE9-D8AEDAD7A8F5";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".ls" 2;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-1.6363585654888109 -0.18028873271248358 0.45562558078935689
		1.6363590021691681 -0.18028854169611858 0.36639425960558936
		1.636358565488816 0.18028873271246548 0.36187965344066186
		-1.6363590021691632 0.18028854169610045 0.45111097462442939
		-1.6363585654888109 -0.18028873271248358 0.45562558078935689
		;
createNode transform -n "R_brow_major_inner_control_transform";
	rename -uid "0603A8C7-4641-5895-515A-53A2C401BBE0";
	setAttr ".opm" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode transform -n "R_brow_major_inner_control" -p "R_brow_major_inner_control_transform";
	rename -uid "E4F7F46F-430C-8AF6-C852-928193A95F24";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" -2.5030331811132928e-16 -3.1308289294429414e-14 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_brow_major_inner_controlShape" -p "R_brow_major_inner_control";
	rename -uid "565FC4FD-476C-94C7-0DF5-3A98B1DAA8C5";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325744633591291 0.068170343101968456 0.19325287809213521
		4.9466504346007412e-06 0.096407347234361396 0.27330050321257637
		-0.19324755303504459 0.068170343101968456 0.19325287809213521
		-0.27329522565880682 7.0895907811063807e-08 4.9309001504127536e-07
		-0.19324755303504482 -0.068170201310124412 -0.19325189191210512
		4.9466504339346073e-06 -0.096407205442517352 -0.27329951703254984
		0.19325744633591269 -0.068170201310124412 -0.19325189191210512
		0.27330511895967513 7.0895907811063807e-08 4.9309001148856169e-07
		0.19325744633591291 0.068170343101968456 0.19325287809213521
		4.9466504346007412e-06 0.096407347234361396 0.27330050321257637
		-0.19324755303504459 0.068170343101968456 0.19325287809213521
		;
createNode nurbsCurve -n "R_brow_major_inner_controlShape1" -p "R_brow_major_inner_control";
	rename -uid "CD94DBF5-4075-F1B0-3728-9590453AE4FD";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325744633591291 0.19325257058110878 1.6797911861488046e-07
		4.9466504343786966e-06 0.27330024320474422 3.3314000447148828e-08
		-0.19324755303504471 0.19325257058113721 1.679791203912373e-07
		-0.27329522565880682 7.0895907811063807e-08 4.9309001504127536e-07
		-0.19324755303504471 -0.19325242878926474 8.1820091146767027e-07
		4.946650434156652e-06 -0.27330010141290018 9.5286602608268822e-07
		0.19325744633591291 -0.19325242878929316 8.1820090969131343e-07
		0.27330511895967513 7.0895907811063807e-08 4.9309001148856169e-07
		0.19325744633591291 0.19325257058110878 1.6797911861488046e-07
		4.9466504343786966e-06 0.27330024320474422 3.3314000447148828e-08
		-0.19324755303504471 0.19325257058113721 1.679791203912373e-07
		;
createNode nurbsCurve -n "R_brow_major_inner_controlShape2" -p "R_brow_major_inner_control";
	rename -uid "770A0F10-47FC-ECF7-E507-D8B6268A7C81";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		4.9466504343786966e-06 -0.12508215658326094 0.19325320320303341
		4.9466504346007412e-06 0.096407347234361396 0.27330050321257637
		4.9466504343786966e-06 0.26142284278716943 0.19325255298123878
		4.9466504343786966e-06 0.27330024320474422 3.3314000447148828e-08
		4.946650434156652e-06 0.12508229837510498 -0.19325221702300688
		4.9466504339346073e-06 -0.096407205442517352 -0.27329951703254984
		4.946650434156652e-06 -0.26142270099529696 -0.19325156680121047
		4.946650434156652e-06 -0.27330010141290018 9.5286602608268822e-07
		4.9466504343786966e-06 -0.12508215658326094 0.19325320320303341
		4.9466504346007412e-06 0.096407347234361396 0.27330050321257637
		4.9466504343786966e-06 0.26142284278716943 0.19325255298123878
		;
createNode transform -n "R_brow_major_inner_joint_basis" -p "R_brow_major_inner_control_transform";
	rename -uid "9BE2A011-4C2E-F944-EE0E-9499D82D53A0";
	setAttr ".t" -type "double3" 1.1940002986321474e-08 -0.0004967041015788709 -7.5561523420475396e-06 ;
	setAttr ".r" -type "double3" 0 0 180 ;
	setAttr ".s" -type "double3" 1 1 -1 ;
createNode transform -n "R_brow_major_mid_control_transform";
	rename -uid "B344BA6B-4827-6501-FBF7-37AF4E25CE84";
	setAttr ".opm" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode transform -n "R_brow_major_mid_control" -p "R_brow_major_mid_control_transform";
	rename -uid "FEAB850D-40B5-0849-8655-49B7E9DD7585";
	setAttr -l on -k off ".v";
	setAttr -k on ".t" -type "double3" 0 0 3.5521838806727473e-16 ;
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -k on ".s";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_brow_major_mid_controlShape" -p "R_brow_major_mid_control";
	rename -uid "19D9928F-4384-8DFE-DA5A-3F8C9C7915B4";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-0.27330017230924097 4.8493286914347377e-33 -7.9195453639315792e-17
		-0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		-8.2350785335842731e-17 -1.6734800062070489e-17 0.27330017230924097
		0.19325249968547878 -1.1833289891669146e-17 0.19325249968547878
		0.27330017230924097 -8.9882840984847358e-33 1.4678996650018188e-16
		0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		-3.1180271039546686e-17 1.6734800062070489e-17 -0.27330017230924097
		-0.19325249968547878 1.1833289891669146e-17 -0.19325249968547878
		;
createNode nurbsCurve -n "R_brow_major_mid_controlShape1" -p "R_brow_major_mid_control";
	rename -uid "243F09BF-4EDF-EB8C-7894-828DECEA8867";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-0.27330017230924097 -1.202254283396718e-16 4.1029598083903049e-17
		-0.19325249968547878 0.19325249968547878 8.2059567893256332e-17
		-8.2350785335842731e-17 0.27330017230924097 0
		0.19325249968547878 0.19325249968547878 4.1029598083903049e-17
		0.27330017230924097 1.0576036352502626e-16 4.1029598083903049e-17
		0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		-3.1180271039546686e-17 -0.27330017230924097 0
		-0.19325249968547878 -0.19325249968547878 4.1029598083903049e-17
		;
createNode nurbsCurve -n "R_brow_major_mid_controlShape2" -p "R_brow_major_mid_control";
	rename -uid "CF5F73E1-460B-2953-763C-E19BD465CEFA";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		-5.894895571485172e-34 -0.27330017230924097 -7.9195453639315792e-17
		-5.894895571485172e-34 -0.19325249968547878 0.19325249968547878
		1.6734800062070489e-17 -8.2350785335842731e-17 0.27330017230924097
		-1.0257436204408037e-17 0.19325249968547878 0.19325249968547878
		-5.894895571485172e-34 0.27330017230924097 1.4678996650018188e-16
		2.0514872408816074e-17 0.19325249968547878 -0.19325249968547878
		-1.6734800062070489e-17 -3.1180271039546686e-17 -0.27330017230924097
		-5.894895571485172e-34 -0.19325249968547878 -0.19325249968547878
		;
createNode transform -n "R_brow_major_mid_joint_basis" -p "R_brow_major_mid_control_transform";
	rename -uid "703530D1-4F7D-FA6E-A83E-8DA182FD599F";
	setAttr ".t" -type "double3" -2.0684292375450219e-05 -0.00013543224756062955 3.5466794825467218e-05 ;
	setAttr ".r" -type "double3" 0 0 180 ;
	setAttr ".s" -type "double3" 1 1 -0.99999999999999944 ;
createNode transform -n "R_brow_major_outer_control_transform";
	rename -uid "1483E8A0-44D9-13D4-F82E-79925F668BE7";
	setAttr ".opm" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode transform -n "R_brow_major_outer_control" -p "R_brow_major_outer_control_transform";
	rename -uid "8C0C6EFE-4B81-A321-DCE0-93AAC06C65EE";
	setAttr -l on -k off ".v";
	setAttr ".t" -type "double3" 0 -2.8421709430404007e-14 0 ;
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_brow_major_outer_controlShape" -p "R_brow_major_outer_control";
	rename -uid "CD964CF1-49B8-08FD-CE70-27B9A8380EA6";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-0.19325685068073906 -2.8421709430404007e-14 0.19325022227086563
		-4.4201509412644668e-06 -2.8421709430404007e-14 0.27329806185128902
		0.19324814869007501 -2.8421709430404007e-14 0.19325055618424614
		0.27329598827049573 -2.8421709430404007e-14 -1.8743455498793082e-06
		0.19324848260345373 -2.8421709430404007e-14 -0.19325444318656793
		-3.9479263431729805e-06 -2.8421709430404007e-14 -0.27330228276698776
		-0.19325651676735944 -2.8421709430404007e-14 -0.19325477709994665
		-0.27330435634778194 -2.8421709430404007e-14 -2.346570148858973e-06
		-0.19325685068073906 -2.8421709430404007e-14 0.19325022227086563
		-4.4201509412644668e-06 -2.8421709430404007e-14 0.27329806185128902
		0.19324814869007501 -2.8421709430404007e-14 0.19325055618424614
		;
createNode nurbsCurve -n "R_brow_major_outer_controlShape1" -p "R_brow_major_outer_control";
	rename -uid "25A9E341-4E59-B240-CFD7-0A87C8EDC1CB";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-0.19325668372404881 0.19325249968545677 -2.2774145396198264e-06
		-4.1840386417746345e-06 0.27330017230920589 -2.1104578493691406e-06
		0.19324831564676526 0.19325249968545677 -1.9435011608948116e-06
		0.27329598827049573 -2.8421709430404007e-14 -1.8743455498793082e-06
		0.19324831564676526 -0.19325249968551361 -1.9435011608948116e-06
		-4.1840386417746345e-06 -0.27330017230926273 -2.1104578493691406e-06
		-0.19325668372404881 -0.19325249968551361 -2.2774145396198264e-06
		-0.27330435634778194 -2.8421709430404007e-14 -2.346570148858973e-06
		-0.19325668372404881 0.19325249968545677 -2.2774145396198264e-06
		-4.1840386417746345e-06 0.27330017230920589 -2.1104578493691406e-06
		0.19324831564676526 0.19325249968545677 -1.9435011608948116e-06
		;
createNode nurbsCurve -n "R_brow_major_outer_controlShape2" -p "R_brow_major_outer_control";
	rename -uid "C653A04E-4297-C5FA-7490-D39ED466E1EE";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		3 8 0 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		-4.3509953320253203e-06 -0.19325249968551361 0.19325038922755589
		-4.4201509412644668e-06 -2.8421709430404007e-14 0.27329806185128902
		-4.3509953320253203e-06 0.19325249968545677 0.19325038922755589
		-4.1840386417746345e-06 0.27330017230920589 -2.1104578493691406e-06
		-4.0170819533003055e-06 0.19325249968545677 -0.1932546101432564
		-3.9479263431729805e-06 -2.8421709430404007e-14 -0.27330228276698776
		-4.0170819533003055e-06 -0.19325249968551361 -0.1932546101432564
		-4.1840386417746345e-06 -0.27330017230926273 -2.1104578493691406e-06
		-4.3509953320253203e-06 -0.19325249968551361 0.19325038922755589
		-4.4201509412644668e-06 -2.8421709430404007e-14 0.27329806185128902
		-4.3509953320253203e-06 0.19325249968545677 0.19325038922755589
		;
createNode transform -n "R_brow_major_outer_joint_basis" -p "R_brow_major_outer_control_transform";
	rename -uid "2BF0D699-43ED-20FD-3DB6-DF900BCC4F2B";
	setAttr ".t" -type "double3" -3.6660285616108013e-06 -0.00011230468740563992 1.6907887481210082e-06 ;
	setAttr ".r" -type "double3" 0 0 180 ;
	setAttr ".s" -type "double3" 0.99999999999999978 1 -1.0000000000000004 ;
createNode transform -n "R_brow_curv_control_transform";
	rename -uid "CD090CCC-476B-FD4A-6612-9BBAF0802F4C";
	setAttr ".opm" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode transform -n "R_brow_curv_control" -p "R_brow_curv_control_transform";
	rename -uid "BB33FA4F-4CA9-5580-95EE-54B554CD0F2C";
	setAttr -l on -k off ".v";
	setAttr -k on ".t";
	setAttr -l on -k off ".tz";
	setAttr -k on ".r";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -k on ".s";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode nurbsCurve -n "R_brow_curv_controlShape" -p "R_brow_curv_control";
	rename -uid "D43DD3FD-4957-BFBA-72BA-5FB544F8604E";
	setAttr -k off ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 13;
	setAttr ".cc" -type "nurbsCurve" 
		1 4 0 no 3
		5 0 1 2 3 4
		5
		-0.021304144102891442 0.65174849979615601 0.12807512783836827
		0.12887603074656012 0.15371033879316087 0.15057794972351424
		-0.021304144102891442 -0.35794475461383968 0.12807512783836827
		-0.170338094651519 0.13629221596266916 0.1057440548628712
		-0.02099908468499817 0.65073684009050226 0.12812083758502446
		;
createNode transform -n "R_brow_curv_compensation_transform" -p "R_brow_curv_control";
	rename -uid "CA8BDD3F-4D45-E975-E8CC-D5924F73585C";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode transform -n "R_brow_curv_transform" -p "R_brow_curv_compensation_transform";
	rename -uid "058ACBCF-43A8-FD9C-1DC2-8DB01A8585FE";
createNode pointConstraint -n "R_brow_curv_control_pointConstraint1" -p "R_brow_curv_control_transform";
	rename -uid "EC341EA4-421F-A18F-CD10-B1BD4D4C2CF6";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_brow_major_inner_controlW0" -dv 
		1 -min 0 -at "double";
	addAttr -dcb 0 -ci true -k true -sn "w1" -ln "R_brow_major_mid_controlW1" -dv 1 
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
	setAttr -s 2 ".tg";
	setAttr ".rst" -type "double3" -2.2919766855007082 161.4081866050937 11.523747910705415 ;
	setAttr -k on ".w0";
	setAttr -k on ".w1";
createNode transform -n "brows_others";
	rename -uid "374AFC09-4B6C-D0B3-38DD-998FC5741504";
	setAttr -l on -k off ".tx";
	setAttr -l on -k off ".ty";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode transform -n "L_brow_main_curve" -p "brows_others";
	rename -uid "EFE68D6D-4C50-5CD3-9009-A8A5E9138472";
	setAttr -k on ".t" -type "double3" 0 -5.6843418860808015e-14 1.7763568394002505e-15 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" -9.5335940800151678e-15 1.2371861130890691e-05 
		7.4746215568045276e-11 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_brow_main_curveShape" -p "L_brow_main_curve";
	rename -uid "79AB5AB2-4BE7-18EE-67BF-259A4E8CAE3F";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_brow_main_curveShapeOrig1" -p "L_brow_main_curve";
	rename -uid "967C1A56-41D9-9723-9ADC-1592467E2AA6";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr -s 4 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "L_brow_curv_cluster";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".gtag[2].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[1:4]";
	setAttr ".gtag[3].gtagnm" -type "string" "softMod1_2";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".tw" yes;
createNode transform -n "L_brow_major_curve" -p "brows_others";
	rename -uid "80E074F6-46F8-D7D6-E509-0D92222DC9CC";
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
createNode nurbsCurve -n "L_brow_major_curveShape" -p "L_brow_major_curve";
	rename -uid "5E4B6C0C-4B63-2788-7F81-A98AE5E7C208";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_brow_major_curveShapeOrig" -p "L_brow_major_curve";
	rename -uid "B01C7BC7-45BD-B44E-09F0-6BA53B9BC33F";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".tw" yes;
createNode transform -n "R_brow_main_curve" -p "brows_others";
	rename -uid "FB210C79-4494-0244-3551-27A1CB855AA6";
	setAttr -k on ".t" -type "double3" 0 -5.6843418860808015e-14 1.7763568394002505e-15 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" -9.5335940800151678e-15 1.2371861130890691e-05 
		7.4746215568045276e-11 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "R_brow_main_curveShape" -p "R_brow_main_curve";
	rename -uid "99ACB48F-47B9-80E7-361B-D9ADCA670698";
	setAttr -k off ".v";
	setAttr ".tw" yes;
	setAttr -s 9 ".cp[0:8]" -type "double3" 1.3322676295501878e-15 0 
		0 1.3322676295501878e-15 0 0 1.3322676295501878e-15 0 0 1.3322676295501878e-15 0 
		0 1.3322676295501878e-15 0 0 8.8817841970012523e-16 0 0 8.8817841970012523e-16 0 
		0 8.8817841970012523e-16 0 0 8.8817841970012523e-16 0 0;
createNode nurbsCurve -n "R_brow_main_curveShapeOrig2" -p "R_brow_main_curve";
	rename -uid "990E5DF4-45E7-82D9-EA41-31AEA5F769A2";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr -s 3 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_brow_curv_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".gtag[2].gtagnm" -type "string" "R_brow_curv_cluster";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".tw" yes;
createNode transform -n "R_brow_major_curve" -p "brows_others";
	rename -uid "F224CA9F-4411-701A-004B-0F8309DA791A";
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
createNode nurbsCurve -n "R_brow_major_curveShape" -p "R_brow_major_curve";
	rename -uid "16F0E12C-4BBA-2016-AF47-799F332C76EC";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_brow_major_curveShapeOrig1" -p "R_brow_major_curve";
	rename -uid "AA928666-4EB9-E1F3-5FC1-ED86A6CC7637";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr -s 2 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_brow_curv_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".tw" yes;
createNode transform -n "brows_oncurve_transforms_group" -p "brows_others";
	rename -uid "56DABD54-4AFB-F11D-6888-7A92C8FA4EB0";
	setAttr -l on -k off ".tx";
	setAttr -l on -k off ".ty";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode transform -n "L_brow_0_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "09D56F95-4F4C-BFA2-A505-2F80208C42B1";
	setAttr ".t" -type "double3" 1.1535199880599976 160.94349670410156 11.454307556152344 ;
createNode transform -n "L_brow_1_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "87FA1C83-420B-B55C-019D-5AA079E6F454";
	setAttr ".t" -type "double3" 1.7167960405349731 161.19635009765625 11.350729942321777 ;
createNode transform -n "L_brow_2_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "7F4FB661-47A4-A1D7-DC55-3D927F7B2785";
	setAttr ".t" -type "double3" 2.3471355438232422 161.40669250488281 11.262089729309082 ;
createNode transform -n "L_brow_3_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "40FADB57-4280-485F-DD83-5492FBD7A79E";
	setAttr ".t" -type "double3" 3.0683705806732178 161.58845520019531 11.100622177124023 ;
createNode transform -n "L_brow_4_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "DFF23793-446F-4DED-2A24-9099F2F58732";
	setAttr ".t" -type "double3" 3.835629940032959 161.76654052734375 10.843279838562012 ;
createNode transform -n "L_brow_5_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "214CBF9A-4603-590D-2D83-2C8D56956974";
	setAttr ".t" -type "double3" 4.4951901435852051 161.87458801269531 10.525218963623047 ;
createNode transform -n "L_brow_6_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "E3DB6114-49E9-9B13-C393-169B5AB63845";
	setAttr ".t" -type "double3" 5.0769081115722656 161.91427612304688 10.156350135803223 ;
createNode transform -n "L_brow_7_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "F748D1EB-450F-E61D-DF8B-3CA30BD556AF";
	setAttr ".t" -type "double3" 5.6095166206359863 161.8175048828125 9.6345396041870117 ;
createNode transform -n "L_brow_8_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "2A4F82B6-4F57-B84E-530C-9B9FFB00E40B";
	setAttr ".t" -type "double3" 6.0371103286743164 161.6151123046875 9.0166959762573242 ;
createNode transform -n "R_brow_0_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "55B20796-4CAE-9DB2-83F3-5597EDD1AFFA";
	setAttr ".t" -type "double3" -1.1535199880630331 160.94354193981152 11.454314583130353 ;
createNode transform -n "R_brow_1_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "3C320CD7-4D58-DDFC-EF3A-CD93AB71D1ED";
	setAttr ".t" -type "double3" -1.720063827629275 161.10572400008033 11.344858873749285 ;
createNode transform -n "R_brow_2_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "DFBED4C2-4B9D-4AC6-7845-2AA0876F62DA";
	setAttr ".t" -type "double3" -2.3464925060364483 161.30849660236356 11.239959625419891 ;
createNode transform -n "R_brow_4_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "AD29FA22-4B20-29B5-900A-18BF1AE6943D";
	setAttr ".t" -type "double3" -3.8330147646605051 161.74626615854845 10.831753971524401 ;
createNode transform -n "R_brow_3_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "BBF78246-46EC-CE44-BDEE-1E8DC1EA5614";
	setAttr ".t" -type "double3" -3.0675337331464778 161.52391062303707 11.087360912777918 ;
createNode transform -n "R_brow_5_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "B0088A39-42AB-F935-9F3F-6B849056E7E4";
	setAttr ".t" -type "double3" -4.4932152510862835 161.87164502788463 10.521025371756149 ;
createNode transform -n "R_brow_6_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "3B109F9E-4CB7-0E6B-47D8-82AEDBCFD77B";
	setAttr ".t" -type "double3" -5.0681246700755924 161.90036806293168 10.145691537543271 ;
createNode transform -n "R_brow_7_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "1AC5B05C-49CE-7C31-65B6-C185554D16C7";
	setAttr ".t" -type "double3" -5.5994506022046169 161.81066651170369 9.6282860359296585 ;
createNode transform -n "R_brow_8_joint_transform" -p "brows_oncurve_transforms_group";
	rename -uid "01D55088-47B6-DEAD-CBBC-9F9AECB29B11";
	setAttr ".t" -type "double3" -6.0371103286743102 161.61511230468764 9.0166959762573189 ;
createNode transform -n "brows_internal";
	rename -uid "0E239355-4BF7-B1F0-019D-5796BAFDA267";
	setAttr -l on -k off ".tx";
	setAttr -l on -k off ".ty";
	setAttr -l on -k off ".tz";
	setAttr -l on -k off ".rx";
	setAttr -l on -k off ".ry";
	setAttr -l on -k off ".rz";
	setAttr -l on -k off ".sx";
	setAttr -l on -k off ".sy";
	setAttr -l on -k off ".sz";
createNode transform -n "L_brow_curve" -p "brows_internal";
	rename -uid "33BF5B89-4CEE-DFAD-26B9-4CB9BB753489";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_brow_curveShape" -p "L_brow_curve";
	rename -uid "55326B4C-473A-78A5-36D7-5599A941653F";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "L_brow_curveShapeOrig" -p "L_brow_curve";
	rename -uid "A99699ED-49A0-2219-166C-BF9DD90AEA98";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 8 0 no 3
		9 0 1 2 3 4 5 6 7 8
		9
		1.1535199880599976 160.94349670410156 11.454307556152344
		1.7167960405349731 161.1832275390625 11.353585243225098
		2.3471355438232422 161.39179992675781 11.26527214050293
		3.0683705806732178 161.57798767089844 11.102655410766602
		3.835629940032959 161.76411437988281 10.843730926513672
		4.4951901435852051 161.87454223632812 10.525227546691895
		5.0769081115722656 161.91427612304688 10.156350135803223
		5.6095166206359863 161.8175048828125 9.6345396041870117
		6.0371103286743164 161.6151123046875 9.0166959762573242
		;
createNode transform -n "L_brow_mid_curveBaseWire" -p "brows_internal";
	rename -uid "630AF309-45BA-8947-1B00-FD910C437E30";
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
createNode nurbsCurve -n "L_brow_mid_curveBaseWireShape" -p "L_brow_mid_curveBaseWire";
	rename -uid "D834B19D-4B18-02B2-8F6C-60993282083A";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "R_brow_curve" -p "brows_internal";
	rename -uid "DB5A8A10-4924-3292-304F-878BEBEB9429";
	setAttr -k on ".t";
	setAttr -k on ".r";
	setAttr -k on ".s";
createNode nurbsCurve -n "R_brow_curveShape" -p "R_brow_curve";
	rename -uid "B98CAA33-4900-3521-1F71-B8AC57BB3AB7";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode nurbsCurve -n "R_brow_curveShapeOrig1" -p "R_brow_curve";
	rename -uid "14AE8361-4083-C19C-8B4C-06B226E8A3D0";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "nurbsCurve" 
		1 8 0 no 3
		9 0 1 2 3 4 5 6 7 8
		9
		-1.1535199880599989 160.94349670410156 11.454307556152344
		-1.7167960405349745 161.1832275390625 11.353585243225098
		-2.3471355438232435 161.39179992675781 11.26527214050293
		-3.0683705806732191 161.57798767089844 11.102655410766602
		-3.8356299400329603 161.76411437988281 10.843730926513672
		-4.495190143585206 161.87454223632812 10.525227546691895
		-5.0769081115722665 161.91427612304688 10.156350135803223
		-5.6095166206359872 161.8175048828125 9.6345396041870117
		-6.0371103286743173 161.6151123046875 9.0166959762573242
		;
createNode transform -n "R_brow_major_curveBaseWire" -p "brows_internal";
	rename -uid "1612D80E-44BE-AC82-5307-278797974F61";
	setAttr ".v" no;
	setAttr -k on ".t";
	setAttr -k on ".r";
	setAttr -k on ".s";
createNode nurbsCurve -n "R_brow_major_curveBaseWireShape" -p "R_brow_major_curveBaseWire";
	rename -uid "C53B50A0-42F2-79E5-232E-0FB4355A9E2C";
	setAttr -k off ".v";
	setAttr -s 2 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_brow_curv_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".tw" yes;
createNode joint -n "L_brow_major_inner_joint";
	rename -uid "2BB635D2-4F61-074E-22AD-AC8D067BEEF4";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 16.042818263663214 1.2374889965560096e-05 1.2283096715979963e-07 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.9999999999999768 2.1438047414994444e-09 -2.1598257447006811e-07 0
		 5.7627689276118396e-08 0.96105543831077012 0.27635564856411016 0 2.0816368034173601e-07 -0.2763556485641161 0.9610554383107478 0
		 1.1535224613852961 160.94368511790887 11.454520417249906 1;
createNode parentConstraint -n "L_brow_major_inner_joint_parentConstraint1" -p "L_brow_major_inner_joint";
	rename -uid "8545012C-4C33-96C6-DE5D-FE9212EFAD0A";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_brow_major_inner_controlW0" -dv 
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
	setAttr ".lr" -type "double3" -7.8610635778863296 -3.5678865926443146e-05 1.0259612234718239e-05 ;
	setAttr ".rst" -type "double3" 1.1535199880599973 160.94349670410156 11.454307556152342 ;
	setAttr ".rsrr" -type "double3" -0.041279594560415335 0.19955985135775134 -0.10554001127128576 ;
	setAttr ".rdta" -type "double3" -0.00072046483896758885 0.0034829764609832373 -0.0018420206892758621 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_brow_major_mid_joint";
	rename -uid "E89056D7-43FB-7223-A22B-17B368F541D7";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" 8.0191147908875981e-14 23.574437149326965 8.4532462017710643e-15 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.91654125644009388 8.5129775814372574e-17 -0.39994015207680045 0
		 4.4532333685421213e-16 0.99999999999999978 1.0799154054901087e-15 0 0.3999401520768005 -1.2766927390896491e-15 0.91654125644009354 0
		 3.833017112841576 161.75832384605488 10.834471503254266 1;
createNode parentConstraint -n "L_brow_major_mid_joint_parentConstraint1" -p "L_brow_major_mid_joint";
	rename -uid "ECDEF735-46A0-1870-9B99-16BE8E20F62E";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_brow_major_mid_controlW0" -dv 1 
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
	setAttr ".tg[0].tot" -type "double3" 1.4432899320127035e-15 0 -1.7763568394002505e-15 ;
	setAttr ".lr" -type "double3" 0 -1.2374889963572178e-05 0 ;
	setAttr ".rst" -type "double3" 3.8330147734031961 161.75813543224757 10.834259220739233 ;
	setAttr ".rsrr" -type "double3" 0 23.574449524216966 0 ;
	setAttr ".rdta" -type "double3" 0 0.41145176354279678 0 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "L_brow_major_outer_joint";
	rename -uid "657837FA-45B9-1880-26A7-0EB25A79498E";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -7.8555534426799869e-14 60.570859526821437 -4.2405494507965652e-14 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.49134678701189194 -3.0870221641801383e-16 -0.87096402617621937 0
		 -3.5958793248255273e-16 0.99999999999999978 -4.7786616408345398e-16 0 0.87096402617621982 5.9927496314947024e-16 0.49134678701189177 0
		 6.037112275646737 161.61530071849481 9.0169077828426811 1;
createNode parentConstraint -n "L_brow_major_outer_joint_parentConstraint1" -p "L_brow_major_outer_joint";
	rename -uid "0F17D9C0-4E1C-BEAB-ECBF-9DB5DD459360";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "L_brow_major_outer_controlW0" -dv 
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
	setAttr ".tg[0].tot" -type "double3" 0 -2.8421709430404007e-14 -1.7763568394002505e-15 ;
	setAttr ".tg[0].tor" -type "double3" 0 -3.1805546814635176e-15 0 ;
	setAttr ".lr" -type "double3" 0 -1.237488999219717e-05 0 ;
	setAttr ".rst" -type "double3" 6.0371103286743146 161.6151123046875 9.0166959762573207 ;
	setAttr ".rsrr" -type "double3" 0 60.570871901711406 0 ;
	setAttr ".rdta" -type "double3" 0 1.0571611454885832 0 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_brow_major_inner_joint";
	rename -uid "A3B3ED51-405B-A617-1A2C-D896B46CF37B";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -163.95699999999994 1.2374889964764957e-05 1.2283092899314346e-07 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.9999999999999768 2.1438040741988417e-09 -2.1598257450913144e-07 0
		 -5.7628349998764831e-08 -0.96105456173415904 -0.27635869693201293 0 -2.0816349716362603e-07 0.27635869693201892 -0.9610545617341365 0
		 -1.1535175266434239 160.94320984637466 11.454376385035419 1;
createNode parentConstraint -n "R_brow_major_inner_joint_parentConstraint1" -p "R_brow_major_inner_joint";
	rename -uid "0A199C05-4AD4-0660-BBB7-90BBAA65675C";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_brow_major_inner_controlW0" -dv 
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
	setAttr ".tg[0].tot" -type "double3" 1.1940002764276869e-08 -0.0004967041015788709 
		-7.5561523438238964e-06 ;
	setAttr ".lr" -type "double3" -7.8612453142203318 -1.1892944479870543e-05 3.4199084734702809e-06 ;
	setAttr ".rst" -type "double3" -1.1535200000000003 160.943 11.4543 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_brow_major_mid_joint";
	rename -uid "416B3985-425C-81D0-244F-2D82036D9AD8";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -179.99999999999997 -23.574461899106907 -3.4481439729605746e-14 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.91654108367980103 -5.0194156014753133e-16 0.39994054799064366 0
		 -3.8981176210648068e-16 -0.99999999999999989 -2.9928984901457015e-16 0 0.39994054799064394 2.0787628481630863e-16 -0.91654108367980058 0
		 -3.8330076605702543 161.75818841380732 10.834513937839615 1;
createNode parentConstraint -n "R_brow_major_mid_joint_parentConstraint1" -p "R_brow_major_mid_joint";
	rename -uid "44290D32-4D63-4868-BC85-149D562B7985";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_brow_major_mid_controlW0" -dv 1 
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
	setAttr ".tg[0].tot" -type "double3" -2.0684292375672264e-05 -0.00013543224756062955 
		3.5466794829019932e-05 ;
	setAttr ".tg[0].tor" -type "double3" 0 3.1805546814635176e-15 0 ;
	setAttr ".lr" -type "double3" -2.5444437451714953e-14 -3.7124669906619888e-05 2.1033126141460005e-20 ;
	setAttr ".rst" -type "double3" -3.8330099999999994 161.758 10.8343 ;
	setAttr ".rsrr" -type "double3" -1.4701261201899824e-47 -3.1805546814635168e-15 
		5.2966875576601903e-31 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode joint -n "R_brow_major_outer_joint";
	rename -uid "D9D21733-4215-C3C6-EBAB-8BB7F3BE3A7B";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".uoc" 1;
	setAttr ".oc" 7;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".jo" -type "double3" -179.99999999999986 -60.570884276601312 -1.2859840535122633e-13 ;
	setAttr ".ssc" no;
	setAttr ".bps" -type "matrix" 0.49134641078574182 -1.0713783054223111e-15 0.87096423842082582 0
		 -3.0654545877606756e-16 -0.99999999999999989 -8.5440137289823591e-16 0 0.87096423842082615 2.3465650199317421e-16 -0.49134641078574171 0
		 -6.037108053028172 161.61518841380735 9.0169144137684132 1;
createNode parentConstraint -n "R_brow_major_outer_joint_parentConstraint1" -p "R_brow_major_outer_joint";
	rename -uid "E43F161A-4092-BAF9-83E9-3298BD20ECF9";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "R_brow_major_outer_controlW0" -dv 
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
	setAttr ".tg[0].tot" -type "double3" -3.6660285598344444e-06 -0.00011230468749090505 
		1.6907887410155809e-06 ;
	setAttr ".tg[0].tor" -type "double3" 1.4124500153760504e-30 -3.1805546814635168e-15 
		2.1186750230640761e-30 ;
	setAttr ".lr" -type "double3" -1.2722218725856882e-13 -3.7124669862092125e-05 8.6979787338873717e-20 ;
	setAttr ".rst" -type "double3" -6.037110000000002 161.61500000000004 9.0167000000000037 ;
	setAttr ".rsrr" -type "double3" -2.9402522403799647e-46 1.9083328088781101e-14 -1.7655625192200634e-30 ;
	setAttr ".udt" yes;
	setAttr -k on ".w0";
createNode transform -n "L_brow_tuner_curve";
	rename -uid "E7E7C7DE-4C5C-AF23-763D-EA8FD8B526E9";
	setAttr -k on ".t" -type "double3" 0 -5.6843418860808015e-14 1.7763568394002505e-15 ;
	setAttr -k on ".t";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -k on ".r" -type "double3" -9.5335940800151678e-15 1.2371861130890691e-05 
		7.4746215568045276e-11 ;
	setAttr -k on ".r";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -k on ".s";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
createNode nurbsCurve -n "L_brow_tuner_curveShape" -p "L_brow_tuner_curve";
	rename -uid "2ACAAAA3-40E7-AFBD-9759-52AC987F7F1D";
	setAttr -k off ".v";
	setAttr -s 4 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "L_brow_curv_cluster";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "cv[1:3]";
	setAttr ".gtag[1].gtagnm" -type "string" "softMod1";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".gtag[2].gtagnm" -type "string" "softMod1_1";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "cv[1:4]";
	setAttr ".gtag[3].gtagnm" -type "string" "softMod1_2";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "cv[2]";
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 0.16666666666666666 0.33333333333333331 0.5 0.66666666666666663 0.83333333333333348
		 1 1 1
		9
		1.1535199880599976 160.94349670410159 11.454307556152344
		1.4485039982756489 161.06904218532418 11.401559935061542
		2.040406333033602 161.32075671449761 11.311873761770574
		2.9760468473167663 161.55336799426385 11.149408076550102
		3.8723788711513154 161.77900094616749 10.838775985219961
		4.7419820525634471 161.92371535220687 10.414458751182103
		5.517692812815512 161.88994020880651 9.8066807797300584
		5.860459183460299 161.69872644595407 9.2719447846125274
		6.0371103286743173 161.61511230468753 9.0166959762573224
		

		"gtag" 4
		"L_brow_curv_cluster" 1 "cv[1:3]"
		"softMod1" 1 "cv[2]"
		"softMod1_1" 1 "cv[1:4]"
		"softMod1_2" 1 "cv[2]";
createNode transform -n "L_brow_main_tuner";
	rename -uid "CE618D67-4FC0-0AC0-3D98-6DA94C3B725F";
	setAttr ".t" -type "double3" 3.8986656285775387 161.83586736492782 11.39993386043948 ;
	setAttr ".r" -type "double3" 0 13.275611973175451 0 ;
	setAttr ".s" -type "double3" 0.99999999999999989 2 0.99999999999999989 ;
createNode locator -n "L_brow_main_tunerShape" -p "L_brow_main_tuner";
	rename -uid "AB6D40B6-4DDE-D5FD-262F-BA8CFCC371BB";
	setAttr -k off ".v";
createNode transform -n "R_brow_main_tuner";
	rename -uid "3921F471-47A9-A80A-5747-A29A4781F661";
	setAttr ".opm" -type "matrix" -1 -0 -0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode locator -n "R_brow_main_tunerShape" -p "R_brow_main_tuner";
	rename -uid "4FE12ABC-4596-54FA-7663-7B93D9AFDFD2";
	setAttr -k off ".v";
createNode wire -n "L_brow_curve_wire";
	rename -uid "B66F26C8-4FD6-05D7-2955-D396B92D90BA";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode wire -n "R_brow_curve_wire";
	rename -uid "9E7649B7-4F1A-AA30-9C37-E09F7FE4F86E";
	setAttr ".ro" 0;
	setAttr ".dds[0]"  100;
	setAttr ".sc[0]"  1;
createNode blendShape -n "L_brow_main_blendShape";
	rename -uid "D7361F04-4C2E-7D95-D704-C990DA3BF653";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -s 3 ".w";
	setAttr -s 3 ".w";
	setAttr -s 3 ".it[0].itg";
	setAttr ".it[0].itg[0].iti[6000].ipt" -type "pointArray" 9 0 2.6192965139824764
		 0 1 0 2.4937522882146652 0 1 0 2.2420402761864864 0 1 0 2.2334838055830915 0 1 0
		 2.0078531100089094 0 1 0 1.863140151113555 0 1 0 1.672862473712371 0 1 0 1.5747835379461321
		 0 1 0 1.6328466617378297 0 1 ;
	setAttr ".it[0].itg[0].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].itg[1].iti[6000].ipt" -type "pointArray" 9 0 -1.0724038825396462
		 0 1 0 -1.2726549631173327 0 1 0 -1.5095596335188475 0 1 0 -1.7421696369995914 0 1 0
		 -1.9678013509062282 0 1 0 -2.0510314574392794 0 1 0 -1.8937372062247846 0 1 0 -1.5846664010179836
		 0 1 0 -1.4293977973910899 0 1 ;
	setAttr ".it[0].itg[1].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].itg[2].iti[6000].ipt" -type "pointArray" 9 -0.71383593200519635
		 0.1412928443005228 0 1 -0.71383593200519635 0.1412928443005228 0 1 -0.55650998191398893
		 0 0 1 -0.59713447101060657 0 0.11288426898269321 1 -0.54966427201045054 0 0.12780640048653424
		 1 -0.20019439396374494 0 0.066037454073622825 1 -0.21468761498335098 0 0.14536522152558184
		 1 -0.20015682955392666 0 0.31606291557640631 1 -0.20015682955392666 0 0.31606291557640631
		 1 ;
	setAttr ".it[0].itg[2].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].siw" 1;
	setAttr ".mlid" 6;
	setAttr ".mlpr" 0;
	setAttr -s 3 ".pndr[0:2]"  0 0 0;
	setAttr -s 3 ".tgvs[0:2]" yes yes yes;
	setAttr -s 3 ".tpvs[0:2]" yes yes yes;
	setAttr ".tgdt[0].cid" -type "Int32Array" 3 0 1 2 ;
	setAttr ".aal" -type "attributeAlias" 6 "up" "weight[0]" "down" "weight[1]" "inner" "weight[2]" ;
createNode animCurveUU -n "L_brow_main_blendShape_up";
	rename -uid "30514597-4876-0C41-BEB1-F2827C54FCE3";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  -1 0 0 0 1 1;
createNode animCurveUU -n "L_brow_main_blendShape_down";
	rename -uid "15B8CDE8-47BD-30BE-14F5-A1BCF59E89CA";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  -1 1 0 0 1 0;
createNode animCurveUU -n "L_brow_main_blendShape_inner";
	rename -uid "2B213A74-4E83-16AE-9FCA-EBB5815B565D";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  -1 1 0 0;
createNode cluster -n "L_brow_curv_cluster";
	rename -uid "ED3C9CC6-425E-87F5-9A18-5CB86B87CE5C";
	setAttr ".ip[0].gtg" -type "string" "L_brow_curv_cluster";
	setAttr -s 2 ".wl[0].w";
	setAttr ".wl[0].w[1]" 0.5;
	setAttr ".wl[0].w[3]" 0.69999998807907104;
	setAttr ".gm[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ma" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode skinCluster -n "skinCluster60";
	rename -uid "8C6AC443-4674-700B-0F9A-CF8F158A2530";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 0 1
		2 0 0.77061329284296598 1 0.22938670715703402
		2 0 0.41481989091133398 1 0.58518010908866602
		2 0 0.14221169903996711 1 0.85778830096003289
		1 1 1
		2 1 0.79390449626730719 2 0.20609550373269284
		2 1 0.46937653522947909 2 0.53062346477052091
		2 1 0.1688402915345889 2 0.8311597084654111
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
createNode dagPose -n "bindPose36";
	rename -uid "1636FE2B-451F-D90D-E8B9-23972C01C206";
	setAttr -s 3 ".wm";
	setAttr -s 3 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.1535199880599978 160.94349670410153
		 11.454307556152344 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 0 1.6653345369377348e-16 0 0 3.835629940032959
		 161.76411437988281 10.84373092651367 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.20427778873390928 0 0.97891296090611868 1
		 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 0 1.1102230246251565e-16 0 0 6.0371103286743164
		 161.6151123046875 9.0166959762573242 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.50430814047622308 0 0.86352376889661464 1
		 1 1 yes;
	setAttr -s 3 ".m";
	setAttr -s 3 ".p";
	setAttr ".bp" yes;
createNode dagPose -n "bindPose16";
	rename -uid "7391B9D9-48BE-98A5-2BEC-F48541FF090D";
	setAttr -s 9 ".wm";
	setAttr ".wm[17]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[18]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[19]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 632 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.9460904598236084 145.81080627441406
		 7.4960579872131348 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.57340399540896436 0.14107686788499743 -0.80689246833673578 0.015156514712995423 1
		 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.4547408252133067 -0.065611145518573721
		 -0.18800455575406261 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.90514816964731148 0.42040486087368939 0.062711930174328662 -0.0058101421415861741 1
		 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.5714062730047829 2.886579864025407e-15
		 1.8318679906315083e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.9763882160186768 146.08332824707031
		 6.3185133934020996 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.30432922545638752 -0.15255487573815224 0.93624533548281519 0.086921828146347191 1
		 1 1 yes;
	setAttr ".xm[4]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5878596182153331 -2.8421709430404007e-14
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.016099457122620883 0.0035476733588370151 0.5101173850083246 0.85994678614805253 1
		 1 1 yes;
	setAttr ".xm[5]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.743141681102685 -2.6645352591003757e-15
		 -1.2212453270876722e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[6]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.9848222732543945 147.92182922363281
		 1.006006121635437 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.027886382689789574 -0.0014498686316442343 -0.19787573131827393 0.97982929252839135 1
		 1 1 yes;
	setAttr ".xm[7]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7605156930318964 -7.1614936720748843e-16
		 -9.8345725018234647e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0066397246744912108 0 0.99997795678517176 1
		 1 1 yes;
	setAttr ".xm[8]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.2064340114593506 146.51962280273438
		 5.5307650566101074 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.84964677963430446 0.27201301807749895 -0.39870909418432254 0.21246252862126749 1
		 1 1 yes;
	setAttr ".xm[9]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.1100971103693582 -5.3898256049540239e-15
		 8.9023168081313712e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[10]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.7766718864440918 148.41204833984375
		 -3.9661440849304199 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23473363917681234 0.27900002449507466 -0.34849186785181119 0.86348857723290906 1
		 1 1 yes;
	setAttr ".xm[11]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.4435945975878131 -8.0910963891362939e-16
		 -2.7678747570785748e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[12]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.1374232145031007 148.18209336945833
		 0.60686976139880655 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.25875211011700933 -0.96332912503939805 -0.067085573075108679 -0.023320982955415587 1
		 1 1 yes;
	setAttr ".xm[13]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.9560908085681348 2.7497471728433078e-14
		 -2.4898571374698015e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[14]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.47644038385623699
		 148.30968242372285 -4.3808113492672884 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.3568271798840964 0.60955944277878271 -0.31338787033064552 0.63474380039887379 1
		 1 1 yes;
	setAttr ".xm[15]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.1973033546809915 -3.2403531206809125e-16
		 3.2357541775056348e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[16]" -type "matrix" "xform" 1 1 1 1.169114864275276 -0.71258911359347166
		 -1.5756697756757378 0 8.045453642247125 2.2438807550149988 -4.1434677099770099 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[17]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[18]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[19]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[20]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 103.42406365931471
		 2.164099060331699 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.47198070911350104 -0.52653035071562271 0.47198070911350104 0.52653035071562304 1
		 1 1 yes;
	setAttr ".xm[21]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.4129999999999825 -1.2289999999999992
		 1.1480326062389819e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.013190362270316343 0.99991300338738365 1
		 1 1 yes;
	setAttr ".xm[22]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.540056104124929 1.7763568394002505e-15
		 1.6959614914571347e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.0088442305325985588 0.99996088902830904 1
		 1 1 yes;
	setAttr ".xm[23]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6498458227762569 2.6645352591003757e-15
		 2.6812166883603948e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.0071754466448816587 0.99997425615135038 1
		 1 1 yes;
	setAttr ".xm[24]" -type "matrix" "xform" 1 1 1 0 0 0 0 10.29522881644408 7.5495165674510645e-15
		 2.5473486394623725e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.14616377610309417 0.9892604058362412 1
		 1 1 yes;
	setAttr ".xm[25]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.64098666933441 3.8767792175072557
		 -3.4775081921847377 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.048147358144702168 -0.67919742764105595 -0.13879939639850619 0.71910181041968513 1
		 1 1 yes;
	setAttr ".xm[26]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.2271924873418731 -9.3258734068513149e-15
		 -1.1368683772161603e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948506 0.53969740289995682 0.049379025691938319 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[27]" -type "matrix" "xform" 1 1 1 0 0 0 0 -25.942629197482162 1.0658141036401503e-14
		 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1664063432051128 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[28]" -type "matrix" "xform" 1 1 1 0 0 0 0 -23.919990038655015 0
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.6718112537259389e-06 0.11687386491933727 -1.4206374895849063e-05 0.99314676634130983 1
		 1 1 yes;
	setAttr ".xm[29]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2686357154040735 -1.8318136906095788
		 0.61950730993277148 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.20515884833089088 -0.90213467411116677 0.06707336650972022 0.37358270867765581 1
		 1 1 no;
	setAttr ".xm[30]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.0516604453308673 1.3812950783176348e-11
		 4.3719694531318964e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -7.5409508216749395e-07 -3.344403501253248e-06 0.21995856706938324 0.97550921510820698 1
		 1 1 yes;
	setAttr ".xm[31]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6102879061749036 0
		 -1.0658141036401503e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.12106269314279793 0.99264486314543166 1
		 1 1 yes;
	setAttr ".xm[32]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[33]" -type "matrix" "xform" 0.99999999999999989 1 1 3.3306690738754691e-16
		 -1.1102230246251568e-16 3.6082248300317583e-16 0 -0.092995528926863358 -0.74776544149076929
		 0.058108452627571694 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.16281155994387658 -0.46390356623307211 0.71034158331208841 0.50368711736806848 1
		 1 1 yes;
	setAttr ".xm[34]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 4.6222318665293681e-33 -1.6653345369377351e-16 -5.5511151231257839e-17 0 -0.28881122908877899
		 -0.77666693499215711 0.10702660267226349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.2177754570780685 -0.44078108077077199 0.76609461237456522 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[35]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3825985602606816 1.4813207129029979
		 0.2175109890033958 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313888827 -0.6176190457175601 -0.78453655612897033 0.038434237189574776 1
		 1 1 no;
	setAttr ".xm[36]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.7442538243088563 -0.62912660693767819
		 -0.25276041286096529 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032218771670288235 -0.08401694867549965 0.11008668831651433 0.9898404033695628 1
		 1 1 yes;
	setAttr ".xm[37]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1895887532116518 -1.3188092200522306e-06
		 1.0604575315653619e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.30387484184281865 0.9527119609278567 1
		 1 1 yes;
	setAttr ".xm[38]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.2084808571526509 -7.1054273576010019e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.15397198031489567 0.98807521438294832 1
		 1 1 yes;
	setAttr ".xm[39]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[40]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 1.0408340855860846e-17 1.6479873021779667e-17 1.6653345369377348e-16 0 0.14478671015100275
		 -0.62522803999102905 0.054605464536113146 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.18392774863239081 0.98155134853469073 -0.0079134639465956551 0.051622771730275414 1
		 1 1 yes;
	setAttr ".xm[41]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 6.5052130349130274e-18 -1.1573858191282761e-17 -3.7645206585083768e-35 0 -0.21927985396480665
		 -0.68039191021174616 0.059962946419279461 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.33286583944205939 0.94152684478977178 0.00012936364655210739 0.05222563295736244 1
		 1 1 yes;
	setAttr ".xm[42]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 0
		 0 0 0 0.44262871211201116 -1.1674609741902977 -0.1744171177961924 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308557 0.015993303709080996 0.049716674357998904 1
		 1 1 yes;
	setAttr ".xm[43]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.1000190082973775 0.077638867047004942
		 1.1051857314747859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327074 -0.14064896677911912 0.1063938653225321 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[44]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.2113433856746667 -1.0148305311374894e-06
		 3.0120894800589326e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.26197949426949685 0.96507343999423101 1
		 1 1 yes;
	setAttr ".xm[45]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6941592092295537 7.1054273576010019e-15
		 -8.8817841970012523e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1786971635264209 0.98390412324962417 1
		 1 1 yes;
	setAttr ".xm[46]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[47]" -type "matrix" "xform" 1 0.99999999999999989 1 2.7755575615628914e-17
		 2.0816681711721682e-17 1.6653345369377348e-16 0 -0.008897969522394078 -0.53397345773781524
		 -0.057093330916351714 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19443813918063449 -0.97295532058317269 -0.073254535055226805 -0.1009233732824573 1
		 1 1 yes;
	setAttr ".xm[48]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628914e-17
		 -1.5407439555097887e-33 -1.1102230246251565e-16 0 -0.012844241410235213 -0.69852386285188572
		 -0.18318987036044843 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.36517286647374636 -0.92254919836856386 -0.090110157422200188 -0.08620854777928888 1
		 1 1 yes;
	setAttr ".xm[49]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 -8.3266726846886728e-17 -1.3866695599588093e-32 -3.3306690738754691e-16 0 0.35997225062985194
		 -1.0044914815075445 0.030306462594378969 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755943328875 -0.79465996101688263 -0.10954779490783749 -0.059590559753185599 1
		 1 1 yes;
	setAttr ".xm[50]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -2.967889953708891e-05 2.0829965791048277 -3.5770309452232141e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[51]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 2.9107975592523871e-05 -2.0429266092840024 3.5082206935044269e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[52]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 0.22215031170242128 -7.6495421552635889e-08 -1.8877433709739861 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[53]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -0.16740074569656826 5.7656123431115702e-08 1.4225114365862055 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[54]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.5358780239681762 -2.1252076385984648
		 -0.55475650764298778 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589730857 -0.67086110383210196 -0.73035777294519266 0.11326205235528281 1
		 1 1 no;
	setAttr ".xm[55]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2738801856345816 -2.482494210198638e-10
		 -5.1581849902504473e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.8802384446748596e-08 -2.3293906098039619e-07 0.30252440548894083 0.95314163904610771 1
		 1 1 yes;
	setAttr ".xm[56]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.4666957502986691 1.4210854715202004e-14
		 -7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.20715555832647703 0.97830801624766706 1
		 1 1 yes;
	setAttr ".xm[57]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[58]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989 1.0000000000000002 1.7525962493923846e-32
		 9.0205620750793969e-17 3.8857805861880479e-16 0 -0.13003639372401921 -0.42748935939727062
		 0.0090326042383743754 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18190833306109286 0.97249127945572167 -0.14435909047317919 -0.018180284465989936 1
		 1 1 yes;
	setAttr ".xm[59]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 -5.5511151231257827e-17 -8.3266726846886741e-17 2.3111159332646827e-33 0 -0.092939849104823224
		 -0.70251570526252749 -0.020561655155919567 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.37941935441919783 0.91371269212297312 -0.14499380240721954 0.012118869955732907 1
		 1 1 yes;
	setAttr ".xm[60]" -type "matrix" "xform" 0.99999999999999989 1 1 2.7755575615628932e-17
		 -8.3266726846886741e-17 -4.4408920985006262e-16 0 0.64530541359000892 -1.0337684191679983
		 -0.099179200290809177 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806070025397454 0.75611401757832797 -0.13453354303836371 0.05541534995389473 1
		 1 1 yes;
	setAttr ".xm[61]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.7723296862230216 -0.27978723663700461
		 -0.36275273402219244 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800207 0.65392768619920127 0.74460445552019161 -0.086698209199445653 1
		 1 1 no;
	setAttr ".xm[62]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4359145921492313 -5.3290705182007514e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.33099740435037722 0.9436316645351156 1
		 1 1 yes;
	setAttr ".xm[63]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5938963073742798 1.4210854715202004e-14
		 -1.0658141036401503e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16311678596505561 0.98660676773293532 1
		 1 1 yes;
	setAttr ".xm[64]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[65]" -type "matrix" "xform" 1.0000000000000004 0.99999999999999989 1.0000000000000004 -2.7755575615628914e-17
		 -6.9388939039072299e-18 -5.5511151231257827e-17 0 0.0097566940123030577 -0.62627658440709411
		 0.19072773034926271 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18942506733578274 0.97750324727186122 -0.092484988897998791 -0.0072161115801939388 1
		 1 1 yes;
	setAttr ".xm[66]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 1.5407439555097894e-33 2.775557561562892e-17 1.1102230246251568e-16 0 -0.16496152272483755
		 -0.64963237563258502 -0.010965767331040155 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.34633520245692045 0.93351292551379461 -0.092423384556460472 0.0079663934706561655 1
		 1 1 yes;
	setAttr ".xm[67]" -type "matrix" "xform" 1 1 1.0000000000000002 -7.70371977754894e-34
		 1.3877787807814454e-17 -1.1102230246251563e-16 0 0.30737120973599019 -1.1821106670030854
		 0.012795115529151246 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317158315414 0.76625634194243475 -0.084576774299171445 0.038109246738131722 1
		 1 1 yes;
	setAttr ".xm[68]" -type "matrix" "xform" 1 1 0.99999999999999989 -3.2522503597421059e-09
		 1.6269235712078467e-08 1.1676854017302847e-08 0 -5.6161683140689291 -2.8078829101015756
		 1.3490852531175506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267574 0.79092168180925615 -0.56655406700099809 0.076316486466476846 1
		 1 1 no;
	setAttr ".xm[69]" -type "matrix" "xform" 1 1 1 5.3070195178143661e-13 2.3792325976042941e-07
		 -1.3578358637460943e-07 0 1.3843792601164751e-06 -2.7145519965188214e-07 -4.9580461336518056e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[70]" -type "matrix" "xform" 1 1 1 0.0058997737361192217 -0.00049452079635831038
		 -2.8729987160049575e-06 0 0.49922049000947766 2.9581812754938621 -2.3353211275889407e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029189813026558381 0.00049262500763106506 -0.083493624323089724 0.99650391447608033 1
		 1 1 yes;
	setAttr ".xm[71]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 0.0058997737361192217 -0.00049452079635831038 -2.8729987160049575e-06 0 -0.4992245719571855
		 -2.9582054164285303 2.2603977356538962e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0029189813026558381 0.00049262500763106506 -0.083493624323089724 0.99650391447608033 1
		 1 1 yes;
	setAttr ".xm[72]" -type "matrix" "xform" 1 1 1 1.1128628787128129e-06 3.0207724709978668e-08
		 -2.1056107480074234e-08 0 -7.9733304050135274 6.3323703614059923e-08 6.1214450397528708e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[73]" -type "matrix" "xform" 1 1 1 1.5970707287989025e-06 -1.7272370083675665e-15
		 8.3248609117360621e-09 0 -15.946661756748483 2.9185864391934047e-07 4.5590822139729426e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[74]" -type "matrix" "xform" 1 1 1 -7.9982792244955534e-07 -2.6897107075777592e-07
		 5.2015762611699531e-08 0 -8.3179983442870338 -0.23421221301943973 -3.6902483877089693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.027401009458430881 0.68285929581411187 -0.72965333882255312 -0.023629895175704567 1
		 1 1 no;
	setAttr ".xm[75]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[76]" -type "matrix" "xform" 1 1 1 1.6766494859155046e-09 1.3251953088681999e-24
		 1.5364583403813301e-25 0 15.276314141915009 -0.66666510324099659 -0.23259512495407628 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[77]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[78]" -type "matrix" "xform" 1 1 1 -5.2046188695544644e-07 4.3714980988727613e-07
		 1.4806520279165935e-07 0 3.1871186934040452e-06 3.1748160012057269e-07 -1.1475461789700603e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.01769022493995764 -5.5666396683338097e-08 -1.3911766870110481e-08 0.99984351572712138 1
		 1 1 no;
	setAttr ".xm[79]" -type "matrix" "xform" 1 1 1 1.6031064300857048e-07 -2.4351549027653503e-07
		 -2.0078720170536655e-07 0 -2.0391023059279121 3.7807471347604569 1.9442799573314105 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[80]" -type "matrix" "xform" 1 1 1 1.6031064300857048e-07 -2.4351549027653503e-07
		 -2.0078720170536655e-07 0 -2.0796412888383458 -5.2507730495076324 0.25073941825030488 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[81]" -type "matrix" "xform" 1 1 1 -3.8163916471489756e-17 1.0755285551056205e-16
		 -4.163336342344337e-17 0 1.8460968932489834 0.7100886774885744 -2.7737621548980016 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[82]" -type "matrix" "xform" 1 1 1 1.6031064308836773e-07 -2.4351549037888371e-07
		 -2.0078720164985537e-07 0 -6.3501221820377936 -2.7291381106600348 2.0160455531035382 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243926 -0.28080602403705029 -0.030710052147679925 0.9519207289690399 1
		 1 1 yes;
	setAttr ".xm[83]" -type "matrix" "xform" 1 1 1 4.7604797767663485e-07 -7.3040871468447449e-08
		 -2.6880013266818929e-08 0 -8.6475412902791504 2.5304690609573299e-07 -5.9611586067376265e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799857334752322 1.9595281799489555e-08 2.3123762860308417e-10 0.99993037925991579 1
		 1 1 no;
	setAttr ".xm[84]" -type "matrix" "xform" 1 1 1 1.9437843710374102e-08 8.5653819506546881e-09
		 2.8195150377370807e-08 0 -17.295084873071218 2.1638773262111499e-07 -3.7567885868838857e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0058998186544699099 3.8789585246972899e-08 2.2885550165905089e-10 0.99998259591847038 1
		 1 1 no;
	setAttr ".xm[85]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.34387171483078305 -4.5604522683327886
		 -7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[86]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.3438717148307161 3.6088802562769589
		 0.6099587491636127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[87]" -type "matrix" "xform" 1 1 1 -3.7358078137980887e-08 -3.9231474221458578e-07
		 1.7747221797652936e-07 0 2.2701034659063684 -0.16849257165543818 -2.3451506203393282 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090864042157167091 -0.73673233087998069 0.66365248834412305 -0.092382753767491999 1
		 1 1 no;
	setAttr ".xm[88]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[89]" -type "matrix" "xform" 1 1 1 -8.7351898515775978e-08 3.0968112931036184e-07
		 -3.3786357366272247e-07 0 9.5350861259021258 -0.04908860630574452 6.6024946909510468e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0043095761169174955 0.008122547781402643 -0.16242313102416744 0.98667835604088205 1
		 1 1 no;
	setAttr ".xm[90]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[91]" -type "matrix" "xform" 1 1 1 -6.5765615175905623e-11 -1.9968099496797911e-26
		 1.1619618915634355e-27 0 4.986384254736592 -0.3437570935533118 1.1348560979840272e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -3.9514086989413111e-19 0.0014376218797037942 0.0021873772694690386 0.9999965743061382 1
		 1 1 yes;
	setAttr ".xm[92]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[93]" -type "matrix" "xform" 1 1 1 1.5942175737862242e-15 -4.693018473877868e-07
		 -4.9014410172549118e-09 0 -1.7763568394002505e-15 4.4408920985006262e-16 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[94]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[95]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.6409866693344668 3.8767792175072415
		 3.4775081921847582 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67919742764105606 -0.048147358144700947 0.71910181041968524 0.13879939639850558 1
		 1 1 yes;
	setAttr ".xm[96]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418794 1.021405182655144e-14
		 -2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948423 0.53969740289995671 0.049379025691938784 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[97]" -type "matrix" "xform" 1 1 1 0 0 0 0 25.942629197482148 -1.7763568394002505e-14
		 4.2632564145606011e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16640634320511283 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[98]" -type "matrix" "xform" 1 1 1 0 0 0 0 23.919990038655001 -7.1054273576010019e-15
		 -3.5527136788005009e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.6718112537259389e-06 0.11687386491933727 -1.4206374895849063e-05 0.99314676634130983 1
		 1 1 yes;
	setAttr ".xm[99]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.2686357154041019 1.8318136906095752
		 -0.61950730993276437 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.20515884833089071 -0.90213467411116688 0.067073366509720067 0.37358270867765553 1
		 1 1 no;
	setAttr ".xm[100]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.0516604453308673
		 -1.382716163789155e-11 -4.3709036390282563e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-7.5409508216748738e-07 -3.3444035012532468e-06 0.21995856706938299 0.97550921510820698 1
		 1 1 yes;
	setAttr ".xm[101]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.6102879061749178
		 3.5527136788005009e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.12106269314279798 0.99264486314543166 1
		 1 1 yes;
	setAttr ".xm[102]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[103]" -type "matrix" "xform" 0.99999999999999989 1 0.99999999999999989 5.5511151231257827e-16
		 -3.8518598887744717e-32 1.3877787807814457e-16 0 0.093011950531163734 0.74777116535866295
		 -0.058093641876983071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.16281156635792474 -0.46390358450879787 0.71034161129637119 0.50368705899679667 1
		 1 1 yes;
	setAttr ".xm[104]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.1102230246251563e-16 5.5511151231257815e-17 5.5511151231257815e-17 0 0.28881221121405076
		 0.77665484218863767 -0.10704700344571805 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.21777545707806917 -0.44078108077077183 0.76609461237456489 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[105]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3825985602606892 -1.481320712902999
		 -0.21751098900338661 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313889209 -0.61761904571755988 -0.78453655612897055 0.038434237189574769 1
		 1 1 no;
	setAttr ".xm[106]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.7442538243088421
		 0.62912660693768885 0.25276041286096174 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032218771670287985 -0.084016948675499345 0.11008668831651404 0.98984040336956292 1
		 1 1 yes;
	setAttr ".xm[107]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.1895887532116802
		 1.3188092069515989e-06 -1.0604575297890051e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.30387484184281832 0.95271196092785682 1 1 1 yes;
	setAttr ".xm[108]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.2084808571526651
		 7.1054273576010019e-15 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.15397198031489528 0.98807521438294843 1 1 1 yes;
	setAttr ".xm[109]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[110]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 2.4286128663675302e-17 -9.9746599868666439e-18 2.2204460492503131e-16 0 -0.14481344796617179
		 0.62524239210620181 -0.054608253490670222 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.18392774863239164 0.98155134853469062 -0.0079134639465971764 0.051622771730275491 1
		 1 1 yes;
	setAttr ".xm[111]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.3091741232762464e-17 3.2363434848692301e-17 1.1102230246251563e-16 0 0.21925389433539522
		 0.68035991504324755 -0.05996656124215427 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.33286583940055764 0.94152684480444415 0.00012936364885220153 0.052225632957356702 1
		 1 1 yes;
	setAttr ".xm[112]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 9.0205620750793994e-17
		 2.7755575615628877e-17 8.8817841970012523e-16 0 -0.44265338170127677 1.1674220371286874
		 0.17441239141144216 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308568 0.015993303709079976 0.049716674357999396 1
		 1 1 yes;
	setAttr ".xm[113]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.100019008297366 -0.077638867046999849
		 -1.1051857314747835 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327053 -0.14064896677911917 0.10639386532253192 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[114]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.2113433856746525
		 1.014830526002708e-06 -3.0120894756180405e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.26197949426949668 0.96507343999423112 1 1 1 yes;
	setAttr ".xm[115]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6941592092295821
		 1.4210854715202004e-14 -2.1231301827739912e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.1786971635264209 0.98390412324962417 1 1 1 yes;
	setAttr ".xm[116]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[117]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999978 2.7755575615628909e-16 -9.7144514654701333e-17 9.4368957093138306e-16 0 0.008957472682361356
		 0.53395019911204145 0.057095533089779771 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19443812507456906 -0.97295532340216873 -0.073254536518429031 -0.10092337222040108 1
		 1 1 yes;
	setAttr ".xm[118]" -type "matrix" "xform" 1 0.99999999999999978 1 5.5511151231257827e-17
		 5.5511151231257821e-17 2.2204460492503131e-16 0 0.012863941463479023 0.69853100111512134
		 0.18319344488131462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.3651728664737463 -0.92254919836856397 -0.09011015742219905 -0.086208547779289033 1
		 1 1 yes;
	setAttr ".xm[119]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1.0000000000000002 0 0 0 0 -0.35991630006155617 1.0045062980003849 -0.030304822923965302 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755975758744 -0.79465996077442913 -0.10954779488351792 -0.059590559797891941 1
		 1 1 yes;
	setAttr ".xm[120]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -2.9056714197395195e-05 2.0429267278445735 -4.0345676239894601e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[121]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 2.962663036498725e-05 -2.082996535952919 4.1137013226943964e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[122]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 0.16740093387851118 -4.2835413083253115e-07 -1.4225110972004771 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[123]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -0.22215036112133646 5.6843365570102833e-07 1.8877432627052784 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[124]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5358780239681948 2.1252076385984608
		 0.55475650764299189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589731023 -0.67086110383210185 -0.73035777294519288 0.11326205235528264 1
		 1 1 no;
	setAttr ".xm[125]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.2738801856345958
		 2.48254750090382e-10 5.1582915716608113e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-8.8802384446748781e-08 -2.3293906098039574e-07 0.3025244054889405 0.95314163904610782 1
		 1 1 yes;
	setAttr ".xm[126]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.4666957502986975
		 -7.1054273576010019e-15 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.20715555832647689 0.97830801624766706 1 1 1 yes;
	setAttr ".xm[127]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[128]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1.0000000000000002 5.5511151231257827e-17 1.3877787807814457e-17 5.5511151231257827e-17 0 0.1300869336832946
		 0.42749737115858011 -0.0090328041227891731 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.18190833306109333 0.97249127945572156 -0.14435909047318005 -0.01818028446598971 1
		 1 1 yes;
	setAttr ".xm[129]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 -5.5511151231257827e-17 -1.3877787807814457e-16 3.8518598887744717e-33 0 0.092932645278267501
		 0.70253901601402902 0.020558105201324395 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.37941935441919805 0.91371269212297301 -0.14499380240722057 0.012118869955733351 1
		 1 1 yes;
	setAttr ".xm[130]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 0 0 0 0 -0.64530862789699484 1.033772745931909 0.099178466978877111 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806069911713481 0.75611401853767068 -0.13453354295504596 0.055415350156170579 1
		 1 1 yes;
	setAttr ".xm[131]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.7723296862230029 0.27978723663700578
		 0.36275273402220165 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800204 0.65392768619920094 0.74460445552019183 -0.086698209199445583 1
		 1 1 no;
	setAttr ".xm[132]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.4359145921492313
		 1.0658141036401503e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.33099740435037706 0.9436316645351156 1
		 1 1 yes;
	setAttr ".xm[133]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.5938963073743082
		 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16311678596505561 0.98660676773293532 1
		 1 1 yes;
	setAttr ".xm[134]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[135]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999978
		 1.0000000000000002 -2.7755575615628886e-17 9.0205620750793981e-17 6.106226635438361e-16 0 -0.0097425222843625647
		 0.62632109537290148 -0.19073555836700962 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18942508170032349 0.97750324448823434 -0.092484988791958059 -0.0072161129392722019 1
		 1 1 yes;
	setAttr ".xm[136]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628907e-17
		 1.3877787807814457e-17 1.1102230246251563e-16 0 0.16497330343041483 0.64960365708683554
		 0.010971411859809876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34633520221586123 0.93351292560322785 -0.092423384554404631 0.0079663934945232405 1
		 1 1 yes;
	setAttr ".xm[137]" -type "matrix" "xform" 1 0.99999999999999989 1.0000000000000002 2.3111159332646827e-33
		 -4.163336342344337e-17 -1.1102230246251565e-16 0 -0.30734474282169799 1.1821151242411378
		 -0.012786813473642411 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317134172704 0.76625634214275939 -0.084576774287164702 0.038109246764780655 1
		 1 1 yes;
	setAttr ".xm[138]" -type "matrix" "xform" 1 0.99999999999999989 1 -3.2522505817867208e-09
		 1.6269233658165888e-08 1.1676854294858608e-08 0 5.6161553990582291 2.8079089430753577
		 -1.3490770884595875 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267533 0.79092168180925626 -0.56655406700099842 0.076316486466475958 1
		 1 1 no;
	setAttr ".xm[139]" -type "matrix" "xform" 1 1 1 -1.7222833206260737e-07 -1.1950459188189162e-07
		 7.3290778634209202e-08 0 3.794008449631292e-07 -9.1163720128406567e-08 -1.3948621102599645e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[140]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 1 0.005900319728525929 -0.00049432277654363284 -2.9662723266230796e-06 0 0.49922314169340609
		 2.9581952655744672 4.6052669233631605e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0029191406150601736 0.0004926176904447542 -0.083493624306147013 0.99650391401444316 1
		 1 1 yes;
	setAttr ".xm[141]" -type "matrix" "xform" 1 1 1 0.005900319728525929 -0.00049432277654363284
		 -2.9662723266230796e-06 0 -0.49922185243011086 -2.9581876247830028 -4.5783868074522616e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029191406150601736 0.0004926176904447542 -0.083493624306147013 0.99650391401444316 1
		 1 1 yes;
	setAttr ".xm[142]" -type "matrix" "xform" 1 1 1 1.9404091557882103e-06 5.1918358268756153e-08
		 -3.0067228184397346e-08 0 7.9733305555205902 -8.0196674190347039e-08 -1.1247605158359875e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[143]" -type "matrix" "xform" 1 1 1 1.08182964958512e-06 -6.4945811118219324e-08
		 4.0594123126932932e-08 0 15.94666095136445 -1.0734020250424692e-07 -1.6400243652014979e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[144]" -type "matrix" "xform" 1 1 1 5.4160604879362514e-07 2.009185912428714e-07
		 4.758449157641748e-08 0 8.3179977339076459 -0.23422280895807646 3.6902475259176484 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.72965333882255323 0.023629895175704421 -0.027401009458430898 0.68285929581411176 1
		 1 1 no;
	setAttr ".xm[145]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[146]" -type "matrix" "xform" 1 1 1 6.3765392965819956e-10 5.0399084806560511e-25
		 5.8433721677698674e-26 0 15.276314141915009 -0.66666510324100159 -0.23259512495407719 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[147]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[148]" -type "matrix" "xform" 1 1 1 -1.0853573356802025e-06 -4.3568480912375238e-07
		 -1.5827201977261405e-07 0 5.709288075195218e-06 6.212917647019367e-07 -2.1773046867679113e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.017689848081294958 -3.5099206601646391e-07 -1.0642097693105201e-07 0.9998435223947425 1
		 1 1 no;
	setAttr ".xm[149]" -type "matrix" "xform" 1 1 1 3.9091003157917731e-07 2.0553793393427188e-07
		 -4.2825701378480775e-07 0 2.0796398125979323 5.2507738269428739 -0.25074371557527542 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[150]" -type "matrix" "xform" 1 1 1 3.9091003157570792e-07 2.0553793404269212e-07
		 -4.2825701378480786e-07 0 2.0391012125653276 -3.7807481359989907 -1.9442803597557088 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903996 -0.28080574450372225 -0.030709888094579113 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[151]" -type "matrix" "xform" 1 1 1 3.9091003157917731e-07 2.0553793393427188e-07
		 -4.2825701378480775e-07 0 -1.8460945685297929 -0.71008786430548199 2.7737649130940696 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[152]" -type "matrix" "xform" 1 1 1 3.9091003156529952e-07 2.0553793392733299e-07
		 -4.2825701382644117e-07 0 6.3501177812513419 2.7291390216045208 -2.0160545373111205 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903978 -0.28080574450372214 -0.030709888094579009 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[153]" -type "matrix" "xform" 1 1 1 -1.8510935268298355e-07 -7.3525778477132489e-08
		 -1.9051371282054823e-08 0 8.6475423825332456 -8.5352365175594969e-08 3.7745845560266389e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799440696141954 5.7471190699417895e-08 2.1503880690791351e-08 0.99993038417644575 1
		 1 1 no;
	setAttr ".xm[154]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999967
		 0.99999999999999833 1.3297720257325253e-07 9.1781417651250027e-08 2.5223403808690039e-08 0 17.295085515775057
		 -9.7533423115692131e-08 5.5281149258235018e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0059001293061062251 -2.8392807976717996e-08 -1.1259027937650805e-08 0.99998259408560208 1
		 1 1 no;
	setAttr ".xm[155]" -type "matrix" "xform" 1 1 1 -6.2131408305892441e-07 -1.3422690300712979e-07
		 -2.3768074267184763e-08 0 -0.34414841807519281 4.5604182918902847 0.00011523384355172084 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3.106570423270981e-07 6.7113447811715346e-08 1.1884057982860475e-08 0.99999999999994937 1.0000000000000002
		 1.0000000000000004 1.0000000000000018 yes;
	setAttr ".xm[156]" -type "matrix" "xform" 0.99999999999999978 1 0.99999999999999978 -6.289219633362861e-20
		 -1.3552527152912673e-20 -2.3955150665752208e-21 0 -0.34371943612941891 -3.6088561973584454
		 -0.61001866734908816 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3.1065704247975371e-07 6.7113447887175844e-08 1.18840581216383e-08 0.99999999999994937 1.0000000000000002
		 1.0000000000000004 1.0000000000000018 yes;
	setAttr ".xm[157]" -type "matrix" "xform" 1 1 1 -0.00022152767880003694 8.4875104148135039e-07
		 1.2506500933867408e-08 0 8.8817841970012523e-16 4.4408920985006262e-16 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[158]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[159]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.8896802499102243 3.884615267454778
		 2.3331122655065721e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 7.6382178455051576e-08 1.5593511478536243e-06 -0.23597495564053356 0.97175913698200467 1
		 1 1 yes;
	setAttr ".xm[160]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.683546000000064 0.00015703100003605641
		 4.3841862470061707e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1288734818512077 0.99166104374203712 1
		 1 1 yes;
	setAttr ".xm[161]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[162]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977792049080051 -5.1625618604184824
		 -3.0255378400541937 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50010523644630966 0.49989474205212669 -0.5001036748994 0.49989630294665471 1
		 1 1 no;
	setAttr ".xm[163]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.44894278226615869
		 -0.18401212650169896 2.1363091819890201 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841859969194742 0.090512344640451117 0.021125460962961716 0.99342508329649548 1
		 1 1 yes;
	setAttr ".xm[164]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7763568394002505e-15
		 0 4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[165]" -type "matrix" "xform" 1 1 1 0.23360810753218131 -0.40234061126456877
		 -0.43485044274246787 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.40087774203409404 -0.45290564647529907 -0.61013986385495111 0.51176445545533888 1
		 1 1 yes;
	setAttr ".xm[166]" -type "matrix" "xform" 0.66197264440161574 1.1021921299515944
		 1 0 0 0 0 0.044855766375292205 2.5245096710397803 0.15444283002983816 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.4862617343533791 0.48494166130101091 0.53021325555582166 0.49724743787289283 1
		 1 1 yes;
	setAttr ".xm[167]" -type "matrix" "xform" 1 1 1 -0.058003319898012974 0.72383020551935373
		 -0.079669027797594522 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47751416514246486 -0.38421895523508581 -0.54200896931834797 0.57496286289187049 1
		 1 1 yes;
	setAttr ".xm[168]" -type "matrix" "xform" 0.6785375197975797 0.95799864639124532
		 1 0 0 0 0 0.059214626181244512 2.5389169532675826 0.15533543079981804 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49557169816285929 0.47655439569781033 0.51760793659052884 0.50930013145449882 1
		 1 1 yes;
	setAttr ".xm[169]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977603558034843 -5.1625605538767454
		 3.0255955792552052 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49989630294665394 0.50010367489940077 0.49989474205212592 0.50010523644631044 1
		 1 1 no;
	setAttr ".xm[170]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.44894370729995314
		 0.18401211987492161 -2.1363089881648829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841864099626877 0.090512559469702922 0.021125451262397732 0.99342506365145145 1
		 1 1 yes;
	setAttr ".xm[171]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[172]" -type "matrix" "xform" 1 1 1 0.53200126771743783 0.0029727848858548088
		 0.010025488126381595 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.064989343048516224 -0.67638815196858926 -0.042556096839040547 0.73243732277135143 1
		 1 1 yes;
	setAttr ".xm[173]" -type "matrix" "xform" 1.1975992053004352 0.79913879068876204
		 1 0 0 0 0 -2.4621405940084298 -0.00029764573881152501 6.2316870597101115e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70788413856216958 0.0067958157402144836 -0.70565959166388148 0.029973387417574993 1
		 1 1 yes;
	setAttr ".xm[174]" -type "matrix" "xform" 1 1 1 -0.73566333107297788 -0.0022688543119592911
		 0.0043549249991153656 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10800905939387451 -0.52060676801724259 -0.12772602498256161 0.83725067854594493 1
		 1 1 yes;
	setAttr ".xm[175]" -type "matrix" "xform" 1.24781063655325 0.69061940645158038 1 0
		 0 0 0 -2.5739657448699944 4.8678124301204662e-05 1.5174167788956083e-06 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70482462364600029 -0.029045690597641061 0.70875472608900425 -0.0067332018001021732 1
		 1 1 yes;
	setAttr ".xm[176]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 -3.9400967430655101 -2.8896707548708074 -2.6925502350709334e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[177]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 1.4007122498098568 4.2847543237057621 3.3515570085725825e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[178]" -type "matrix" "xform" 1 1 1 2.2260632721892816e-07 0.018838865332075082
		 9.9413410438024742e-08 0 1.5056762133197878 7.5070726841770457 1.5419261387338663e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15951152046933148 -0.68888073166472075 0.68888038349887182 0.15950934019388496 1
		 1 1 no;
	setAttr ".xm[179]" -type "matrix" "xform" 1 1 1 -2.2151420150933658e-07 2.4661162094690787e-09
		 -9.8557642670254815e-08 0 10.563390829596955 -4.2760353465259426e-15 -0.046552117208733534 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.015251496810226965 0 0.99988368915841785 1
		 1 1 yes;
	setAttr ".xm[180]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 9.4827687854422607
		 3.7321796315329531e-15 -2.3385624103866576e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.012722857859538445 0 0.9999190611683958 1 1 1 yes;
	setAttr ".xm[181]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 10.536384444209355
		 -2.2139260911782478e-15 0.035821534330517872 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.02346357552664715 0 0.99972469241461936 1 1 1 yes;
	setAttr ".xm[182]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 8.2070163083248531
		 1.8807214628973473e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.00096055918587931069 0 0.9999995386629188 1
		 1 1 yes;
	setAttr ".xm[183]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 7.488432529677028
		 1.7562206841626555e-15 0.02118917542799284 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.0088147932995396357 0 0.99996114895484134 1 1 1 yes;
	setAttr ".xm[184]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 4.5543586581220552
		 1.064711944369183e-15 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.017460398155145457 0 0.9998475556284887 1 1 1 yes;
	setAttr ".xm[185]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 8.1939419076200011
		 4.4656352014393452e-15 -2.020721012740978e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.049673452335513124 0 0.99876551208633124 1 1 1 yes;
	setAttr ".xm[186]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.5673177093418502 -5.6921998704852754e-08
		 -2.3594068920829159e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[187]" -type "matrix" "xform" 1 1 1 0 0 0 0 12.482656650018839 -7.4267186961406164e-08
		 -3.0783681381763017e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[188]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[189]" -type "matrix" "xform" 1 1 1 3.8944537725842122e-15 9.0138253250326943e-08
		 6.5471963239805116e-08 0 4.2530390196097017 10.77130977070858 5.5192402113899419 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.3782104709457097 -0.37821047094570959 0.59745865101028073 0.59745865101028095 1
		 1 1 yes;
	setAttr ".xm[190]" -type "matrix" "xform" 1 1 1 -6.6467294437285689e-17 -6.8039369138794825e-09
		 3.2205305089405556e-09 0 4.2528131677824774 -10.771300081889816 5.5191355833121776 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59745865101028095 0.59745865101028073 0.37821047094570959 0.3782104709457097 1
		 1 1 yes;
	setAttr ".xm[191]" -type "matrix" "xform" 1 1 1 0.45147067833840204 -3.0694132441347363e-08
		 -7.275961944337105e-08 0 11.559844746539198 -10.610553688903337 -0.064109199610069695 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41448053453211336 0.51498461377259264 -0.59595391917958995 0.45588996510775948 1
		 1 1 no;
	setAttr ".xm[192]" -type "matrix" "xform" 1 1 1 0.7750111904053576 -0.21789524103559429
		 -0.23887808228062216 0 3.7101141635033201 -1.1368683772161603e-13 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16334516138569405 0.27854149049191035 -0.27089239992649744 0.90683532352268281 1
		 1 1 yes;
	setAttr ".xm[193]" -type "matrix" "xform" 1 1 1 0.12538130224185476 -0.059683413925607449
		 -0.3571596861617784 0 4.0725563230532771 8.5265128291212022e-14 -1.1368683772161603e-13 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18051798240081326 0.17788544273638804 0.027008285055259748 0.96697496339398192 1
		 1 1 yes;
	setAttr ".xm[194]" -type "matrix" "xform" 1 1 1 0.14248795753079574 0.23026417415148623
		 -0.080345506665518374 0 4.000610933484765 -3.5527136788005009e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020971424288593093 -0.027413947918390729 0.11149405566238443 0.99316552012984671 1
		 1 1 yes;
	setAttr ".xm[195]" -type "matrix" "xform" 1 1 1 -0.097362896099633209 0.38168489929344435
		 0.14514040658241065 0 4.0603935283487544 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 0.071389841504829202 -0.14883679234685407 0.092570372479719693 0.98192760726683959 1
		 1 1 yes;
	setAttr ".xm[196]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[197]" -type "matrix" "xform" 1 1 1 0.50350514714478545 4.1006020464770464e-09
		 -4.5991031285753878e-09 0 12.566899404695164 -9.6150313351416621 0.071513720417332782 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54332247225669583 0.40457064582709801 -0.45375334041170345 0.57899152821188804 1
		 1 1 no;
	setAttr ".xm[198]" -type "matrix" "xform" 1 1 1 0.56908407903183811 -0.38500868437795283
		 -0.18640777234602562 0 3.4644126223781484 -2.0810261958104093e-08 -4.7554209459121921e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.044405792528022334 0.23820893735320914 -0.42228386868031159 0.87347636602681034 1
		 1 1 yes;
	setAttr ".xm[199]" -type "matrix" "xform" 1 1 1 0.39338315205201096 -0.18573442225732267
		 -0.27401196531058752 0 4.303739247827437 1.4210854715202004e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17400122083625127 0.19635169321082077 -0.087211217863158774 0.96102226363365917 1
		 1 1 yes;
	setAttr ".xm[200]" -type "matrix" "xform" 1 1 1 -0.030987593584643962 0.015876666981339729
		 -0.13141720737013338 0 4.1818076225511618 -1.4210854715202004e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.050839916640124189 0.051504431728612514 0.036612817149271802 0.99670562254295114 1
		 1 1 yes;
	setAttr ".xm[201]" -type "matrix" "xform" 1 1 1 0.12036348611889762 0.16073074494383702
		 -0.054912447136772631 0 4.2405858650267305 1.4210854715202004e-14 2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.013845469812409465 -0.017827603972404502 0.081747532548058319 0.99639742092429218 1
		 1 1 yes;
	setAttr ".xm[202]" -type "matrix" "xform" 1 1 1 -0.27422613628046527 0.2670227663113845
		 -0.043179333783084875 0 4.224601729290427 -2.8421709430404007e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.026620080080550244 -0.052681510888382001 0.11017046964238202 0.99215850415435092 1
		 1 1 yes;
	setAttr ".xm[203]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[204]" -type "matrix" "xform" 1 1 1 0.28180597477669983 1.6638588366529264e-08
		 7.4364846238523222e-08 0 14.043917314267674 -8.3515692259221659 0.15407804390279989 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62938079819301485 0.46599988082158245 -0.38226311049846218 0.49050875251338294 1
		 1 1 no;
	setAttr ".xm[205]" -type "matrix" "xform" 1 1 1 0.16657712992334422 -0.18663500741767519
		 0.010533570859111338 0 3.6589284731835434 -1.6929959656408755e-08 -5.8478001108142053e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0015731991924447363 0.017124862808462073 -0.35508761471425648 0.93467483650445626 1
		 1 1 yes;
	setAttr ".xm[206]" -type "matrix" "xform" 1 1 1 0.375882884846373 -0.10434518109949192
		 -0.097616190672198705 0 4.0030741049005627 -5.6843418860808015e-14 -3.5527136788005009e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094743762826098421 0.14225531451370066 -0.13053594339965241 0.97659992442090782 1
		 1 1 yes;
	setAttr ".xm[207]" -type "matrix" "xform" 1 1 1 0.036754376770198251 0.063024627285098209
		 -0.13767769969643656 0 4.0831724074700873 -2.8421709430404007e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.061230068711689851 0.080745357838719653 0.071197012427159964 0.99230139135975504 1
		 1 1 yes;
	setAttr ".xm[208]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[209]" -type "matrix" "xform" 1 1 1 0.1664074764349939 -2.9141556668122256e-09
		 3.421383202683414e-08 0 14.951931269453581 -7.5211136838236436 -0.087329301588584415 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6320347144562688 0.52782869945912025 -0.37432424431774103 0.42639224179788793 1
		 1 1 no;
	setAttr ".xm[210]" -type "matrix" "xform" 1 1 1 0.17040092240406829 -0.11050539964674586
		 -0.0049174716551962294 0 4.0750092727693534 1.9670096662594005e-09 1.171116892351165e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0073815378305819076 0.035025908130299058 -0.3541431012040927 0.93450594568919199 1
		 1 1 yes;
	setAttr ".xm[211]" -type "matrix" "xform" 1 1 1 0.36997183039461146 -0.10990467620587775
		 -0.081587009718689901 0 4.287632031359621 -5.6843418860808015e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13613405303142886 0.14053384536649907 -0.1943974599906845 0.9612114155901974 1
		 1 1 yes;
	setAttr ".xm[212]" -type "matrix" "xform" 1 1 1 0.4143833470440455 -0.02955823715551428
		 -0.14436653328433313 0 4.1413681691741147 1.4210854715202004e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17831145707108373 0.11992841067894842 -0.0094390494990498446 0.9765925992622323 1
		 1 1 yes;
	setAttr ".xm[213]" -type "matrix" "xform" 1 1 1 0.32802497756303522 0.23231687115775795
		 -0.19975834173395818 0 4.3499426101529934 2.1316282072803006e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.043429001529634449 0.039314051682630254 0.15242651384174591 0.98657715615378339 1
		 1 1 yes;
	setAttr ".xm[214]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[215]" -type "matrix" "xform" 1 1 1 3.5996839562301617e-08 -6.3073126694564231e-09
		 1.8355733985840653e-08 0 11.13450705315293 -10.370759311270046 0.33848942153285977 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084844947099925044 -0.27041773600217633 -0.92181779653480711 0.26443814588440379 1
		 1 1 no;
	setAttr ".xm[216]" -type "matrix" "xform" 1 1 1 2.7686504091597737 0.017278520765435353
		 0.037843225583184675 0 2.600889742057376 4.7741167463755119e-08 1.6404650970969215e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.93000072000406364 -0.363977974682195 -0.010685059690918201 0.050045221925496215 1
		 1 1 yes;
	setAttr ".xm[217]" -type "matrix" "xform" 1 1 1 -0.13858841596375779 0.24467850433967553
		 -0.7266573557982885 0 2.6511928129189641 3.907985046680551e-14 -1.0658141036401503e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.063571288267562018 -0.023906635276354345 0.19527786790137486 0.97839343742977924 1
		 1 1 yes;
	setAttr ".xm[218]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[219]" -type "matrix" "xform" 1 1 1 -0.27606462167449519 -3.1858226335938633e-08
		 -9.9184254602802609e-08 0 10.470345513282581 -9.0848465124632973 0.097967074647777555 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23662118052248096 -0.20574559852158006 -0.64054804476594396 0.700983143851313 1
		 1 1 no;
	setAttr ".xm[220]" -type "matrix" "xform" 1 1 1 -0.99365940053776181 0.15394967857761332
		 -0.22640150308056317 0 2.1274797555267142 8.5265128291212022e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22328030716644459 -0.41420835725404437 -0.50483542982748153 0.72368399872006706 1
		 1 1 yes;
	setAttr ".xm[221]" -type "matrix" "xform" 1 1 1 -1.7127515388839774 -0.20224384528717648
		 -0.57917206034646818 0 2.639408073676293 -7.1054273576010019e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.7017785729713647 -0.32534900068867412 -0.021023075432680283 0.63341368201871673 1
		 1 1 yes;
	setAttr ".xm[222]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[223]" -type "matrix" "xform" 1 1 1 -0.58871132130422521 -2.902190415350382e-08
		 1.3813381944315262e-08 0 11.659360585550274 -10.690352657914914 0.51157115252927832 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.37693942322479668 0.61413663147404751 0.59970049279673476 -0.34801176422647118 1
		 1 1 no;
	setAttr ".xm[224]" -type "matrix" "xform" 1 1 1 -0.64116319438986236 0.23478917672635735
		 -0.28663701278127085 0 4.2885967811930641 4.9267299573330092e-08 3.2895343338168459e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22660364973293748 -0.25319576300284674 -0.2194805848851025 0.91453319479590889 1
		 1 1 yes;
	setAttr ".xm[225]" -type "matrix" "xform" 1 1 1 -0.24702108125275421 0.061810932937138387
		 -0.11375023769757539 0 4.5340884300743198 -2.8421709430404007e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092516220210340089 -0.063472909040306072 -0.003884960665585923 0.99367844189988319 1
		 1 1 yes;
	setAttr ".xm[226]" -type "matrix" "xform" 1 1 1 0.24913418041829566 -0.33161626926996085
		 -0.043267425329907419 0 4.532349631042166 -7.1054273576010019e-15 5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090439092198492763 0.078146807396151444 0.11412592256858679 0.98625002960404018 1
		 1 1 yes;
	setAttr ".xm[227]" -type "matrix" "xform" 1 1 1 0.14067995876799974 -0.42436195409338978
		 -0.11600463946360258 0 4.5179710886268225 -7.1054273576010019e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032243738609480932 0.056325887812229164 0.22075158847536744 0.97316826493071051 1
		 1 1 yes;
	setAttr ".xm[228]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[229]" -type "matrix" "xform" 1 1 1 -0.48711264523091796 8.2840213201580938e-09
		 1.4324810048774101e-08 0 13.118840755789563 -10.023280050816982 0.24307552472855182 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47657025244159062 0.53983229596189353 0.5313438850621367 -0.44624607844926117 1
		 1 1 no;
	setAttr ".xm[230]" -type "matrix" "xform" 1 1 1 -0.25707445750961794 0.2967392312547813
		 -0.095466686122511163 0 4.2576142635573255 7.0404809093815857e-08 -2.6201263381153694e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.070336992054541109 -0.13802067634345827 -0.31294420027560338 0.93705332183621048 1
		 1 1 yes;
	setAttr ".xm[231]" -type "matrix" "xform" 1 1 1 -0.82064730014139953 0.11277654776761636
		 -0.30591420501499944 0 4.4831290673189699 8.5265128291212022e-14 6.3948846218409017e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.33149761930554317 -0.24949646258216235 -0.11973951164966329 0.90195526103218948 1
		 1 1 yes;
	setAttr ".xm[232]" -type "matrix" "xform" 1 1 1 -0.29432373049685984 -0.16711771924131327
		 -0.22982205716715076 0 4.3959831042409974 1.4210854715202004e-14 -2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.052409745972236597 -0.037599698140709265 0.10867617125244583 0.99198234411140718 1
		 1 1 yes;
	setAttr ".xm[233]" -type "matrix" "xform" 1 1 1 0.019545786695121536 -0.43310121593267642
		 -0.14272019861866786 0 4.5214945161723961 1.1546319456101628e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.070891049651653909 0.083402588927564081 0.13365389970052929 0.98496451831236409 1
		 1 1 yes;
	setAttr ".xm[234]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[235]" -type "matrix" "xform" 1 1 1 -0.28955678051547729 -2.0562057726203384e-08
		 -1.1117330575951324e-08 0 14.07102776478655 -9.0881921846450808 0.4700482760667028 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52039384466942717 0.59301541921989354 0.47167965981558169 -0.3937527873093512 1
		 1 1 no;
	setAttr ".xm[236]" -type "matrix" "xform" 1 1 1 -0.52623215293941006 0.15241378971787767
		 -0.10414478433141151 0 5.4393351738680877 -8.9888089860323817e-08 8.9921812218562991e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092181342153629914 -0.19388876786037579 -0.27822862241370622 0.93621502846627713 1
		 1 1 yes;
	setAttr ".xm[237]" -type "matrix" "xform" 1 1 1 -0.67210954826355418 -0.047449864254822678
		 -0.25544739709196784 0 5.7224209536090171 2.8421709430404007e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.12971758998090704 -0.16717093037661793 0.071055743230454549 0.9747709003866134 1
		 1 1 yes;
	setAttr ".xm[238]" -type "matrix" "xform" 1 1 1 0.01134805204773333 -0.21486546896777364
		 -0.17319448231217699 0 5.6743041256576703 -3.5527136788005009e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.012271928225658608 0.025466011624172884 0.13759018857390604 0.99008576499098244 1
		 1 1 yes;
	setAttr ".xm[239]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[240]" -type "matrix" "xform" 1 1 1 -0.40909294887190145 -8.1833122077012283e-08
		 -2.8849972743301528e-08 0 14.76624914810327 -8.1360405532038698 0.49815024985889211 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.5155648583716258 0.59500971570831662 0.47579428496428899 -0.39214297573751666 1
		 1 1 no;
	setAttr ".xm[241]" -type "matrix" "xform" 1 1 1 -0.34249673052058849 0.25207708765604525
		 -0.099849212848047847 0 5.2768869299535481 -8.5265128291212022e-14 2.1316282072803006e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.08200328237693888 -0.14985466411081202 -0.32227306981757614 0.93110639015850361 1
		 1 1 yes;
	setAttr ".xm[242]" -type "matrix" "xform" 1 1 1 -0.59918926148009211 0.1167435112365946
		 -0.14972446037539391 0 5.2858940783937669 -2.8421709430404007e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.170454007603353 -0.13147989968328083 -0.077896840354802044 0.97344262775675139 1
		 1 1 yes;
	setAttr ".xm[243]" -type "matrix" "xform" 1 1 1 -0.2188257822137534 -0.1655517318743111
		 -0.29662490696246918 0 5.4754897225444665 -3.5527136788005009e-14 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.095565669962619129 -0.081410754277070119 0.12704581802047121 0.98392014510129 1
		 1 1 yes;
	setAttr ".xm[244]" -type "matrix" "xform" 1 1 1 0.014493922294741664 -0.20446607764127964
		 -0.47010882376847773 0 5.3259893014724184 7.1054273576010019e-14 -2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.065953319468648811 -0.10417388950270078 0.17022863969017771 0.97766056002386492 1
		 1 1 yes;
	setAttr ".xm[245]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[246]" -type "matrix" "xform" 1 1 1 -4.0579464155426279e-09 4.8375343939506078e-09
		 3.7644982343775473e-08 0 17.043317186369848 -2.0220670344563585 -0.32638396616415061 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.76030032532266922 0.39209918154902723 -0.24865310820127207 0.45428325846840611 1
		 1 1 no;
	setAttr ".xm[247]" -type "matrix" "xform" 1 1 1 0.2517434142673603 -0.14546472763342799
		 -0.036064088893669174 0 2.4893927647862739 0 -1.2042514541121818e-08 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.03716156970224125 0.10937765032783689 -0.26142534589096245 0.9582861450901905 1
		 1 1 yes;
	setAttr ".xm[248]" -type "matrix" "xform" 1 1 1 -0.17384261872883722 -0.092660793704895619
		 -0.010921304248149815 0 2.4527219098537731 -2.8421709430404007e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0010591050938175248 0.033899055776556754 -0.092242225906682324 0.99515883359071822 1
		 1 1 yes;
	setAttr ".xm[249]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[250]" -type "matrix" "xform" 1 1 1 1.4055002272305548 -9.464370312269691e-09
		 -2.3201453279105333e-08 0 7.0454953501284479 -5.7686102140994953 -7.4789343609185917 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.32385315277634991 -0.9325115233988962 0.15221832518446413 -0.048692665188142616 1
		 1 1 no;
	setAttr ".xm[251]" -type "matrix" "xform" 1 1 1 0.30975139813597324 -0.04984133635443385
		 0.1734208267267284 0 3.8994339199381614 3.6402660441581247e-08 6.0726108586095506e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.054117112836187677 -0.035741148526551171 -0.060007380793525196 0.99608886282830156 1
		 1 1 yes;
	setAttr ".xm[252]" -type "matrix" "xform" 1 1 1 -1.6200961847375286 0.31271944462391843
		 0.30282210206782706 0 3.8753796785145767 -1.4210854715202004e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.26349488639961138 -0.13794692836691611 -0.039341044346965441 0.95393572740781596 1
		 1 1 yes;
	setAttr ".xm[253]" -type "matrix" "xform" 1 1 1 -0.53567510940198404 0.61880633472049906
		 0.039540374506785526 0 3.8738202249231222 2.8421709430404007e-14 -1.5987211554602254e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.30117490267905089 -0.21960656083056396 0.17430017250304658 0.91141981890994894 1
		 1 1 yes;
	setAttr ".xm[254]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[255]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.436168815274073 -9.2821712339051707
		 -0.086203643238799726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5370102245311007 -0.55464071945418225 0.46740594424565796 -0.43072656564951844 1
		 1 1 no;
	setAttr ".xm[256]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.6842749127368792 -7.2858385991025898e-17
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098149669675103565 0.21336511951404907 -0.35528274181868902 0.90477408311866347 1
		 1 1 yes;
	setAttr ".xm[257]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.086124694635906 -2.2204460492503131e-14
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15539376894301871 0.14386981915757893 -0.018142993932345093 0.97715151510930998 1
		 1 1 yes;
	setAttr ".xm[258]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.3542138218270701 -4.8849813083506888e-15
		 -3.1086244689504383e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.042345277449608434 0.047665405785576626 0.11559435084104877 0.99124811859728057 1
		 1 1 yes;
	setAttr ".xm[259]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[260]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.95422099999999999
		 -0.74553599999999998 1.2150244631780774e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[261]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.5853841945645684e-05
		 -2.8217865983027934 1.5924359185037464 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.35118023178006774 -0.35118036430445482 0.61373646201463816 0.61373638618517878 1
		 1 1 yes;
	setAttr ".xm[262]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0333029283221162 1.1471967024358105e-16
		 -1.9003452463541333e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.1167210741668856 0 0.99316473499884617 1
		 1 1 yes;
	setAttr ".xm[263]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0134628592404753 -3.119115312198905e-17
		 -2.5729418595688003e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.15232175999380265 0 0.98833095743905053 1
		 1 1 yes;
	setAttr ".xm[264]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92213062093366782
		 1.3035083173738416e-16 3.8094527532450684e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.070148210841866954 0 0.99753658003889012 1 1 1 yes;
	setAttr ".xm[265]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.94821701958468041
		 2.0002410538132562e-16 -2.5673907444456745e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.039329575009993872 0 0.99922629295346965 1 1 1 yes;
	setAttr ".xm[266]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.76201279828011625
		 1.8913872956232026e-16 -2.541022947610827e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.031340980280144204 0 0.99950875081465873 1 1 1 yes;
	setAttr ".xm[267]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.62797717990570079
		 1.7383309535097934e-16 1.609823385706477e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[268]" -type "matrix" "xform" 1 1 1 5.4904916386097485e-16 2.162977167374795e-07
		 1.2772412461004159e-08 0 -1.737517085917375 -8.8275211160129885 1.2305494212866918e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[269]" -type "matrix" "xform" 1.0000000000000007 1.0000000000000011 1.0000000000000002 -1.1102229047307621e-16
		 2.1598257482491371e-07 -1.6653342372017294e-16 0 -2.2147732164010279 -8.523143920105273
		 1.2575274408751927e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[270]" -type "matrix" "xform" 1 1 1 -7.7040041016390239e-12 -5.0861370670626822e-11
		 1.224376156036707e-11 0 -1.8825256038787188 -7.8514162719707299 -1.5584216272912981 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72330838765809879 -0.56220012029869171 0.33328766480031136 -0.22287963920361428 1
		 1 1 no;
	setAttr ".xm[271]" -type "matrix" "xform" 1 1 1 -8.7136201032385965e-13 3.1941463363200889e-13
		 9.1674064173194422e-13 0 -1.7763568394002505e-15 5.6843418860808015e-14 -7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[272]" -type "matrix" "xform" 1 1 1 1.1595381773573089e-07 4.1220840345224184e-07
		 -6.1034828939914254e-08 0 -1.882539826420242 -7.8514152794665693 1.5584393116040054 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52963666997509684 -0.75587184796602791 -0.25791530207195246 -0.2856964196962325 1
		 1 1 no;
	setAttr ".xm[273]" -type "matrix" "xform" 1 1 1 -2.4286128663675299e-17 3.1225022567582528e-17
		 -5.2041704279304213e-18 0 -2.8421709430404007e-14 -1.1368683772161603e-13 1.9539925233402755e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[274]" -type "matrix" "xform" 1 1 1 6.371569938022838e-13 5.2863713406737041e-11
		 -1.1385337117362567e-12 0 -2.0962510907311582 -8.2628865146613428 0.79756355079681185 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[275]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.3743454961862737e-13
		 -5.2863990962492473e-11 1.1385337117699468e-12 0 -2.1073618075504328 -8.2670560414176997
		 -0.78861130532133572 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[276]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.9341087475650056 -7.8887793987084285 -1.3696936838415938 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[277]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.9306823487580971 -7.9024038613621483 1.3779603976003294 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[278]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.373236502678969e-13
		 -2.1603543803872017e-07 1.1385337805953517e-12 0 -1.7418699342912305 -8.4869843496898447
		 -0.79823078792583002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[279]" -type "matrix" "xform" 1 1 0.99999999999999933 6.3715687086256627e-13
		 2.1603543798320894e-07 -1.1384226206264102e-12 0 -1.7416859135606728 -8.4870035932095398
		 0.79825373149077394 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[280]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.8406639910366778 -8.0028192385838359 -1.4240631330226121 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[281]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.8405874071773951 -8.002837634097073 1.4240796995612557 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[282]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -1.7237789224739686 -8.8036907272161677
		 -0.0063072443458632964 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[283]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -2.2281032650074337 -8.4906339138507221
		 -0.0083357945227417098 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[284]" -type "matrix" "xform" 1 1 1 -4.4354204941136489e-16 -1.6431944693806747e-10
		 -6.6597161674231131e-09 0 -1.8825256038787472 -7.8514162718883158 -1.558421627436785 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612976018935651 0.49379419236729649 -0.50612817754426698 0.49379573644444624 1
		 1 1 no;
	setAttr ".xm[285]" -type "matrix" "xform" 1 1 1 6.2831853043861097 -3.1685629667824836e-09
		 6.2831853077357485 0 -1.8675766147055697 -7.8926128892540381 -1.5291612942300026 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64305812804792051 0.19111865506375916 -0.67699473568429369 0.30270122479745171 1
		 1 1 no;
	setAttr ".xm[286]" -type "matrix" "xform" 1 1 1 6.2831853057768798 -1.9450387124955158e-09
		 6.2831853085042191 0 -1.8665142437048132 -7.9639889621071527 -1.4469206940003723 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65557417648337579 0.011913804084112078 -0.65207995547049813 0.38062092963207134 1
		 1 1 no;
	setAttr ".xm[287]" -type "matrix" "xform" 1 1 1 6.2831853065749534 -1.1028419841032536e-09
		 6.2831853081667592 0 -1.8407136884509612 -8.0812925426506368 -1.321099832351605 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66143441675356773 -0.085189985898714626 -0.63826999606174195 0.38452384940831497 1
		 1 1 no;
	setAttr ".xm[288]" -type "matrix" "xform" 1 1 1 6.283185307083853 -5.3285271331980662e-10
		 6.2831853076414319 0 -1.7962104843565214 -8.2478767133366233 -1.1312591025739318 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65636076819940237 -0.19668151839946188 -0.6660229843433092 0.29482250018477996 1
		 1 1 no;
	setAttr ".xm[289]" -type "matrix" "xform" 1 1 1 6.2831853071794921 -1.4701712069963894e-12
		 6.2831853071806592 0 -1.7428545598614278 -8.454043694267849 -0.85216878537911978 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6887583188119174 -0.1937555132678557 -0.65499673991219631 0.24300216058727891 1
		 1 1 no;
	setAttr ".xm[290]" -type "matrix" "xform" 1 1 1 6.2831853071796466 -1.3754735198046403e-12
		 1.1927507592712356e-12 0 -1.7177228070475223 -8.6485379619927407 -0.54517255800719666 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67791117584788774 0.25397256167209059 0.64651697239396388 -0.24072843617818168 1
		 1 1 no;
	setAttr ".xm[291]" -type "matrix" "xform" 1 1 1 6.2831853071796742 -1.3304669865821784e-12
		 1.2418364947474585e-12 0 -1.7095304714105737 -8.7439447768268934 -0.33261841471678033 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.66584691905237059 0.27429577238237313 0.649420098353787 -0.24426060979163394 1
		 1 1 no;
	setAttr ".xm[292]" -type "matrix" "xform" 1 1 1 6.2831853071795871 -1.3078626723284087e-12
		 6.2831853071808563 0 -1.7194483528268449 -8.7895647512090065 -0.16174460007928099 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66165950988240652 -0.26336086847177403 -0.64876398882268638 0.26824062471378862 1
		 1 1 no;
	setAttr ".xm[293]" -type "matrix" "xform" 1 1 1 6.2831853071796537 -1.3694982647916425e-12
		 6.283185307180787 0 -1.7329321149119608 -8.8201061450118772 -0.0042007890812100577 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69246881376264713 -0.25147600152334765 -0.62946276891640662 0.24702911806520322 1
		 1 1 no;
	setAttr ".xm[294]" -type "matrix" "xform" 1 1 1 6.2831853071795862 -1.3071332211067599e-12
		 -6.2831853071783161 0 -1.7194493365969663 -8.7895646830348433 0.15407540843549086 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64876198427345444 -0.26824158877185539 -0.6616614725041462 0.26335989371649915 1
		 1 1 no;
	setAttr ".xm[295]" -type "matrix" "xform" 1 1 1 6.2831853071794983 -1.3306985721661121e-12
		 1.2421157852272079e-12 0 -1.709532525858549 -8.743944634455957 0.32692161265999414 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64941808409672175 -0.24426160641853964 -0.66584888980715995 0.27429486984001406 1
		 1 1 no;
	setAttr ".xm[296]" -type "matrix" "xform" 1 1 1 6.2831853071795258 -1.3763842496294563e-12
		 1.1932503596323999e-12 0 -1.7177262186002622 -8.6485386805902777 0.54248745661699793 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6465149150270163 -0.24072937500204919 -0.67791313727458669 0.25397167355683603 1
		 1 1 no;
	setAttr ".xm[297]" -type "matrix" "xform" 1 1 1 6.2831853071796804 -1.4704626405404545e-12
		 -6.2831853071785142 0 -1.7428598916070257 -8.454044279798179 0.85193128699658638 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6549946359894947 0.24300291381025024 0.68876030629496843 -0.19375461588612264 1
		 1 1 no;
	setAttr ".xm[298]" -type "matrix" "xform" 1 1 1 6.2831853072753194 -5.3285290765304997e-10
		 -6.2831853067177406 0 -1.7962175321030998 -8.2478762249357089 1.1312809994200437 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6660209816770758 0.2948232564432568 0.65636277833530976 -0.1966804582109038 1
		 1 1 no;
	setAttr ".xm[299]" -type "matrix" "xform" 1 1 1 6.283185307784219 -1.1028424565449165e-09
		 -6.2831853061924132 0 -1.840721918889443 -8.0812919722905043 1.3211201879297041 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.63826796220002224 0.3845242453439251 0.66143631918145218 -0.085188666144083325 1
		 1 1 no;
	setAttr ".xm[300]" -type "matrix" "xform" 1 1 1 6.2831853085822935 -1.9450384645534075e-09
		 -6.2831853058549534 0 -1.8665232579947997 -7.9639883374269909 1.4469394076853499 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65207791250723812 0.38062100966311407 0.65557613864712228 0.011915093779042596 1
		 1 1 no;
	setAttr ".xm[301]" -type "matrix" "xform" 1 1 1 6.2831853099730637 -3.1685618581130845e-09
		 -6.283185306623424 0 -1.8675861413458961 -7.8926122290685745 1.5291787783869248 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67699271253233562 0.30270071874162335 0.64306018574324142 0.19111969956883793 1
		 1 1 no;
	setAttr ".xm[302]" -type "matrix" "xform" 1 1 1 2.7780763396607956e-16 -1.1148759693213544e-10
		 -4.5184902486283818e-09 0 -1.8825353128066524 -7.8514155990705268 1.5584382854203351 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975964732398 0.49379419289612164 -0.50612817808630073 0.49379573591562304 1
		 1 1 no;
	setAttr ".xm[303]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825256038787472 -7.8514162718883158
		 -1.558421627436785 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[304]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.8948587124511391 -7.8444173295206392
		 -1.5321763594664928 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39662690245854215 -0.45199488038181301 -0.61337259146967793 0.51201737508461975 1
		 1 1 no;
	setAttr ".xm[305]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.9122784361071297 -7.8701407551794054
		 -1.4351866804222122 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34531075875321526 -0.3921319497726255 -0.65360120409052325 0.54753856473148632 1
		 1 1 no;
	setAttr ".xm[306]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795853
		 6.2831853071795862 -6.2831853071795853 0 -1.9380812291148857 -7.9409271871768423
		 -1.2947925508541605 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31220752909447685 -0.36268486817606038 -0.67938606833492221 0.55625598003549714 1
		 1 1 no;
	setAttr ".xm[307]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795862
		 6.2831853071795871 -6.2831853071795871 0 -1.975087508500792 -8.0460690950090807
		 -1.1300509599736959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.30140935602809049 -0.36386870791348802 -0.69238230286542657 0.54530607018340582 1
		 1 1 no;
	setAttr ".xm[308]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795845 0 -2.0401621860136459 -8.2018743957734479 -0.89309135134282558 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31802914751199135 -0.35089191239675305 -0.6669881042438367 0.5752036125969292 1
		 1 1 no;
	setAttr ".xm[309]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795871
		 -6.2831853071795853 0 -2.1161383932623323 -8.3810965537053299 -0.61618121607523502 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39321321601051529 -0.41761555105483644 -0.61004571434593735 0.54664873975889527 1
		 1 1 no;
	setAttr ".xm[310]" -type "matrix" "xform" 1 1 1 6.2831853071795871 6.2831853071795862
		 -6.2831853071795871 0 -2.1742652677366152 -8.4655707124831068 -0.36965220402961513 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.45054194021294525 -0.46587727597940454 -0.5603292069660184 0.51575333605900942 1
		 1 1 no;
	setAttr ".xm[311]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795862 0 -2.2029916703461367 -8.4924568266441369 -0.18224446339057085 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.46684447698938986 -0.47002177105963616 -0.54433894842053732 0.51461721528422433 1
		 1 1 no;
	setAttr ".xm[312]" -type "matrix" "xform" 1 1 1 -12.566370614359172 -1.6564237503326203e-16
		 12.566370614359172 0 -2.2191402248840006 -8.5126716149447432 -0.0060345197239753869 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5210154231410371 -0.5083398673784898 -0.48865441014361111 0.48098895572558131 1
		 1 1 no;
	setAttr ".xm[313]" -type "matrix" "xform" 1 1 1 -9.1962028270220486e-16 -8.2704296969910748e-17
		 12.566370614359171 0 -2.2029321890367441 -8.492528786055118 0.17440806533623612 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.54433759463077147 -0.51461878119465521 -0.46684606036008436 0.47002005174203154 1
		 1 1 no;
	setAttr ".xm[314]" -type "matrix" "xform" 1 1 1 12.566370614359171 7.4891265064436157e-17
		 12.566370614359172 0 -2.1742514249500005 -8.4657100176875062 0.36412567824223924 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.56032790469742466 -0.51575488393289992 -0.45054357494389541 0.4658755477523252 1
		 1 1 no;
	setAttr ".xm[315]" -type "matrix" "xform" 1 1 1 1.1830814106161824e-15 1.7227972520794604e-16
		 12.566370614359174 0 -2.1150330315333292 -8.3790821265202631 0.61877412209008509 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61004457916828103 -0.54665012594444418 -0.39321499765955675 0.41761371726502594 1
		 1 1 no;
	setAttr ".xm[316]" -type "matrix" "xform" 1 1 1 12.566370614359171 2.0860049798621125e-16
		 12.566370614359172 0 -2.0402234834052706 -8.2020127510352054 0.89283242467045199 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66698718996922646 -0.57520477368749168 -0.31803110203459156 0.35088997546629919 1
		 1 1 no;
	setAttr ".xm[317]" -type "matrix" "xform" 0.99999999999999989 1 1 -2.4980018054066022e-16
		 3.6255720647915268e-16 12.566370614359172 0 -1.9750538808291935 -8.0459548058728814
		 1.1302538249888108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69238144193930851 -0.54530726917128136 -0.30141139418492574 0.36386686095672788 1
		 1 1 no;
	setAttr ".xm[318]" -type "matrix" "xform" 0.99999999999999989 1 1 12.566370614359172
		 -2.4806545706468351e-16 12.566370614359172 0 -1.9381093551659774 -7.9409834837403457
		 1.2947041851289773 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67938517528829057 -0.55625717616120429 -0.31220952710024397 0.36268298658126158 1
		 1 1 no;
	setAttr ".xm[319]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 -3.8857805861880469e-16
		 -8.2833045977892613e-17 12.566370614359172 0 -1.9125580899236638 -7.8708159193851843
		 1.4337036903747025 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65360021304210603 -0.54753986080091888 -0.34531267642342445 0.39213010321411845 1
		 1 1 no;
	setAttr ".xm[320]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 12.566370614359172
		 1.2945373939476918e-16 12.566370614359172 0 -1.8938496260620354 -7.8449955301582817
		 1.5343610860101882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61337145460518805 -0.51201886772879657 -0.39662870375810466 0.45199315162998033 1
		 1 1 no;
	setAttr ".xm[321]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825353128066524 -7.8514155990705268
		 1.5584382854203354 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[322]" -type "matrix" "xform" 1 1 1 3.1005292266810725e-08 2.1148490762399202e-07
		 -3.1079389114420901e-08 0 4.8977792049080051 -5.1625618604184824 -3.0255378400541928 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65179301766768583 0.48951258216125237 -0.42813074108507698 0.39018888062503504 1
		 1 1 no;
	setAttr ".xm[323]" -type "matrix" "xform" 1 1 1 0.49834220988984118 0.30627952379061368
		 -0.52909698088640933 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[324]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225656
		 -0.55413068517553654 2.0122308310650965 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[325]" -type "matrix" "xform" 1 1 1 -8.2840640233110677e-10 -2.0433946057473432e-07
		 -7.8271160943146079e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[326]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.901761559953421 -0.44001460413102222
		 2.0127867015537895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[327]" -type "matrix" "xform" 1 1 1 -1.664122574395709e-09 -2.0833728584711331e-07
		 -1.4960872611444271e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[328]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8428479870225871
		 -0.18680962154292047 2.0498306576013867 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[329]" -type "matrix" "xform" 1 1 1 -4.4747798214463139e-09 -2.1481279191168167e-07
		 -3.4359190717270576e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[330]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.651376863175166 0.2190784334356124
		 2.1506761056779968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[331]" -type "matrix" "xform" 1 1 1 -1.0361694732866221e-08 -2.2151459530258195e-07
		 -5.7974875983844382e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[332]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3051931605799645
		 0.6475386998250201 2.3327372183632118 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[333]" -type "matrix" "xform" 1 1 1 -1.7320393411859419e-08 -2.2502606366396108e-07
		 -6.3307502029031801e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[334]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.91435072973679254
		 0.92020894931960129 2.5015859093419888 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[335]" -type "matrix" "xform" 1 1 1 -2.5445130220729105e-08 -2.2532170881614217e-07
		 -4.014963090252103e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[336]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.41712374201814484
		 1.0593653880451939 2.6435531694482233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[337]" -type "matrix" "xform" 1 1 1 -3.190568315011897e-08 -2.2289943559674655e-07
		 9.9402877218481709e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[338]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.083717869653032295
		 1.0397697937033286 2.6871212004845209 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[339]" -type "matrix" "xform" 1 1 1 -3.6079726452084256e-08 -2.1926283188589039e-07
		 8.0179502415478777e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[340]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.58789356729053921
		 0.91744020449246477 2.645443954446506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[341]" -type "matrix" "xform" 1 1 1 -3.7396839938730265e-08 -2.1537079319162405e-07
		 1.6010125581981647e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[342]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0720351163478234 0.67978613269735888
		 2.5040854117433398 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[343]" -type "matrix" "xform" 1 1 1 -3.6216028457075853e-08 -2.1266279747213787e-07
		 2.2657445523747539e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[344]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.4569764020345559 0.37641624804336971
		 2.328854407787091 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[345]" -type "matrix" "xform" 1 1 1 -3.4538128080462249e-08 -2.1165486210934367e-07
		 2.6389732584957976e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[346]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6833247299506056 0.1579125858016539
		 2.20308696024758 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[347]" -type "matrix" "xform" 1 1 1 -3.367774831740739e-08 -2.1142378280090454e-07
		 2.7785074916686697e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[348]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830005 0.063639944138600413
		 2.1502427556486179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[349]" -type "matrix" "xform" 1 1 1 -6.4834891247562247e-10 -2.025742260656978e-07
		 -6.1929112210620829e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[350]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225514
		 -0.55413068517555075 2.012230831065116 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[351]" -type "matrix" "xform" 1 1 1 -1.445557769773017e-09 -2.0185979906885197e-07
		 -1.3155000906206124e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[352]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8506016512536583
		 -0.59243673710301437 2.0335628223445017 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[353]" -type "matrix" "xform" 1 1 1 -4.2411285983377584e-09 -1.997631357588286e-07
		 -3.2927039771929791e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[354]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6364599551777204
		 -0.70627961864414601 2.1078232484508579 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[355]" -type "matrix" "xform" 1 1 1 -9.1443072315415327e-09 -1.9721820002506209e-07
		 -5.4537058067462486e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[356]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3189053392455676
		 -0.84994631869366799 2.2114279058556665 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[357]" -type "matrix" "xform" 1 1 1 -1.6113930557458474e-08 -1.9536765121410154e-07
		 -6.3803359897679159e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[358]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92219956674101411
		 -0.98703341618508489 2.329071840198889 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[359]" -type "matrix" "xform" 1 1 1 -2.569099510587126e-08 -1.9554379646801572e-07
		 -3.8784512095213989e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[360]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.36773835626903661
		 -1.0933495407932128 2.4359116826740372 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[361]" -type "matrix" "xform" 1 1 1 -3.2663938161256452e-08 -1.9813898893499142e-07
		 1.874227962805391e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[362]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.14225480745387031
		 -1.1122214925050571 2.4792086530559612 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[363]" -type "matrix" "xform" 1 1 1 -3.658448467951151e-08 -2.0224406229853182e-07
		 9.434842533308028e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[364]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.63081150567859368
		 -1.0184191038586903 2.446030501026895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[365]" -type "matrix" "xform" 1 1 1 -3.7450513623057725e-08 -2.0592254278816584e-07
		 1.5943511654662818e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[366]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0143511103689953 -0.84258197477461749
		 2.3826599599763405 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[367]" -type "matrix" "xform" 1 1 1 -3.6906885292331896e-08 -2.0836109096952292e-07
		 2.0394194882311313e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[368]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.2768222604636605 -0.63371529019519812
		 2.3106343541978127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[369]" -type "matrix" "xform" 1 1 1 -3.5721108749179831e-08 -2.1009830120158472e-07
		 2.4054550412573915e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[370]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.5095055663478689 -0.38621291736137664
		 2.2416218081692989 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[371]" -type "matrix" "xform" 1 1 1 -3.4551784760320525e-08 -2.1098125107312762e-07
		 2.6399085652106398e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[372]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6700046218427431 -0.15828365563567104
		 2.1857435417215871 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[373]" -type "matrix" "xform" 1 1 1 -3.3677749901210003e-08 -2.1142377802617302e-07
		 2.7785076246352328e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[374]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830076 0.063639944138600413
		 2.1502427556486179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[375]" -type "matrix" "xform" 1 1 1 -7.2270448430293699e-09 -2.1591548370108326e-07
		 -2.0564798882655632e-09 0 0.083717268904223374 1.0397698796430177 2.6871211859469835 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209614 -0.01732673914736188 -0.054206990661288729 0.99527072079149959 1
		 1 1 yes;
	setAttr ".xm[376]" -type "matrix" "xform" 1 1 1 -6.6170082868012172e-11 -5.2777739643744211e-11
		 4.8759722676698461e-12 0 0.14242158253221859 -1.1122180545978608 2.4792041459058893 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274875672208086 0.012855654817866638 -0.074198286521042198 0.99711886723061027 1
		 1 1 yes;
	setAttr ".xm[377]" -type "matrix" "xform" 1 1 1 0.10364137184880047 -0.0053000494540148772
		 0.35836950924492161 0 -1.2997743370483512 0.64071898021839502 2.3341839743222934 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089968452397532442 -0.27124541290781967 -0.032274665279149017 0.95775255130476067 1
		 1 1 yes;
	setAttr ".xm[378]" -type "matrix" "xform" 1 1 1 5.1168433250912356e-08 -2.0984148939156934e-07
		 -0.2654357220276109 0 1.0662731636068834 0.67192514206931264 2.5009029203714821 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.065057965514676644 0.19944902313067039 -0.070024549757776403 0.97523541297808347 1
		 1 1 yes;
	setAttr ".xm[379]" -type "matrix" "xform" 1 1 1 9.2852030667262482e-09 -2.1434760788957048e-07
		 2.5393769589002867e-08 0 -0.91942591903668713 -0.98083258183578437 2.3247648013731599 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258928005 -0.094092400772244497 -0.081393910043315199 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[380]" -type "matrix" "xform" 1 1 1 -1.5310318264371994e-07 -1.4762871270962601e-07
		 0.73374126969787457 0 1.2767232674260036 -0.63316612625669677 2.3114565207102906 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.036310446668287463 0.18874460055130868 -0.068116033193234712 0.97898786164461427 1
		 1 1 yes;
	setAttr ".xm[381]" -type "matrix" "xform" 1 1 1 -4.2188058602083735e-11 -3.2005124245332403e-11
		 -2.3731962568905957e-12 0 -1.8415442721152147 0.53882220307929174 2.1607462442420857 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18364789511409785 -0.16327168456973754 0.38197916478446375 0.89090275861537493 1
		 1 1 yes;
	setAttr ".xm[382]" -type "matrix" "xform" 1 1 1 -3.0767520475764811e-11 -4.3098710364489831e-11
		 -2.3855995297559274e-12 0 -1.4782201886627462 0.92915995471909696 2.2581012505222482 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279457351529084 -0.2041408319858658 0.24397191038610644 0.9339711743371133 1
		 1 1 yes;
	setAttr ".xm[383]" -type "matrix" "xform" 1 1 1 -1.6787268623748906e-11 -5.0222976060081451e-11
		 -2.3520895106937167e-12 0 -1.008194076838091 1.233727124026359 2.4101979372509081 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003998754952359 -0.13325847765132248 0.097328953220419082 0.98013287575673647 1
		 1 1 yes;
	setAttr ".xm[384]" -type "matrix" "xform" 1 1 1 -7.2335366862393327e-12 -5.2457873656918142e-11
		 -2.3850223009925876e-12 0 -0.43756942257016007 1.3740585931925295 2.5662376537978169 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08782850160250745 -0.073005731704837012 0.00062653087303683047 0.993456554109723 1
		 1 1 yes;
	setAttr ".xm[385]" -type "matrix" "xform" 1 1 1 5.2679770268906823e-12 -5.2691570182575559e-11
		 -2.5386290293527681e-12 0 0.088691852656662462 1.377613015388846 2.6357312381437197 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179930946433952 0.025570101570747766 -0.12537050949400147 0.98885035438931446 1
		 1 1 yes;
	setAttr ".xm[386]" -type "matrix" "xform" 1 1 1 1.3623394079581829e-11 -5.1171582596246253e-11
		 -2.8304164571157472e-12 0 0.64581895626352193 1.2361821128119459 2.6147490036525944 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08302621016941017 0.12036288508314086 -0.21035049969512737 0.96662924205580381 1
		 1 1 yes;
	setAttr ".xm[387]" -type "matrix" "xform" 1 1 1 2.2817220335443616e-11 -4.7786045953532938e-11
		 -3.1074587353197541e-12 0 1.1910360206362576 0.97244359768617983 2.5037355652675011 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199138466527528 0.17192327577532207 -0.3005309751392517 0.93258848249514259 1
		 1 1 yes;
	setAttr ".xm[388]" -type "matrix" "xform" 1 1 1 3.3207575578308265e-11 -4.1248282567290161e-11
		 -3.7326114428380778e-12 0 1.6303005776548574 0.62516010491745533 2.3474455111359305 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214051530672434 0.24209093085439834 -0.40455846701440484 0.87035653721526351 1
		 1 1 yes;
	setAttr ".xm[389]" -type "matrix" "xform" 1 1 1 3.9991121525488847e-11 -3.4710595508887009e-11
		 -4.0915881800719941e-12 0 1.88607497790764 0.27366056866094368 2.2146113775048288 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383053603373361 0.25974188268956622 -0.47782105644473855 0.82097754971566561 1
		 1 1 yes;
	setAttr ".xm[390]" -type "matrix" "xform" 1 1 1 1.0408403104515979e-17 -5.2954076887323787e-11
		 -2.3510429714157514e-12 0 1.9903089863693886 0.073126376516910341 2.150529464487267 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018783301713158 -0.1622475379965643 -0.060171158694305706 0.98097291596736969 1
		 1 1 yes;
	setAttr ".xm[391]" -type "matrix" "xform" 1 1 1 -0.00020942154066701382 0.00064656522961714733
		 0.0011213558940740124 0 -1.8415442721152644 0.53882220307920647 2.1607462442420982 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635703914590389 -0.10419109701550218 0.39729100105206633 0.90974028557414954 1
		 1 1 yes;
	setAttr ".xm[392]" -type "matrix" "xform" 1 1 1 -4.859151275138007e-13 -5.2946289713640734e-11
		 -2.4756672406405371e-12 0 0.090138694212775761 1.3933507902455062 2.6435101973089505 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490162301620583 -0.07397825714305363 -0.059407940992506889 0.99189683258459549 1
		 1 1 yes;
	setAttr ".xm[393]" -type "matrix" "xform" 1 1 1 -0.00040368505052095269 -0.00045044459247356976
		 -0.0012710992754142753 0 1.8940854349569634 0.27923234072866876 2.2118679046868692 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671788206761885 0.085969143739353798 -0.38565737410528028 0.91839554294175296 1
		 1 1 yes;
	setAttr ".xm[394]" -type "matrix" "xform" 1 1 1 5.7762735572936142e-13 -5.2954184440178638e-11
		 -2.2790319978580338e-12 0 -1.9005620307747684 -0.5518137729151249 2.0009549927581158 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892722284055417 -0.039558279527996974 -0.070604718981914047 0.99351259131644254 1
		 1 1 yes;
	setAttr ".xm[395]" -type "matrix" "xform" 1 1 1 1.9381733676761222e-08 -5.2953749651655156e-11
		 -1.6403846437959249e-08 0 1.7739757398722382 0.063860529367332219 2.1504218347892703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537172867420804 0.26549863850734806 -0.09161642970614664 0.95819757854748955 1
		 1 1 yes;
	setAttr ".xm[396]" -type "matrix" "xform" 1 1 1 -3.1005296175097963e-08 -2.1148490693792196e-07
		 3.1079396559751079e-08 0 4.8974606715216282 -5.1625538842295233 3.0255988686508091 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.48951389000388029 -0.65179176827743435 -0.39018721510704873 -0.42813266573113745 1
		 1 1 no;
	setAttr ".xm[397]" -type "matrix" "xform" 1 1 1 6.283185307139437 -1.691866915670064e-10
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1.0275841211271339e-07 0 0.99999999999999467 1
		 1 1 yes;
	setAttr ".xm[398]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407374 0.55361168484853351
		 -2.012150500121642 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[399]" -type "matrix" "xform" 1 1 1 6.2831834777536537 -7.6260061262469617e-06
		 -6.2831870313297804 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[400]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9017475930669789 0.43989678048490077
		 -2.0127687111993176 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[401]" -type "matrix" "xform" 1 1 1 6.283192743436123 -2.4064184400022912e-05
		 -6.2831786216370435 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[402]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.8427478699924755 0.18611709322672709
		 -2.0497229357518041 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[403]" -type "matrix" "xform" 1 1 1 -9.4247607596253147 3.1416441391713117
		 3.1416058582721185 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[404]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6513189699522393 -0.21949107321481165
		 -2.1506126723226746 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[405]" -type "matrix" "xform" 1 1 1 -3.1415612628268654 3.1416730457082229
		 3.141610217482913 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[406]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3052215051098592 -0.64737534197141144
		 -2.3327639497827963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[407]" -type "matrix" "xform" 1 1 1 -3.141565465772318 3.1416722639098977
		 3.1416025906685041 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[408]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.91437234838192438
		 -0.92013477945110367 -2.5016174983116439 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[409]" -type "matrix" "xform" 1 1 1 -3.1415723290649904 3.1416376445391214
		 3.1415958561675876 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[410]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.41701125790985216
		 -1.0601170330202194 -2.6434264207041664 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[411]" -type "matrix" "xform" 1 1 1 1.7425805181374886e-05 6.2831825452840677
		 -5.4245412396542647e-07 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[412]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.083744097464116152
		 -1.0399260121631357 -2.6870785872144829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[413]" -type "matrix" "xform" 1 1 1 1.2693526097136423e-05 6.283214088528303
		 -2.8122587644200276e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[414]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.58794971646821637
		 -0.9178402388111806 -2.6453821064307608 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[415]" -type "matrix" "xform" 1 1 1 1.5381657927121628e-05 6.2832188663890669
		 -6.5651340723563942e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[416]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0720354286874141
		 -0.67981279993915678 -2.5040824246573692 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[417]" -type "matrix" "xform" 1 1 1 8.3656757013608564e-06 6.2832054104990904
		 -5.2010808494964904e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[418]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.4570052721775646
		 -0.37663416137027639 -2.3288206309923876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[419]" -type "matrix" "xform" 1 1 1 5.4110698190280008e-06 6.2831907162611085
		 -4.1141251738219395e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[420]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6833662884828087
		 -0.15821562273086442 -2.2030402065381178 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[421]" -type "matrix" "xform" 1 1 1 5.4871734328989679e-08 6.2831855193676329
		 2.424508580468098e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[422]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758332
		 -0.063688645826516677 -2.1502361142816575 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[423]" -type "matrix" "xform" 1 1 1 6.283185307139437 2.0534763752778872e-07
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[424]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407445 0.55361168484856194
		 -2.0121505001216349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[425]" -type "matrix" "xform" 1 1 1 6.2831857368727118 -9.6775282638451468e-07
		 -6.2831849161452924 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[426]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.850494206942777 0.59169526363584168
		 -2.0334476430835586 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[427]" -type "matrix" "xform" 1 1 1 6.2831870256632865 -2.7747909729560291e-06
		 -6.2831839729904075 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[428]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6364648755525515 0.70628849354667977
		 -2.1078251817848361 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[429]" -type "matrix" "xform" 1 1 1 6.2831887525327561 -3.4914099042060667e-06
		 -6.2831832523585769 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[430]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3188063863827146 0.84926055027781899
		 -2.2113213665086953 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[431]" -type "matrix" "xform" 1 1 1 6.283186499846197 -7.6909015776679209e-07
		 -6.2831848349460371 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[432]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92212606378262052
		 0.9865173671582852 -2.3289921614483173 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[433]" -type "matrix" "xform" 1 1 1 6.2831814995216435 2.1715219251396469e-05
		 -6.2831858857056826 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[434]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.36766900114157508
		 1.0928620039817076 -2.4358357948869713 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[435]" -type "matrix" "xform" 1 1 1 6.2831550232537685 6.9571799983719759e-05
		 1.7396942165332526e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[436]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.14222208218171062
		 1.1124159575755357 -2.4792399288635174 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[437]" -type "matrix" "xform" 1 1 1 6.2831297046218744 0.00011709473560854273
		 1.4350585037239655e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[438]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.63086954984229138
		 1.018008392816057 -2.4459668606990306 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[439]" -type "matrix" "xform" 1 1 1 6.2831124886687117 0.00013760109368610648
		 3.1022076281352182e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[440]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0144414120572804
		 0.84195399111771962 -2.3825621868996532 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[441]" -type "matrix" "xform" 1 1 1 6.2831085925143197 0.00013233797747792705
		 4.2422124632536497e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[442]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2768198175289776
		 0.63370445935751718 -2.3106336851512452 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[443]" -type "matrix" "xform" 1 1 1 6.2831274499323984 9.9294363699924888e-05
		 3.8927715753699082e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[444]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.509568013397292 0.38577221615099688
		 -2.2415536902277644 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[445]" -type "matrix" "xform" 1 1 1 12.566339093615564 5.3566477875247642e-05
		 6.2832094222993158 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[446]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6700909513003346
		 0.15768375781621558 -2.185650057238286 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[447]" -type "matrix" "xform" 1 1 1 5.4871726338854156e-08 6.2831855193676382
		 2.4252473123899102e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[448]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758403
		 -0.063688645826545098 -2.1502361142816628 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[449]" -type "matrix" "xform" 1 1 1 7.2270430958825361e-09 2.1591548446684657e-07
		 2.0564790140118618e-09 0 -0.08374469820877195 -1.0399259262240435 -2.687078601751189 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209892 -0.017326739147361585 -0.054206990661288007 0.9952707207914997 1
		 1 1 yes;
	setAttr ".xm[450]" -type "matrix" "xform" 1 1 1 4.4155530427770434e-09 5.2777770446013385e-11
		 -4.8764757071011789e-12 0 -0.14246364064053552 1.111925119629916 -2.4791563476353051 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274720089168961 0.012855868281954794 -0.074198315184487218 0.99711886248793169 1
		 1 1 yes;
	setAttr ".xm[451]" -type "matrix" "xform" 1 1 1 -8.255627292896861e-08 -3.1415924552526793
		 -2.2864956150669968e-08 0 1.2997323877743199 -0.64101202232799892 -2.3341367938949915 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087241177286391219 -0.24582379979002997 0.15223950242423173 0.9533009862284304 1
		 1 1 yes;
	setAttr ".xm[452]" -type "matrix" "xform" 1 1 1 4.8377458483628288e-08 -3.1415924437483032
		 4.9291246639882047e-09 0 -1.0663151974821972 -0.67221804415686393 -2.5008549191160636 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090878646671435137 0.18908602085785248 -0.19846026990574109 0.95739285017397791 1
		 1 1 yes;
	setAttr ".xm[453]" -type "matrix" "xform" 1 1 1 1.7252994588545789e-09 -3.141592439242185
		 -2.5393772418169647e-08 0 0.91938398463565107 0.98053956659313712 -2.3247174258871564 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258927571 -0.094092400772244747 -0.081393910043314976 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[454]" -type "matrix" "xform" 1 1 1 -1.5351977022959318e-07 -3.1415925059610723
		 -3.7962259114010521e-08 0 -1.2767648498227935 0.63287314458960964 -2.3114085656174659 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10159609039787926 0.16316006616322959 0.28757587279425023 0.93827349137237259 1
		 1 1 yes;
	setAttr ".xm[455]" -type "matrix" "xform" 1 1 1 4.2188481874687819e-11 3.2005471189927497e-11
		 2.37230547773593e-12 0 1.8415064518602078 -0.53897067132891152 -2.1606717130969457 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.1836477917828139 -0.16327150229346379 0.3819791708688603 0.89090281071195965 1
		 1 1 yes;
	setAttr ".xm[456]" -type "matrix" "xform" 1 1 1 3.0767874359456707e-11 4.3099150984179343e-11
		 2.3848154360708408e-12 0 1.4782174567261905 -0.93053018598536141 -2.2577112041161485 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279449930527945 -0.20414063697037549 0.24397190945446856 0.93397123014063621 1
		 1 1 yes;
	setAttr ".xm[457]" -type "matrix" "xform" 1 1 1 1.6787461178172851e-11 5.0223528677889282e-11
		 2.3515344068007828e-12 0 1.0079696133229659 -1.2364652224000565 -2.4095905251895697 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003994071765356 -0.13325826996625711 0.097328941894998411 0.98013291037596306 1
		 1 1 yes;
	setAttr ".xm[458]" -type "matrix" "xform" 1 1 1 7.2336303614321482e-12 5.2458536646529363e-11
		 2.3849944373762158e-12 0 0.4370771531536124 -1.377367917365433 -2.5656936294083401 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087828472935711638 -0.073005518894025734 0.0006265163043274128 0.99345657229197259 1
		 1 1 yes;
	setAttr ".xm[459]" -type "matrix" "xform" 1 1 1 -5.2680360073551046e-12 5.2692179178949222e-11
		 2.5384707355580039e-12 0 -0.089247510662981977 -1.3809657735308178 -2.6351800514961585 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179926004818169 0.025570316952063965 -0.1253705233265395 0.98885034744682221 1
		 1 1 yes;
	setAttr ".xm[460]" -type "matrix" "xform" 1 1 1 -1.362354673510289e-11 5.1172803841611895e-11
		 2.8298578754593399e-12 0 -0.64645207588672626 -1.2389449794704319 -2.614164119697179 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.083026220942287066 0.12036309861276841 -0.21035050844990655 0.96662921263700774 1
		 1 1 yes;
	setAttr ".xm[461]" -type "matrix" "xform" 1 1 1 -2.2817553402202499e-11 4.7786892498660126e-11
		 3.1079167012270498e-12 0 -1.1916738483654097 -0.97488500632479713 -2.5031910497689172 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199141396272945 0.1719234854915308 -0.3005309772264117 0.93258843995712515 1
		 1 1 yes;
	setAttr ".xm[462]" -type "matrix" "xform" 1 1 1 -3.3207964156212918e-11 4.1248379711928763e-11
		 3.7328889972244691e-12 0 -1.6307371394187653 -0.62669016381025244 -2.347062232367163 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214056635292294 0.2420911318830031 -0.40455845650067002 0.87035647784931902 1
		 1 1 yes;
	setAttr ".xm[463]" -type "matrix" "xform" 1 1 1 -3.9992231748371436e-11 3.4711039598260505e-11
		 4.0925318682547815e-12 0 -1.8861537960163437 -0.27451522969829512 -2.2145073519171703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383060355622937 0.25974207653192272 -0.47782103714693691 0.82097748532221482 1
		 1 1 yes;
	setAttr ".xm[464]" -type "matrix" "xform" 1 1 1 -1.8041117925524469e-16 5.2954923432380057e-11
		 2.350918071325475e-12 0 -1.9901188991541003 -0.07355444937721245 -2.1506127682602347 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018770653616712 -0.16224732593480973 -0.060171175601813162 0.98097295113898286 1
		 1 1 yes;
	setAttr ".xm[465]" -type "matrix" "xform" 1 1 1 -0.00020935370173638714 0.000646535944230735
		 0.0011213569858792456 0 1.8415022460801751 -0.53911528115796159 -2.1606993877420653 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635812904552347 -0.10419091882317158 0.39729095672071563 0.90974031807770606 1
		 1 1 yes;
	setAttr ".xm[466]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 1 4.8561675520700063e-13 5.2946981868306453e-11 2.475271723713735e-12 0 -0.09018097762430699
		 -1.3936437182729549 -2.643462576570407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490146409749334 -0.073978042904410513 -0.059407956248894334 0.99189684900297059 1
		 1 1 yes;
	setAttr ".xm[467]" -type "matrix" "xform" 1 1 1 -0.000403610907061532 -0.000450427601655768
		 -0.0012711010462760047 0 -1.8941274664792758 -0.2795251833647967 -2.211819451642576 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671737794658616 0.085969349280733631 -0.38565740435772389 0.9183955121323597 1
		 1 1 yes;
	setAttr ".xm[468]" -type "matrix" "xform" 1 1 1 1.1733102774948214e-08 5.2954895663435723e-11
		 2.2788033250065268e-12 0 1.900507324931457 0.55143386844616771 -2.0008900762192354 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892713468937018 -0.039558064329149753 -0.070604734425650101 0.99351259949624415 1
		 1 1 yes;
	setAttr ".xm[469]" -type "matrix" "xform" 1 1 1 7.6044138828766526e-09 5.2954477517670043e-11
		 -1.6400808634596416e-08 0 -1.7739559364336124 -0.063729916002699838 -2.1504440386576462 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537148639359559 0.26549884514744027 -0.09161644128664588 0.9581975215630828 1
		 1 1 yes;
	setAttr ".xm[470]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.5915750767282191 -9.2818264498213523
		 -1.1534880686784996 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64363684588735537 0.41682505669272873 -0.36208451121158108 0.52998423511454607 1
		 1 1 no;
	setAttr ".xm[471]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.8337191568088542 -9.1870481363271033
		 -1.7167633873436821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61642871162872426 0.43518963307226322 -0.39157607613074635 0.52658693807217416 1
		 1 1 no;
	setAttr ".xm[472]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0444083914252076 -9.1039067135571727
		 -2.3471022522914278 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62188391732851445 0.47247700980397356 -0.38995912234872376 0.48780913426446854 1
		 1 1 no;
	setAttr ".xm[473]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.234552859380841 -8.9459321480848182
		 -3.0683367309514535 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64168255502320148 0.49811503910081212 -0.36887102762533897 0.45172898000805622 1
		 1 1 no;
	setAttr ".xm[474]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4270119939492929 -8.6916776346774398
		 -3.8355955456947233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64878746840716661 0.54451986867036606 -0.35167433360611811 0.39862024101106558 1
		 1 1 no;
	setAttr ".xm[475]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5452645532116378 -8.3759951317221315
		 -4.4951554490413859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6445427653902942 0.59357124520206972 -0.33510087316810716 0.34633106308021078 1
		 1 1 no;
	setAttr ".xm[476]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5940869418139698 -8.0082101606394041
		 -5.0768733443424905 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61698848935560613 -0.68501063281675922 0.29416559189051417 -0.25209569904775003 1
		 1 1 no;
	setAttr ".xm[477]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5102178515226967 -7.4841715353962703
		 -5.6094822277796474 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58988744759981515 -0.75044903532326779 0.23882949243968127 -0.17838026260647855 1
		 1 1 no;
	setAttr ".xm[478]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3231279971573144 -6.8615237398363567
		 -6.0370766530067455 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69509540550453952 0.67815590284734562 -0.17080820677032965 0.16664784780994155 1
		 1 1 no;
	setAttr ".xm[479]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.591567890365809 -9.281825951815577
		 1.1535519073689353 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41682678573717025 -0.64363583240600963 -0.52998279777602875 -0.36208642614234421 1
		 1 1 no;
	setAttr ".xm[480]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.827736044453701 -9.1932244021217073
		 1.7200965521217058 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.43519135790030139 -0.61642760554878873 -0.52658544940181073 -0.39157790234456746 1
		 1 1 no;
	setAttr ".xm[481]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0416263359323068 -9.0953952317671671
		 2.3465259188539829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47247861349105658 -0.62188280791458672 -0.48780752826761631 -0.38996095750635934 1
		 1 1 no;
	setAttr ".xm[482]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4212459635155028 -8.6820597606841829
		 3.8330491390015489 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54452118627198365 -0.64878645899644094 -0.39861840479573157 -0.35167623701626072 1
		 1 1 no;
	setAttr ".xm[483]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2333822087389308 -8.9417385609598981
		 3.06756760661741 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.4981165258469773 -0.64168150350957542 -0.45172728987584854 -0.3688729189209331 1
		 1 1 no;
	setAttr ".xm[484]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5426726920976819 -8.3717750511885107
		 4.4932499366907726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59357239634656755 -0.64454179631808617 -0.34632907498779958 -0.33510275276777873 1
		 1 1 no;
	setAttr ".xm[485]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5804144182153834 -7.9972095573383752
		 5.0681593923931487 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.68501148158394198 0.61698762745372138 0.25209343207274298 0.29416736592114684 1
		 1 1 no;
	setAttr ".xm[486]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.50350089676121 -7.4777487740598909
		 5.5994849728088294 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.75044964252362167 0.58988674215589432 0.17837779764324985 0.2388311679258335 1
		 1 1 no;
	setAttr ".xm[487]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3230903863112644 -6.861521133447007
		 6.037144004283026 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67815645881857545 0.69509490941182561 0.16664558532716539 0.17081022558202422 1
		 1 1 no;
	setAttr ".xm[488]" -type "matrix" "xform" 1 1 1 -6.94626294870168e-17 5.1124975364302835e-09
		 1.6258070612007458e-08 0 5.5915750828797286 -9.2818262008181733 -1.1534905420038315 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.57008357847228652 0.41833620676040645 -0.57008179842243811 0.41833751299278132 1
		 1 1 no;
	setAttr ".xm[489]" -type "matrix" "xform" 1 1 1 -5.2347015614236926e-13 -5.2863935451341294e-11
		 1.1958212198375924e-12 0 6.4212685080667882 -8.6820605052311421 -3.8329827384701094 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59884764109944522 0.58425295472417371 -0.39206449597387255 0.38251198496577321 1
		 1 1 no;
	setAttr ".xm[490]" -type "matrix" "xform" 1 1 1 -1.1360357099646383e-12 -5.2863824429038779e-11
		 6.4115379675105551e-13 0 6.3231280293178997 -6.8615224366417022 -6.0370785999793464 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69229959826107823 0.67542819395830289 -0.18180850502978574 0.17738006808153359 1
		 1 1 no;
	setAttr ".xm[491]" -type "matrix" "xform" 1 1 1 9.29738472916946e-16 -5.1125492173120699e-09
		 -1.6258055013373962e-08 0 5.5910963223046792 -9.2816699913087817 1.1535494445110896 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.41833660886893093 0.57008246188149481 0.41833530263937935 0.57008424193341456 1
		 1 1 no;
	setAttr ".xm[492]" -type "matrix" "xform" 1 1 1 5.2169379923974139e-13 5.2863824429039439e-11
		 -1.1962653090198163e-12 0 6.4211081908840413 -8.6820979314971503 3.8330420344877867 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58425431348311907 0.5988465870770513 0.38250990957457948 0.39206610590534852 1
		 1 1 no;
	setAttr ".xm[493]" -type "matrix" "xform" 1 1 1 1.1363132656868772e-12 5.2864435051703047e-11
		 -6.4204197511069275e-13 0 6.322977984395493 -6.8615236890383668 6.037141728287307 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6754288240451688 0.69229910948735618 0.17737766881810094 0.18181036619684324 1
		 1 1 no;
	setAttr ".xm[494]" -type "matrix" "xform" 1 1 1 3.8857805861880479e-16 -1.1102230246251568e-16
		 1.1102230246251563e-16 0 1.495428866347595 -7.2689254591411965 -4.7917412416201888 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66648149151545732 -0.51538575008480991 0.47835595225089356 -0.24770049055863874 1
		 1 1 no;
	setAttr ".xm[495]" -type "matrix" "xform" 1 1 1 7.4024120153676099e-13 5.2636672798202689e-11
		 -5.0178750043788385e-12 0 1.4953990139619009 -7.2689233898976573 4.791778693941005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60531135036067751 0.64530882279232671 0.30095010597674293 0.35581417350001959 1
		 1 1 no;
	setAttr ".xm[496]" -type "matrix" "xform" 1 1 1 2.7755575632105181e-16 9.0150109599562194e-14
		 3.6552982862758646e-12 0 0.75632669249665696 -8.806608677981508 1.6755937096558037e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[497]" -type "matrix" "xform" 1 1 1.0000000000000002 0.18929270062667797
		 9.0165490181700516e-14 3.6553101812596358e-12 0 -0.57788721563673562 -6.3299602678278584
		 1.2065149448500139e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[498]" -type "matrix" "xform" 1 1 1 2.4999769986678032e-16 -5.2864032509432428e-11
		 1.3046305120116952e-12 0 2.7626215921599648 0.13552840493653662 -1.6028016275437693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094505107667796004 -1.0760925916377254e-07 9.1386232877953759e-09 0.99552437671042815 1
		 1 0.99999999999999978 no;
	setAttr ".xm[499]" -type "matrix" "xform" 1 1 1 1.8754747393352533e-16 -5.2233709371485339e-11
		 8.2430333753187757e-12 0 -3.7847003367119197e-07 -0.07801570437288774 1.7945141948880554 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.028719491485545857 -1.0677350968429597e-07 1.6207551421166537e-08 0.99958751033053628 1
		 1 0.99999999999999978 no;
	setAttr ".xm[500]" -type "matrix" "xform" 1 1 1 -8.602253271174304e-16 5.2864152786734516e-11
		 -1.3046074685068644e-12 0 -2.7626196645013401 0.13572391530999539 -1.6028359655176878 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99552437671042815 9.1386232877954073e-09 1.0760925916377248e-07 0.094505107667795768 1
		 1 0.99999999999999978 no;
	setAttr ".xm[501]" -type "matrix" "xform" 1 1 1 0.2624680135684086 3.1965137486376539e-14
		 1.3028000587699907e-12 0 -1.8685434565056482 -5.6773791186242102 7.9032646361304687e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[502]" -type "matrix" "xform" 1 1 1 -7.2150406547701684e-16 3.4473903877621093e-17
		 1.3047401308268929e-12 0 2.6266441606518613 0.070830992159642392 -1.2832055548392702 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129724 -1.0720295509604647e-07 1.3068799426625743e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[503]" -type "matrix" "xform" 1 1 1 0.4082714640584762 3.447389712066404e-17
		 1.3047401307979626e-12 0 -4.2002976708392941e-07 0.14396607244674442 1.9711992067807955 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129733 -1.0720295509604645e-07 1.3068799426625749e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[504]" -type "matrix" "xform" 1 1 1 -4.4394831262548391e-16 8.3796731243561907e-17
		 -1.3047083555174597e-12 0 -2.6266436315536201 0.070830461190809046 -1.2832075745338258 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99140116938230771 1.3068799426625761e-08 1.0720295509604644e-07 0.13085763771129721 1
		 1 1 no;
	setAttr ".xm[505]" -type "matrix" "xform" 1 1 1 -0.55802535373957873 -0.86235996928280023
		 0.37113427545726307 0 -2.142966561689434 -6.3020949920387741 -3.6431927373101844 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72952498310547087 -0.58947769198180122 0.33048263278386492 -0.1053118184679015 1
		 1 1 no;
	setAttr ".xm[506]" -type "matrix" "xform" 1 1 1 -0.55802560820066893 -0.8623603446012863
		 0.37113460705176132 0 -2.1428273734635752 -6.301980721854906 3.6432410976005833 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58947809063799661 0.72952397662169755 0.10530982318633428 0.33048477927479436 1
		 1 1 no;
	setAttr ".xm[507]" -type "matrix" "xform" 1 1 1 -6.5231069736441992e-08 -1.2229472208344874e-08
		 -1.328371922431916e-08 0 5.1598859727164381e-06 1.2468008989685586e-06 1.6550885445151819e-11 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[508]" -type "matrix" "xform" 1 1 1 4.3181583572549488e-07 3.0053109731673356e-10
		 -8.4867158606452038e-07 0 3.8945085470691083 5.070714856003633e-05 1.2383109652697871e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[509]" -type "matrix" "xform" 1 1 1 1.4950003389690157e-06 3.2791962651043259e-09
		 7.7345600245272222e-07 0 7.7890216926664664 0.00010251789687742985 2.6258098901601676e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[510]" -type "matrix" "xform" 1 1 1 -0.00077547738423497435 0.090417237835238334
		 -0.017141201898906815 0 13.363890593036812 1.4372147948893783 -6.0925967608967495 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.29674085579966925 -0.072556452995173229 -0.90237946084669252 0.30396008663979535 1
		 1 1 yes;
	setAttr ".xm[511]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[512]" -type "matrix" "xform" 1 1 1 4.1633363423443375e-16 -1.3877787807814412e-17
		 -2.2204460492503131e-16 0 9.4595187974194772 1.0716760400088674 -5.3028283221497432 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18679828651183841 0.3428633420922797 -0.12293018645729969 0.91238111448184156 1
		 1 1 yes;
	setAttr ".xm[513]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.753460999056756 1.4210854715202004e-14
		 -3.907985046680551e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[514]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.7654831981509034 0
		 1.2434497875801753e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[515]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[516]" -type "matrix" "xform" 1 1 1 -5.9834680001711395e-09 6.1297348175798586e-10
		 2.9696373512327469e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.29491121738262233 -0.78941577506998695 -0.22136537116205757 -0.49076214236922971 1
		 1 1 yes;
	setAttr ".xm[517]" -type "matrix" "xform" 1 1 1 5.5511151231258014e-16 2.0539125955565392e-15
		 1.8596235662471376e-15 0 4.2217770159966861 -0.43249790135706689 -0.20952977089794089 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.19526362041306367 0.98075079329215076 1
		 1 1 yes;
	setAttr ".xm[518]" -type "matrix" "xform" 1 1 1 0.0041896447755215734 -0.15349829127575432
		 -0.054468196627642268 0 13.539495298871033 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19378466263256422 -0.064469339669166695 -0.92506382426677092 0.32023136917538486 1
		 1 1 yes;
	setAttr ".xm[519]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[520]" -type "matrix" "xform" 0.99999988079071045 1 1 0.16168690515675491
		 1.1886835758738338e-15 6.5014699993595287e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 1 -0.64957844548541277 -0.31610924763916659 0.67361757392455257 -0.15608379421885649 1
		 1 1 yes;
	setAttr ".xm[521]" -type "matrix" "xform" 1 1 1 0 0 0 0 -5.3178290533725026
		 -3.918306651362613e-14 1.0269562977782698e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.040901237501683091 -0.10049288483265671 0.33925400923495591 0.93441692305247215 1.0000001192093038
		 1 1 yes;
	setAttr ".xm[522]" -type "matrix" "xform" 1 1 1 0.00065992617226282263 -0.12604240715274512
		 -0.010457532561554423 0 13.363890593036814 1.4372147948893783 -6.0925967608967504 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.52309622362027819 -0.79625546307504325 -0.056206447644327834 0.29864429276408061 1
		 1 1 yes;
	setAttr ".xm[523]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[524]" -type "matrix" "xform" 1 1 1 -0.0017390185854515162 0.18701234659205648
		 -0.01854314004582595 0 13.539495298871032 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52156514552747757 0.77998608375093237 -0.10622780617703403 0.3291005337592135 1
		 1 1 yes;
	setAttr ".xm[525]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[526]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[527]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[528]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.1278504909219862
		 -6.9040537706030758 4.4577838808432881e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[529]" -type "matrix" "xform" 1 1 1 0 0 -1.7347234759768071e-18 0 -2.3598245839357759
		 -6.9968577821554048 2.8582904152448743e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[530]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345595731
		 0.19315413354009436 -7.9999999999999991 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.046101807560602462 -0.99887540111039552 -0.0019555817656306046 0.010896425842871192 1
		 1 1 yes;
	setAttr ".xm[531]" -type "matrix" "xform" 1 1 1 0 0 0 0 50.884879303655445 -6.9388939039072284e-16
		 2.6645352591003757e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.041604680783302275 0.99913415042071274 1
		 1 1 yes;
	setAttr ".xm[532]" -type "matrix" "xform" 1 1 1 0 0 0 0 43.0893684535707 2.6645352591003757e-15
		 4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.04987531894619833 0.99875545182993364 1
		 1 1 yes;
	setAttr ".xm[533]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.0708992880109598 -12.614425958600854
		 -7.9936057773011271e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.61843902098991788 0.78583279221284219 1
		 1 1 yes;
	setAttr ".xm[534]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[535]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 0.0012413669866422339
		 2.5158018416556076 -9.8983505836258701e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[536]" -type "matrix" "xform" 1 1 1 4.4564903616485817e-17 7.5176908324114549e-09
		 3.2196467715804674e-15 0 0 -1.7763568394002505e-15 -8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[537]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.7755575615628914e-16 0 -0.18599651324030475 -4.466696168286358 -4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668544 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[538]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.7755575615628914e-16 0 0.18779704740523329 4.5099358985119951 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668544 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[539]" -type "matrix" "xform" 1 1 1 -2.175278136723275e-16 -3.8921911082563932e-09
		 -6.6613381435176405e-16 0 14.363123245911318 -1.7763568394002505e-15 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[540]" -type "matrix" "xform" 1 1 1 1.7161041695030145e-16 -5.0587262850384354e-10
		 1.1102230241910913e-16 0 28.726246491822632 0 1.7763568394002505e-15 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[541]" -type "matrix" "xform" 1 1 1 -8.4447832536887831e-17 1.9460082006017018e-08
		 6.6613381395341305e-16 0 -2.8421709430404007e-14 -2.4980018054066022e-16 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[542]" -type "matrix" "xform" 1 1 1 0 4.0592526690879326e-16 0 0 0.79993655503660932
		 8.8770532069966901 0.0071619148329844506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.004476417234014666 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[543]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 2.3931518875712356
		 -6.8856854788981927 0.021426136727047407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.004476417234014666 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[544]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 -0.057243470674194441
		 -9.1593399531575415e-16 6.3937013769780924 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.004476417234014666 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[545]" -type "matrix" "xform" 1 1 1 1.7734161856919416e-16 4.0058494094022555e-09
		 -9.9920072180743891e-16 0 16.961626940047651 -2.7755575615628914e-17 2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[546]" -type "matrix" "xform" 1 1 1 7.4599792225601508e-17 3.101180949689185e-09
		 -5.5511151219690454e-16 0 33.923253880095373 -2.4980018054066022e-16 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[547]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345597152
		 0.19315413354010147 7.9999999999999982 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99887540111039552 0.046101807560602247 0.010896425842871421 0.0019555817656292628 1
		 1 1 yes;
	setAttr ".xm[548]" -type "matrix" "xform" 1 1 1 0 0 0 0 -50.88487930365546 2.7311486405778851e-14
		 -2.6645352591003757e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.041604680783301998 0.99913415042071274 1
		 1 1 yes;
	setAttr ".xm[549]" -type "matrix" "xform" 1 1 1 0 0 0 0 -43.089368453570685
		 -7.1054273576010019e-15 8.8817841970012523e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 -0.049875318946198337 0.99875545182993364 1 1 1 yes;
	setAttr ".xm[550]" -type "matrix" "xform" 1 1 1 0 0 0 0 -5.0708992880109669
		 12.614425958600851 -3.4638958368304884e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 -0.61843902098991788 0.78583279221284219 1 1 1 no;
	setAttr ".xm[551]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[552]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 -0.00097755623600903618
		 -2.5153934276395504 -3.7146064117976607e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[553]" -type "matrix" "xform" 1 1 1 -2.6469779673105168e-22 1.2863772876451032e-14
		 -1.1102230246251565e-16 0 7.1054273576010019e-15 0 8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[554]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.3869795029440866e-15 0 -0.18779704740521908 -4.5099358985119951 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668492 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[555]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.3869795029440866e-15 0 0.18599651324026922 4.4666961682863562 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668492 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[556]" -type "matrix" "xform" 1 1 1 -1.4250923983095974e-16 6.0074698163872185e-09
		 1.2212453266596122e-15 0 -14.363123245911318 -1.7763568394002505e-15 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[557]" -type "matrix" "xform" 1 1 1 -2.6469779887190521e-23 -1.7143320048046075e-15
		 3.3306690738754701e-16 0 -28.726246491822618 -5.3290705182007514e-15 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[558]" -type "matrix" "xform" 1 1 1 -8.511536301937945e-18 1.3234889800375957e-23
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 no;
	setAttr ".xm[559]" -type "matrix" "xform" 1 1 1 0 1.7347234759768065e-17 0 0 -2.3931518875712356
		 6.8778854795754505 -0.02142613672705096 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0044764172340143278 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[560]" -type "matrix" "xform" 1 1 1 0 3.1225025876304978e-17 0 0 -0.79993655503660932
		 -8.8770532069966848 -0.0071619148329853388 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.0044764172340143278 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[561]" -type "matrix" "xform" 1 1 1 0 1.7347234759768065e-17 0 0 0.057243470674166019
		 0 -6.3937013769780959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0044764172340143278 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[562]" -type "matrix" "xform" 1 1 1 -1.503217129219141e-17 1.6689062678700195e-33
		 2.2204460492503131e-16 0 -16.961626940047694 9.7699626167013776e-15 -1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[563]" -type "matrix" "xform" 1 1 1 2.1028162314901689e-16 -5.7321815634235685e-09
		 1.1102230185982944e-16 0 -33.923253880095402 1.8873791418627661e-14 -2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[564]" -type "matrix" "xform" 1 1 1 -4.4408920985006262e-16 -3.6082248300317588e-16
		 -1.3877787807814377e-17 0 2.7234218615202934 8.2800818998085433 0.001829057443381634 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.076379404101996479 0.70296954886326635 0.70300419241410317 0.076059880674338512 1
		 1 1 yes;
	setAttr ".xm[565]" -type "matrix" "xform" 1 1 1 3.4565643505569351e-08 1.354442376863951e-07
		 5.645017779755202e-16 0 1.8006120956543867 -5.0026479930620109 0.20054753246170876 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65867133796905708 -0.011454464113109158 -0.75209533848103105 0.019325258731440371 1
		 1 1 yes;
	setAttr ".xm[566]" -type "matrix" "xform" 1 1 1 6.4905336174093364e-11 2.4715402141568689e-07
		 -3.2975431415879046e-08 0 0 0 8.5940461489983306 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 1 0.52127652319645179 -0.018291187064478034 0.85266702003926675 0.029919421407304671 1
		 1 1 yes;
	setAttr ".xm[567]" -type "matrix" "xform" 1 1 1 1.5703148806486966 0.4666221181478204
		 2.9289232293494352 0 7.366695598380554 1.03035315090712e-16 5.2030718199174931e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[568]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[569]" -type "matrix" "xform" 1 1 1 0 0 4.4408920985006262e-16 0 1.843312039902969
		 4.9973336318009256 -0.43090286475866613 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65676708076667645 0.02017898901653617 0.75309084324165154 0.033226372794312453 1
		 1 1 yes;
	setAttr ".xm[570]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 8.5995913842935465 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.036909777513786872 0.85367589325795301 -0.022440074634479661 -0.51901019319905217 1
		 1 1 yes;
	setAttr ".xm[571]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.369598533323475 -2.2204460492503131e-16
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[572]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[573]" -type "matrix" "xform" 1 1 1 -1.1102230246251568e-16 -2.3592239273284576e-16
		 1.7347234759768073e-16 0 4.4098233039084249 -7.9775949135248307 4.7855023292131883e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.038411961755856185 -0.70606268928053895 -0.70604515724327954 0.038732879228279102 1
		 1 1 yes;
	setAttr ".xm[574]" -type "matrix" "xform" 1 1 1 0.13265057495460209 3.1516608241825494
		 0.0084610721249207543 0 -1.6038104389313901 3.5224893319268848 -1.1028910808846533 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99758377078038141 -0.018355759882081799 0.010529841346111547 0.066172568304189827 1
		 1 1 yes;
	setAttr ".xm[575]" -type "matrix" "xform" 1 1 1 -2.8957776174501473 0.061538894960088852
		 -0.0092131505334556423 0 -13.884523486194837 1.4277529923667487e-05 -1.2434497875801753e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.9915087600315764 -0.005252000539066987 -0.042398037768010315 0.12282182894097395 1
		 1 1 yes;
	setAttr ".xm[576]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[577]" -type "matrix" "xform" 1 1 1 -1.3783320039095983e-15 -2.8423513518160723e-08
		 9.6985337581690092e-08 0 -1.6066223558716501 -3.5210270942806403 -1.1028448784012284 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99988449989743855 -0.015198252032689891 -9.306245352234214e-19 6.1225267615822506e-17 1
		 1 1 yes;
	setAttr ".xm[578]" -type "matrix" "xform" 1 1 1 -1.8603876073842534e-14 2.8438902720610119e-08
		 -6.5248671624259742e-07 0 13.88410209316004 -8.8817841970012523e-16 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[579]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[580]" -type "matrix" "xform" 1 1 1 0.49834220988984118 0.30627952379061368
		 -0.52909698088640933 0 3.5527136788005009e-15 2.8421709430404007e-14 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[581]" -type "matrix" "xform" 1 1 1 -8.2840640233110677e-10 -2.0433946057473432e-07
		 -7.8271160943146079e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[582]" -type "matrix" "xform" 1 1 1 -1.664122574395709e-09 -2.0833728584711331e-07
		 -1.4960872611444271e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[583]" -type "matrix" "xform" 1 1 1 -4.4747798214463139e-09 -2.1481279191168167e-07
		 -3.4359190717270576e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[584]" -type "matrix" "xform" 1 1 1 -1.0361694732866221e-08 -2.2151459530258195e-07
		 -5.7974875983844382e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[585]" -type "matrix" "xform" 1 1 1 -1.7320393411859419e-08 -2.2502606366396108e-07
		 -6.3307502029031801e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[586]" -type "matrix" "xform" 1 1 1 -2.5445130220729105e-08 -2.2532170881614217e-07
		 -4.014963090252103e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[587]" -type "matrix" "xform" 1 1 1 -3.190568315011897e-08 -2.2289943559674655e-07
		 9.9402877218481709e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[588]" -type "matrix" "xform" 1 1 1 -3.6079726452084256e-08 -2.1926283188589039e-07
		 8.0179502415478777e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[589]" -type "matrix" "xform" 1 1 1 -3.7396839938730265e-08 -2.1537079319162405e-07
		 1.6010125581981647e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[590]" -type "matrix" "xform" 1 1 1 -3.6216028457075853e-08 -2.1266279747213787e-07
		 2.2657445523747539e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[591]" -type "matrix" "xform" 1 1 1 -3.4538128080462249e-08 -2.1165486210934367e-07
		 2.6389732584957976e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[592]" -type "matrix" "xform" 1 1 1 -3.367774831740739e-08 -2.1142378280090454e-07
		 2.7785074916686697e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[593]" -type "matrix" "xform" 1 1 1 -6.4834891247562247e-10 -2.025742260656978e-07
		 -6.1929112210620829e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[594]" -type "matrix" "xform" 1 1 1 -1.445557769773017e-09 -2.0185979906885197e-07
		 -1.3155000906206124e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[595]" -type "matrix" "xform" 1 1 1 -4.2411285983377584e-09 -1.997631357588286e-07
		 -3.2927039771929791e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[596]" -type "matrix" "xform" 1 1 1 -9.1443072315415327e-09 -1.9721820002506209e-07
		 -5.4537058067462486e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[597]" -type "matrix" "xform" 1 1 1 -1.6113930557458474e-08 -1.9536765121410154e-07
		 -6.3803359897679159e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[598]" -type "matrix" "xform" 1 1 1 -2.569099510587126e-08 -1.9554379646801572e-07
		 -3.8784512095213989e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[599]" -type "matrix" "xform" 1 1 1 -3.2663938161256452e-08 -1.9813898893499142e-07
		 1.874227962805391e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[600]" -type "matrix" "xform" 1 1 1 -3.658448467951151e-08 -2.0224406229853182e-07
		 9.434842533308028e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[601]" -type "matrix" "xform" 1 1 1 -3.7450513623057725e-08 -2.0592254278816584e-07
		 1.5943511654662818e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[602]" -type "matrix" "xform" 1 1 1 -3.6906885292331896e-08 -2.0836109096952292e-07
		 2.0394194882311313e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[603]" -type "matrix" "xform" 1 1 1 -3.5721108749179831e-08 -2.1009830120158472e-07
		 2.4054550412573915e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[604]" -type "matrix" "xform" 1 1 1 -3.4551784760320525e-08 -2.1098125107312762e-07
		 2.6399085652106398e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[605]" -type "matrix" "xform" 1 1 1 -3.3677749901210003e-08 -2.1142377802617302e-07
		 2.7785076246352328e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[606]" -type "matrix" "xform" 1 1 1 6.283185307139437 -1.691866915670064e-10
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1.0275841211271339e-07 0 0.99999999999999467 1
		 1 1 yes;
	setAttr ".xm[607]" -type "matrix" "xform" 1 1 1 6.2831834777536537 -7.6260061262469617e-06
		 -6.2831870313297804 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[608]" -type "matrix" "xform" 1 1 1 6.283192743436123 -2.4064184400022912e-05
		 -6.2831786216370435 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[609]" -type "matrix" "xform" 1 1 1 -9.4247607596253147 3.1416441391713117
		 3.1416058582721185 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[610]" -type "matrix" "xform" 1 1 1 -3.1415612628268654 3.1416730457082229
		 3.141610217482913 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[611]" -type "matrix" "xform" 1 1 1 -3.141565465772318 3.1416722639098977
		 3.1416025906685041 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[612]" -type "matrix" "xform" 1 1 1 -3.1415723290649904 3.1416376445391214
		 3.1415958561675876 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[613]" -type "matrix" "xform" 1 1 1 1.7425805181374886e-05 6.2831825452840677
		 -5.4245412396542647e-07 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[614]" -type "matrix" "xform" 1 1 1 1.2693526097136423e-05 6.283214088528303
		 -2.8122587644200276e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[615]" -type "matrix" "xform" 1 1 1 1.5381657927121628e-05 6.2832188663890669
		 -6.5651340723563942e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[616]" -type "matrix" "xform" 1 1 1 8.3656757013608564e-06 6.2832054104990904
		 -5.2010808494964904e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[617]" -type "matrix" "xform" 1 1 1 5.4110698190280008e-06 6.2831907162611085
		 -4.1141251738219395e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[618]" -type "matrix" "xform" 1 1 1 5.4871734328989679e-08 6.2831855193676329
		 2.424508580468098e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[619]" -type "matrix" "xform" 1 1 1 6.283185307139437 2.0534763752778872e-07
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[620]" -type "matrix" "xform" 1 1 1 6.2831857368727118 -9.6775282638451468e-07
		 -6.2831849161452924 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[621]" -type "matrix" "xform" 1 1 1 6.2831870256632865 -2.7747909729560291e-06
		 -6.2831839729904075 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[622]" -type "matrix" "xform" 1 1 1 6.2831887525327561 -3.4914099042060667e-06
		 -6.2831832523585769 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[623]" -type "matrix" "xform" 1 1 1 6.283186499846197 -7.6909015776679209e-07
		 -6.2831848349460371 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[624]" -type "matrix" "xform" 1 1 1 6.2831814995216435 2.1715219251396469e-05
		 -6.2831858857056826 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[625]" -type "matrix" "xform" 1 1 1 6.2831550232537685 6.9571799983719759e-05
		 1.7396942165332526e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[626]" -type "matrix" "xform" 1 1 1 6.2831297046218744 0.00011709473560854273
		 1.4350585037239655e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[627]" -type "matrix" "xform" 1 1 1 6.2831124886687117 0.00013760109368610648
		 3.1022076281352182e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[628]" -type "matrix" "xform" 1 1 1 6.2831085925143197 0.00013233797747792705
		 4.2422124632536497e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[629]" -type "matrix" "xform" 1 1 1 6.2831274499323984 9.9294363699924888e-05
		 3.8927715753699082e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[630]" -type "matrix" "xform" 1 1 1 12.566339093615564 5.3566477875247642e-05
		 6.2832094222993158 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[631]" -type "matrix" "xform" 1 1 1 5.4871726338854156e-08 6.2831855193676382
		 2.4252473123899102e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr -s 138 ".m";
	setAttr -s 367 ".p";
	setAttr -s 73 ".g";
	setAttr ".g[17]" yes;
	setAttr ".g[18]" yes;
	setAttr ".g[19]" yes;
	setAttr ".g[25]" yes;
	setAttr ".g[26]" yes;
	setAttr ".g[27]" yes;
	setAttr ".g[78]" yes;
	setAttr ".g[95]" yes;
	setAttr ".g[96]" yes;
	setAttr ".g[97]" yes;
	setAttr ".g[148]" yes;
	setAttr ".g[159]" yes;
	setAttr ".g[162]" yes;
	setAttr ".g[169]" yes;
	setAttr ".g[178]" yes;
	setAttr ".g[530]" yes;
	setAttr ".g[531]" yes;
	setAttr ".g[547]" yes;
	setAttr ".g[548]" yes;
	setAttr ".g[564]" yes;
	setAttr ".g[573]" yes;
	setAttr ".g[580]" yes;
	setAttr ".g[581]" yes;
	setAttr ".g[582]" yes;
	setAttr ".g[583]" yes;
	setAttr ".g[584]" yes;
	setAttr ".g[585]" yes;
	setAttr ".g[586]" yes;
	setAttr ".g[587]" yes;
	setAttr ".g[588]" yes;
	setAttr ".g[589]" yes;
	setAttr ".g[590]" yes;
	setAttr ".g[591]" yes;
	setAttr ".g[592]" yes;
	setAttr ".g[593]" yes;
	setAttr ".g[594]" yes;
	setAttr ".g[595]" yes;
	setAttr ".g[596]" yes;
	setAttr ".g[597]" yes;
	setAttr ".g[598]" yes;
	setAttr ".g[599]" yes;
	setAttr ".g[600]" yes;
	setAttr ".g[601]" yes;
	setAttr ".g[602]" yes;
	setAttr ".g[603]" yes;
	setAttr ".g[604]" yes;
	setAttr ".g[605]" yes;
	setAttr ".g[606]" yes;
	setAttr ".g[607]" yes;
	setAttr ".g[608]" yes;
	setAttr ".g[609]" yes;
	setAttr ".g[610]" yes;
	setAttr ".g[611]" yes;
	setAttr ".g[612]" yes;
	setAttr ".g[613]" yes;
	setAttr ".g[614]" yes;
	setAttr ".g[615]" yes;
	setAttr ".g[616]" yes;
	setAttr ".g[617]" yes;
	setAttr ".g[618]" yes;
	setAttr ".g[619]" yes;
	setAttr ".g[620]" yes;
	setAttr ".g[621]" yes;
	setAttr ".g[622]" yes;
	setAttr ".g[623]" yes;
	setAttr ".g[624]" yes;
	setAttr ".g[625]" yes;
	setAttr ".g[626]" yes;
	setAttr ".g[627]" yes;
	setAttr ".g[628]" yes;
	setAttr ".g[629]" yes;
	setAttr ".g[630]" yes;
	setAttr ".g[631]" yes;
	setAttr ".bp" yes;
createNode dagPose -n "bindPose20";
	rename -uid "9A204C73-4E34-0605-B986-03933B30EC64";
	setAttr -s 15 ".wm";
	setAttr ".wm[0]" -type "matrix" 0.88852064375176909 0.066712196373037838 -0.45396095479900817 0
		 0.052330306798845171 0.96818451890954527 0.24470446733607268 0 0.45584274110407924 -0.24118088688570985 0.85676086230858017 0
		 1.5584299564361586 153.43620300292972 10.208477020263674 1;
	setAttr ".wm[1]" -type "matrix" 0.8728134094416613 0 -0.48805404649364692 0 0 1 0 0
		 0.48805404649364692 0 0.8728134094416613 0 1.3697034551294751 153.38555964045023 10.247178167510663 1;
	setAttr ".wm[2]" -type "matrix" 0.8728134094416613 0 -0.48805404649364692 0 0 1 0 0
		 0.48805404649364692 0 0.8728134094416613 0 0.78862278809124176 153.2216944449919 10.629723438757164 1;
	setAttr ".wm[3]" -type "matrix" 0.87281340944166141 0 0.4880540464936467 0 5.9769382584935799e-17 -1 -1.0688881481256189e-16 0
		 0.4880540464936467 1.2246467991473532e-16 -0.87281340944166153 0 -0.79755204752716469 153.23270385115049 10.625279450940639 1;
	setAttr ".wm[4]" -type "matrix" 0.8728134094416613 0 0.48805404649364692 0 5.9769382584935824e-17 -1 -1.0688881481256187e-16 0
		 0.48805404649364692 1.2246467991473532e-16 -0.87281340944166108 0 -1.3779506606698126 153.38932957940548 10.260711787483924 1;
	setAttr ".wm[5]" -type "matrix" 0.88852064375176898 -0.066712196373037894 0.45396095479900822 0
		 0.052330306798845296 -0.96818451890954504 -0.24470446733607293 0 0.4558427411040793 0.2411808868857101 -0.85676086230857984 0
		 -1.5584300000000022 153.43600000000006 10.208500000000006 1;
	setAttr ".wm[13]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[14]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[15]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 564 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 -7.7040041016390239e-12 -5.0861370670626822e-11
		 1.224376156036707e-11 0 -1.8825256038787188 -7.8514162719707299 -1.5584216272912981 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72330838765809879 -0.56220012029869171 0.33328766480031136 -0.22287963920361428 1
		 1 1 no;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.9341087475650056 -7.8887793987084285 -1.3696936838415938 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[2]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.3743454961862737e-13
		 -5.2863990962492473e-11 1.1385337117699468e-12 0 -2.1073618075504328 -8.2670560414176997
		 -0.78861130532133572 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 6.371569938022838e-13 5.2863713406737041e-11
		 -1.1385337117362567e-12 0 -2.0962510907311582 -8.2628865146613428 0.79756355079681185 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[4]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.9306823487580971 -7.9024038613621483 1.3779603976003294 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[5]" -type "matrix" "xform" 1 1 1 1.1595381773573089e-07 4.1220840345224184e-07
		 -6.1034828939914254e-08 0 -1.882539826420242 -7.8514152794665693 1.5584393116040054 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52963666997509684 -0.75587184796602791 -0.25791530207195246 -0.2856964196962325 1
		 1 1 no;
	setAttr ".xm[6]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7375170859174034 -8.8275211160129849
		 1.2305494212866864e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[7]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.373236502678969e-13
		 -2.1603543803872017e-07 1.1385337805953517e-12 0 -1.7418699342912305 -8.4869843496898447
		 -0.79823078792583002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[8]" -type "matrix" "xform" 1 1 0.99999999999999933 6.3715687086256627e-13
		 2.1603543798320894e-07 -1.1384226206264102e-12 0 -1.7416859135606728 -8.4870035932095398
		 0.79825373149077394 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[9]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.8406639910366778 -8.0028192385838359 -1.4240631330226121 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[10]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.8405874071773951 -8.002837634097073 1.4240796995612557 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[11]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -1.7237789224739686 -8.8036907272161677
		 -0.0063072443458632964 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[12]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -2.2281032650074337 -8.4906339138507221
		 -0.0083357945227417098 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[13]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[14]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[15]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[16]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 103.42406365931471
		 2.164099060331699 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.47198070911350104 -0.52653035071562271 0.47198070911350104 0.52653035071562304 1
		 1 1 yes;
	setAttr ".xm[17]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.4130000000000003 -1.2290000000000001
		 1.1480326062389902e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.013190362270316343 0.99991300338738365 1
		 1 1 yes;
	setAttr ".xm[18]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5400561041249299 2.4806545706468341e-15
		 1.6959614914574737e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.0088442305325985588 0.99996088902830904 1
		 1 1 yes;
	setAttr ".xm[19]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6498458227762445 3.5366674866477155e-15
		 2.6812166883603278e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.0071754466448816587 0.99997425615135038 1
		 1 1 yes;
	setAttr ".xm[20]" -type "matrix" "xform" 1 1 1 0 0 0 0 10.295228816444084 7.0776717819853729e-15
		 2.5473486394623843e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.14616377610309417 0.9892604058362412 1
		 1 1 yes;
	setAttr ".xm[21]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.6409866693344473 3.8767792175072477
		 -3.4775081921847382 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.048147358144702168 -0.67919742764105595 -0.13879939639850619 0.71910181041968513 1
		 1 1 yes;
	setAttr ".xm[22]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.2271924873418767 -1.0411810302812796e-14
		 -5.103968463149311e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948506 0.53969740289995682 0.049379025691938319 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[23]" -type "matrix" "xform" 1 1 1 0 0 0 0 -25.942629197482177 1.0061396160665481e-14
		 -1.9697785069716645e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1664063432051128 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[24]" -type "matrix" "xform" 1 1 1 0 0 0 0 -23.919990038655026 3.6637359812630166e-15
		 2.0095470426584328e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.6718112537259389e-06 0.11687386491933727 -1.4206374895849063e-05 0.99314676634130983 1
		 1 1 yes;
	setAttr ".xm[25]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2686357154040788 -1.8318136906095779
		 0.61950730993277292 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.20515884833089088 -0.90213467411116677 0.06707336650972022 0.37358270867765581 1
		 1 1 no;
	setAttr ".xm[26]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.0516604453308727 1.3820583566470646e-11
		 4.3720749243192358e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -7.5409508216749395e-07 -3.344403501253248e-06 0.21995856706938324 0.97550921510820698 1
		 1 1 yes;
	setAttr ".xm[27]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6102879061749169 5.5443930696563726e-15
		 -1.2969660068140598e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.12106269314279793 0.99264486314543166 1
		 1 1 yes;
	setAttr ".xm[28]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[29]" -type "matrix" "xform" 0.99999999999999989 1 1 3.3306690738754691e-16
		 -1.1102230246251568e-16 3.6082248300317583e-16 0 -0.092995528926863358 -0.74776544149076929
		 0.058108452627575247 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.16281155994387658 -0.46390356623307211 0.71034158331208841 0.50368711736806848 1
		 1 1 yes;
	setAttr ".xm[30]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 4.6222318665293681e-33 -1.6653345369377351e-16 -5.5511151231257839e-17 0 -0.28881122908877899
		 -0.77666693499215711 0.10702660267226349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.2177754570780685 -0.44078108077077199 0.76609461237456522 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[31]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3825985602606816 1.4813207129029979
		 0.2175109890033958 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313888827 -0.6176190457175601 -0.78453655612897033 0.038434237189574776 1
		 1 1 no;
	setAttr ".xm[32]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.7442538243088426 -0.62912660693768319
		 -0.25276041286096579 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032218771670288235 -0.08401694867549965 0.11008668831651433 0.9898404033695628 1
		 1 1 yes;
	setAttr ".xm[33]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.189588753211658 -1.3188092211845713e-06
		 1.0604575324188459e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.30387484184281865 0.9527119609278567 1
		 1 1 yes;
	setAttr ".xm[34]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.2084808571526642 -1.3588942796537162e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.15397198031489567 0.98807521438294832 1
		 1 1 yes;
	setAttr ".xm[35]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[36]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 1.0408340855860846e-17 1.6479873021779667e-17 1.6653345369377348e-16 0 0.14478671015100275
		 -0.62522803999102905 0.05460546453611137 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18392774863239081 0.98155134853469073 -0.0079134639465956551 0.051622771730275414 1
		 1 1 yes;
	setAttr ".xm[37]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 6.5052130349130274e-18 -1.1573858191282761e-17 -3.7645206585083768e-35 0 -0.21927985396480665
		 -0.68039191021174616 0.059962946419279461 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.33286583944205939 0.94152684478977178 0.00012936364655210739 0.05222563295736244 1
		 1 1 yes;
	setAttr ".xm[38]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 0
		 0 0 0 0.44262871211201116 -1.1674609741902977 -0.1744171177961924 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308557 0.015993303709080996 0.049716674357998904 1
		 1 1 yes;
	setAttr ".xm[39]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.1000190082973775 0.077638867047004942
		 1.1051857314747859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327074 -0.14064896677911912 0.1063938653225321 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[40]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.2113433856746574 -1.0148305355107273e-06
		 3.0120894788879943e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.26197949426949685 0.96507343999423101 1
		 1 1 yes;
	setAttr ".xm[41]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6941592092295417 4.5432407835832578e-15
		 5.4817261840867104e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1786971635264209 0.98390412324962417 1
		 1 1 yes;
	setAttr ".xm[42]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[43]" -type "matrix" "xform" 1 0.99999999999999989 1 2.7755575615628914e-17
		 2.0816681711721682e-17 1.6653345369377348e-16 0 -0.008897969522394078 -0.53397345773780103
		 -0.057093330916351048 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19443813918063449 -0.97295532058317269 -0.073254535055226805 -0.1009233732824573 1
		 1 1 yes;
	setAttr ".xm[44]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628914e-17
		 -1.5407439555097887e-33 -1.1102230246251565e-16 0 -0.012844241410235213 -0.69852386285188572
		 -0.18318987036044843 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.36517286647374636 -0.92254919836856386 -0.090110157422200188 -0.08620854777928888 1
		 1 1 yes;
	setAttr ".xm[45]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 -8.3266726846886728e-17 -1.3866695599588093e-32 -3.3306690738754691e-16 0 0.35997225062985194
		 -1.0044914815075445 0.030306462594378969 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755943328875 -0.79465996101688263 -0.10954779490783749 -0.059590559753185599 1
		 1 1 yes;
	setAttr ".xm[46]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -2.967889953708891e-05 2.0829965791048277 -3.5770309452232141e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[47]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 2.9107975592523871e-05 -2.0429266092840024 3.5082206935044269e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[48]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 0.22215031170242128 -7.6495421552635889e-08 -1.8877433709739861 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[49]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -0.16740074569656826 5.7656123431115702e-08 1.4225114365862055 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[50]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.5358780239681762 -2.1252076385984648
		 -0.55475650764298778 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589730857 -0.67086110383210196 -0.73035777294519266 0.11326205235528281 1
		 1 1 no;
	setAttr ".xm[51]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2738801856345932 -2.4825194677724483e-10
		 -5.1581794391353242e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.8802384446748596e-08 -2.3293906098039619e-07 0.30252440548894083 0.95314163904610771 1
		 1 1 yes;
	setAttr ".xm[52]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.4666957502986877 9.5895513751997896e-15
		 -6.5173560992448643e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.20715555832647703 0.97830801624766706 1
		 1 1 yes;
	setAttr ".xm[53]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[54]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989 1.0000000000000002 1.7525962493923846e-32
		 9.0205620750793969e-17 3.8857805861880479e-16 0 -0.1300363937240121 -0.42748935939729193
		 0.0090326042383708227 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18190833306109286 0.97249127945572167 -0.14435909047317919 -0.018180284465989936 1
		 1 1 yes;
	setAttr ".xm[55]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 -5.5511151231257827e-17 -8.3266726846886741e-17 2.3111159332646827e-33 0 -0.092939849104823224
		 -0.70251570526252749 -0.020561655155919567 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.37941935441919783 0.91371269212297312 -0.14499380240721954 0.012118869955732907 1
		 1 1 yes;
	setAttr ".xm[56]" -type "matrix" "xform" 0.99999999999999989 1 1 2.7755575615628932e-17
		 -8.3266726846886741e-17 -4.4408920985006262e-16 0 0.64530541359000892 -1.0337684191679983
		 -0.099179200290809177 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806070025397454 0.75611401757832797 -0.13453354303836371 0.05541534995389473 1
		 1 1 yes;
	setAttr ".xm[57]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.7723296862230216 -0.27978723663700461
		 -0.36275273402219244 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800207 0.65392768619920127 0.74460445552019161 -0.086698209199445653 1
		 1 1 no;
	setAttr ".xm[58]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4359145921492384 -2.4047604185728488e-15
		 3.2265856653168612e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.33099740435037722 0.9436316645351156 1
		 1 1 yes;
	setAttr ".xm[59]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5938963073742798 9.5427138413484158e-15
		 -7.0794065054613498e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16311678596505561 0.98660676773293532 1
		 1 1 yes;
	setAttr ".xm[60]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[61]" -type "matrix" "xform" 1.0000000000000004 0.99999999999999989 1.0000000000000004 -2.7755575615628914e-17
		 -6.9388939039072299e-18 -5.5511151231257827e-17 0 0.0097566940122959522 -0.62627658440707989
		 0.19072773034925916 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18942506733578274 0.97750324727186122 -0.092484988897998791 -0.0072161115801939388 1
		 1 1 yes;
	setAttr ".xm[62]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 1.5407439555097894e-33 2.775557561562892e-17 1.1102230246251568e-16 0 -0.16496152272483755
		 -0.64963237563258502 -0.010965767331040155 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.34633520245692045 0.93351292551379461 -0.092423384556460472 0.0079663934706561655 1
		 1 1 yes;
	setAttr ".xm[63]" -type "matrix" "xform" 1 1 1.0000000000000002 -7.70371977754894e-34
		 1.3877787807814454e-17 -1.1102230246251563e-16 0 0.30737120973599019 -1.1821106670030854
		 0.012795115529151246 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317158315414 0.76625634194243475 -0.084576774299171445 0.038109246738131722 1
		 1 1 yes;
	setAttr ".xm[64]" -type "matrix" "xform" 1 1 0.99999999999999989 -3.2522503597421059e-09
		 1.6269235712078467e-08 1.1676854017302847e-08 0 -5.6161683140689291 -2.8078829101015756
		 1.3490852531175506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267574 0.79092168180925615 -0.56655406700099809 0.076316486466476846 1
		 1 1 no;
	setAttr ".xm[65]" -type "matrix" "xform" 1 1 1 5.3070195178143661e-13 2.3792325976042941e-07
		 -1.3578358637460943e-07 0 1.3843792601164751e-06 -2.7145519965188214e-07 -4.9580461336518056e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[66]" -type "matrix" "xform" 1 1 1 0.0058997737361192217 -0.00049452079635831038
		 -2.8729987160049575e-06 0 0.49922049000947766 2.9581812754938603 -2.3353210565346672e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029189813026558381 0.00049262500763106506 -0.083493624323089724 0.99650391447608033 1
		 1 1 yes;
	setAttr ".xm[67]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 0.0058997737361192217 -0.00049452079635831038 -2.8729987160049575e-06 0 -0.4992245719571855
		 -2.9582054164285303 2.2603977356538962e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0029189813026558381 0.00049262500763106506 -0.083493624323089724 0.99650391447608033 1
		 1 1 yes;
	setAttr ".xm[68]" -type "matrix" "xform" 1 1 1 1.1128628787128129e-06 3.0207724709978668e-08
		 -2.1056107480074234e-08 0 -7.9733304050135274 6.3323703614059923e-08 6.1214450397528708e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[69]" -type "matrix" "xform" 1 1 1 1.5970707287989025e-06 -1.7272370083675665e-15
		 8.3248609117360621e-09 0 -15.946661756748483 2.9185864391934047e-07 4.5590822139729426e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[70]" -type "matrix" "xform" 1 1 1 -7.9982792244955534e-07 -2.6897107075777592e-07
		 5.2015762611699531e-08 0 -8.3179983442870338 -0.23421221301943973 -3.6902483877089693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.027401009458430881 0.68285929581411187 -0.72965333882255312 -0.023629895175704567 1
		 1 1 no;
	setAttr ".xm[71]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[72]" -type "matrix" "xform" 1 1 1 1.6766494859155046e-09 1.3251953088681999e-24
		 1.5364583403813301e-25 0 15.276314141915009 -0.66666510324099659 -0.23259512495407628 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[73]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[74]" -type "matrix" "xform" 1 1 1 -5.2046188695544644e-07 4.3714980988727613e-07
		 1.4806520279165935e-07 0 3.1871186934040452e-06 3.1748160012057269e-07 -1.1475461789700603e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.01769022493995764 -5.5666396683338097e-08 -1.3911766870110481e-08 0.99984351572712138 1
		 1 1 no;
	setAttr ".xm[75]" -type "matrix" "xform" 1 1 1 1.6031064300857048e-07 -2.4351549027653503e-07
		 -2.0078720170536655e-07 0 -2.0391023059279405 3.7807471347604498 1.9442799573314176 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[76]" -type "matrix" "xform" 1 1 1 1.6031064300857048e-07 -2.4351549027653503e-07
		 -2.0078720170536655e-07 0 -2.0796412888383458 -5.2507730495076324 0.25073941825030488 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[77]" -type "matrix" "xform" 1 1 1 -3.8163916471489756e-17 1.0755285551056205e-16
		 -4.163336342344337e-17 0 1.8460968932489834 0.7100886774885744 -2.7737621548980016 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[78]" -type "matrix" "xform" 1 1 1 1.6031064308836773e-07 -2.4351549037888371e-07
		 -2.0078720164985537e-07 0 -6.3501221820377936 -2.7291381106600348 2.0160455531035382 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243926 -0.28080602403705029 -0.030710052147679925 0.9519207289690399 1
		 1 1 yes;
	setAttr ".xm[79]" -type "matrix" "xform" 1 1 1 4.7604797767663485e-07 -7.3040871468447449e-08
		 -2.6880013266818929e-08 0 -8.6475412902791504 2.5304690609573299e-07 -5.9611586067376265e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799857334752322 1.9595281799489555e-08 2.3123762860308417e-10 0.99993037925991579 1
		 1 1 no;
	setAttr ".xm[80]" -type "matrix" "xform" 1 1 1 1.9437843710374102e-08 8.5653819506546881e-09
		 2.8195150377370807e-08 0 -17.295084873071218 2.1638773262111499e-07 -3.7567885868838857e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0058998186544699099 3.8789585246972899e-08 2.2885550165905089e-10 0.99998259591847038 1
		 1 1 no;
	setAttr ".xm[81]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.34387171483078305 -4.5604522683327868
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[82]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.3438717148307161 3.6088802562769589
		 0.6099587491636127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[83]" -type "matrix" "xform" 1 1 1 -3.7358078137980887e-08 -3.9231474221458578e-07
		 1.7747221797652936e-07 0 2.2701034659063684 -0.16849257165543818 -2.3451506203393282 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090864042157167091 -0.73673233087998069 0.66365248834412305 -0.092382753767491999 1
		 1 1 no;
	setAttr ".xm[84]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[85]" -type "matrix" "xform" 1 1 1 -8.7351898515775978e-08 3.0968112931036184e-07
		 -3.3786357366272247e-07 0 9.5350861259021258 -0.04908860630574452 6.6024946909510468e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0043095761169174955 0.008122547781402643 -0.16242313102416744 0.98667835604088205 1
		 1 1 no;
	setAttr ".xm[86]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[87]" -type "matrix" "xform" 1 1 1 -6.5765615175905623e-11 -1.9968099496797911e-26
		 1.1619618915634355e-27 0 4.986384254736592 -0.3437570935533118 1.1348560979840272e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -3.9514086989413111e-19 0.0014376218797037942 0.0021873772694690386 0.9999965743061382 1
		 1 1 yes;
	setAttr ".xm[88]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[89]" -type "matrix" "xform" 1 1 1 1.5942175737862242e-15 -4.693018473877868e-07
		 -4.9014410172549118e-09 0 -1.7763568394002505e-15 4.4408920985006262e-16 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[90]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[91]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.6409866693344668 3.8767792175072415
		 3.4775081921847582 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67919742764105606 -0.048147358144700947 0.71910181041968524 0.13879939639850558 1
		 1 1 yes;
	setAttr ".xm[92]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418767 9.7699626167013776e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948423 0.53969740289995671 0.049379025691938784 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[93]" -type "matrix" "xform" 1 1 1 0 0 0 0 25.942629197482148 -1.7763568394002505e-14
		 4.2632564145606011e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16640634320511283 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[94]" -type "matrix" "xform" 1 1 1 0 0 0 0 23.919990038655015 -7.1054273576010019e-15
		 -3.5527136788005009e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.6718112537259389e-06 0.11687386491933727 -1.4206374895849063e-05 0.99314676634130983 1
		 1 1 yes;
	setAttr ".xm[95]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.2686357154040877 1.8318136906095788
		 -0.61950730993276437 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.20515884833089071 -0.90213467411116688 0.067073366509720067 0.37358270867765553 1
		 1 1 no;
	setAttr ".xm[96]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.0516604453308673 -1.382716163789155e-11
		 -4.3709036390282563e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -7.5409508216748738e-07 -3.3444035012532468e-06 0.21995856706938299 0.97550921510820698 1
		 1 1 yes;
	setAttr ".xm[97]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.6102879061749178 3.5527136788005009e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.12106269314279798 0.99264486314543166 1
		 1 1 yes;
	setAttr ".xm[98]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723 -1.5543122344752192e-15
		 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[99]" -type "matrix" "xform" 0.99999999999999989 1 0.99999999999999989 5.5511151231257827e-16
		 -3.8518598887744717e-32 1.3877787807814457e-16 0 0.093011950531149523 0.74777116535866317
		 -0.058093641876986624 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.16281156635792474 -0.46390358450879787 0.71034161129637119 0.50368705899679667 1
		 1 1 yes;
	setAttr ".xm[100]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.1102230246251563e-16 5.5511151231257815e-17 5.5511151231257815e-17 0 0.28881221121405076
		 0.77665484218863767 -0.10704700344571805 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.21777545707806917 -0.44078108077077183 0.76609461237456489 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[101]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3825985602606892 -1.481320712902999
		 -0.21751098900338661 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313889209 -0.61761904571755988 -0.78453655612897055 0.038434237189574769 1
		 1 1 no;
	setAttr ".xm[102]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.7442538243088421
		 0.6291266069376924 0.25276041286096529 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032218771670287985 -0.084016948675499345 0.11008668831651404 0.98984040336956292 1
		 1 1 yes;
	setAttr ".xm[103]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.189588753211666 1.3188092120586248e-06
		 -1.0604575297890051e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.30387484184281832 0.95271196092785682 1
		 1 1 yes;
	setAttr ".xm[104]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.2084808571526651
		 1.4210854715202004e-14 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.15397198031489528 0.98807521438294843 1 1 1 yes;
	setAttr ".xm[105]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[106]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 2.4286128663675302e-17 -9.9746599868666439e-18 2.2204460492503131e-16 0 -0.14481344796616469
		 0.62524239210618759 -0.054608253490670222 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.18392774863239164 0.98155134853469062 -0.0079134639465971764 0.051622771730275491 1
		 1 1 yes;
	setAttr ".xm[107]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.3091741232762464e-17 3.2363434848692301e-17 1.1102230246251563e-16 0 0.21925389433539522
		 0.68035991504324755 -0.05996656124215427 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.33286583940055764 0.94152684480444415 0.00012936364885220153 0.052225632957356702 1
		 1 1 yes;
	setAttr ".xm[108]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 9.0205620750793994e-17
		 2.7755575615628877e-17 8.8817841970012523e-16 0 -0.44265338170127677 1.1674220371286874
		 0.17441239141144216 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308568 0.015993303709079976 0.049716674357999396 1
		 1 1 yes;
	setAttr ".xm[109]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.100019008297366 -0.077638867046999849
		 -1.1051857314747835 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327053 -0.14064896677911917 0.10639386532253192 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[110]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.2113433856746525
		 1.014830534828981e-06 -3.0120894747298621e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.26197949426949668 0.96507343999423112 1 1 1 yes;
	setAttr ".xm[111]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6941592092295679
		 1.4210854715202004e-14 -2.1231299607293863e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.1786971635264209 0.98390412324962417 1 1 1 yes;
	setAttr ".xm[112]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[113]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999978 2.7755575615628909e-16 -9.7144514654701333e-17 9.4368957093138306e-16 0 0.0089574726823542505
		 0.53395019911204145 0.057095533089779549 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19443812507456906 -0.97295532340216873 -0.073254536518429031 -0.10092337222040108 1
		 1 1 yes;
	setAttr ".xm[114]" -type "matrix" "xform" 1 0.99999999999999978 1 5.5511151231257827e-17
		 5.5511151231257821e-17 2.2204460492503131e-16 0 0.012863941463479023 0.69853100111512134
		 0.18319344488131462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.3651728664737463 -0.92254919836856397 -0.09011015742219905 -0.086208547779289033 1
		 1 1 yes;
	setAttr ".xm[115]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1.0000000000000002 0 0 0 0 -0.35991630006155617 1.0045062980003849 -0.030304822923965302 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755975758744 -0.79465996077442913 -0.10954779488351792 -0.059590559797891941 1
		 1 1 yes;
	setAttr ".xm[116]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -2.9056714197395195e-05 2.0429267278445735 -4.0345676239894601e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[117]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 2.962663036498725e-05 -2.082996535952919 4.1137013226943964e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[118]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 0.16740093387851118 -4.2835413083253115e-07 -1.4225110972004771 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[119]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -0.22215036112133646 5.6843365570102833e-07 1.8877432627052784 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[120]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5358780239681948 2.1252076385984608
		 0.55475650764299189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589731023 -0.67086110383210185 -0.73035777294519288 0.11326205235528264 1
		 1 1 no;
	setAttr ".xm[121]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.2738801856345958
		 2.482565264472214e-10 5.1582915716608113e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-8.8802384446748781e-08 -2.3293906098039574e-07 0.3025244054889405 0.95314163904610782 1
		 1 1 yes;
	setAttr ".xm[122]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.4666957502986833
		 -7.1054273576010019e-15 -7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.20715555832647689 0.97830801624766706 1 1 1 yes;
	setAttr ".xm[123]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[124]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1.0000000000000002 5.5511151231257827e-17 1.3877787807814457e-17 5.5511151231257827e-17 0 0.1300869336832946
		 0.427497371158573 -0.0090328041227820677 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18190833306109333 0.97249127945572156 -0.14435909047318005 -0.01818028446598971 1
		 1 1 yes;
	setAttr ".xm[125]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 -5.5511151231257827e-17 -1.3877787807814457e-16 3.8518598887744717e-33 0 0.092932645278267501
		 0.70253901601402902 0.020558105201324395 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.37941935441919805 0.91371269212297301 -0.14499380240722057 0.012118869955733351 1
		 1 1 yes;
	setAttr ".xm[126]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 0 0 0 0 -0.64530862789699484 1.033772745931909 0.099178466978877111 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806069911713481 0.75611401853767068 -0.13453354295504596 0.055415350156170579 1
		 1 1 yes;
	setAttr ".xm[127]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.7723296862230029 0.27978723663700578
		 0.36275273402220165 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800204 0.65392768619920094 0.74460445552019183 -0.086698209199445583 1
		 1 1 no;
	setAttr ".xm[128]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.4359145921492313
		 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.33099740435037706 0.9436316645351156 1
		 1 1 yes;
	setAttr ".xm[129]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.593896307374294 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16311678596505561 0.98660676773293532 1
		 1 1 yes;
	setAttr ".xm[130]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[131]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999978
		 1.0000000000000002 -2.7755575615628886e-17 9.0205620750793981e-17 6.106226635438361e-16 0 -0.0097425222843767756
		 0.62632109537290148 -0.19073555836701317 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18942508170032349 0.97750324448823434 -0.092484988791958059 -0.0072161129392722019 1
		 1 1 yes;
	setAttr ".xm[132]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628907e-17
		 1.3877787807814457e-17 1.1102230246251563e-16 0 0.16497330343041483 0.64960365708683554
		 0.010971411859809876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34633520221586123 0.93351292560322785 -0.092423384554404631 0.0079663934945232405 1
		 1 1 yes;
	setAttr ".xm[133]" -type "matrix" "xform" 1 0.99999999999999989 1.0000000000000002 2.3111159332646827e-33
		 -4.163336342344337e-17 -1.1102230246251565e-16 0 -0.30734474282169799 1.1821151242411378
		 -0.012786813473642411 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317134172704 0.76625634214275939 -0.084576774287164702 0.038109246764780655 1
		 1 1 yes;
	setAttr ".xm[134]" -type "matrix" "xform" 1 0.99999999999999989 1 -3.2522505817867208e-09
		 1.6269233658165888e-08 1.1676854294858608e-08 0 5.6161553990582291 2.8079089430753577
		 -1.3490770884595875 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267533 0.79092168180925626 -0.56655406700099842 0.076316486466475958 1
		 1 1 no;
	setAttr ".xm[135]" -type "matrix" "xform" 1 1 1 -1.7222833206260737e-07 -1.1950459188189162e-07
		 7.3290778634209202e-08 0 3.794008449631292e-07 -9.1163720128406567e-08 -1.3948621102599645e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[136]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 1 0.005900319728525929 -0.00049432277654363284 -2.9662723266230796e-06 0 0.49922314169340609
		 2.9581952655744708 4.605266994417434e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029191406150601736 0.0004926176904447542 -0.083493624306147013 0.99650391401444316 1
		 1 1 yes;
	setAttr ".xm[137]" -type "matrix" "xform" 1 1 1 0.005900319728525929 -0.00049432277654363284
		 -2.9662723266230796e-06 0 -0.49922185243011086 -2.9581876247830028 -4.5783868074522616e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029191406150601736 0.0004926176904447542 -0.083493624306147013 0.99650391401444316 1
		 1 1 yes;
	setAttr ".xm[138]" -type "matrix" "xform" 1 1 1 1.9404091557882103e-06 5.1918358268756153e-08
		 -3.0067228184397346e-08 0 7.9733305555205902 -8.0196674190347039e-08 -1.1247605158359875e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[139]" -type "matrix" "xform" 1 1 1 1.08182964958512e-06 -6.4945811118219324e-08
		 4.0594123126932932e-08 0 15.94666095136445 -1.0734020250424692e-07 -1.6400243652014979e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[140]" -type "matrix" "xform" 1 1 1 5.4160604879362514e-07 2.009185912428714e-07
		 4.758449157641748e-08 0 8.3179977339076459 -0.23422280895807646 3.6902475259176484 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.72965333882255323 0.023629895175704421 -0.027401009458430898 0.68285929581411176 1
		 1 1 no;
	setAttr ".xm[141]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[142]" -type "matrix" "xform" 1 1 1 6.3765392965819956e-10 5.0399084806560511e-25
		 5.8433721677698674e-26 0 15.276314141915009 -0.66666510324100159 -0.23259512495407719 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[143]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[144]" -type "matrix" "xform" 1 1 1 -1.0853573356802025e-06 -4.3568480912375238e-07
		 -1.5827201977261405e-07 0 5.709288075195218e-06 6.212917647019367e-07 -2.1773046867679113e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.017689848081294958 -3.5099206601646391e-07 -1.0642097693105201e-07 0.9998435223947425 1
		 1 1 no;
	setAttr ".xm[145]" -type "matrix" "xform" 1 1 1 3.9091003157917731e-07 2.0553793393427188e-07
		 -4.2825701378480775e-07 0 2.0796398125979323 5.2507738269428739 -0.25074371557527542 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[146]" -type "matrix" "xform" 1 1 1 3.9091003157570792e-07 2.0553793404269212e-07
		 -4.2825701378480786e-07 0 2.0391012125653276 -3.7807481359989907 -1.9442803597557088 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903996 -0.28080574450372225 -0.030709888094579113 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[147]" -type "matrix" "xform" 1 1 1 3.9091003157917731e-07 2.0553793393427188e-07
		 -4.2825701378480775e-07 0 -1.8460945685297929 -0.71008786430548199 2.7737649130940696 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[148]" -type "matrix" "xform" 1 1 1 3.9091003156529952e-07 2.0553793392733299e-07
		 -4.2825701382644117e-07 0 6.3501177812513419 2.7291390216045208 -2.0160545373111205 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903978 -0.28080574450372214 -0.030709888094579009 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[149]" -type "matrix" "xform" 1 1 1 -1.8510935268298355e-07 -7.3525778477132489e-08
		 -1.9051371282054823e-08 0 8.6475423825332456 -8.5352365175594969e-08 3.7745845560266389e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799440696141954 5.7471190699417895e-08 2.1503880690791351e-08 0.99993038417644575 1
		 1 1 no;
	setAttr ".xm[150]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999967
		 0.99999999999999833 1.3297720257325253e-07 9.1781417651250027e-08 2.5223403808690039e-08 0 17.295085515775057
		 -9.7533423115692131e-08 5.5281149258235018e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0059001293061062251 -2.8392807976717996e-08 -1.1259027937650805e-08 0.99998259408560208 1
		 1 1 no;
	setAttr ".xm[151]" -type "matrix" "xform" 1 1 1 -6.2131408305892441e-07 -1.3422690300712979e-07
		 -2.3768074267184763e-08 0 -0.3441484180751786 4.5604182918902847 0.00011523384354461541 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3.106570423270981e-07 6.7113447811715346e-08 1.1884057982860475e-08 0.99999999999994937 1.0000000000000002
		 1.0000000000000004 1.0000000000000018 yes;
	setAttr ".xm[152]" -type "matrix" "xform" 0.99999999999999978 1 0.99999999999999978 -6.289219633362861e-20
		 -1.3552527152912673e-20 -2.3955150665752208e-21 0 -0.34371943612941891 -3.6088561973584454
		 -0.61001866734908816 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3.1065704247975371e-07 6.7113447887175844e-08 1.18840581216383e-08 0.99999999999994937 1.0000000000000002
		 1.0000000000000004 1.0000000000000018 yes;
	setAttr ".xm[153]" -type "matrix" "xform" 1 1 1 -0.00022152767880003694 8.4875104148135039e-07
		 1.2506500933867408e-08 0 8.8817841970012523e-16 4.4408920985006262e-16 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[154]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[155]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.8896802499102243 3.884615267454778
		 2.3331122655065721e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 7.6382178455051576e-08 1.5593511478536243e-06 -0.23597495564053356 0.97175913698200467 1
		 1 1 yes;
	setAttr ".xm[156]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.683546000000035 0.00015703100003605641
		 4.3841862470061707e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1288734818512077 0.99166104374203712 1
		 1 1 yes;
	setAttr ".xm[157]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[158]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977792049080051 -5.1625618604184824
		 -3.0255378400541937 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50010523644630966 0.49989474205212669 -0.5001036748994 0.49989630294665471 1
		 1 1 no;
	setAttr ".xm[159]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.44894278226615869
		 -0.18401212650169896 2.1363091819890201 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841859969194742 0.090512344640451117 0.021125460962961716 0.99342508329649548 1
		 1 1 yes;
	setAttr ".xm[160]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7763568394002505e-15
		 0 4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[161]" -type "matrix" "xform" 1 1 1 0.23360810753218131 -0.40234061126456877
		 -0.43485044274246787 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.40087774203409404 -0.45290564647529907 -0.61013986385495111 0.51176445545533888 1
		 1 1 yes;
	setAttr ".xm[162]" -type "matrix" "xform" 0.66197264440161574 1.1021921299515944
		 1 0 0 0 0 0.044855766375292205 2.5245096710397803 0.15444283002983816 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.4862617343533791 0.48494166130101091 0.53021325555582166 0.49724743787289283 1
		 1 1 yes;
	setAttr ".xm[163]" -type "matrix" "xform" 1 1 1 -0.058003319898012974 0.72383020551935373
		 -0.079669027797594522 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47751416514246486 -0.38421895523508581 -0.54200896931834797 0.57496286289187049 1
		 1 1 yes;
	setAttr ".xm[164]" -type "matrix" "xform" 0.6785375197975797 0.95799864639124532
		 1 0 0 0 0 0.059214626181244512 2.5389169532675826 0.15533543079981804 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49557169816285929 0.47655439569781033 0.51760793659052884 0.50930013145449882 1
		 1 1 yes;
	setAttr ".xm[165]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977603558034843 -5.1625605538767454
		 3.0255955792552052 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49989630294665394 0.50010367489940077 0.49989474205212592 0.50010523644631044 1
		 1 1 no;
	setAttr ".xm[166]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.44894370729995314
		 0.18401211987492161 -2.1363089881648829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841864099626877 0.090512559469702922 0.021125451262397732 0.99342506365145145 1
		 1 1 yes;
	setAttr ".xm[167]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[168]" -type "matrix" "xform" 1 1 1 0.53200126771743783 0.0029727848858548088
		 0.010025488126381595 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.064989343048516224 -0.67638815196858926 -0.042556096839040547 0.73243732277135143 1
		 1 1 yes;
	setAttr ".xm[169]" -type "matrix" "xform" 1.1975992053004352 0.79913879068876204
		 1 0 0 0 0 -2.4621405940084298 -0.00029764573881152501 6.2316870597101115e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70788413856216958 0.0067958157402144836 -0.70565959166388148 0.029973387417574993 1
		 1 1 yes;
	setAttr ".xm[170]" -type "matrix" "xform" 1 1 1 -0.73566333107297788 -0.0022688543119592911
		 0.0043549249991153656 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10800905939387451 -0.52060676801724259 -0.12772602498256161 0.83725067854594493 1
		 1 1 yes;
	setAttr ".xm[171]" -type "matrix" "xform" 1.24781063655325 0.69061940645158038 1 0
		 0 0 0 -2.5739657448699944 4.8678124301204662e-05 1.5174167788956083e-06 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70482462364600029 -0.029045690597641061 0.70875472608900425 -0.0067332018001021732 1
		 1 1 yes;
	setAttr ".xm[172]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 -3.9400967430654816 -2.8896707548708092 -2.6925502350708791e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[173]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 1.4007122498098568 4.2847543237057621 3.3515570085725825e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[174]" -type "matrix" "xform" 1 1 1 2.2260632721892816e-07 0.018838865332075082
		 9.9413410438024742e-08 0 1.5056762133197878 7.5070726841770457 1.5419261387338663e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15951152046933148 -0.68888073166472075 0.68888038349887182 0.15950934019388496 1
		 1 1 no;
	setAttr ".xm[175]" -type "matrix" "xform" 1 1 1 -2.2151420150933658e-07 2.4661162094690787e-09
		 -9.8557642670254815e-08 0 10.563390829596955 -4.2760353465259426e-15 -0.046552117208733534 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.015251496810226965 0 0.99988368915841785 1
		 1 1 yes;
	setAttr ".xm[176]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 9.4827687854422607
		 3.7321796315329531e-15 -2.3385624103866576e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.012722857859538445 0 0.9999190611683958 1 1 1 yes;
	setAttr ".xm[177]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 10.536384444209355
		 -2.2139260911782478e-15 0.035821534330517872 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.02346357552664715 0 0.99972469241461936 1 1 1 yes;
	setAttr ".xm[178]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 8.2070163083248531
		 1.8807214628973473e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.00096055918587931069 0 0.9999995386629188 1
		 1 1 yes;
	setAttr ".xm[179]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 7.488432529677028
		 1.7562206841626555e-15 0.02118917542799284 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.0088147932995396357 0 0.99996114895484134 1 1 1 yes;
	setAttr ".xm[180]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 4.5543586581220552
		 1.064711944369183e-15 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.017460398155145457 0 0.9998475556284887 1 1 1 yes;
	setAttr ".xm[181]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 8.1939419076200011
		 4.4656352014393452e-15 -2.020721012740978e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.049673452335513124 0 0.99876551208633124 1 1 1 yes;
	setAttr ".xm[182]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.5673177093418502 -5.6921998704852754e-08
		 -2.3594068920829159e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[183]" -type "matrix" "xform" 1 1 1 0 0 0 0 12.482656650018839 -7.4267186961406164e-08
		 -3.0783681381763017e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[184]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[185]" -type "matrix" "xform" 1 1 1 3.8944537725842122e-15 9.0138253250326943e-08
		 6.5471963239805116e-08 0 4.2530390196097017 10.77130977070858 5.5192402113899419 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.3782104709457097 -0.37821047094570959 0.59745865101028073 0.59745865101028095 1
		 1 1 yes;
	setAttr ".xm[186]" -type "matrix" "xform" 1 1 1 -6.6467294437285689e-17 -6.8039369138794825e-09
		 3.2205305089405556e-09 0 4.2528131677824774 -10.771300081889816 5.5191355833121776 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59745865101028095 0.59745865101028073 0.37821047094570959 0.3782104709457097 1
		 1 1 yes;
	setAttr ".xm[187]" -type "matrix" "xform" 1 1 1 0.45147067833840204 -3.0694132441347363e-08
		 -7.275961944337105e-08 0 11.559844746539198 -10.610553688903337 -0.064109199610069695 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41448053453211336 0.51498461377259264 -0.59595391917958995 0.45588996510775948 1
		 1 1 no;
	setAttr ".xm[188]" -type "matrix" "xform" 1 1 1 0.7750111904053576 -0.21789524103559429
		 -0.23887808228062216 0 3.7101141635033201 -1.1368683772161603e-13 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16334516138569405 0.27854149049191035 -0.27089239992649744 0.90683532352268281 1
		 1 1 yes;
	setAttr ".xm[189]" -type "matrix" "xform" 1 1 1 0.12538130224185476 -0.059683413925607449
		 -0.3571596861617784 0 4.0725563230532771 8.5265128291212022e-14 -1.1368683772161603e-13 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18051798240081326 0.17788544273638804 0.027008285055259748 0.96697496339398192 1
		 1 1 yes;
	setAttr ".xm[190]" -type "matrix" "xform" 1 1 1 0.14248795753079574 0.23026417415148623
		 -0.080345506665518374 0 4.000610933484765 -3.5527136788005009e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020971424288593093 -0.027413947918390729 0.11149405566238443 0.99316552012984671 1
		 1 1 yes;
	setAttr ".xm[191]" -type "matrix" "xform" 1 1 1 -0.097362896099633209 0.38168489929344435
		 0.14514040658241065 0 4.0603935283487544 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
		0 0 0 1 0.071389841504829202 -0.14883679234685407 0.092570372479719693 0.98192760726683959 1
		 1 1 yes;
	setAttr ".xm[192]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[193]" -type "matrix" "xform" 1 1 1 0.50350514714478545 4.1006020464770464e-09
		 -4.5991031285753878e-09 0 12.566899404695164 -9.6150313351416621 0.071513720417332782 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54332247225669583 0.40457064582709801 -0.45375334041170345 0.57899152821188804 1
		 1 1 no;
	setAttr ".xm[194]" -type "matrix" "xform" 1 1 1 0.56908407903183811 -0.38500868437795283
		 -0.18640777234602562 0 3.4644126223781484 -2.0810261958104093e-08 -4.7554209459121921e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.044405792528022334 0.23820893735320914 -0.42228386868031159 0.87347636602681034 1
		 1 1 yes;
	setAttr ".xm[195]" -type "matrix" "xform" 1 1 1 0.39338315205201096 -0.18573442225732267
		 -0.27401196531058752 0 4.303739247827437 1.4210854715202004e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17400122083625127 0.19635169321082077 -0.087211217863158774 0.96102226363365917 1
		 1 1 yes;
	setAttr ".xm[196]" -type "matrix" "xform" 1 1 1 -0.030987593584643962 0.015876666981339729
		 -0.13141720737013338 0 4.1818076225511618 -1.4210854715202004e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.050839916640124189 0.051504431728612514 0.036612817149271802 0.99670562254295114 1
		 1 1 yes;
	setAttr ".xm[197]" -type "matrix" "xform" 1 1 1 0.12036348611889762 0.16073074494383702
		 -0.054912447136772631 0 4.2405858650267305 1.4210854715202004e-14 2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.013845469812409465 -0.017827603972404502 0.081747532548058319 0.99639742092429218 1
		 1 1 yes;
	setAttr ".xm[198]" -type "matrix" "xform" 1 1 1 -0.27422613628046527 0.2670227663113845
		 -0.043179333783084875 0 4.224601729290427 -2.8421709430404007e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.026620080080550244 -0.052681510888382001 0.11017046964238202 0.99215850415435092 1
		 1 1 yes;
	setAttr ".xm[199]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[200]" -type "matrix" "xform" 1 1 1 0.28180597477669983 1.6638588366529264e-08
		 7.4364846238523222e-08 0 14.043917314267674 -8.3515692259221659 0.15407804390279989 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62938079819301485 0.46599988082158245 -0.38226311049846218 0.49050875251338294 1
		 1 1 no;
	setAttr ".xm[201]" -type "matrix" "xform" 1 1 1 0.16657712992334422 -0.18663500741767519
		 0.010533570859111338 0 3.6589284731835434 -1.6929959656408755e-08 -5.8478001108142053e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0015731991924447363 0.017124862808462073 -0.35508761471425648 0.93467483650445626 1
		 1 1 yes;
	setAttr ".xm[202]" -type "matrix" "xform" 1 1 1 0.375882884846373 -0.10434518109949192
		 -0.097616190672198705 0 4.0030741049005627 -5.6843418860808015e-14 -3.5527136788005009e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094743762826098421 0.14225531451370066 -0.13053594339965241 0.97659992442090782 1
		 1 1 yes;
	setAttr ".xm[203]" -type "matrix" "xform" 1 1 1 0.036754376770198251 0.063024627285098209
		 -0.13767769969643656 0 4.0831724074700873 -2.8421709430404007e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.061230068711689851 0.080745357838719653 0.071197012427159964 0.99230139135975504 1
		 1 1 yes;
	setAttr ".xm[204]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[205]" -type "matrix" "xform" 1 1 1 0.1664074764349939 -2.9141556668122256e-09
		 3.421383202683414e-08 0 14.951931269453581 -7.5211136838236436 -0.087329301588584415 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6320347144562688 0.52782869945912025 -0.37432424431774103 0.42639224179788793 1
		 1 1 no;
	setAttr ".xm[206]" -type "matrix" "xform" 1 1 1 0.17040092240406829 -0.11050539964674586
		 -0.0049174716551962294 0 4.0750092727693534 1.9670096662594005e-09 1.171116892351165e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0073815378305819076 0.035025908130299058 -0.3541431012040927 0.93450594568919199 1
		 1 1 yes;
	setAttr ".xm[207]" -type "matrix" "xform" 1 1 1 0.36997183039461146 -0.10990467620587775
		 -0.081587009718689901 0 4.287632031359621 -5.6843418860808015e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13613405303142886 0.14053384536649907 -0.1943974599906845 0.9612114155901974 1
		 1 1 yes;
	setAttr ".xm[208]" -type "matrix" "xform" 1 1 1 0.4143833470440455 -0.02955823715551428
		 -0.14436653328433313 0 4.1413681691741147 1.4210854715202004e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17831145707108373 0.11992841067894842 -0.0094390494990498446 0.9765925992622323 1
		 1 1 yes;
	setAttr ".xm[209]" -type "matrix" "xform" 1 1 1 0.32802497756303522 0.23231687115775795
		 -0.19975834173395818 0 4.3499426101529934 2.1316282072803006e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.043429001529634449 0.039314051682630254 0.15242651384174591 0.98657715615378339 1
		 1 1 yes;
	setAttr ".xm[210]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[211]" -type "matrix" "xform" 1 1 1 3.5996839562301617e-08 -6.3073126694564231e-09
		 1.8355733985840653e-08 0 11.13450705315293 -10.370759311270046 0.33848942153285977 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084844947099925044 -0.27041773600217633 -0.92181779653480711 0.26443814588440379 1
		 1 1 no;
	setAttr ".xm[212]" -type "matrix" "xform" 1 1 1 2.7686504091597737 0.017278520765435353
		 0.037843225583184675 0 2.600889742057376 4.7741167463755119e-08 1.6404650970969215e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.93000072000406364 -0.363977974682195 -0.010685059690918201 0.050045221925496215 1
		 1 1 yes;
	setAttr ".xm[213]" -type "matrix" "xform" 1 1 1 -0.13858841596375779 0.24467850433967553
		 -0.7266573557982885 0 2.6511928129189641 3.907985046680551e-14 -1.0658141036401503e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.063571288267562018 -0.023906635276354345 0.19527786790137486 0.97839343742977924 1
		 1 1 yes;
	setAttr ".xm[214]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[215]" -type "matrix" "xform" 1 1 1 -0.27606462167449519 -3.1858226335938633e-08
		 -9.9184254602802609e-08 0 10.470345513282581 -9.0848465124632973 0.097967074647777555 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23662118052248096 -0.20574559852158006 -0.64054804476594396 0.700983143851313 1
		 1 1 no;
	setAttr ".xm[216]" -type "matrix" "xform" 1 1 1 -0.99365940053776181 0.15394967857761332
		 -0.22640150308056317 0 2.1274797555267142 8.5265128291212022e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22328030716644459 -0.41420835725404437 -0.50483542982748153 0.72368399872006706 1
		 1 1 yes;
	setAttr ".xm[217]" -type "matrix" "xform" 1 1 1 -1.7127515388839774 -0.20224384528717648
		 -0.57917206034646818 0 2.639408073676293 -7.1054273576010019e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.7017785729713647 -0.32534900068867412 -0.021023075432680283 0.63341368201871673 1
		 1 1 yes;
	setAttr ".xm[218]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[219]" -type "matrix" "xform" 1 1 1 -0.58871132130422521 -2.902190415350382e-08
		 1.3813381944315262e-08 0 11.659360585550274 -10.690352657914914 0.51157115252927832 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.37693942322479668 0.61413663147404751 0.59970049279673476 -0.34801176422647118 1
		 1 1 no;
	setAttr ".xm[220]" -type "matrix" "xform" 1 1 1 -0.64116319438986236 0.23478917672635735
		 -0.28663701278127085 0 4.2885967811930641 4.9267299573330092e-08 3.2895343338168459e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22660364973293748 -0.25319576300284674 -0.2194805848851025 0.91453319479590889 1
		 1 1 yes;
	setAttr ".xm[221]" -type "matrix" "xform" 1 1 1 -0.24702108125275421 0.061810932937138387
		 -0.11375023769757539 0 4.5340884300743198 -2.8421709430404007e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092516220210340089 -0.063472909040306072 -0.003884960665585923 0.99367844189988319 1
		 1 1 yes;
	setAttr ".xm[222]" -type "matrix" "xform" 1 1 1 0.24913418041829566 -0.33161626926996085
		 -0.043267425329907419 0 4.532349631042166 -7.1054273576010019e-15 5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090439092198492763 0.078146807396151444 0.11412592256858679 0.98625002960404018 1
		 1 1 yes;
	setAttr ".xm[223]" -type "matrix" "xform" 1 1 1 0.14067995876799974 -0.42436195409338978
		 -0.11600463946360258 0 4.5179710886268225 -7.1054273576010019e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032243738609480932 0.056325887812229164 0.22075158847536744 0.97316826493071051 1
		 1 1 yes;
	setAttr ".xm[224]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[225]" -type "matrix" "xform" 1 1 1 -0.48711264523091796 8.2840213201580938e-09
		 1.4324810048774101e-08 0 13.118840755789563 -10.023280050816982 0.24307552472855182 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47657025244159062 0.53983229596189353 0.5313438850621367 -0.44624607844926117 1
		 1 1 no;
	setAttr ".xm[226]" -type "matrix" "xform" 1 1 1 -0.25707445750961794 0.2967392312547813
		 -0.095466686122511163 0 4.2576142635573255 7.0404809093815857e-08 -2.6201263381153694e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.070336992054541109 -0.13802067634345827 -0.31294420027560338 0.93705332183621048 1
		 1 1 yes;
	setAttr ".xm[227]" -type "matrix" "xform" 1 1 1 -0.82064730014139953 0.11277654776761636
		 -0.30591420501499944 0 4.4831290673189699 8.5265128291212022e-14 6.3948846218409017e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.33149761930554317 -0.24949646258216235 -0.11973951164966329 0.90195526103218948 1
		 1 1 yes;
	setAttr ".xm[228]" -type "matrix" "xform" 1 1 1 -0.29432373049685984 -0.16711771924131327
		 -0.22982205716715076 0 4.3959831042409974 1.4210854715202004e-14 -2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.052409745972236597 -0.037599698140709265 0.10867617125244583 0.99198234411140718 1
		 1 1 yes;
	setAttr ".xm[229]" -type "matrix" "xform" 1 1 1 0.019545786695121536 -0.43310121593267642
		 -0.14272019861866786 0 4.5214945161723961 1.1546319456101628e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.070891049651653909 0.083402588927564081 0.13365389970052929 0.98496451831236409 1
		 1 1 yes;
	setAttr ".xm[230]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[231]" -type "matrix" "xform" 1 1 1 -0.28955678051547729 -2.0562057726203384e-08
		 -1.1117330575951324e-08 0 14.07102776478655 -9.0881921846450808 0.4700482760667028 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52039384466942717 0.59301541921989354 0.47167965981558169 -0.3937527873093512 1
		 1 1 no;
	setAttr ".xm[232]" -type "matrix" "xform" 1 1 1 -0.52623215293941006 0.15241378971787767
		 -0.10414478433141151 0 5.4393351738680877 -8.9888089860323817e-08 8.9921812218562991e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092181342153629914 -0.19388876786037579 -0.27822862241370622 0.93621502846627713 1
		 1 1 yes;
	setAttr ".xm[233]" -type "matrix" "xform" 1 1 1 -0.67210954826355418 -0.047449864254822678
		 -0.25544739709196784 0 5.7224209536090171 2.8421709430404007e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.12971758998090704 -0.16717093037661793 0.071055743230454549 0.9747709003866134 1
		 1 1 yes;
	setAttr ".xm[234]" -type "matrix" "xform" 1 1 1 0.01134805204773333 -0.21486546896777364
		 -0.17319448231217699 0 5.6743041256576703 -3.5527136788005009e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.012271928225658608 0.025466011624172884 0.13759018857390604 0.99008576499098244 1
		 1 1 yes;
	setAttr ".xm[235]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[236]" -type "matrix" "xform" 1 1 1 -0.40909294887190145 -8.1833122077012283e-08
		 -2.8849972743301528e-08 0 14.76624914810327 -8.1360405532038698 0.49815024985889211 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.5155648583716258 0.59500971570831662 0.47579428496428899 -0.39214297573751666 1
		 1 1 no;
	setAttr ".xm[237]" -type "matrix" "xform" 1 1 1 -0.34249673052058849 0.25207708765604525
		 -0.099849212848047847 0 5.2768869299535481 -8.5265128291212022e-14 2.1316282072803006e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.08200328237693888 -0.14985466411081202 -0.32227306981757614 0.93110639015850361 1
		 1 1 yes;
	setAttr ".xm[238]" -type "matrix" "xform" 1 1 1 -0.59918926148009211 0.1167435112365946
		 -0.14972446037539391 0 5.2858940783937669 -2.8421709430404007e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.170454007603353 -0.13147989968328083 -0.077896840354802044 0.97344262775675139 1
		 1 1 yes;
	setAttr ".xm[239]" -type "matrix" "xform" 1 1 1 -0.2188257822137534 -0.1655517318743111
		 -0.29662490696246918 0 5.4754897225444665 -3.5527136788005009e-14 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.095565669962619129 -0.081410754277070119 0.12704581802047121 0.98392014510129 1
		 1 1 yes;
	setAttr ".xm[240]" -type "matrix" "xform" 1 1 1 0.014493922294741664 -0.20446607764127964
		 -0.47010882376847773 0 5.3259893014724184 7.1054273576010019e-14 -2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.065953319468648811 -0.10417388950270078 0.17022863969017771 0.97766056002386492 1
		 1 1 yes;
	setAttr ".xm[241]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[242]" -type "matrix" "xform" 1 1 1 -4.0579464155426279e-09 4.8375343939506078e-09
		 3.7644982343775473e-08 0 17.043317186369848 -2.0220670344563585 -0.32638396616415061 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.76030032532266922 0.39209918154902723 -0.24865310820127207 0.45428325846840611 1
		 1 1 no;
	setAttr ".xm[243]" -type "matrix" "xform" 1 1 1 0.2517434142673603 -0.14546472763342799
		 -0.036064088893669174 0 2.4893927647862739 0 -1.2042514541121818e-08 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.03716156970224125 0.10937765032783689 -0.26142534589096245 0.9582861450901905 1
		 1 1 yes;
	setAttr ".xm[244]" -type "matrix" "xform" 1 1 1 -0.17384261872883722 -0.092660793704895619
		 -0.010921304248149815 0 2.4527219098537731 -2.8421709430404007e-14 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0010591050938175248 0.033899055776556754 -0.092242225906682324 0.99515883359071822 1
		 1 1 yes;
	setAttr ".xm[245]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[246]" -type "matrix" "xform" 1 1 1 1.4055002272305548 -9.464370312269691e-09
		 -2.3201453279105333e-08 0 7.0454953501284479 -5.7686102140994953 -7.4789343609185917 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.32385315277634991 -0.9325115233988962 0.15221832518446413 -0.048692665188142616 1
		 1 1 no;
	setAttr ".xm[247]" -type "matrix" "xform" 1 1 1 0.30975139813597324 -0.04984133635443385
		 0.1734208267267284 0 3.8994339199381614 3.6402660441581247e-08 6.0726108586095506e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.054117112836187677 -0.035741148526551171 -0.060007380793525196 0.99608886282830156 1
		 1 1 yes;
	setAttr ".xm[248]" -type "matrix" "xform" 1 1 1 -1.6200961847375286 0.31271944462391843
		 0.30282210206782706 0 3.8753796785145767 -1.4210854715202004e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.26349488639961138 -0.13794692836691611 -0.039341044346965441 0.95393572740781596 1
		 1 1 yes;
	setAttr ".xm[249]" -type "matrix" "xform" 1 1 1 -0.53567510940198404 0.61880633472049906
		 0.039540374506785526 0 3.8738202249231222 2.8421709430404007e-14 -1.5987211554602254e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.30117490267905089 -0.21960656083056396 0.17430017250304658 0.91141981890994894 1
		 1 1 yes;
	setAttr ".xm[250]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[251]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.436168815274073 -9.2821712339051707
		 -0.086203643238799726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5370102245311007 -0.55464071945418225 0.46740594424565796 -0.43072656564951844 1
		 1 1 no;
	setAttr ".xm[252]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.6842749127368792 -7.2858385991025898e-17
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098149669675103565 0.21336511951404907 -0.35528274181868902 0.90477408311866347 1
		 1 1 yes;
	setAttr ".xm[253]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.086124694635906 -2.2204460492503131e-14
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15539376894301871 0.14386981915757893 -0.018142993932345093 0.97715151510930998 1
		 1 1 yes;
	setAttr ".xm[254]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.3542138218270701 -4.8849813083506888e-15
		 -3.1086244689504383e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.042345277449608434 0.047665405785576626 0.11559435084104877 0.99124811859728057 1
		 1 1 yes;
	setAttr ".xm[255]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[256]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.95422099999999999
		 -0.74553599999999998 1.2150244631780774e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[257]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.5853841945645684e-05
		 -2.8217865983027934 1.5924359185037456 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.35118023178006774 -0.35118036430445482 0.61373646201463816 0.61373638618517878 1
		 1 1 yes;
	setAttr ".xm[258]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0333029283221162 1.1471967024358105e-16
		 -1.9003452463541333e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.1167210741668856 0 0.99316473499884617 1
		 1 1 yes;
	setAttr ".xm[259]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0134628592404753 -3.119115312198905e-17
		 -2.5729418595688003e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.15232175999380265 0 0.98833095743905053 1
		 1 1 yes;
	setAttr ".xm[260]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92213062093366782
		 1.3035083173738416e-16 3.8094527532450684e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.070148210841866954 0 0.99753658003889012 1 1 1 yes;
	setAttr ".xm[261]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.94821701958468041
		 2.0002410538132562e-16 -2.5673907444456745e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.039329575009993872 0 0.99922629295346965 1 1 1 yes;
	setAttr ".xm[262]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.76201279828011625
		 1.8913872956232026e-16 -2.541022947610827e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.031340980280144204 0 0.99950875081465873 1 1 1 yes;
	setAttr ".xm[263]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.62797717990570079
		 1.7383309535097934e-16 1.609823385706477e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[264]" -type "matrix" "xform" 1.0000000000000007 1.0000000000000011 1.0000000000000002 -1.1102229047307621e-16
		 2.1598257482491371e-07 -1.6653342372017294e-16 0 -2.2147732164010279 -8.523143920105273
		 1.2575274408751927e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[265]" -type "matrix" "xform" 1 1 1 -8.7136201032385965e-13 3.1941463363200889e-13
		 9.1674064173194422e-13 0 -1.7763568394002505e-15 5.6843418860808015e-14 -7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[266]" -type "matrix" "xform" 1 1 1 -2.4286128663675299e-17 3.1225022567582528e-17
		 -5.2041704279304213e-18 0 -2.8421709430404007e-14 -1.1368683772161603e-13 1.9539925233402755e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[267]" -type "matrix" "xform" 1 1 1 -4.4354204941136489e-16 -1.6431944693806747e-10
		 -6.6597161674231131e-09 0 -1.8825256038787472 -7.8514162718883158 -1.558421627436785 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612976018935651 0.49379419236729649 -0.50612817754426698 0.49379573644444624 1
		 1 1 no;
	setAttr ".xm[268]" -type "matrix" "xform" 1 1 1 6.2831853043861097 -3.1685629667824836e-09
		 6.2831853077357485 0 -1.8675766147055697 -7.8926128892540381 -1.5291612942300026 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64305812804792051 0.19111865506375916 -0.67699473568429369 0.30270122479745171 1
		 1 1 no;
	setAttr ".xm[269]" -type "matrix" "xform" 1 1 1 6.2831853057768798 -1.9450387124955158e-09
		 6.2831853085042191 0 -1.8665142437048132 -7.9639889621071527 -1.4469206940003723 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65557417648337579 0.011913804084112078 -0.65207995547049813 0.38062092963207134 1
		 1 1 no;
	setAttr ".xm[270]" -type "matrix" "xform" 1 1 1 6.2831853065749534 -1.1028419841032536e-09
		 6.2831853081667592 0 -1.8407136884509612 -8.0812925426506368 -1.321099832351605 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66143441675356773 -0.085189985898714626 -0.63826999606174195 0.38452384940831497 1
		 1 1 no;
	setAttr ".xm[271]" -type "matrix" "xform" 1 1 1 6.283185307083853 -5.3285271331980662e-10
		 6.2831853076414319 0 -1.7962104843565214 -8.2478767133366233 -1.1312591025739318 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65636076819940237 -0.19668151839946188 -0.6660229843433092 0.29482250018477996 1
		 1 1 no;
	setAttr ".xm[272]" -type "matrix" "xform" 1 1 1 6.2831853071794921 -1.4701712069963894e-12
		 6.2831853071806592 0 -1.7428545598614278 -8.454043694267849 -0.85216878537911978 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6887583188119174 -0.1937555132678557 -0.65499673991219631 0.24300216058727891 1
		 1 1 no;
	setAttr ".xm[273]" -type "matrix" "xform" 1 1 1 6.2831853071796466 -1.3754735198046403e-12
		 1.1927507592712356e-12 0 -1.7177228070475223 -8.6485379619927407 -0.54517255800719666 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67791117584788774 0.25397256167209059 0.64651697239396388 -0.24072843617818168 1
		 1 1 no;
	setAttr ".xm[274]" -type "matrix" "xform" 1 1 1 6.2831853071796742 -1.3304669865821784e-12
		 1.2418364947474585e-12 0 -1.7095304714105737 -8.7439447768268934 -0.33261841471678033 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.66584691905237059 0.27429577238237313 0.649420098353787 -0.24426060979163394 1
		 1 1 no;
	setAttr ".xm[275]" -type "matrix" "xform" 1 1 1 6.2831853071795871 -1.3078626723284087e-12
		 6.2831853071808563 0 -1.7194483528268449 -8.7895647512090065 -0.16174460007928099 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66165950988240652 -0.26336086847177403 -0.64876398882268638 0.26824062471378862 1
		 1 1 no;
	setAttr ".xm[276]" -type "matrix" "xform" 1 1 1 6.2831853071796537 -1.3694982647916425e-12
		 6.283185307180787 0 -1.7329321149119608 -8.8201061450118772 -0.0042007890812100577 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69246881376264713 -0.25147600152334765 -0.62946276891640662 0.24702911806520322 1
		 1 1 no;
	setAttr ".xm[277]" -type "matrix" "xform" 1 1 1 6.2831853071795862 -1.3071332211067599e-12
		 -6.2831853071783161 0 -1.7194493365969663 -8.7895646830348433 0.15407540843549086 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64876198427345444 -0.26824158877185539 -0.6616614725041462 0.26335989371649915 1
		 1 1 no;
	setAttr ".xm[278]" -type "matrix" "xform" 1 1 1 6.2831853071794983 -1.3306985721661121e-12
		 1.2421157852272079e-12 0 -1.709532525858549 -8.743944634455957 0.32692161265999414 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64941808409672175 -0.24426160641853964 -0.66584888980715995 0.27429486984001406 1
		 1 1 no;
	setAttr ".xm[279]" -type "matrix" "xform" 1 1 1 6.2831853071795258 -1.3763842496294563e-12
		 1.1932503596323999e-12 0 -1.7177262186002622 -8.6485386805902777 0.54248745661699793 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6465149150270163 -0.24072937500204919 -0.67791313727458669 0.25397167355683603 1
		 1 1 no;
	setAttr ".xm[280]" -type "matrix" "xform" 1 1 1 6.2831853071796804 -1.4704626405404545e-12
		 -6.2831853071785142 0 -1.7428598916070257 -8.454044279798179 0.85193128699658638 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6549946359894947 0.24300291381025024 0.68876030629496843 -0.19375461588612264 1
		 1 1 no;
	setAttr ".xm[281]" -type "matrix" "xform" 1 1 1 6.2831853072753194 -5.3285290765304997e-10
		 -6.2831853067177406 0 -1.7962175321030998 -8.2478762249357089 1.1312809994200437 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6660209816770758 0.2948232564432568 0.65636277833530976 -0.1966804582109038 1
		 1 1 no;
	setAttr ".xm[282]" -type "matrix" "xform" 1 1 1 6.283185307784219 -1.1028424565449165e-09
		 -6.2831853061924132 0 -1.840721918889443 -8.0812919722905043 1.3211201879297041 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.63826796220002224 0.3845242453439251 0.66143631918145218 -0.085188666144083325 1
		 1 1 no;
	setAttr ".xm[283]" -type "matrix" "xform" 1 1 1 6.2831853085822935 -1.9450384645534075e-09
		 -6.2831853058549534 0 -1.8665232579947997 -7.9639883374269909 1.4469394076853499 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65207791250723812 0.38062100966311407 0.65557613864712228 0.011915093779042596 1
		 1 1 no;
	setAttr ".xm[284]" -type "matrix" "xform" 1 1 1 6.2831853099730637 -3.1685618581130845e-09
		 -6.283185306623424 0 -1.8675861413458961 -7.8926122290685745 1.5291787783869248 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67699271253233562 0.30270071874162335 0.64306018574324142 0.19111969956883793 1
		 1 1 no;
	setAttr ".xm[285]" -type "matrix" "xform" 1 1 1 2.7780763396607956e-16 -1.1148759693213544e-10
		 -4.5184902486283818e-09 0 -1.8825353128066524 -7.8514155990705268 1.5584382854203351 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975964732398 0.49379419289612164 -0.50612817808630073 0.49379573591562304 1
		 1 1 no;
	setAttr ".xm[286]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825256038787472 -7.8514162718883158
		 -1.558421627436785 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[287]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.8948587124511391 -7.8444173295206392
		 -1.5321763594664928 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39662690245854215 -0.45199488038181301 -0.61337259146967793 0.51201737508461975 1
		 1 1 no;
	setAttr ".xm[288]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.9122784361071297 -7.8701407551794054
		 -1.4351866804222122 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34531075875321526 -0.3921319497726255 -0.65360120409052325 0.54753856473148632 1
		 1 1 no;
	setAttr ".xm[289]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795853
		 6.2831853071795862 -6.2831853071795853 0 -1.9380812291148857 -7.9409271871768423
		 -1.2947925508541605 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31220752909447685 -0.36268486817606038 -0.67938606833492221 0.55625598003549714 1
		 1 1 no;
	setAttr ".xm[290]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795862
		 6.2831853071795871 -6.2831853071795871 0 -1.975087508500792 -8.0460690950090807
		 -1.1300509599736959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.30140935602809049 -0.36386870791348802 -0.69238230286542657 0.54530607018340582 1
		 1 1 no;
	setAttr ".xm[291]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795845 0 -2.0401621860136459 -8.2018743957734479 -0.89309135134282558 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31802914751199135 -0.35089191239675305 -0.6669881042438367 0.5752036125969292 1
		 1 1 no;
	setAttr ".xm[292]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795871
		 -6.2831853071795853 0 -2.1161383932623323 -8.3810965537053299 -0.61618121607523502 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39321321601051529 -0.41761555105483644 -0.61004571434593735 0.54664873975889527 1
		 1 1 no;
	setAttr ".xm[293]" -type "matrix" "xform" 1 1 1 6.2831853071795871 6.2831853071795862
		 -6.2831853071795871 0 -2.1742652677366152 -8.4655707124831068 -0.36965220402961513 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.45054194021294525 -0.46587727597940454 -0.5603292069660184 0.51575333605900942 1
		 1 1 no;
	setAttr ".xm[294]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795862 0 -2.2029916703461367 -8.4924568266441369 -0.18224446339057085 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.46684447698938986 -0.47002177105963616 -0.54433894842053732 0.51461721528422433 1
		 1 1 no;
	setAttr ".xm[295]" -type "matrix" "xform" 1 1 1 -12.566370614359172 -1.6564237503326203e-16
		 12.566370614359172 0 -2.2191402248840006 -8.5126716149447432 -0.0060345197239753869 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5210154231410371 -0.5083398673784898 -0.48865441014361111 0.48098895572558131 1
		 1 1 no;
	setAttr ".xm[296]" -type "matrix" "xform" 1 1 1 -9.1962028270220486e-16 -8.2704296969910748e-17
		 12.566370614359171 0 -2.2029321890367441 -8.492528786055118 0.17440806533623612 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.54433759463077147 -0.51461878119465521 -0.46684606036008436 0.47002005174203154 1
		 1 1 no;
	setAttr ".xm[297]" -type "matrix" "xform" 1 1 1 12.566370614359171 7.4891265064436157e-17
		 12.566370614359172 0 -2.1742514249500005 -8.4657100176875062 0.36412567824223924 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.56032790469742466 -0.51575488393289992 -0.45054357494389541 0.4658755477523252 1
		 1 1 no;
	setAttr ".xm[298]" -type "matrix" "xform" 1 1 1 1.1830814106161824e-15 1.7227972520794604e-16
		 12.566370614359174 0 -2.1150330315333292 -8.3790821265202631 0.61877412209008509 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61004457916828103 -0.54665012594444418 -0.39321499765955675 0.41761371726502594 1
		 1 1 no;
	setAttr ".xm[299]" -type "matrix" "xform" 1 1 1 12.566370614359171 2.0860049798621125e-16
		 12.566370614359172 0 -2.0402234834052706 -8.2020127510352054 0.89283242467045199 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66698718996922646 -0.57520477368749168 -0.31803110203459156 0.35088997546629919 1
		 1 1 no;
	setAttr ".xm[300]" -type "matrix" "xform" 0.99999999999999989 1 1 -2.4980018054066022e-16
		 3.6255720647915268e-16 12.566370614359172 0 -1.9750538808291935 -8.0459548058728814
		 1.1302538249888108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69238144193930851 -0.54530726917128136 -0.30141139418492574 0.36386686095672788 1
		 1 1 no;
	setAttr ".xm[301]" -type "matrix" "xform" 0.99999999999999989 1 1 12.566370614359172
		 -2.4806545706468351e-16 12.566370614359172 0 -1.9381093551659774 -7.9409834837403457
		 1.2947041851289773 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67938517528829057 -0.55625717616120429 -0.31220952710024397 0.36268298658126158 1
		 1 1 no;
	setAttr ".xm[302]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 -3.8857805861880469e-16
		 -8.2833045977892613e-17 12.566370614359172 0 -1.9125580899236638 -7.8708159193851843
		 1.4337036903747025 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65360021304210603 -0.54753986080091888 -0.34531267642342445 0.39213010321411845 1
		 1 1 no;
	setAttr ".xm[303]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 12.566370614359172
		 1.2945373939476918e-16 12.566370614359172 0 -1.8938496260620354 -7.8449955301582817
		 1.5343610860101882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61337145460518805 -0.51201886772879657 -0.39662870375810466 0.45199315162998033 1
		 1 1 no;
	setAttr ".xm[304]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825353128066524 -7.8514155990705268
		 1.5584382854203354 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[305]" -type "matrix" "xform" 1 1 1 3.1005292266810725e-08 2.1148490762399202e-07
		 -3.1079389114420901e-08 0 4.8977792049080051 -5.1625618604184824 -3.0255378400541928 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65179301766768583 0.48951258216125237 -0.42813074108507698 0.39018888062503504 1
		 1 1 no;
	setAttr ".xm[306]" -type "matrix" "xform" 1 1 1 0.49834220988984118 0.30627952379061368
		 -0.52909698088640933 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[307]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225514
		 -0.55413068517555075 2.012230831065116 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[308]" -type "matrix" "xform" 1 1 1 -8.2840640233110677e-10 -2.0433946057473432e-07
		 -7.8271160943146079e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[309]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.901761559953421 -0.4400146041309938
		 2.0127867015537824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[310]" -type "matrix" "xform" 1 1 1 -1.664122574395709e-09 -2.0833728584711331e-07
		 -1.4960872611444271e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[311]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8428479870225871
		 -0.18680962154292047 2.0498306576013903 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[312]" -type "matrix" "xform" 1 1 1 -4.4747798214463139e-09 -2.1481279191168167e-07
		 -3.4359190717270576e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[313]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6513768631751731
		 0.21907843343558397 2.1506761056780022 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[314]" -type "matrix" "xform" 1 1 1 -1.0361694732866221e-08 -2.2151459530258195e-07
		 -5.7974875983844382e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[315]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3051931605799645
		 0.64753869982504852 2.3327372183632082 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[316]" -type "matrix" "xform" 1 1 1 -1.7320393411859419e-08 -2.2502606366396108e-07
		 -6.3307502029031801e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[317]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.9143507297367961
		 0.92020894931957287 2.5015859093419923 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[318]" -type "matrix" "xform" 1 1 1 -2.5445130220729105e-08 -2.2532170881614217e-07
		 -4.014963090252103e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[319]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.41712374201814839
		 1.0593653880451654 2.6435531694482233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[320]" -type "matrix" "xform" 1 1 1 -3.190568315011897e-08 -2.2289943559674655e-07
		 9.9402877218481709e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[321]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.083717869653032295
		 1.0397697937033286 2.6871212004845244 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[322]" -type "matrix" "xform" 1 1 1 -3.6079726452084256e-08 -2.1926283188589039e-07
		 8.0179502415478777e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[323]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.58789356729054276
		 0.91744020449246477 2.6454439544465114 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[324]" -type "matrix" "xform" 1 1 1 -3.7396839938730265e-08 -2.1537079319162405e-07
		 1.6010125581981647e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[325]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0720351163478199 0.67978613269733046
		 2.504085411743338 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[326]" -type "matrix" "xform" 1 1 1 -3.6216028457075853e-08 -2.1266279747213787e-07
		 2.2657445523747539e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[327]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.4569764020345559 0.37641624804336971
		 2.3288544077870892 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[328]" -type "matrix" "xform" 1 1 1 -3.4538128080462249e-08 -2.1165486210934367e-07
		 2.6389732584957976e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[329]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.683324729950602 0.15791258580162548
		 2.2030869602475871 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[330]" -type "matrix" "xform" 1 1 1 -3.367774831740739e-08 -2.1142378280090454e-07
		 2.7785074916686697e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[331]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830005 0.063639944138571991
		 2.1502427556486268 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[332]" -type "matrix" "xform" 1 1 1 -6.4834891247562247e-10 -2.025742260656978e-07
		 -6.1929112210620829e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[333]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225514
		 -0.55413068517555075 2.012230831065116 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[334]" -type "matrix" "xform" 1 1 1 -1.445557769773017e-09 -2.0185979906885197e-07
		 -1.3155000906206124e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[335]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8506016512536547
		 -0.59243673710298594 2.0335628223445017 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[336]" -type "matrix" "xform" 1 1 1 -4.2411285983377584e-09 -1.997631357588286e-07
		 -3.2927039771929791e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[337]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6364599551777239
		 -0.70627961864414601 2.1078232484508561 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[338]" -type "matrix" "xform" 1 1 1 -9.1443072315415327e-09 -1.9721820002506209e-07
		 -5.4537058067462486e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[339]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3189053392455712
		 -0.84994631869369641 2.2114279058556701 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[340]" -type "matrix" "xform" 1 1 1 -1.6113930557458474e-08 -1.9536765121410154e-07
		 -6.3803359897679159e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[341]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92219956674101411
		 -0.98703341618511331 2.3290718401988943 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[342]" -type "matrix" "xform" 1 1 1 -2.569099510587126e-08 -1.9554379646801572e-07
		 -3.8784512095213989e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[343]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.36773835626902951
		 -1.0933495407931844 2.4359116826740337 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[344]" -type "matrix" "xform" 1 1 1 -3.2663938161256452e-08 -1.9813898893499142e-07
		 1.874227962805391e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[345]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.14225480745387031
		 -1.1122214925050855 2.4792086530559629 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[346]" -type "matrix" "xform" 1 1 1 -3.658448467951151e-08 -2.0224406229853182e-07
		 9.434842533308028e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[347]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.63081150567859012
		 -1.0184191038586903 2.4460305010268968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[348]" -type "matrix" "xform" 1 1 1 -3.7450513623057725e-08 -2.0592254278816584e-07
		 1.5943511654662818e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[349]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0143511103689882 -0.84258197477467434
		 2.3826599599763458 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[350]" -type "matrix" "xform" 1 1 1 -3.6906885292331896e-08 -2.0836109096952292e-07
		 2.0394194882311313e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[351]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.2768222604636534 -0.63371529019519812
		 2.3106343541978145 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[352]" -type "matrix" "xform" 1 1 1 -3.5721108749179831e-08 -2.1009830120158472e-07
		 2.4054550412573915e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[353]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.5095055663478725 -0.38621291736137664
		 2.2416218081692971 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[354]" -type "matrix" "xform" 1 1 1 -3.4551784760320525e-08 -2.1098125107312762e-07
		 2.6399085652106398e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[355]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6700046218427325 -0.15828365563569946
		 2.1857435417215925 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[356]" -type "matrix" "xform" 1 1 1 -3.3677749901210003e-08 -2.1142377802617302e-07
		 2.7785076246352328e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[357]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830005 0.063639944138571991
		 2.1502427556486214 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[358]" -type "matrix" "xform" 1 1 1 -7.2270448430293699e-09 -2.1591548370108326e-07
		 -2.0564798882655632e-09 0 0.083717268904223374 1.0397698796429609 2.6871211859469906 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209614 -0.01732673914736188 -0.054206990661288729 0.99527072079149959 1
		 1 1 yes;
	setAttr ".xm[359]" -type "matrix" "xform" 1 1 1 -6.6170082868012172e-11 -5.2777739643744211e-11
		 4.8759722676698461e-12 0 0.14242158253221859 -1.1122180545978608 2.4792041459058893 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274875672208086 0.012855654817866638 -0.074198286521042198 0.99711886723061027 1
		 1 1 yes;
	setAttr ".xm[360]" -type "matrix" "xform" 1 1 1 0.10364137184880047 -0.0053000494540148772
		 0.35836950924492161 0 -1.2997743370483512 0.64071898021839502 2.3341839743222934 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089968452397532442 -0.27124541290781967 -0.032274665279149017 0.95775255130476067 1
		 1 1 yes;
	setAttr ".xm[361]" -type "matrix" "xform" 1 1 1 5.1168433250912356e-08 -2.0984148939156934e-07
		 -0.2654357220276109 0 1.0662731636068834 0.67192514206931264 2.5009029203714821 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.065057965514676644 0.19944902313067039 -0.070024549757776403 0.97523541297808347 1
		 1 1 yes;
	setAttr ".xm[362]" -type "matrix" "xform" 1 1 1 9.2852030667262482e-09 -2.1434760788957048e-07
		 2.5393769589002867e-08 0 -0.91942591903668713 -0.98083258183578437 2.3247648013731599 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258928005 -0.094092400772244497 -0.081393910043315199 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[363]" -type "matrix" "xform" 1 1 1 -1.5310318264371994e-07 -1.4762871270962601e-07
		 0.73374126969787457 0 1.2767232674260036 -0.63316612625669677 2.3114565207102906 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.036310446668287463 0.18874460055130868 -0.068116033193234712 0.97898786164461427 1
		 1 1 yes;
	setAttr ".xm[364]" -type "matrix" "xform" 1 1 1 -4.2188058602083735e-11 -3.2005124245332403e-11
		 -2.3731962568905957e-12 0 -1.8415442721152147 0.53882220307929174 2.1607462442420857 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18364789511409785 -0.16327168456973754 0.38197916478446375 0.89090275861537493 1
		 1 1 yes;
	setAttr ".xm[365]" -type "matrix" "xform" 1 1 1 -3.0767520475764811e-11 -4.3098710364489831e-11
		 -2.3855995297559274e-12 0 -1.4782201886627462 0.92915995471909696 2.2581012505222482 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279457351529084 -0.2041408319858658 0.24397191038610644 0.9339711743371133 1
		 1 1 yes;
	setAttr ".xm[366]" -type "matrix" "xform" 1 1 1 -1.6787268623748906e-11 -5.0222976060081451e-11
		 -2.3520895106937167e-12 0 -1.008194076838091 1.233727124026359 2.4101979372509081 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003998754952359 -0.13325847765132248 0.097328953220419082 0.98013287575673647 1
		 1 1 yes;
	setAttr ".xm[367]" -type "matrix" "xform" 1 1 1 -7.2335366862393327e-12 -5.2457873656918142e-11
		 -2.3850223009925876e-12 0 -0.43756942257016007 1.3740585931925295 2.5662376537978169 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08782850160250745 -0.073005731704837012 0.00062653087303683047 0.993456554109723 1
		 1 1 yes;
	setAttr ".xm[368]" -type "matrix" "xform" 1 1 1 5.2679770268906823e-12 -5.2691570182575559e-11
		 -2.5386290293527681e-12 0 0.088691852656662462 1.377613015388846 2.6357312381437197 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179930946433952 0.025570101570747766 -0.12537050949400147 0.98885035438931446 1
		 1 1 yes;
	setAttr ".xm[369]" -type "matrix" "xform" 1 1 1 1.3623394079581829e-11 -5.1171582596246253e-11
		 -2.8304164571157472e-12 0 0.64581895626352193 1.2361821128119459 2.6147490036525944 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08302621016941017 0.12036288508314086 -0.21035049969512737 0.96662924205580381 1
		 1 1 yes;
	setAttr ".xm[370]" -type "matrix" "xform" 1 1 1 2.2817220335443616e-11 -4.7786045953532938e-11
		 -3.1074587353197541e-12 0 1.1910360206362576 0.97244359768617983 2.5037355652675011 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199138466527528 0.17192327577532207 -0.3005309751392517 0.93258848249514259 1
		 1 1 yes;
	setAttr ".xm[371]" -type "matrix" "xform" 1 1 1 3.3207575578308265e-11 -4.1248282567290161e-11
		 -3.7326114428380778e-12 0 1.6303005776548574 0.62516010491745533 2.3474455111359305 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214051530672434 0.24209093085439834 -0.40455846701440484 0.87035653721526351 1
		 1 1 yes;
	setAttr ".xm[372]" -type "matrix" "xform" 1 1 1 3.9991121525488847e-11 -3.4710595508887009e-11
		 -4.0915881800719941e-12 0 1.88607497790764 0.27366056866094368 2.2146113775048288 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383053603373361 0.25974188268956622 -0.47782105644473855 0.82097754971566561 1
		 1 1 yes;
	setAttr ".xm[373]" -type "matrix" "xform" 1 1 1 1.0408403104515979e-17 -5.2954076887323787e-11
		 -2.3510429714157514e-12 0 1.9903089863693886 0.073126376516910341 2.150529464487267 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018783301713158 -0.1622475379965643 -0.060171158694305706 0.98097291596736969 1
		 1 1 yes;
	setAttr ".xm[374]" -type "matrix" "xform" 1 1 1 -0.00020942154066701382 0.00064656522961714733
		 0.0011213558940740124 0 -1.8415442721152644 0.53882220307920647 2.1607462442420982 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635703914590389 -0.10419109701550218 0.39729100105206633 0.90974028557414954 1
		 1 1 yes;
	setAttr ".xm[375]" -type "matrix" "xform" 1 1 1 -4.859151275138007e-13 -5.2946289713640734e-11
		 -2.4756672406405371e-12 0 0.090138694212775761 1.3933507902455062 2.6435101973089505 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490162301620583 -0.07397825714305363 -0.059407940992506889 0.99189683258459549 1
		 1 1 yes;
	setAttr ".xm[376]" -type "matrix" "xform" 1 1 1 -0.00040368505052095269 -0.00045044459247356976
		 -0.0012710992754142753 0 1.8940854349569634 0.27923234072866876 2.2118679046868692 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671788206761885 0.085969143739353798 -0.38565737410528028 0.91839554294175296 1
		 1 1 yes;
	setAttr ".xm[377]" -type "matrix" "xform" 1 1 1 5.7762735572936142e-13 -5.2954184440178638e-11
		 -2.2790319978580338e-12 0 -1.9005620307747684 -0.5518137729151249 2.0009549927581158 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892722284055417 -0.039558279527996974 -0.070604718981914047 0.99351259131644254 1
		 1 1 yes;
	setAttr ".xm[378]" -type "matrix" "xform" 1 1 1 1.9381733676761222e-08 -5.2953749651655156e-11
		 -1.6403846437959249e-08 0 1.7739757398722382 0.063860529367332219 2.1504218347892703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537172867420804 0.26549863850734806 -0.09161642970614664 0.95819757854748955 1
		 1 1 yes;
	setAttr ".xm[379]" -type "matrix" "xform" 1 1 1 -3.1005296175097963e-08 -2.1148490693792196e-07
		 3.1079396559751079e-08 0 4.8974606715216282 -5.1625538842295233 3.0255988686508091 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.48951389000388029 -0.65179176827743435 -0.39018721510704873 -0.42813266573113745 1
		 1 1 no;
	setAttr ".xm[380]" -type "matrix" "xform" 1 1 1 6.283185307139437 -1.691866915670064e-10
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1.0275841211271339e-07 0 0.99999999999999467 1
		 1 1 yes;
	setAttr ".xm[381]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407374 0.55361168484853351
		 -2.0121505001216367 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[382]" -type "matrix" "xform" 1 1 1 6.2831834777536537 -7.6260061262469617e-06
		 -6.2831870313297804 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[383]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9017475930669754 0.43989678048490077
		 -2.0127687111993176 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[384]" -type "matrix" "xform" 1 1 1 6.283192743436123 -2.4064184400022912e-05
		 -6.2831786216370435 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[385]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.8427478699924755 0.18611709322672709
		 -2.0497229357518076 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[386]" -type "matrix" "xform" 1 1 1 -9.4247607596253147 3.1416441391713117
		 3.1416058582721185 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[387]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6513189699522428 -0.21949107321481165
		 -2.1506126723226764 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[388]" -type "matrix" "xform" 1 1 1 -3.1415612628268654 3.1416730457082229
		 3.141610217482913 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[389]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3052215051098663 -0.6473753419713546
		 -2.3327639497828034 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[390]" -type "matrix" "xform" 1 1 1 -3.141565465772318 3.1416722639098977
		 3.1416025906685041 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[391]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.91437234838192794
		 -0.92013477945110367 -2.5016174983116457 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[392]" -type "matrix" "xform" 1 1 1 -3.1415723290649904 3.1416376445391214
		 3.1415958561675876 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[393]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.41701125790985216
		 -1.0601170330202194 -2.6434264207041647 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[394]" -type "matrix" "xform" 1 1 1 1.7425805181374886e-05 6.2831825452840677
		 -5.4245412396542647e-07 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[395]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.083744097464105494
		 -1.0399260121630789 -2.6870785872144882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[396]" -type "matrix" "xform" 1 1 1 1.2693526097136423e-05 6.283214088528303
		 -2.8122587644200276e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[397]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.58794971646821637
		 -0.9178402388111806 -2.6453821064307608 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[398]" -type "matrix" "xform" 1 1 1 1.5381657927121628e-05 6.2832188663890669
		 -6.5651340723563942e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[399]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0720354286874141
		 -0.67981279993915678 -2.5040824246573692 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[400]" -type "matrix" "xform" 1 1 1 8.3656757013608564e-06 6.2832054104990904
		 -5.2010808494964904e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[401]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.4570052721775539
		 -0.37663416137019112 -2.3288206309923964 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[402]" -type "matrix" "xform" 1 1 1 5.4110698190280008e-06 6.2831907162611085
		 -4.1141251738219395e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[403]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6833662884828122
		 -0.15821562273086442 -2.2030402065381196 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[404]" -type "matrix" "xform" 1 1 1 5.4871734328989679e-08 6.2831855193676329
		 2.424508580468098e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[405]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758332
		 -0.063688645826488255 -2.1502361142816646 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[406]" -type "matrix" "xform" 1 1 1 6.283185307139437 2.0534763752778872e-07
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[407]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407374 0.55361168484853351
		 -2.0121505001216367 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[408]" -type "matrix" "xform" 1 1 1 6.2831857368727118 -9.6775282638451468e-07
		 -6.2831849161452924 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[409]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.8504942069427806 0.59169526363587011
		 -2.033447643083564 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[410]" -type "matrix" "xform" 1 1 1 6.2831870256632865 -2.7747909729560291e-06
		 -6.2831839729904075 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[411]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.636464875552555 0.70628849354667977
		 -2.1078251817848379 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[412]" -type "matrix" "xform" 1 1 1 6.2831887525327561 -3.4914099042060667e-06
		 -6.2831832523585769 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[413]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3188063863827182 0.84926055027784741
		 -2.211321366508697 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[414]" -type "matrix" "xform" 1 1 1 6.283186499846197 -7.6909015776679209e-07
		 -6.2831848349460371 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[415]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92212606378262052
		 0.98651736715831362 -2.3289921614483227 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[416]" -type "matrix" "xform" 1 1 1 6.2831814995216435 2.1715219251396469e-05
		 -6.2831858857056826 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[417]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.36766900114157863
		 1.0928620039817076 -2.4358357948869731 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[418]" -type "matrix" "xform" 1 1 1 6.2831550232537685 6.9571799983719759e-05
		 1.7396942165332526e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[419]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.14222208218171062
		 1.1124159575755357 -2.4792399288635174 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[420]" -type "matrix" "xform" 1 1 1 6.2831297046218744 0.00011709473560854273
		 1.4350585037239655e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[421]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.63086954984229493
		 1.0180083928160286 -2.445966860699027 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[422]" -type "matrix" "xform" 1 1 1 6.2831124886687117 0.00013760109368610648
		 3.1022076281352182e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[423]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0144414120572769
		 0.84195399111774805 -2.3825621868996532 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[424]" -type "matrix" "xform" 1 1 1 6.2831085925143197 0.00013233797747792705
		 4.2422124632536497e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[425]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2768198175289669
		 0.6337044593575456 -2.3106336851512523 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[426]" -type "matrix" "xform" 1 1 1 6.2831274499323984 9.9294363699924888e-05
		 3.8927715753699082e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[427]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.5095680133972813
		 0.3857722161510253 -2.2415536902277662 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[428]" -type "matrix" "xform" 1 1 1 12.566339093615564 5.3566477875247642e-05
		 6.2832094222993158 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[429]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.670090951300331 0.15768375781621558
		 -2.1856500572382878 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[430]" -type "matrix" "xform" 1 1 1 5.4871726338854156e-08 6.2831855193676382
		 2.4252473123899102e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[431]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758332
		 -0.063688645826488255 -2.1502361142816646 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[432]" -type "matrix" "xform" 1 1 1 7.2270430958825361e-09 2.1591548446684657e-07
		 2.0564790140118618e-09 0 -0.08374469820877195 -1.039925926224015 -2.6870786017511907 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209892 -0.017326739147361585 -0.054206990661288007 0.9952707207914997 1
		 1 1 yes;
	setAttr ".xm[433]" -type "matrix" "xform" 1 1 1 4.4155530427770434e-09 5.2777770446013385e-11
		 -4.8764757071011789e-12 0 -0.14246364064053552 1.111925119629916 -2.4791563476353051 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274720089168961 0.012855868281954794 -0.074198315184487218 0.99711886248793169 1
		 1 1 yes;
	setAttr ".xm[434]" -type "matrix" "xform" 1 1 1 -8.255627292896861e-08 -3.1415924552526793
		 -2.2864956150669968e-08 0 1.2997323877743199 -0.64101202232799892 -2.3341367938949915 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087241177286391219 -0.24582379979002997 0.15223950242423173 0.9533009862284304 1
		 1 1 yes;
	setAttr ".xm[435]" -type "matrix" "xform" 1 1 1 4.8377458483628288e-08 -3.1415924437483032
		 4.9291246639882047e-09 0 -1.0663151974821972 -0.67221804415686393 -2.5008549191160636 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090878646671435137 0.18908602085785248 -0.19846026990574109 0.95739285017397791 1
		 1 1 yes;
	setAttr ".xm[436]" -type "matrix" "xform" 1 1 1 1.7252994588545789e-09 -3.141592439242185
		 -2.5393772418169647e-08 0 0.91938398463565107 0.98053956659313712 -2.3247174258871564 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258927571 -0.094092400772244747 -0.081393910043314976 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[437]" -type "matrix" "xform" 1 1 1 -1.5351977022959318e-07 -3.1415925059610723
		 -3.7962259114010521e-08 0 -1.2767648498227935 0.63287314458960964 -2.3114085656174659 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10159609039787926 0.16316006616322959 0.28757587279425023 0.93827349137237259 1
		 1 1 yes;
	setAttr ".xm[438]" -type "matrix" "xform" 1 1 1 4.2188481874687819e-11 3.2005471189927497e-11
		 2.37230547773593e-12 0 1.8415064518602078 -0.53897067132891152 -2.1606717130969457 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.1836477917828139 -0.16327150229346379 0.3819791708688603 0.89090281071195965 1
		 1 1 yes;
	setAttr ".xm[439]" -type "matrix" "xform" 1 1 1 3.0767874359456707e-11 4.3099150984179343e-11
		 2.3848154360708408e-12 0 1.4782174567261905 -0.93053018598536141 -2.2577112041161485 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279449930527945 -0.20414063697037549 0.24397190945446856 0.93397123014063621 1
		 1 1 yes;
	setAttr ".xm[440]" -type "matrix" "xform" 1 1 1 1.6787461178172851e-11 5.0223528677889282e-11
		 2.3515344068007828e-12 0 1.0079696133229659 -1.2364652224000565 -2.4095905251895697 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003994071765356 -0.13325826996625711 0.097328941894998411 0.98013291037596306 1
		 1 1 yes;
	setAttr ".xm[441]" -type "matrix" "xform" 1 1 1 7.2336303614321482e-12 5.2458536646529363e-11
		 2.3849944373762158e-12 0 0.4370771531536124 -1.377367917365433 -2.5656936294083401 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087828472935711638 -0.073005518894025734 0.0006265163043274128 0.99345657229197259 1
		 1 1 yes;
	setAttr ".xm[442]" -type "matrix" "xform" 1 1 1 -5.2680360073551046e-12 5.2692179178949222e-11
		 2.5384707355580039e-12 0 -0.089247510662981977 -1.3809657735308178 -2.6351800514961585 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179926004818169 0.025570316952063965 -0.1253705233265395 0.98885034744682221 1
		 1 1 yes;
	setAttr ".xm[443]" -type "matrix" "xform" 1 1 1 -1.362354673510289e-11 5.1172803841611895e-11
		 2.8298578754593399e-12 0 -0.64645207588672626 -1.2389449794704319 -2.614164119697179 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.083026220942287066 0.12036309861276841 -0.21035050844990655 0.96662921263700774 1
		 1 1 yes;
	setAttr ".xm[444]" -type "matrix" "xform" 1 1 1 -2.2817553402202499e-11 4.7786892498660126e-11
		 3.1079167012270498e-12 0 -1.1916738483654097 -0.97488500632479713 -2.5031910497689172 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199141396272945 0.1719234854915308 -0.3005309772264117 0.93258843995712515 1
		 1 1 yes;
	setAttr ".xm[445]" -type "matrix" "xform" 1 1 1 -3.3207964156212918e-11 4.1248379711928763e-11
		 3.7328889972244691e-12 0 -1.6307371394187653 -0.62669016381025244 -2.347062232367163 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214056635292294 0.2420911318830031 -0.40455845650067002 0.87035647784931902 1
		 1 1 yes;
	setAttr ".xm[446]" -type "matrix" "xform" 1 1 1 -3.9992231748371436e-11 3.4711039598260505e-11
		 4.0925318682547815e-12 0 -1.8861537960163437 -0.27451522969829512 -2.2145073519171703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383060355622937 0.25974207653192272 -0.47782103714693691 0.82097748532221482 1
		 1 1 yes;
	setAttr ".xm[447]" -type "matrix" "xform" 1 1 1 -1.8041117925524469e-16 5.2954923432380057e-11
		 2.350918071325475e-12 0 -1.9901188991541003 -0.07355444937721245 -2.1506127682602347 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018770653616712 -0.16224732593480973 -0.060171175601813162 0.98097295113898286 1
		 1 1 yes;
	setAttr ".xm[448]" -type "matrix" "xform" 1 1 1 -0.00020935370173638714 0.000646535944230735
		 0.0011213569858792456 0 1.8415022460801751 -0.53911528115796159 -2.1606993877420653 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635812904552347 -0.10419091882317158 0.39729095672071563 0.90974031807770606 1
		 1 1 yes;
	setAttr ".xm[449]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 1 4.8561675520700063e-13 5.2946981868306453e-11 2.475271723713735e-12 0 -0.09018097762430699
		 -1.3936437182729549 -2.643462576570407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490146409749334 -0.073978042904410513 -0.059407956248894334 0.99189684900297059 1
		 1 1 yes;
	setAttr ".xm[450]" -type "matrix" "xform" 1 1 1 -0.000403610907061532 -0.000450427601655768
		 -0.0012711010462760047 0 -1.8941274664792758 -0.2795251833647967 -2.211819451642576 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671737794658616 0.085969349280733631 -0.38565740435772389 0.9183955121323597 1
		 1 1 yes;
	setAttr ".xm[451]" -type "matrix" "xform" 1 1 1 1.1733102774948214e-08 5.2954895663435723e-11
		 2.2788033250065268e-12 0 1.900507324931457 0.55143386844616771 -2.0008900762192354 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892713468937018 -0.039558064329149753 -0.070604734425650101 0.99351259949624415 1
		 1 1 yes;
	setAttr ".xm[452]" -type "matrix" "xform" 1 1 1 7.6044138828766526e-09 5.2954477517670043e-11
		 -1.6400808634596416e-08 0 -1.7739559364336124 -0.063729916002699838 -2.1504440386576462 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537148639359559 0.26549884514744027 -0.09161644128664588 0.9581975215630828 1
		 1 1 yes;
	setAttr ".xm[453]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.5915750767282191 -9.2818264498213523
		 -1.1534880686784996 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64363684588735537 0.41682505669272873 -0.36208451121158108 0.52998423511454607 1
		 1 1 no;
	setAttr ".xm[454]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.8337191568088542 -9.1870481363271033
		 -1.7167633873436821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61642871162872426 0.43518963307226322 -0.39157607613074635 0.52658693807217416 1
		 1 1 no;
	setAttr ".xm[455]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0444083914252076 -9.1039067135571727
		 -2.3471022522914278 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62188391732851445 0.47247700980397356 -0.38995912234872376 0.48780913426446854 1
		 1 1 no;
	setAttr ".xm[456]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.234552859380841 -8.9459321480848182
		 -3.0683367309514535 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64168255502320148 0.49811503910081212 -0.36887102762533897 0.45172898000805622 1
		 1 1 no;
	setAttr ".xm[457]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4270119939492929 -8.6916776346774398
		 -3.8355955456947233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64878746840716661 0.54451986867036606 -0.35167433360611811 0.39862024101106558 1
		 1 1 no;
	setAttr ".xm[458]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5452645532116378 -8.3759951317221315
		 -4.4951554490413859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6445427653902942 0.59357124520206972 -0.33510087316810716 0.34633106308021078 1
		 1 1 no;
	setAttr ".xm[459]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5940869418139698 -8.0082101606394041
		 -5.0768733443424905 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61698848935560613 -0.68501063281675922 0.29416559189051417 -0.25209569904775003 1
		 1 1 no;
	setAttr ".xm[460]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5102178515226967 -7.4841715353962703
		 -5.6094822277796474 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58988744759981515 -0.75044903532326779 0.23882949243968127 -0.17838026260647855 1
		 1 1 no;
	setAttr ".xm[461]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3231279971573144 -6.8615237398363567
		 -6.0370766530067455 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69509540550453952 0.67815590284734562 -0.17080820677032965 0.16664784780994155 1
		 1 1 no;
	setAttr ".xm[462]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.591567890365809 -9.281825951815577
		 1.1535519073689353 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41682678573717025 -0.64363583240600963 -0.52998279777602875 -0.36208642614234421 1
		 1 1 no;
	setAttr ".xm[463]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.827736044453701 -9.1932244021217073
		 1.7200965521217058 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.43519135790030139 -0.61642760554878873 -0.52658544940181073 -0.39157790234456746 1
		 1 1 no;
	setAttr ".xm[464]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0416263359323068 -9.0953952317671671
		 2.3465259188539829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47247861349105658 -0.62188280791458672 -0.48780752826761631 -0.38996095750635934 1
		 1 1 no;
	setAttr ".xm[465]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4212459635155028 -8.6820597606841829
		 3.8330491390015489 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54452118627198365 -0.64878645899644094 -0.39861840479573157 -0.35167623701626072 1
		 1 1 no;
	setAttr ".xm[466]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2333822087389308 -8.9417385609598981
		 3.06756760661741 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.4981165258469773 -0.64168150350957542 -0.45172728987584854 -0.3688729189209331 1
		 1 1 no;
	setAttr ".xm[467]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5426726920976819 -8.3717750511885107
		 4.4932499366907726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59357239634656755 -0.64454179631808617 -0.34632907498779958 -0.33510275276777873 1
		 1 1 no;
	setAttr ".xm[468]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5804144182153834 -7.9972095573383752
		 5.0681593923931487 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.68501148158394198 0.61698762745372138 0.25209343207274298 0.29416736592114684 1
		 1 1 no;
	setAttr ".xm[469]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.50350089676121 -7.4777487740598909
		 5.5994849728088294 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.75044964252362167 0.58988674215589432 0.17837779764324985 0.2388311679258335 1
		 1 1 no;
	setAttr ".xm[470]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3230903863112644 -6.861521133447007
		 6.037144004283026 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67815645881857545 0.69509490941182561 0.16664558532716539 0.17081022558202422 1
		 1 1 no;
	setAttr ".xm[471]" -type "matrix" "xform" 1 1 1 -6.94626294870168e-17 5.1124975364302835e-09
		 1.6258070612007458e-08 0 5.5915750828797286 -9.2818262008181733 -1.1534905420038315 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.57008357847228652 0.41833620676040645 -0.57008179842243811 0.41833751299278132 1
		 1 1 no;
	setAttr ".xm[472]" -type "matrix" "xform" 1 1 1 -5.2347015614236926e-13 -5.2863935451341294e-11
		 1.1958212198375924e-12 0 6.4212685080667882 -8.6820605052311421 -3.8329827384701094 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59884764109944522 0.58425295472417371 -0.39206449597387255 0.38251198496577321 1
		 1 1 no;
	setAttr ".xm[473]" -type "matrix" "xform" 1 1 1 -1.1360357099646383e-12 -5.2863824429038779e-11
		 6.4115379675105551e-13 0 6.3231280293178997 -6.8615224366417022 -6.0370785999793464 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69229959826107823 0.67542819395830289 -0.18180850502978574 0.17738006808153359 1
		 1 1 no;
	setAttr ".xm[474]" -type "matrix" "xform" 1 1 1 9.29738472916946e-16 -5.1125492173120699e-09
		 -1.6258055013373962e-08 0 5.5910963223046792 -9.2816699913087817 1.1535494445110896 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.41833660886893093 0.57008246188149481 0.41833530263937935 0.57008424193341456 1
		 1 1 no;
	setAttr ".xm[475]" -type "matrix" "xform" 1 1 1 5.2169379923974139e-13 5.2863824429039439e-11
		 -1.1962653090198163e-12 0 6.4211081908840413 -8.6820979314971503 3.8330420344877867 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58425431348311907 0.5988465870770513 0.38250990957457948 0.39206610590534852 1
		 1 1 no;
	setAttr ".xm[476]" -type "matrix" "xform" 1 1 1 1.1363132656868772e-12 5.2864435051703047e-11
		 -6.4204197511069275e-13 0 6.322977984395493 -6.8615236890383668 6.037141728287307 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6754288240451688 0.69229910948735618 0.17737766881810094 0.18181036619684324 1
		 1 1 no;
	setAttr ".xm[477]" -type "matrix" "xform" 1 1 1 3.8857805861880479e-16 -1.1102230246251568e-16
		 1.1102230246251563e-16 0 1.495428866347595 -7.2689254591411965 -4.7917412416201888 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66648149151545732 -0.51538575008480991 0.47835595225089356 -0.24770049055863874 1
		 1 1 no;
	setAttr ".xm[478]" -type "matrix" "xform" 1 1 1 7.4024120153676099e-13 5.2636672798202689e-11
		 -5.0178750043788385e-12 0 1.4953990139619009 -7.2689233898976573 4.791778693941005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60531135036067751 0.64530882279232671 0.30095010597674293 0.35581417350001959 1
		 1 1 no;
	setAttr ".xm[479]" -type "matrix" "xform" 1 1 1 2.7755575632105181e-16 9.0150109599562194e-14
		 3.6552982862758646e-12 0 0.75632669249665696 -8.806608677981508 1.6755937096558037e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[480]" -type "matrix" "xform" 1 1 1.0000000000000002 0.18929270062667797
		 9.0165490181700516e-14 3.6553101812596358e-12 0 -0.57788721563673562 -6.3299602678278584
		 1.2065149448500139e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[481]" -type "matrix" "xform" 1 1 1 2.4999769986678032e-16 -5.2864032509432428e-11
		 1.3046305120116952e-12 0 2.7626215921599648 0.13552840493653662 -1.6028016275437693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094505107667796004 -1.0760925916377254e-07 9.1386232877953759e-09 0.99552437671042815 1
		 1 0.99999999999999978 no;
	setAttr ".xm[482]" -type "matrix" "xform" 1 1 1 1.8754747393352533e-16 -5.2233709371485339e-11
		 8.2430333753187757e-12 0 -3.7847003367119197e-07 -0.07801570437288774 1.7945141948880554 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.028719491485545857 -1.0677350968429597e-07 1.6207551421166537e-08 0.99958751033053628 1
		 1 0.99999999999999978 no;
	setAttr ".xm[483]" -type "matrix" "xform" 1 1 1 -8.602253271174304e-16 5.2864152786734516e-11
		 -1.3046074685068644e-12 0 -2.7626196645013401 0.13572391530999539 -1.6028359655176878 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99552437671042815 9.1386232877954073e-09 1.0760925916377248e-07 0.094505107667795768 1
		 1 0.99999999999999978 no;
	setAttr ".xm[484]" -type "matrix" "xform" 1 1 1 0.2624680135684086 3.1965137486376539e-14
		 1.3028000587699907e-12 0 -1.8685434565056482 -5.6773791186242102 7.9032646361304687e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[485]" -type "matrix" "xform" 1 1 1 -7.2150406547701684e-16 3.4473903877621093e-17
		 1.3047401308268929e-12 0 2.6266441606518613 0.070830992159642392 -1.2832055548392702 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129724 -1.0720295509604647e-07 1.3068799426625743e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[486]" -type "matrix" "xform" 1 1 1 0.4082714640584762 3.447389712066404e-17
		 1.3047401307979626e-12 0 -4.2002976708392941e-07 0.14396607244674442 1.9711992067807955 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129733 -1.0720295509604645e-07 1.3068799426625749e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[487]" -type "matrix" "xform" 1 1 1 -4.4394831262548391e-16 8.3796731243561907e-17
		 -1.3047083555174597e-12 0 -2.6266436315536201 0.070830461190809046 -1.2832075745338258 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99140116938230771 1.3068799426625761e-08 1.0720295509604644e-07 0.13085763771129721 1
		 1 1 no;
	setAttr ".xm[488]" -type "matrix" "xform" 1 1 1 -0.55802535373957873 -0.86235996928280023
		 0.37113427545726307 0 -2.142966561689434 -6.3020949920387741 -3.6431927373101844 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72952498310547087 -0.58947769198180122 0.33048263278386492 -0.1053118184679015 1
		 1 1 no;
	setAttr ".xm[489]" -type "matrix" "xform" 1 1 1 -0.55802560820066893 -0.8623603446012863
		 0.37113460705176132 0 -2.1428273734635752 -6.301980721854906 3.6432410976005833 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58947809063799661 0.72952397662169755 0.10530982318633428 0.33048477927479436 1
		 1 1 no;
	setAttr ".xm[490]" -type "matrix" "xform" 1 1 1 -6.5231069736441992e-08 -1.2229472208344874e-08
		 -1.328371922431916e-08 0 5.1598859727164381e-06 1.2468008989685586e-06 1.6550885445151819e-11 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[491]" -type "matrix" "xform" 1 1 1 4.3181583572549488e-07 3.0053109731673356e-10
		 -8.4867158606452038e-07 0 3.8945085470691083 5.070714856003633e-05 1.2383109652697871e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[492]" -type "matrix" "xform" 1 1 1 1.4950003389690157e-06 3.2791962651043259e-09
		 7.7345600245272222e-07 0 7.7890216926664664 0.00010251789687742985 2.6258098901601676e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[493]" -type "matrix" "xform" 1 1 1 -0.00077547738423497435 0.090417237835238334
		 -0.017141201898906815 0 13.363890593036812 1.4372147948893783 -6.0925967608967495 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.29674085579966925 -0.072556452995173229 -0.90237946084669252 0.30396008663979535 1
		 1 1 yes;
	setAttr ".xm[494]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[495]" -type "matrix" "xform" 1 1 1 -3.0010716134398763e-16 -1.3183898417423734e-16
		 -4.1633363423443352e-17 0 8.0454536422471108 2.2438807550149988 -4.1434677099770028 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.19238282086113531 0.3147207522944821 -0.022701956752592317 0.92920628467112243 1
		 1 1 yes;
	setAttr ".xm[496]" -type "matrix" "xform" 1 1 1 4.1633363423443375e-16 -1.3877787807814412e-17
		 -2.2204460492503131e-16 0 9.4595187974194772 1.0716760400088674 -5.3028283221497432 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18679828651183841 0.3428633420922797 -0.12293018645729969 0.91238111448184156 1
		 1 1 yes;
	setAttr ".xm[497]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.753460999056756 1.4210854715202004e-14
		 -3.907985046680551e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[498]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.7654831981509034 0
		 1.2434497875801753e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[499]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[500]" -type "matrix" "xform" 1 1 1 -5.9834680001711395e-09 6.1297348175798586e-10
		 2.9696373512327469e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.29491121738262233 -0.78941577506998695 -0.22136537116205757 -0.49076214236922971 1
		 1 1 yes;
	setAttr ".xm[501]" -type "matrix" "xform" 1 1 1 5.5511151231258014e-16 2.0539125955565392e-15
		 1.8596235662471376e-15 0 4.2217770159966861 -0.43249790135706689 -0.20952977089794089 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.19526362041306367 0.98075079329215076 1
		 1 1 yes;
	setAttr ".xm[502]" -type "matrix" "xform" 1 1 1 0.0041896447755215734 -0.15349829127575432
		 -0.054468196627642268 0 13.539495298871033 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19378466263256422 -0.064469339669166695 -0.92506382426677092 0.32023136917538486 1
		 1 1 yes;
	setAttr ".xm[503]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[504]" -type "matrix" "xform" 0.99999988079071045 1 1 0.16168690515675491
		 1.1886835758738338e-15 6.5014699993595287e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 1 -0.64957844548541277 -0.31610924763916659 0.67361757392455257 -0.15608379421885649 1
		 1 1 yes;
	setAttr ".xm[505]" -type "matrix" "xform" 1 1 1 0 0 0 0 -5.3178290533725026
		 -3.918306651362613e-14 1.0269562977782698e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.040901237501683091 -0.10049288483265671 0.33925400923495591 0.93441692305247215 1.0000001192093038
		 1 1 yes;
	setAttr ".xm[506]" -type "matrix" "xform" 1 1 1 0.00065992617226282263 -0.12604240715274512
		 -0.010457532561554423 0 13.363890593036814 1.4372147948893783 -6.0925967608967504 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.52309622362027819 -0.79625546307504325 -0.056206447644327834 0.29864429276408061 1
		 1 1 yes;
	setAttr ".xm[507]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[508]" -type "matrix" "xform" 1 1 1 -0.0017390185854515162 0.18701234659205648
		 -0.01854314004582595 0 13.539495298871032 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52156514552747757 0.77998608375093237 -0.10622780617703403 0.3291005337592135 1
		 1 1 yes;
	setAttr ".xm[509]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[510]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[511]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[512]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.1278504909219862
		 -6.9040537706030758 4.4577838808432881e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[513]" -type "matrix" "xform" 1 1 1 0 0 -1.7347234759768071e-18 0 -2.3598245839357759
		 -6.9968577821554048 2.8582904152448743e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[514]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345595731
		 0.19315413354009436 -7.9999999999999991 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.046101807560602462 -0.99887540111039552 -0.0019555817656306046 0.010896425842871192 1
		 1 1 yes;
	setAttr ".xm[515]" -type "matrix" "xform" 1 1 1 0 0 0 0 50.884879303655453 -7.4940054162198066e-16
		 2.739833099979494e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.041604680783302275 0.99913415042071274 1
		 1 1 yes;
	setAttr ".xm[516]" -type "matrix" "xform" 1 1 1 0 0 0 0 43.089368453570707 1.7416623698807143e-15
		 4.3771139057041664e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.04987531894619833 0.99875545182993364 1
		 1 1 yes;
	setAttr ".xm[517]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.0708992880109616 -12.614425958600853
		 -7.1147514962843772e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.61843902098991788 0.78583279221284219 1
		 1 1 yes;
	setAttr ".xm[518]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[519]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 0.0012413669866422339
		 2.5158018416556076 -9.8983505836258701e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[520]" -type "matrix" "xform" 1 1 1 4.4564903616485817e-17 7.5176908324114549e-09
		 3.2196467715804674e-15 0 0 -1.7763568394002505e-15 -8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[521]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.7755575615628914e-16 0 -0.18599651324030475 -4.4666961682863571 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668544 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[522]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.7755575615628914e-16 0 0.18779704740523329 4.5099358985119951 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668544 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[523]" -type "matrix" "xform" 1 1 1 -2.175278136723275e-16 -3.8921911082563932e-09
		 -6.6613381435176405e-16 0 14.363123245911318 -1.7763568394002505e-15 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[524]" -type "matrix" "xform" 1 1 1 1.7161041695030145e-16 -5.0587262850384354e-10
		 1.1102230241910913e-16 0 28.726246491822632 0 1.7763568394002505e-15 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[525]" -type "matrix" "xform" 1 1 1 -8.4447832536887831e-17 1.9460082006017018e-08
		 6.6613381395341305e-16 0 -2.8421709430404007e-14 -2.4980018054066022e-16 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[526]" -type "matrix" "xform" 1 1 1 0 4.0592526690879326e-16 0 0 0.79993655503660932
		 8.8770532069966865 0.0071619148329853388 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.004476417234014666 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[527]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 2.3931518875712356
		 -6.8856854788981927 0.021426136727047407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.004476417234014666 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[528]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 -0.057243470674194441
		 -9.1593399531575415e-16 6.3937013769780924 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.004476417234014666 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[529]" -type "matrix" "xform" 1 1 1 1.7734161856919416e-16 4.0058494094022555e-09
		 -9.9920072180743891e-16 0 16.961626940047651 -2.7755575615628914e-17 2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[530]" -type "matrix" "xform" 1 1 1 7.4599792225601508e-17 3.101180949689185e-09
		 -5.5511151219690454e-16 0 33.923253880095373 -2.4980018054066022e-16 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[531]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345597152
		 0.19315413354010147 7.9999999999999982 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99887540111039552 0.046101807560602247 0.010896425842871421 0.0019555817656292628 1
		 1 1 yes;
	setAttr ".xm[532]" -type "matrix" "xform" 1 1 1 0 0 0 0 -50.884879303655453
		 2.7422508708241367e-14 -2.6645352591003757e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0.041604680783301998 0.99913415042071274 1 1 1 yes;
	setAttr ".xm[533]" -type "matrix" "xform" 1 1 1 0 0 0 0 -43.089368453570692
		 -6.2172489379008766e-15 9.7699626167013776e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 -0.049875318946198337 0.99875545182993364 1 1 1 yes;
	setAttr ".xm[534]" -type "matrix" "xform" 1 1 1 0 0 0 0 -5.0708992880109669
		 12.614425958600849 -3.5527136788005009e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 -0.61843902098991788 0.78583279221284219 1 1 1 no;
	setAttr ".xm[535]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[536]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 -0.00097755623600903618
		 -2.5153934276395504 -3.7146064117976607e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[537]" -type "matrix" "xform" 1 1 1 -2.6469779673105168e-22 1.2863772876451032e-14
		 -1.1102230246251565e-16 0 7.1054273576010019e-15 0 8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[538]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.3869795029440866e-15 0 -0.18779704740523329 -4.5099358985119951 -8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668492 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[539]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.3869795029440866e-15 0 0.18599651324026922 4.4666961682863562 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668492 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[540]" -type "matrix" "xform" 1 1 1 -1.4250923983095974e-16 6.0074698163872185e-09
		 1.2212453266596122e-15 0 -14.363123245911318 -1.7763568394002505e-15 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[541]" -type "matrix" "xform" 1 1 1 -2.6469779887190521e-23 -1.7143320048046075e-15
		 3.3306690738754701e-16 0 -28.726246491822618 -5.3290705182007514e-15 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[542]" -type "matrix" "xform" 1 1 1 -8.511536301937945e-18 1.3234889800375957e-23
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 no;
	setAttr ".xm[543]" -type "matrix" "xform" 1 1 1 0 1.7347234759768065e-17 0 0 -2.3931518875712356
		 6.8778854795754505 -0.021426136727050071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0044764172340143278 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[544]" -type "matrix" "xform" 1 1 1 0 3.1225025876304978e-17 0 0 -0.79993655503660932
		 -8.8770532069966848 -0.0071619148329853388 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.0044764172340143278 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[545]" -type "matrix" "xform" 1 1 1 0 1.7347234759768065e-17 0 0 0.057243470674166019
		 0 -6.3937013769780959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0044764172340143278 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[546]" -type "matrix" "xform" 1 1 1 -1.503217129219141e-17 1.6689062678700195e-33
		 2.2204460492503131e-16 0 -16.961626940047694 9.7699626167013776e-15 -1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[547]" -type "matrix" "xform" 1 1 1 2.1028162314901689e-16 -5.7321815634235685e-09
		 1.1102230185982944e-16 0 -33.923253880095402 1.8873791418627661e-14 -2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[548]" -type "matrix" "xform" 1 1 1 -4.4408920985006262e-16 -3.6082248300317588e-16
		 -1.3877787807814377e-17 0 2.7234218615202934 8.2800818998085433 0.001829057443381634 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.076379404101996479 0.70296954886326635 0.70300419241410317 0.076059880674338512 1
		 1 1 yes;
	setAttr ".xm[549]" -type "matrix" "xform" 1 1 1 3.4565643505569351e-08 1.354442376863951e-07
		 5.645017779755202e-16 0 1.8006120956543867 -5.0026479930620109 0.20054753246170876 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65867133796905708 -0.011454464113109158 -0.75209533848103105 0.019325258731440371 1
		 1 1 yes;
	setAttr ".xm[550]" -type "matrix" "xform" 1 1 1 6.4905336174093364e-11 2.4715402141568689e-07
		 -3.2975431415879046e-08 0 0 0 8.5940461489983306 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 1 0.52127652319645179 -0.018291187064478034 0.85266702003926675 0.029919421407304671 1
		 1 1 yes;
	setAttr ".xm[551]" -type "matrix" "xform" 1 1 1 1.5703148806486966 0.4666221181478204
		 2.9289232293494352 0 7.366695598380554 1.03035315090712e-16 5.2030718199174931e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[552]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[553]" -type "matrix" "xform" 1 1 1 0 0 4.4408920985006262e-16 0 1.843312039902969
		 4.9973336318009256 -0.43090286475866613 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65676708076667645 0.02017898901653617 0.75309084324165154 0.033226372794312453 1
		 1 1 yes;
	setAttr ".xm[554]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 8.5995913842935465 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.036909777513786872 0.85367589325795301 -0.022440074634479661 -0.51901019319905217 1
		 1 1 yes;
	setAttr ".xm[555]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.369598533323475 -2.2204460492503131e-16
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[556]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[557]" -type "matrix" "xform" 1 1 1 -1.1102230246251568e-16 -2.3592239273284576e-16
		 1.7347234759768073e-16 0 4.4098233039084249 -7.9775949135248307 4.7855023292131883e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.038411961755856185 -0.70606268928053895 -0.70604515724327954 0.038732879228279102 1
		 1 1 yes;
	setAttr ".xm[558]" -type "matrix" "xform" 1 1 1 0.13265057495460209 3.1516608241825494
		 0.0084610721249207543 0 -1.6038104389313901 3.5224893319268848 -1.1028910808846533 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99758377078038141 -0.018355759882081799 0.010529841346111547 0.066172568304189827 1
		 1 1 yes;
	setAttr ".xm[559]" -type "matrix" "xform" 1 1 1 -2.8957776174501473 0.061538894960088852
		 -0.0092131505334556423 0 -13.884523486194837 1.4277529923667487e-05 -1.2434497875801753e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.9915087600315764 -0.005252000539066987 -0.042398037768010315 0.12282182894097395 1
		 1 1 yes;
	setAttr ".xm[560]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[561]" -type "matrix" "xform" 1 1 1 -1.3783320039095983e-15 -2.8423513518160723e-08
		 9.6985337581690092e-08 0 -1.6066223558716501 -3.5210270942806403 -1.1028448784012284 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99988449989743855 -0.015198252032689891 -9.306245352234214e-19 6.1225267615822506e-17 1
		 1 1 yes;
	setAttr ".xm[562]" -type "matrix" "xform" 1 1 1 -1.8603876073842534e-14 2.8438902720610119e-08
		 -6.5248671624259742e-07 0 13.88410209316004 -8.8817841970012523e-16 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[563]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr -s 79 ".m";
	setAttr -s 249 ".p";
	setAttr -s 23 ".g";
	setAttr ".g[11]" yes;
	setAttr ".g[12]" yes;
	setAttr ".g[13]" yes;
	setAttr ".g[14]" yes;
	setAttr ".g[15]" yes;
	setAttr ".g[21]" yes;
	setAttr ".g[22]" yes;
	setAttr ".g[23]" yes;
	setAttr ".g[74]" yes;
	setAttr ".g[91]" yes;
	setAttr ".g[92]" yes;
	setAttr ".g[93]" yes;
	setAttr ".g[144]" yes;
	setAttr ".g[155]" yes;
	setAttr ".g[158]" yes;
	setAttr ".g[165]" yes;
	setAttr ".g[174]" yes;
	setAttr ".g[514]" yes;
	setAttr ".g[515]" yes;
	setAttr ".g[531]" yes;
	setAttr ".g[532]" yes;
	setAttr ".g[548]" yes;
	setAttr ".g[557]" yes;
	setAttr ".bp" yes;
createNode dagPose -n "bindPose15";
	rename -uid "D6ECE1A9-4241-FEAB-6866-53930606CED8";
	setAttr -s 163 ".wm";
	setAttr ".wm[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[1]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[2]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".wm[3]" -type "matrix" 3.3306690738754701e-16 0.99404867320216028 0.10893684089886711 -1.7341198419700619e-18
		 -2.7755575615628923e-16 0.10893684089886714 -0.99404867320216017 -4.5759280925121615e-20
		 -1 2.7755575615628918e-16 3.3306690738754691e-16 -3.8518598887744717e-34 -2.3665827156630354e-30 103.42406365931474 2.1640990603316994 0.99999999999999989;
	setAttr ".wm[4]" -type "matrix" 3.2562952471023237e-16 0.99657635555788127 0.082677491150685678 -1.7325343826158914e-18
		 -2.8624495665283324e-16 0.082677491150685678 -0.99657635555788138 -1.3908664445967476e-19
		 -1 2.7755575615628918e-16 3.3306690738754681e-16 -3.8518598887744717e-34 1.6621084025409651e-15 110.65906309629761 4.1933336812804543 0.99999999999999978;
	setAttr ".wm[5]" -type "matrix" 3.2051554821504265e-16 0.99788283071405504 0.065037344396157382 -1.7329889575290719e-18
		 -2.9195983614977729e-16 0.065037344396157409 -0.99788283071405526 -1.3330324337982328e-19
		 -1 2.7755575615628914e-16 3.3306690738754681e-16 -3.8518598887744717e-34 3.7747841483908447e-15 117.17672837369051 4.734049111954227 0.99999999999999978;
	setAttr ".wm[6]" -type "matrix" 3.1629276683509981e-16 0.99871339461989661 0.05071050588193915 -8.9300903420550769e-19
		 -2.9652933787399736e-16 0.050710505881939177 -0.99871339461989683 -4.3255327839489398e-20
		 -1 2.7755575615628914e-16 3.3306690738754686e-16 -3.8518598887744717e-34 5.958557007202495e-15 124.81037817784856 5.2315747693076275 0.99999999999999989;
	setAttr ".wm[7]" -type "matrix" 2.1702555694510112e-16 0.97070554289117217 -0.24027223934602709 0
		 -3.7532741733700033e-16 -0.24027223934602707 -0.97070554289117217 0 -1 2.7755575615628909e-16 3.3306690738754696e-16 0
		 1.0108284371359062e-14 135.09254951131538 5.7538641409368774 1;
	setAttr ".wm[8]" -type "matrix" -0.99018984819548717 0.069962060554344341 0.12095195167333102 0
		 -0.11929868116643298 0.027360720809832158 -0.99248134271064059 0 -0.072745372378917178 -0.99717435839463719 -0.01874592642938747 0
		 3.4775081921847488 142.54892074324644 -0.085536151262866511 1;
	setAttr ".wm[9]" -type "matrix" -0.34064587854747219 0.93673914914207057 0.080499390638749002 0
		 0.067062193307717941 0.10961054514396704 -0.99170973103121285 0 -0.93779691173376045 -0.33242336689503565 -0.1001581623473069 0
		 10.633800824105371 142.04329146480919 -0.95967918772569083 1;
	setAttr ".wm[10]" -type "matrix" -0.29977222136490994 0.92083168052301567 -0.2494105680261075 0
		 0.17513870971480958 -0.20387182563396722 -0.9632043973488208 0 -0.93779691173376045 -0.33242336689503565 -0.1001581623473069 0
		 19.471050538913008 117.7418150638515 -3.0480450296900323 1;
	setAttr ".wm[11]" -type "matrix" -0.073882001117057311 0.97285184124518109 -0.21931882020656412 -8.693243371458952e-19
		 0.17513013351581436 -0.20384548164949334 -0.96321153229486378 1.8425733424711733e-19
		 -0.98176926324145619 -0.10957332977027814 -0.15531516074543961 9.8288301344316432e-20
		 26.641599087827124 95.715342024655627 2.9176401628526927 0.99999999999999989;
	setAttr ".wm[12]" -type "matrix" -0.69778497833827358 -0.63103932671399132 0.33894762448763005 5.6347617592408136e-19
		 0.15818186041499374 -0.59725439511195799 -0.78629872602917306 5.3561707311402094e-19
		 0.69862337710751299 -0.49505207368498205 0.5165741198502809 4.4152588679928896e-19
		 25.806309421711806 94.786672898343454 4.8640810456125996 0.99999999999999989;
	setAttr ".wm[13]" -type "matrix" -0.56237783254956963 -0.82628846522913646 -0.031281714884678326 7.3881139402333085e-19
		 0.44232325877764905 -0.26865423989963921 -0.85567227028124948 2.419755889910707e-19
		 0.69862816161472396 -0.49504774680148245 0.51657179577054524 4.4152202317991163e-19
		 22.979121625665286 92.229915818818256 6.2373817287997149 0.99999999999999989;
	setAttr ".wm[14]" -type "matrix" -0.43958324420627992 -0.8666375820119514 -0.23602091614422657 7.7531260187992537e-19
		 0.56452215475737799 -0.062185447101816053 -0.82307211528324431 5.7313444953634392e-20
		 0.69862816161472396 -0.49504774680148245 0.51657179577054524 4.4152202317991163e-19
		 21.511153570660277 90.0730650310188 6.1557274467518139 0.99999999999999989;
	setAttr ".wm[15]" -type "matrix" -0.17961525959048147 -0.94998285197781074 0.25548177913571096 8.4880282600223862e-19
		 -0.97980374216026112 0.14955842994283478 -0.13272868145876576 -1.33436475820017e-19
		 0.087880517584913734 -0.27416209982624945 -0.95765972957406431 2.4711258173250234e-19
		 27.296937825585371 89.850901547333734 6.4842678222617272 0.99999999999999989;
	setAttr ".wm[16]" -type "matrix" -0.71178817296623054 -0.68984623746833018 0.13217324039374648 6.164838845197351e-19
		 -0.6968748816113719 0.67003550151123048 -0.25576908744750593 -5.9851429500277265e-19
		 0.087880579222782002 -0.27416162270708372 -0.95765986050898444 2.4711215543543636e-19
		 26.529283726781909 85.790788659677418 7.5761663364274439 0.99999999999999989;
	setAttr ".wm[17]" -type "matrix" -0.93315767123934057 -0.35905751378458717 0.017159906817984259 3.2098087394820056e-19
		 -0.34855955646437148 0.89213962272138159 -0.28739020367422258 -7.9702134209483848e-19
		 0.087880579222782002 -0.27416162270708372 -0.95765986050898444 2.4711215543543636e-19
		 24.773518865413234 84.089147877354776 7.9021975068099124 0.99999999999999989;
	setAttr ".wm[18]" -type "matrix" -0.18860385619307218 -0.96793014340677397 0.16595126668285687 8.6503536102546329e-19
		 -0.98082277006291596 0.17720202182164088 -0.081155019490049135 -1.5825887293157773e-19
		 0.049145489673118201 -0.17807493070857661 -0.98278890912439865 1.6125790483920032e-19
		 27.449092665581265 89.223650008855884 4.7287748117981971 0.99999999999999989;
	setAttr ".wm[19]" -type "matrix" -0.75997689555703285 -0.64514425250011675 0.078892405753404823 5.7662901930505489e-19
		 -0.64808937583043558 0.74301965823200189 -0.16703876321535394 -6.6395106806248733e-19
		 0.049145489673118201 -0.17807493070857661 -0.98278890912439865 1.6125790483920032e-19
		 26.612462067758806 84.929994561536688 5.464920457262326 0.99999999999999989;
	setAttr ".wm[20]" -type "matrix" -0.92813215536613058 -0.37166197048024319 0.020930405494475824 3.3224207113811857e-19
		 -0.36899244303943357 0.91112935346847335 -0.18354257878735325 -8.1421572869349575e-19
		 0.049145489673118201 -0.17807493070857661 -0.98278890912439865 1.6125790483920032e-19
		 24.641160804683643 83.256557267252902 5.6695591772259579 0.99999999999999989;
	setAttr ".wm[21]" -type "matrix" -0.036238603237466326 -0.97662773566886441 0.21186087311654195 8.727157408793414e-19
		 -0.99750878484064975 0.048189116158684729 0.051517310193510156 -4.3191079211219499e-20
		 -0.060522622226131584 -0.20946616673379678 -0.97594105210956383 1.8930907230544397e-19
		 26.863508528127461 93.071632690832104 1.9795809201985408 0.99999999999999989;
	setAttr ".wm[22]" -type "matrix" -0.26727977684013599 -0.96175922100506828 0.059839131878819153 8.5973949761469186e-19
		 -0.9585786859183022 0.27171170102064063 0.08543801514320333 -2.4310298085248501e-19
		 -0.098429791198738681 -0.034524662781750898 -0.99454493305449976 3.2940787802191528e-20
		 27.370679039546602 89.437518256271659 2.9871101572851431 0.99999999999999989;
	setAttr ".wm[23]" -type "matrix" -0.77294561223932845 -0.62681778414068345 0.098257549353383489 5.6020379314674241e-19
		 -0.62679075992275246 0.77840061224588564 0.035011857001426824 -6.9600486578911825e-19
		 -0.098429791198738681 -0.034524662781750898 -0.99454493305449976 3.2940787802191528e-20
		 26.250887852338046 85.408142245703388 3.2378103438574906 0.99999999999999989;
	setAttr ".wm[24]" -type "matrix" -0.9270113454438077 -0.36025202952032331 0.10425181362906294 3.2186722535386945e-19
		 -0.36188608929196686 0.93221592074277193 0.0034547779483026604 -8.3345818869402671e-19
		 -0.098429791198738681 -0.034524662781750898 -0.99454493305449976 3.2940787802191528e-20
		 24.543852264087349 84.023827168505846 3.4548102606751687 0.99999999999999989;
	setAttr ".wm[25]" -type "matrix" -0.28697025564055889 -0.95728303596983899 -0.035457882367106411 8.5593626783174271e-19
		 -0.93117097670109839 0.27007088899105675 0.24491289690235254 -2.4196855429981808e-19
		 -0.22487481968222731 0.10330006758926907 -0.96889649163826486 -9.0335390072098551e-20
		 26.606833978816947 89.81631047590983 1.5617572740190555 0.99999999999999989;
	setAttr ".wm[26]" -type "matrix" -0.71843374497117873 -0.68931638414984042 0.093251684324071868 6.1609132900385177e-19
		 -0.65824332093806492 0.71705789067455461 0.22922415200363511 -6.4156616976422993e-19
		 -0.22487481968222731 0.10330006758926907 -0.96889649163826486 -9.0335390072098551e-20
		 25.685274214117939 86.74214596720239 1.4478866710614016 0.99999999999999989;
	setAttr ".wm[27]" -type "matrix" -0.90401655522299196 -0.39314545731701972 0.16790091504737573 3.5114298713351826e-19
		 -0.36357307842528758 0.91365515673422604 0.18179348507940507 -8.1723575450822447e-19
		 -0.22487481968222731 0.10330006758926907 -0.96889649163826486 -9.0335390072098551e-20
		 24.468133068853742 85.574334266922136 1.6058698708351979 0.99999999999999989;
	setAttr ".wm[28]" -type "matrix" -0.29977222136490994 0.92083168052301556 -0.2494105680261075 -8.2275277678033477e-19
		 0.17513721198658894 -0.20387235653733601 -0.96320455730726184 1.8428134729220556e-19
		 -0.93779719144147133 -0.33242304129688643 -0.10015662404163027 2.9741286438144036e-19
		 24.251416380654781 103.05743509478901 0.92900750022130119 0.99999999999999989;
	setAttr ".wm[29]" -type "matrix" -0.2997721930361989 0.92083169056476866 -0.24941056500055722 -8.2275278576450926e-19
		 0.17513766607532019 -0.20387219557543501 -0.96320450881053365 1.8428120328251262e-19
		 -0.93779711569398461 -0.33242311219721288 -0.10015709796695219 2.9741292875839103e-19
		 21.861233459784 110.39953138057125 -1.0596253416176307 0.99999999999999989;
	setAttr ".wm[30]" -type "matrix" -0.29977202202216258 0.92083178729667969 -0.24941041340879422 -8.2275287256412999e-19
		 0.17513866901066066 -0.20387170060013726 -0.96320443121467347 1.8428076058626605e-19
		 -0.9377969830565237 -0.33242314780774446 -0.10015822168784831 2.9741296293936972e-19
		 19.471050541336286 117.74162814498352 -3.0482581740201882 0.99999999999999989;
	setAttr ".wm[31]" -type "matrix" -0.34064580359000862 0.93673917813250862 0.080499370482933957 -8.376628815324416e-19
		 0.078123005481407909 0.11352529415321497 -0.99045888536676674 -9.9432327228149735e-20
		 -0.93694035696572953 -0.33110681016713833 -0.11185279500250966 2.9626047283415276e-19
		 16.525300572067721 125.84212011126398 -2.3521362681969391 0.99999999999999989;
	setAttr ".wm[32]" -type "matrix" -0.34064591255195309 0.93673913492965821 0.080499412127555875 -8.3766284299361843e-19
		 0.089173262586330584 0.11742443930331012 -0.98907008361086968 -1.0292126794142313e-19
		 -0.93595325283977504 -0.32974428599376548 -0.12353224013635225 2.9506665794754492e-19
		 13.579550700213549 133.94261280647424 -1.6560142935368507 0.99999999999999989;
	setAttr ".wm[33]" -type "matrix" -0.99018984819548717 0.069962060554344341 0.12095195167333102 0
		 -0.11929868116643298 0.027360720809832158 -0.99248134271064059 0 -0.072745372378917178 -0.99717435839463719 -0.01874592642938747 0
		 3.4775081921847506 142.54892074324644 -0.085536151262867163 1;
	setAttr ".wm[34]" -type "matrix" -0.02158803176047935 -0.99962488383907522 -0.016853738292268529 0
		 -0.0049114548957100469 0.016963501819868776 -0.99984404644765212 0 0.99975488720761763 -0.021501888654791506 -0.0052758211456613094 0
		 7.9999999999999991 102.52301307337278 1.8710432515811346 1;
	setAttr ".wm[35]" -type "matrix" -0.021921621348182097 -0.9947539835366489 -0.099919741570100126 0
		 -0.0030996809434176158 0.10001090451668568 -0.99498151287137149 0 0.99975488720761763 -0.021501888654791506 -0.0052758211456613094 0
		 6.9014956094645292 51.657221510290839 1.013442812763655 1;
	setAttr ".wm[36]" -type "matrix" -0.021503748858943066 -0.99976872380693993 -0.00029611223175338142 -3.1521712730185081e-18
		 -0.005268234001594852 0.00040948958379849492 -0.99998603891693638 2.7793395909331974e-17
		 0.99975488720761718 -0.021501888654791596 -0.0052758211456615644 1.0842021724854847e-19
		 5.9569067900930692 8.7939005930229666 -3.2920357475359552 1.0000000000000002;
	setAttr ".wm[37]" -type "matrix" 6.580667544844182e-05 -0.23541000479184829 0.97189614944878921 -4.6232089368273982e-19
		 -0.022139583870649442 -0.97165827245394187 -0.23535088782041078 -9.9270145501226383e-19
		 0.9997548872076174 -0.021501888654791395 -0.0052758211456612886 7.0814120383154151e-18
		 5.9143191930603827 3.7190086072590844 9.320712544711121 0.99999999999999978;
	setAttr ".wm[38]" -type "matrix" -0.021921621348182194 -0.99475398353664879 -0.09991974157010014 -2.4824619411565465e-17
		 -0.0030996809434174848 0.10001090451668575 -0.99498151287137127 3.0659124256867234e-17
		 0.99975488720761685 -0.021501888654791738 -0.0052758211456616702 -2.8622937353617311e-17
		 6.271769711116268 23.081673380494586 -1.8568763129782548 1.0000000000000007;
	setAttr ".wm[39]" -type "matrix" -0.021921621348182176 -0.99475398353664868 -0.09991974157010014 -2.7755575615628914e-17
		 -0.0030996809434174826 0.10001090451668575 -0.99498151287137127 3.0357660829594124e-17
		 0.99975488720761685 -0.021501888654792127 -0.0052758211456615366 -8.6736173798842724e-19
		 6.5866326602904079 37.369447445392694 -0.42171675010729692 1.0000000000000013;
	setAttr ".wm[40]" -type "matrix" -0.021921621348182204 -0.99475398353664901 -0.099919741570100154 -3.1225022567582534e-17
		 -0.0030996809434174787 0.10001090451668578 -0.99498151287137127 3.0791341698588326e-17
		 0.99975488720761663 -0.021501888654793567 -0.0052758211456615418 -7.5894152073987756e-19
		 6.9014956094645452 51.657221510290825 1.0134428127636592 1.0000000000000018;
	setAttr ".wm[41]" -type "matrix" -0.021588031760479503 -0.99962488383907544 -0.016853738292268581 -3.7077694404631944e-17
		 -0.0049114548957099255 0.016963501819868852 -0.99984404644765179 2.7066202738141143e-17
		 0.99975488720761663 -0.021501888654794361 -0.0052758211456615852 2.702929735114234e-17
		 7.2676637178177197 68.612484354038997 1.2993096086638283 1.0000000000000027;
	setAttr ".wm[42]" -type "matrix" -0.021588031760479354 -0.99962488383907522 -0.016853738292268522 4.1551376368618146e-19
		 -0.004911454895710099 0.016963501819869109 -0.99984404644765223 -3.6943601636650556e-19
		 0.99975488720761763 -0.021501888654792134 -0.0052758211456616078 6.7448993323331296e-19
		 7.6338318589088523 85.567748713705925 1.5851764301224849 0.99999999999999989;
	setAttr ".wm[43]" -type "matrix" -0.021588031760479354 -0.99962488383907544 -0.016853738292268439 4.0102977351167413e-19
		 -0.0049114548957100573 0.016963501819868852 -0.99984404644765212 5.0174814784475372e-19
		 0.99975488720761763 -0.021501888654791523 -0.0052758211456613024 -7.2651180138340829e-19
		 8.0000000000000071 102.52301307337282 1.8710432515811328 0.99999999999999978;
	setAttr ".wm[44]" -type "matrix" -0.99018984819548761 -0.069962060554344091 -0.12095195167333116 0
		 -0.11929868116643334 -0.027360720809829535 0.9924813427106407 0 -0.072745372378916345 0.99717435839463742 0.018745926429384881 0
		 -3.4775081921847475 142.54892074324647 -0.085536151262862958 1;
	setAttr ".wm[45]" -type "matrix" -0.34064587854747341 -0.93673914914207068 -0.080499390638745838 0
		 0.067062193307718218 -0.10961054514396391 0.99170973103121318 0 -0.93779691173376056 0.33242336689503671 0.10015816234730612 0
		 -10.63380082410537 142.04329146480916 -0.95967918772568994 1;
	setAttr ".wm[46]" -type "matrix" -0.29977222136491105 -0.92083168052301478 0.24941056802611067 0
		 0.17513870971481027 0.20387182563397027 0.96320439734881991 0 -0.93779691173376056 0.33242336689503671 0.10015816234730612 0
		 -19.471050538913055 117.7418150638515 -3.0480450296899524 1;
	setAttr ".wm[47]" -type "matrix" -0.073882001117058393 -0.97285184124518054 0.2193188202065674 8.6932433714589462e-19
		 0.17513013351581505 0.20384548164949637 0.96321153229486278 -1.8425733424711997e-19
		 -0.98176926324145641 0.10957332977027935 0.15531516074543961 -9.8288301344317781e-20
		 -26.641599087827181 95.715342024655669 2.9176401628528348 0.99999999999999989;
	setAttr ".wm[48]" -type "matrix" -0.6977849783382728 0.63103932671399132 -0.33894762448763216 -5.6347617592408165e-19
		 0.15818186041499477 0.59725439511196021 0.78629872602917106 -5.3561707311402277e-19
		 0.69862337710751454 0.49505207368497989 -0.51657411985028223 -4.4152588679928665e-19
		 -25.806309421711862 94.786672898343511 4.864081045612747 0.99999999999999989;
	setAttr ".wm[49]" -type "matrix" -0.56237783254956875 0.82628846522913713 0.031281714884675287 -7.3881139402333162e-19
		 0.44232325877764939 0.26865423989964154 0.8556722702812487 -2.4197558899107262e-19
		 0.69862816161472552 0.49504774680148017 -0.51657179577054668 -4.4152202317990932e-19
		 -22.979121625665357 92.229915818818313 6.2373817287998552 0.99999999999999989;
	setAttr ".wm[50]" -type "matrix" -0.43958324420627892 0.86663758201195273 0.23602091614422341 -7.7531260187992662e-19
		 0.5645221547573781 0.062185447101818066 0.8230721152832442 -5.7313444953636029e-20
		 0.69862816161472552 0.49504774680148017 -0.51657179577054668 -4.4152202317990932e-19
		 -21.511153570660355 90.073065031018842 6.1557274467519809 0.99999999999999989;
	setAttr ".wm[51]" -type "matrix" -0.17961525959048047 0.94998285197781041 -0.25548177913571368 -8.4880282600223843e-19
		 -0.97980374216026167 -0.14955842994283375 0.13272868145876621 1.3343647582001582e-19
		 0.087880517584914067 0.27416209982625211 0.9576597295740632 -2.4711258173250461e-19
		 -27.296937825585445 89.850901547333763 6.4842678222618941 0.99999999999999989;
	setAttr ".wm[52]" -type "matrix" -0.71178817296622976 0.68984623746833096 -0.13217324039374859 -6.1648388451973606e-19
		 -0.69687488161137334 -0.67003550151122893 0.2557690874475077 5.9851429500277101e-19
		 0.087880579222782335 0.27416162270708638 0.95765986050898333 -2.4711215543543867e-19
		 -26.529283726781983 85.790788659677446 7.5761663364276304 0.99999999999999989;
	setAttr ".wm[53]" -type "matrix" -0.93315767123934001 0.35905751378458878 -0.017159906817985536 -3.2098087394820215e-19
		 -0.34855955646437342 -0.89213962272138037 0.28739020367422502 7.9702134209483723e-19
		 0.087880579222782335 0.27416162270708638 0.95765986050898333 -2.4711215543543867e-19
		 -24.773518865413315 84.089147877354776 7.9021975068100883 0.99999999999999989;
	setAttr ".wm[54]" -type "matrix" -0.1886038561930711 0.96793014340677352 -0.16595126668286017 -8.6503536102546319e-19
		 -0.98082277006291707 -0.1772020218216401 0.08115501949004926 1.5825887293157674e-19
		 0.049145489673118103 0.17807493070857972 0.98278890912439787 -1.6125790483920304e-19
		 -27.44909266558134 89.223650008855955 4.7287748117983606 0.99999999999999989;
	setAttr ".wm[55]" -type "matrix" -0.75997689555703241 0.64514425250011731 -0.078892405753407405 -5.7662901930505547e-19
		 -0.64808937583043735 -0.74301965823200056 0.16703876321535602 6.6395106806248598e-19
		 0.049145489673118103 0.17807493070857972 0.98278890912439787 -1.6125790483920304e-19
		 -26.612462067758884 84.929994561536745 5.464920457262509 0.99999999999999989;
	setAttr ".wm[56]" -type "matrix" -0.92813215536613081 0.37166197048024407 -0.020930405494477524 -3.3224207113811953e-19
		 -0.3689924430394354 -0.91112935346847246 0.18354257878735603 8.1421572869349498e-19
		 0.049145489673118103 0.17807493070857972 0.98278890912439787 -1.6125790483920304e-19
		 -24.641160804683718 83.256557267252958 5.6695591772261427 0.99999999999999989;
	setAttr ".wm[57]" -type "matrix" -0.036238603237465784 0.97662773566886374 -0.21186087311654472 -8.7271574087934082e-19
		 -0.99750878484065042 -0.048189116158684757 -0.051517310193509969 4.3191079211219252e-20
		 -0.060522622226131778 0.2094661667337995 0.97594105210956306 -1.893090723054464e-19
		 -26.863508528127532 93.071632690832132 1.9795809201986954 0.99999999999999989;
	setAttr ".wm[58]" -type "matrix" -0.26727977684013499 0.96175922100506828 -0.059839131878822359 -8.5973949761469186e-19
		 -0.9585786859183032 -0.27171170102063996 -0.08543801514320204 2.4310298085248419e-19
		 -0.098429791198738625 0.034524662781754395 0.99454493305449954 -3.2940787802194681e-20
		 -27.370679039546683 89.437518256271687 2.9871101572853109 0.99999999999999989;
	setAttr ".wm[59]" -type "matrix" -0.77294561223932801 0.62681778414068434 -0.098257549353385334 -5.6020379314674337e-19
		 -0.62679075992275446 -0.77840061224588453 -0.035011857001424021 6.9600486578911709e-19
		 -0.098429791198738625 0.034524662781754395 0.99454493305449954 -3.2940787802194681e-20
		 -26.250887852338114 85.408142245703417 3.23781034385767 0.99999999999999989;
	setAttr ".wm[60]" -type "matrix" -0.92701134544380737 0.3602520295203252 -0.10425181362906383 -3.2186722535387128e-19
		 -0.36188608929196964 -0.93221592074277104 -0.0034547779482994772 8.3345818869402594e-19
		 -0.098429791198738625 0.034524662781754395 0.99454493305449954 -3.2940787802194681e-20
		 -24.543852264087423 84.023827168505846 3.4548102606753481 0.99999999999999989;
	setAttr ".wm[61]" -type "matrix" -0.28697025564055817 0.95728303596983921 0.035457882367104024 -8.5593626783174319e-19
		 -0.93117097670109905 -0.27007088899105686 -0.24491289690235135 2.4196855429981798e-19
		 -0.22487481968222739 -0.10330006758926638 0.96889649163826486 9.0335390072096095e-20
		 -26.606833978817026 89.816310475909873 1.5617572740192207 0.99999999999999989;
	setAttr ".wm[62]" -type "matrix" -0.7184337449711784 0.68931638414984087 -0.093251684324073311 -6.1609132900385235e-19
		 -0.65824332093806626 -0.7170578906745545 -0.22922415200363286 6.4156616976422984e-19
		 -0.22487481968222739 -0.10330006758926638 0.96889649163826486 9.0335390072096095e-20
		 -25.685274214118014 86.742145967202447 1.447886671061581 0.99999999999999989;
	setAttr ".wm[63]" -type "matrix" -0.90401655522299207 0.39314545731702005 -0.16790091504737625 -3.5114298713351869e-19
		 -0.36357307842528891 -0.91365515673422637 -0.18179348507940243 8.1723575450822476e-19
		 -0.22487481968222739 -0.10330006758926638 0.96889649163826486 9.0335390072096095e-20
		 -24.468133064079431 85.574334269115369 1.6058698502644422 0.99999999999999989;
	setAttr ".wm[64]" -type "matrix" -0.2997722751612889 -0.92083165065750883 0.24941061363140105 8.2275274998387247e-19
		 0.17513770734721476 0.2038722226397246 0.96320449557770438 -1.8428122745184373e-19
		 -0.93779708173452225 0.33242320614437515 0.10015710412600839 -2.9741301276503166e-19
		 -24.251416380655108 103.05743597106658 0.92900750631586071 0.99999999999999989;
	setAttr ".wm[65]" -type "matrix" -0.29977217794197003 -0.92083170391174918 0.24941053386517653 8.2275279776235053e-19
		 0.17513688099141669 0.20387244298398205 0.96320459919393098 -1.8428142466748397e-19
		 -0.93779726713641409 0.33242292349163766 0.10015630628545708 -2.9741275839463009e-19
		 -21.861233459784032 110.39953122149912 -1.0596253254658592 0.99999999999999989;
	setAttr ".wm[66]" -type "matrix" -0.29977232059989295 -0.92083162585496192 0.24941065058946882 8.2275272773199914e-19
		 0.17513889320053844 0.20387183586969654 0.96320436181924007 -1.8428088137979234e-19
		 -0.93779684574573285 0.33242351205115789 0.100158298432671 -2.9741328875253234e-19
		 -19.471050537803446 117.74162623572565 -3.0482581470204062 0.99999999999999989;
	setAttr ".wm[67]" -type "matrix" -0.34064584544788207 -0.93673916104287069 -0.080499392220038907 8.3766286629871727e-19
		 0.078123453915098839 -0.11352548089317996 0.99045882859225765 9.9432494302074486e-20
		 -0.93694030435640374 0.3311067944888319 0.11185328209693564 -2.9626045983262764e-19
		 -16.525300949145965 125.84211955507347 -2.3521361843239026 0.99999999999999989;
	setAttr ".wm[68]" -type "matrix" -0.34064583631011935 -0.93673916783804634 -0.080499351815176839 8.3766287228971361e-19
		 0.089173125388757185 -0.11742431666074613 0.98907011054078353 1.0292115823624329e-19
		 -0.93595329365998858 0.32974423618137849 0.12353206382222628 -2.9506661304494042e-19
		 -13.579550855983211 133.9426116922491 -1.6560142370586277 0.99999999999999989;
	setAttr ".wm[69]" -type "matrix" -0.99018984819548761 -0.069962060554344091 -0.12095195167333116 0
		 -0.11928256312581592 -0.027581621857645119 0.99247716561633681 0 -0.072771798553651693 0.99716827276979292 0.018965788055721314 0
		 -3.4775081921847444 142.54892074324641 -0.085536151262863694 1;
	setAttr ".wm[70]" -type "matrix" -0.021588031760479319 0.999624883839075 0.016853738292268987 0
		 -0.0049114548957067692 -0.016963501819869192 0.99984404644765212 0 0.99975488720761763 0.021501888654791568 0.0052758211456579978 0
		 -7.9999999999999982 102.52301307337277 1.8710432515811313 1;
	setAttr ".wm[71]" -type "matrix" -0.021921621348181791 0.99475398353664879 0.099919741570100029 0
		 -0.0030996809434143645 -0.10001090451668551 0.9949815128713716 0 0.99975488720761763 0.021501888654791568 0.0052758211456579978 0
		 -6.9014956094645301 51.657221510290832 1.013442812763655 1;
	setAttr ".wm[72]" -type "matrix" -0.02150374885894301 0.99976872380693982 0.00029611223175332818 2.8966957443422586e-17
		 -0.0052682340015918205 -0.00040948958379834004 0.99998603891693638 -2.7736624266298057e-17
		 0.99975488720761696 0.021501888654791322 0.005275821145657637 -2.7696772784159331e-17
		 -5.9569067900930328 8.793900593022979 -3.2920357475359485 1.0000000000000007;
	setAttr ".wm[73]" -type "matrix" 6.5806675445343536e-05 0.23541000479184826 -0.97189614944878921 2.7755579531787875e-17
		 -0.02213958387064887 0.97165827245394154 0.23535088782041061 -3.470764479835433e-18
		 0.99975488720761729 0.021501888654791457 0.0052758211456577385 -4.8924747659764031e-20
		 -5.9143191930603525 3.7190086072590862 9.3207125447111263 0.99999999999999978;
	setAttr ".wm[74]" -type "matrix" -0.021921621348181684 0.99475398353664868 0.099919741570100057 2.7771043554633669e-17
		 -0.0030996809434144915 -0.10001090451668558 0.99498151287137138 -3.0355473688642932e-17
		 0.99975488720761696 0.02150188865479093 0.0052758211456577688 1.6193272936661577e-19
		 -6.2717697111162289 23.081673380494603 -1.8568763129782524 1.0000000000000009;
	setAttr ".wm[75]" -type "matrix" -0.021921621348181645 0.99475398353664901 0.099919741570100071 3.1232462577703204e-17
		 -0.003099680943414495 -0.10001090451668559 0.99498151287137138 -3.0790289693482339e-17
		 0.99975488720761674 0.021501888654789515 0.0052758211456577636 4.1963329344804278e-19
		 -6.5866326602903635 37.369447445392723 -0.42171675010729615 1.0000000000000013;
	setAttr ".wm[76]" -type "matrix" -0.021921621348181607 0.99475398353664923 0.099919741570100057 3.3485096820137409e-17
		 -0.0030996809434144907 -0.10001090451668561 0.99498151287137127 -3.0226703628603103e-17
		 0.99975488720761674 0.02150188865478872 0.0052758211456577202 2.8337472488147557e-17
		 -6.901495609464499 51.65722151029086 1.0134428127636617 1.0000000000000013;
	setAttr ".wm[77]" -type "matrix" -0.021588031760479118 0.99962488383907555 0.016853738292269053 3.6969525076845781e-17
		 -0.0049114548957068811 -0.016963501819869244 0.99984404644765179 -2.7568913765775652e-17
		 0.99975488720761674 0.021501888654787773 0.0052758211456577307 2.8366120008756666e-17
		 -7.2676637178176664 68.612484354039026 1.2993096086638316 1.0000000000000022;
	setAttr ".wm[78]" -type "matrix" -0.021588031760479326 0.99962488383907488 0.016853738292268987 1.1957255095714111e-18
		 -0.0049114548957067171 -0.01696350181986955 0.99984404644765223 3.5335255722351176e-19
		 0.99975488720761752 0.021501888654791565 0.0052758211456577211 -2.7673410443681375e-17
		 -7.6338318589088461 85.567748713705868 1.5851764301224873 1;
	setAttr ".wm[79]" -type "matrix" -0.021588031760479368 0.99962488383907488 0.01685373829226889 -4.0675082954606399e-18
		 -0.0049114548957067579 -0.016963501819869296 0.99984404644765212 -5.4263969239410421e-19
		 0.99975488720761785 0.021501888654794406 0.00527582114565799 1.3764586823430442e-17
		 -7.9999999999999964 102.52301307337272 1.8710432515811284 0.99999999999999956;
	setAttr ".wm[80]" -type "matrix" 3.0666760140905786e-06 0.97279370722579106 0.23167305232265833 0
		 5.8748547601898034e-07 0.23167305232195515 -0.97279370723061487 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 -2.3331122644269127e-05 143.75915173801548 -0.3931690512432553 1;
	setAttr ".wm[81]" -type "matrix" 3.1149708989876793e-06 0.99969574466304745 -0.024666132507785293 0
		 -2.1586398122802563e-07 -0.02466613250723218 -0.9996957446678908 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 1.2498181468262009e-05 155.12486814474966 2.3134409537602632 1;
	setAttr ".wm[82]" -type "matrix" 3.0666760140905786e-06 0.97279370722579106 0.23167305232265833 0
		 5.8748547601898034e-07 0.23167305232195515 -0.97279370723061487 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 5.5508080854298013e-07 151.33629623498817 1.4112376725346112 1;
	setAttr ".wm[83]" -type "matrix" 3.0666760140905786e-06 0.97279370722579106 0.23167305232265833 0
		 5.8748547601898034e-07 0.23167305232195515 -0.97279370723061487 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 -1.1388020918233014e-05 147.54772398650186 0.50903431064569826 1;
	setAttr ".wm[84]" -type "matrix" 3.0666760140905786e-06 0.97279370722579106 0.23167305232265833 0
		 5.8748547601898034e-07 0.23167305232195515 -0.97279370723061487 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 -2.3331122645008662e-05 143.75915173801556 -0.39316905124324936 1;
	setAttr ".wm[85]" -type "matrix" -0.32473670655979908 0.94191836337378021 -0.085649682731191015 -1.9631230145025887e-18
		 0.12281287722321051 -0.047796937557380979 -0.99127818998921458 1.2080511955403588e-18
		 -0.93779692290007588 -0.33242329867112902 -0.10015828422928326 -6.5052126355871613e-18
		 19.839490355899219 117.59823687136713 -6.0221022523173957 1;
	setAttr ".wm[86]" -type "matrix" -0.32473670655979908 0.94191836337378021 -0.085649682731191071 -1.9631230145025887e-18
		 0.12281287722321051 -0.047796937557380972 -0.99127818998921446 1.2080511955403588e-18
		 -0.93779692290007588 -0.33242329867112902 -0.10015828422928326 -6.5052126355871613e-18
		 19.102607729442205 117.88502058395673 -0.074389824237054647 1;
	setAttr ".wm[87]" -type "matrix" -0.18811632540955492 0.95337547628800401 -0.23598188347207236 2.5336755793636984e-20
		 0.17513287212711312 -0.20385915482660028 -0.9632081405874291 -4.3368124131930628e-19
		 -0.96640608711602927 -0.22252336103430692 -0.12861815027079518 2.1535435890191944e-19
		 27.006400261394262 95.29070410248886 0.91128090083654367 0.99999999999999978;
	setAttr ".wm[88]" -type "matrix" -0.18811632540955492 0.95337547628800401 -0.23598188347207236 2.5336755793636984e-20
		 0.17513287212711312 -0.20385915482660028 -0.9632081405874291 -4.3368124131930628e-19
		 -0.96640608711602927 -0.22252336103430692 -0.12861815027079518 2.1535435890191944e-19
		 26.283815483161469 96.131811316639897 4.8854037037403568 0.99999999999999978;
	setAttr ".wm[89]" -type "matrix" -0.18811632540955492 0.95337547628800401 -0.23598188347207236 2.5336755793636984e-20
		 0.17513287212711312 -0.20385915482660028 -0.9632081405874291 -4.3368124131930628e-19
		 -0.96640608711602927 -0.22252336103430692 -0.12861815027079518 2.1535435890191944e-19
		 28.478514583363182 96.138307706931158 3.1621136573718287 0.99999999999999978;
	setAttr ".wm[90]" -type "matrix" -0.18811632540955492 0.95337547628800401 -0.23598188347207236 2.5336755793636984e-20
		 0.17513287212711312 -0.20385915482660028 -0.9632081405874291 -4.3368124131930628e-19
		 -0.96640608711602927 -0.22252336103430692 -0.12861815027079518 2.1535435890191944e-19
		 25.25738899495521 95.396616574482877 2.7334166489299099 0.99999999999999978;
	setAttr ".wm[91]" -type "matrix" -0.34064598513380562 0.93673910914121628 0.080499405075683983 0
		 0.10019469426600672 0.12130141692520297 -0.98754594297828979 0 -0.93483759875882178 -0.32833794733057903 -0.13517712931402803 0
		 10.633800830315739 142.04329146348095 -0.95967914605397453 1;
	setAttr ".wm[92]" -type "matrix" -0.79177796450419047 0.59893480364258633 0.11985305966564526 0
		 -0.12714782923092324 0.030307053784837626 -0.99142065341243868 0 -0.59742872750434772 -0.80022408328948647 0.052156802778126288 0
		 9.8896381555803607 139.95341376491808 -5.1203094659959589 1;
	setAttr ".wm[93]" -type "matrix" -0.79177796450419047 0.59893480364258633 0.11985305966564526 0
		 -0.12714782923092324 0.030307053784837626 -0.99142065341243868 0 -0.59742872750434772 -0.80022408328948647 0.052156802778126288 0
		 10.581720136152734 139.37595680854531 4.0243962441297638 1;
	setAttr ".wm[94]" -type "matrix" -0.79177796450419047 0.59893480364258633 0.11985305966564526 0
		 -0.12714782923092324 0.030307053784837626 -0.99142065341243868 0 -0.59742872750434772 -0.80022408328948647 0.052156802778126288 0
		 12.669100190758069 144.76946697186878 -1.1373651233930304 1;
	setAttr ".wm[95]" -type "matrix" -0.34064655373249608 -0.93673889260585474 -0.080499518692539462 0
		 0.10019392297717356 -0.1213013524868736 0.98754602914664158 0 -0.93483747423208186 0.32833858890543433 0.13517643214321806 0
		 -10.633800690563652 142.04329146250919 -0.95967922185668175 1;
	setAttr ".wm[96]" -type "matrix" -0.79177796450419102 -0.59893480364258656 -0.11985305966564534 0
		 -0.12714782923092358 -0.030307053784837487 0.99142065341243868 0 -0.59742872750434795 0.80022408328948647 -0.052156802778126704 0
		 -10.581720136152702 139.37595680854542 4.0243962441297727 1;
	setAttr ".wm[97]" -type "matrix" -0.79177796450419091 -0.59893480364258678 -0.11985305966564538 0
		 -0.12714782923092363 -0.030307053784837459 0.99142065341243868 0 -0.59742872750434795 0.80022408328948635 -0.05215680277812676 0
		 -9.8896381555803696 139.95341376491811 -5.1203094659959678 1;
	setAttr ".wm[98]" -type "matrix" -0.79177796450419102 -0.59893480364258656 -0.11985305966564534 0
		 -0.12714782923092358 -0.030307053784837487 0.99142065341243868 0 -0.59742872750434795 0.80022408328948647 -0.052156802778126704 0
		 -12.669100190758048 144.76946697186889 -1.1373651233930238 1;
	setAttr ".wm[99]" -type "matrix" -0.32473690330214044 -0.94191828315008486 0.085649819038521646 3.6083634379896604e-20
		 0.12281280261519487 0.047797085340682548 0.99127819210690571 -2.1381715026821718e-19
		 -0.93779686454345634 0.33242350473534565 0.10015814670775323 -4.3368083626737983e-19
		 -19.102609204682739 117.8850186312393 -0.074399949421415368 0.99999999999999989;
	setAttr ".wm[100]" -type "matrix" -0.32473690330214056 -0.94191828315008508 0.085649819038521702 3.6083634379896604e-20
		 0.12281280261519487 0.047797085340682562 0.99127819210690582 -2.1381715026821723e-19
		 -0.93779686454345634 0.33242350473534565 0.10015814670775323 -4.3368083626737983e-19
		 -19.839490921730633 117.59823421165333 -6.0221086631505116 0.99999999999999989;
	setAttr ".wm[101]" -type "matrix" -0.1881163558787366 -0.9533754680046933 0.23598189264800795 -2.5336760534827332e-20
		 0.17513312321960989 0.20385910218399658 0.96320810607473573 4.3368129718677581e-19
		 -0.9664060356818196 0.22252344475035885 0.12861839189705473 -2.1535424583800007e-19
		 -26.283814949434056 96.131811233264685 4.8854037474323393 0.99999999999999989;
	setAttr ".wm[102]" -type "matrix" -0.1881163558787366 -0.9533754680046933 0.23598189264800795 -2.5336760534827332e-20
		 0.17513312321960989 0.20385910218399658 0.96320810607473573 4.3368129718677581e-19
		 -0.9664060356818196 0.22252344475035885 0.12861839189705473 -2.1535424583800007e-19
		 -27.006400776861863 95.290704220940185 0.91128101429053254 0.99999999999999989;
	setAttr ".wm[103]" -type "matrix" -0.1881163558787366 -0.9533754680046933 0.23598189264800795 -2.5336760534827332e-20
		 0.17513312321960989 0.20385910218399658 0.96320810607473573 4.3368129718677581e-19
		 -0.9664060356818196 0.22252344475035885 0.12861839189705473 -2.1535424583800007e-19
		 -25.257389406977403 95.396616353032329 2.7334163858530451 0.99999999999999989;
	setAttr ".wm[104]" -type "matrix" -0.1881163558787366 -0.9533754680046933 0.23598189264800795 -2.5336760534827332e-20
		 0.17513312321960989 0.20385910218399658 0.96320810607473573 4.3368129718677581e-19
		 -0.9664060356818196 0.22252344475035885 0.12861839189705473 -2.1535424583800007e-19
		 -28.478514387263978 96.138307843424514 3.1621141035582792 0.99999999999999989;
	setAttr ".wm[105]" -type "matrix" -0.021773679285379648 -0.99805359797577553 -0.058437337875598683 -3.5919509973594239e-17
		 -0.0040090391444202447 0.058537888174125322 -0.99827713749902669 2.8585373117772956e-17
		 0.99975488720761663 -0.021501888654794361 -0.0052758211456615852 2.702929735114234e-17
		 6.8833994313403704 51.921452417810507 -3.4926246629350715 1.000000000000002;
	setAttr ".wm[106]" -type "matrix" -0.021773679285379648 -0.99805359797577553 -0.058437337875598683 -3.5919509973594239e-17
		 -0.0040090391444202447 0.058537888174125322 -0.99827713749902669 2.8585373117772956e-17
		 0.99975488720761663 -0.021501888654794361 -0.0052758211456615852 2.702929735114234e-17
		 6.9194182875927499 51.395523958769012 5.4763076473578867 1.0000000000000016;
	setAttr ".wm[107]" -type "matrix" -0.021773679285379138 0.99805359797577586 0.058437337875598759 3.2451985606014006e-17
		 -0.0040090391444172219 -0.05853788817412528 0.99827713749902669 -2.8815615882062873e-17
		 0.99975488720761652 0.021501888654788678 0.0052758211456576847 2.8351886810495935e-17
		 -6.9194182875926904 51.395523958769019 5.476307647357884 1.0000000000000011;
	setAttr ".wm[108]" -type "matrix" -0.021773679285379138 0.99805359797577586 0.058437337875598759 3.2451985606014006e-17
		 -0.0040090391444172219 -0.05853788817412528 0.99827713749902669 -2.8815615882062873e-17
		 0.99975488720761652 0.021501888654788678 0.0052758211456576847 2.8351886810495935e-17
		 -6.8833994313403384 51.921452417810563 -3.492624662935067 1.0000000000000016;
	setAttr ".wm[109]" -type "matrix" -0.012636616249611165 -0.99977732317110857 -0.016900295931518414 3.5940375296883515e-18
		 -0.0049114548957100582 0.016963501819868849 -0.99984404644765223 4.0657581468206431e-19
		 0.99990809254679391 -0.012551640483222755 -0.0051247224912559144 1.3900378495971425e-17
		 7.9462918571665666 101.87380850100239 -7.0181452537642706 0.99999999999999978;
	setAttr ".wm[110]" -type "matrix" -0.012636616249611165 -0.99977732317110857 -0.016900295931518414 3.5940375296883515e-18
		 -0.0049114548957100582 0.016963501819868849 -0.99984404644765223 4.0657581468206431e-19
		 0.99990809254679391 -0.012551640483222755 -0.0051247224912559144 1.3900378495971425e-17
		 8.0035761796059646 100.01349285519163 8.7152082872965533 0.99999999999999978;
	setAttr ".wm[111]" -type "matrix" -0.012636616249611165 -0.99977732317110857 -0.016900295931518414 3.5940375296883515e-18
		 -0.0049114548957100582 0.016963501819868849 -0.99984404644765223 4.0657581468206431e-19
		 0.99990809254679391 -0.012551640483222755 -0.0051247224912559144 1.3900378495971425e-17
		 14.393369972842923 102.44275841599632 1.838275993131113 0.99999999999999989;
	setAttr ".wm[112]" -type "matrix" -0.012636616249611937 0.99977732317110868 0.016900295931518847 -1.6108949912010714e-18
		 -0.0049114548957067588 -0.0169635018198693 0.99984404644765201 -4.3368086899420177e-19
		 0.99990809254679391 0.012551640483230616 0.0051247224912525742 1.383855423340807e-17
		 -8.0035378702610771 100.01362517049422 8.707409504411407 0.99999999999999956;
	setAttr ".wm[113]" -type "matrix" -0.012636616249611937 0.99977732317110868 0.016900295931518847 -1.6108949912010714e-18
		 -0.0049114548957067588 -0.0169635018198693 0.99984404644765201 -4.3368086899420177e-19
		 0.99990809254679391 0.012551640483230616 0.0051247224912525742 1.383855423340807e-17
		 -7.946291857166587 101.87380850100229 -7.0181452537642697 0.99999999999999956;
	setAttr ".wm[114]" -type "matrix" -0.012636616249611937 0.99977732317110868 0.016900295931518847 -1.6108949912010714e-18
		 -0.0049114548957067588 -0.0169635018198693 0.99984404644765201 -4.3368086899420177e-19
		 0.99990809254679391 0.012551640483230616 0.0051247224912525742 1.383855423340807e-17
		 -14.393369972842915 102.44275841599614 1.8382759931311285 0.99999999999999944;
	setAttr ".wm[115]" -type "matrix" 3.1149708989876793e-06 0.99969574466304745 -0.024666132507785293 0
		 -2.1586398122802563e-07 -0.02466613250723218 -0.9996957446678908 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 8.4868472119254909e-07 151.25725293418731 5.2993922931900901 1;
	setAttr ".wm[116]" -type "matrix" 3.205155482150427e-16 0.99788283071405526 0.065037344396157395 -1.7347234759768075e-18
		 -2.9195983614977719e-16 0.065037344396157409 -0.99788283071405526 -1.0842021724855042e-19
		 -1 2.7755575615628918e-16 3.3306690738754681e-16 -3.8518598887744717e-34 4.9832185495385748e-15 115.60224441037876 11.550133431160205 0.99999999999999978;
	setAttr ".wm[117]" -type "matrix" 3.2562952471023242e-16 0.99657635555788127 0.082677491150685678 -1.7347234759768071e-18
		 -2.8624495665283329e-16 0.082677491150685692 -0.99657635555788127 -2.4074124304840448e-35
		 -1 2.7755575615628918e-16 3.3306690738754691e-16 -3.8518598887744717e-34 2.6106660559090654e-15 107.72883506531626 10.971132334022165 0.99999999999999989;
	setAttr ".wm[118]" -type "matrix" -0.34064580359000868 0.93673917813250729 0.080499370482933916 -4.3368086899420177e-18
		 0.078123005481407937 0.11352529415321506 -0.99045888536676663 2.1684043449710089e-19
		 -0.93694035696572975 -0.33110681016713844 -0.11185279500250968 -5.6378512969246246e-18
		 16.051885877880661 125.6465115335634 2.1924856588350639 0.99999999999999978;
	setAttr ".wm[119]" -type "matrix" -0.021503748858943232 -0.99976872380693993 -0.00029611223175343747 -2.7755575615628907e-17
		 -0.0052682340015948511 0.0004094895837984953 -0.99998603891693638 2.8033402422328324e-17
		 0.99975488720761685 -0.021501888654791738 -0.0052758211456616702 -2.8622937353617311e-17
		 5.9436262533497368 8.7936897079968492 -5.8078028334048062 1.0000000000000002;
	setAttr ".wm[120]" -type "matrix" -0.13390237923891365 -0.79470199902643324 0.59204635424732388 2.1467749918434364e-19
		 0.97770308527417138 -0.20345818476970789 -0.051975418185724737 -3.1551105650519096e-19
		 0.16176164526711417 0.57188591501592756 0.80422613133799059 2.9910736321827954e-19
		 25.240297497534748 90.676192820467762 6.6444233789720233 0.99999999999999978;
	setAttr ".wm[121]" -type "matrix" -0.13390237923891379 0.79470199902643301 -0.59204635424732488 -2.1467749918434313e-19
		 0.97770308527417216 0.20345818476970748 0.051975418185723321 3.1551105650519077e-19
		 0.16176164526711309 -0.57188591501592878 -0.80422613133799015 -2.9910736321828007e-19
		 -25.240300000000044 90.676211586192622 6.6444468898230031 0.99999999999999989;
	setAttr ".wm[122]" -type "matrix" 1.0000000000000009 -2.1857515797307769e-16 0 -2.8661915358014007e-18
		 1.214306433183765e-16 0.99999999999999978 -5.5511151231257827e-16 2.5912642471602236e-18
		 6.9388939039072284e-17 5.5511151231257827e-16 1.0000000000000007 -5.5199861244972463e-19
		 25.044662615754213 83.7519818323415 8.0141721859614563 1;
	setAttr ".wm[123]" -type "matrix" 0.99999999999999989 -5.8980598183211441e-17 8.3266726846886741e-17 -4.3331929478717738e-18
		 5.1000870193718129e-16 0.99999999999999944 -8.3266726846886741e-16 1.9469206241339137e-18
		 -5.5511151231257827e-17 1.27675647831893e-15 1.0000000000000004 -4.9300057041118616e-20
		 27.08319579094206 85.389829618741246 7.7632550480705431 0.99999999999999978;
	setAttr ".wm[124]" -type "matrix" 0.99999999999999423 1.0944545980259845e-07 -3.6082248300317588e-16 -6.2747100464827498e-18
		 -1.0944545943136763e-07 0.99999999999999378 -1.1102230246251565e-15 2.6532980047166161e-18
		 1.6653345369377348e-16 1.1657341758564144e-15 1.0000000000000004 -1.3353995336411662e-18
		 28.185205372380945 89.110454866250322 6.8813222427513603 0.99999999999999956;
	setAttr ".wm[125]" -type "matrix" 0.99999999999998435 1.7402354998229453e-07 -7.7510533664041558e-16 2.0469357035500896e-19
		 -1.7402354925933981e-07 0.9999999999999849 -1.028191861407655e-16 -1.700307972202516e-18
		 7.0181510501838147e-16 3.6923076358346727e-16 1.0000000000000011 3.9411406124426398e-19
		 28.551191151291324 88.714385260215892 4.863142769982745 0.99999999999999978;
	setAttr ".wm[126]" -type "matrix" 0.999999999999998 5.0641941107612554e-08 -5.8286708792820718e-16 -1.1242557895101097e-18
		 -5.0641940906384624e-08 0.99999999999999833 -1.1934897514720433e-15 1.2889337011818149e-18
		 6.1756155744774333e-16 1.2490009027033011e-15 1.0000000000000002 -2.8976606394780464e-19
		 27.15830993652343 84.555681642344979 5.5711970689611281 0.99999999999999978;
	setAttr ".wm[127]" -type "matrix" 0.99999999999999922 -3.2742487929282582e-08 -1.8735013540549517e-15 7.1016238367971e-18
		 3.2742488038570161e-08 0.99999999999999911 -8.3266726846886741e-16 9.2113804399523297e-19
		 1.9359513991901167e-15 8.0491169285323849e-16 1.0000000000000002 -2.5305499097509867e-19
		 24.872570037841786 82.648348268321499 5.5972667100744093 1;
	setAttr ".wm[128]" -type "matrix" 0.99999999999999922 -1.0364972768961422e-16 1.3877787807814457e-17 -9.0029770362277886e-19
		 4.0635897424756706e-16 0.99999999999999933 -1.0130785099704553e-15 -2.2140007094747885e-18
		 -1.2490009027033011e-16 9.5756735873919752e-16 0.99999999999999956 9.8357081689338825e-19
		 24.63051986694332 83.386934694102806 3.4134369256810966 0.99999999999999989;
	setAttr ".wm[129]" -type "matrix" 0.99999999999999889 3.2146732806097311e-08 1.3877787807814457e-16 -5.3052115467029952e-18
		 -3.2146732613109325e-08 0.99999999999999967 -1.4710455076283324e-15 2.4086668155975901e-18
		 -2.7755575615628914e-16 1.429412144204889e-15 1.0000000000000004 1.1439585405101292e-19
		 26.840940475463825 85.013903077891811 3.1328068139867669 0.99999999999999978;
	setAttr ".wm[130]" -type "matrix" 0.99999999999999545 9.0905384613534229e-08 1.1102230246251565e-16 -6.4010038267184904e-18
		 -9.0905384671213785e-08 0.99999999999999545 -4.2327252813834093e-16 -1.8292324643097943e-18
		 -2.9143354396410359e-16 4.0939474033052647e-16 1.0000000000000002 -1.1591536897596433e-20
		 28.388644383136668 88.700624895919148 3.0873167875127674 0.99999999999999956;
	setAttr ".wm[131]" -type "matrix" 0.99999999999999556 9.4417726841794503e-08 1.9428902930940239e-16 8.5642400609097672e-19
		 -9.4417727188739198e-08 0.99999999999999545 1.3877787807814457e-16 -2.5664886805660267e-19
		 -1.9428902930940239e-16 -1.3877787807814457e-17 1.0000000000000004 -2.3321396834411711e-21
		 27.432070803642389 89.203561899201674 1.2736166763693917 0.99999999999999978;
	setAttr ".wm[132]" -type "matrix" 0.99999999999999944 -2.4965185752012786e-08 -1.9428902930940239e-16 2.4369159804396184e-18
		 2.4965186265490935e-08 0.99999999999999967 -7.2164496600635175e-16 -7.0523413328961033e-20
		 -8.3266726846886741e-17 6.2450045135165055e-16 1.0000000000000002 -3.4931046748336945e-19
		 26.195495406878639 86.231194139576104 1.4640624064954113 0.99999999999999989;
	setAttr ".wm[133]" -type "matrix" 0.99999999999999967 2.6177415710787466e-08 -1.1102230246251565e-16 -4.4049597509998597e-18
		 -2.6177415828748662e-08 0.99999999999999933 -1.0963452368173421e-15 -1.8725636567799876e-19
		 -1.3877787807814457e-16 1.0963452368173421e-15 1.0000000000000004 1.6738033824622326e-18
		 24.683154206931857 85.084067115055291 1.5626205258090604 0.99999999999999944;
	setAttr ".wm[134]" -type "matrix" 0.99999999999999967 2.7755575615628914e-16 -5.5511151231257827e-16 -5.5869200757801234e-18
		 1.1102230246251565e-16 0.99999999999999933 -3.5375513296465044e-08 -2.9045105386550931e-19
		 5.5511151231257827e-16 3.5375513462998498e-08 0.999999999999999 -2.7968579240853742e-18
		 22.872776607694419 92.624228792617743 6.9662755231783215 0.99999999999999989;
	setAttr ".wm[135]" -type "matrix" 0.99999999999998934 1.207766395228127e-07 7.8875736830852361e-08 6.6716892675411966e-19
		 -1.2077664213183681e-07 0.99999999999999212 2.7682216685587235e-08 -4.3612770438302824e-19
		 -7.8875733666716741e-08 -2.7682226233505247e-08 0.99999999999999656 3.5881691247463943e-19
		 21.170498890112633 90.171392121108909 6.8231584080732359 0.99999999999999989;
	setAttr ".wm[136]" -type "matrix" 0.99999999999999367 -1.1245251890432129e-07 3.1918911957973251e-16 -1.2855346862086045e-19
		 -1.1245251925126598e-07 -0.99999999999999356 1.8318679906315083e-15 3.7499026425470977e-18
		 2.3592239273284576e-16 -1.8318679906315083e-15 -0.99999999999999978 2.7323279639197577e-19
		 -28.185209098865737 89.110450964563498 6.8813229359707577 0.99999999999999956;
	setAttr ".wm[137]" -type "matrix" 1.0000000000000002 -1.7347234759768071e-16 9.7144514654701197e-17 5.5039660388565293e-18
		 -8.2919782151691379e-16 -1 1.6653345369377348e-15 -2.9903482875628659e-18 5.5511151231257827e-17 -1.7208456881689926e-15 -1 9.0830745797187933e-19
		 -27.083207219992854 85.389808056916252 7.7632585627444444 0.99999999999999989;
	setAttr ".wm[138]" -type "matrix" 1.0000000000000011 -8.3960616237277463e-16 1.3877787807814457e-16 -9.3789182178182166e-19
		 -7.3205330686221259e-16 -1 1.6653345369377348e-15 -2.4082783473328012e-18 1.3877787807814457e-17 -1.7208456881689926e-15 -1.0000000000000002 -3.023272947306398e-19
		 -25.044712587646931 83.751992776683281 8.0141734297810725 1;
	setAttr ".wm[139]" -type "matrix" 0.99999999999998546 -1.74653698134703e-07 2.3387161213048251e-16 -3.2419524203489473e-19
		 -1.7465369799461537e-07 -0.9999999999999839 1.4350868156922454e-15 3.5334759535831839e-18
		 1.3976469880189602e-16 -1.479453788208624e-15 -1.0000000000000004 -2.9097225065586899e-19
		 -28.551200106805485 88.714411566896459 4.8631468986602719 0.99999999999999967;
	setAttr ".wm[140]" -type "matrix" 0.99999999999999911 -5.1158398243350556e-08 6.5225602696727947e-16 2.1503053043791248e-18
		 -5.1158398732542576e-08 -0.99999999999999778 1.6375789613221059e-15 4.1640284254455804e-18
		 5.3429483060085659e-16 -1.6375789613221059e-15 -1.0000000000000002 -2.0569058664267747e-19
		 -27.158300000000054 84.555711586192643 5.5711968898230095 0.99999999999999989;
	setAttr ".wm[141]" -type "matrix" 0.99999999999999911 6.2132753671229057e-08 7.9103390504542404e-16 -6.1103576991969029e-18
		 6.213275365735127e-08 -0.99999999999999789 1.7486012637846216e-15 1.2269223426136742e-18
		 8.0491169285323849e-16 -1.5265566588595902e-15 -1 -5.2786584320854941e-19 -24.872600000000041 82.648311586192676 5.5972668898230111 1;
	setAttr ".wm[142]" -type "matrix" 1.0000000000000002 5.3342746886286818e-17 5.5511151231257827e-17 2.0916140992040346e-18
		 -5.5901464013352609e-16 -0.99999999999999967 1.2836953722228372e-15 -2.9105753440273487e-18
		 2.4980018054066022e-16 -1.366962099069724e-15 -1.0000000000000002 2.2107613003548585e-19
		 -24.630500000000005 83.386911586192639 3.4134368898230067 0.99999999999999978;
	setAttr ".wm[143]" -type "matrix" 0.99999999999999989 -3.2234892398411405e-08 9.241950773282642e-16 -3.6186125924134355e-19
		 -3.2234892208183304e-08 -0.99999999999999878 1.1739952582310323e-15 -6.3613842468594707e-19
		 9.9350846823480532e-16 -1.2096642823174312e-15 -0.99999999999999989 3.6987709005747404e-19
		 -26.840900000000012 85.013911586192648 3.1328068898230041 0.99999999999999967;
	setAttr ".wm[144]" -type "matrix" 0.999999999999996 -9.0905385665644017e-08 -2.7755575615628914e-17 -4.1038133695353999e-19
		 -9.0905385898964325e-08 -0.99999999999999545 1.6028844918025698e-15 1.1970778964001334e-19
		 9.7144514654701197e-17 -1.5959455978986625e-15 -1.0000000000000004 9.0967221505050808e-20
		 -28.388600000000029 88.70061158619265 3.0873168898229997 0.99999999999999989;
	setAttr ".wm[145]" -type "matrix" 0.99999999999999645 -9.3601533208281795e-08 2.2204460492503131e-16 6.0854104758988944e-18
		 -9.3601533614207089e-08 -0.999999999999995 9.0205620750793969e-16 1.8037490500683995e-18
		 3.6082248300317588e-16 -8.8817841970012523e-16 -1.0000000000000002 -1.0106953242891726e-19
		 -27.432101025200048 89.203611288850155 1.2736166201789558 0.99999999999999944;
	setAttr ".wm[146]" -type "matrix" 1 2.4965184258863183e-08 3.5831080006703607e-16 -1.874119522809511e-18
		 2.4965184904921768e-08 -0.99999999999999944 1.0383224025245352e-15 8.169451054813733e-19
		 3.8300845259803832e-16 -9.6651372973408753e-16 -0.99999999999999978 -5.9776461488045999e-19
		 -26.195515062595575 86.231202231349442 1.4640623965108346 0.99999999999999989;
	setAttr ".wm[147]" -type "matrix" 0.99999999999999878 -5.5173743438580169e-08 1.1102230246251565e-16 -9.303952464371514e-19
		 -5.5173743865322145e-08 -0.99999999999999778 1.124100812432971e-15 -2.7380038118843811e-19
		 8.3266726846886741e-17 -1.124100812432971e-15 -0.99999999999999944 -4.8465697920333883e-19
		 -24.683200033002421 85.084111533524265 1.5626168765480466 0.99999999999999978;
	setAttr ".wm[148]" -type "matrix" 1.0000000000000002 -1.6653345369377348e-16 1.1102230246251565e-16 3.0157691038697767e-18
		 -4.9960036108132044e-16 -0.99999999999999911 3.5375516294067211e-08 -5.1139580787981622e-20
		 2.2204460492503131e-16 -3.5375516016511455e-08 -0.99999999999999911 2.5886609531711271e-18
		 -22.872796761503096 92.624216255996714 6.9662757448885539 0.99999999999999967;
	setAttr ".wm[149]" -type "matrix" 0.99999999999996192 -2.31894366431451e-07 -1.5144351928064737e-07 -8.1196918048717985e-18
		 -2.3189437448056793e-07 -0.99999999999997125 -5.3150584100603027e-08 2.2081376459063237e-18
		 -1.5144350706819409e-07 5.315061984978442e-08 -0.9999999999999869 -3.3512283678913473e-19
		 -21.170492530317105 90.171414040658348 6.8231593442555196 0.99999999999999978;
	setAttr ".wm[150]" -type "matrix" -0.79177812739951459 -0.59893460989482872 -0.11985295174440909 5.3572955939432692e-19
		 -0.12714740404816258 -0.030307421111769615 0.99142069671223187 2.50290839901997e-20
		 -0.59742860210700643 0.80022421438974378 -0.052156227708540913 -7.1533456697193599e-19
		 -10.638820530482439 135.10169695204073 0.95155027463472752 0.99999999999999989;
	setAttr ".wm[151]" -type "matrix" -0.79177784671711104 0.5989349836166965 0.11985293842072282 -5.3572989349391882e-19
		 -0.12714759004312612 0.030307190488220954 -0.99142067990885474 -2.5028877835429053e-20
		 -0.59742893451375401 -0.80022394340882907 0.05215657773457328 7.1533432397058112e-19
		 10.638819769980156 135.1017059180829 0.95155214804418975 0.99999999999999989;
	setAttr ".wm[152]" -type "matrix" -0.34064584544788207 -0.93673916104287092 -0.080499392220038976 -3.469446951953615e-18
		 0.078123453915098895 -0.11352548089318003 0.9904588285922582 3.2526065174565162e-19
		 -0.93694030435640541 0.33110679448883268 0.11185328209693586 -6.0715321659188356e-18
		 -16.051900559283574 125.64681133054313 2.1924870027246026 1;
	setAttr ".wm[153]" -type "matrix" -0.021503748858943038 0.9997687238069396 0.00029611223175329788 1.387778780781446e-17
		 -0.0052682340015918205 -0.00040948958379834021 0.99998603891693616 -2.7728470561316776e-17
		 0.99975488720761685 0.021501888654791301 0.0052758211456575424 -2.6888213877640507e-17
		 -5.9436378014822795 8.7939532104091747 -5.8073943666228738 1.0000000000000004;
	setAttr ".wm[154]" -type "matrix" 3.1149708989876793e-06 0.99969574466304745 -0.024666132507785293 0
		 -2.1586398122802563e-07 -0.02466613250723218 -0.9996957446678908 0 -0.99999999999512523 3.1193476820236338e-06 1.3896401852995875e-07 0
		 1.5936438563273792e-05 156.41946697635026 -2.0045600214665327 1;
	setAttr ".wm[155]" -type "matrix" -0.34064571782844649 -0.93673920818458822 -0.080499383692374346 -3.4694461292598649e-18
		 0.07812287987737028 -0.11352525290735627 0.99045890000140213 3.252569618792009e-19
		 -0.93694039861925504 0.3311067392881491 0.11185265590570993 -6.0715328336997508e-18
		 -16.118599586200201 126.37181082106264 -5.9671230504982198 1;
	setAttr ".wm[156]" -type "matrix" -0.34064580359000868 0.93673917813250729 0.080499370482933916 -4.3368086899420177e-18
		 0.078123005481407937 0.11352529415321506 -0.99045888536676663 2.1684043449710089e-19
		 -0.93694035696572975 -0.33110681016713844 -0.11185279500250968 -5.6378512969246246e-18
		 16.118603719304485 126.37197591568598 -5.9671279186105703 0.99999999999999978;
	setAttr -s 1103 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 -1.5707963267948963 -0.10915346290887797
		 1.5707963267948963 0 0 103.42406365931471 2.164099060331699 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[4]" -type "matrix" "xform" 1.0000000000000004 1.0000000000000002 1 4.4216473245316071e-33
		 -1.8141930498456838e-31 0.02638148957847954 0 7.4129999999999825 -1.2289999999999992
		 1.1480326062389819e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[5]" -type "matrix" "xform" 1.0000000000000002 1.0000000000000002 1 5.3694632603463618e-32
		 -1.6493435655536807e-31 0.017688691673104842 0 6.540056104124929 1.7763568394002505e-15
		 1.6959614914571347e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[6]" -type "matrix" "xform" 1 1 1 5.0729311349434677e-32 -1.7117808192569654e-31
		 0.014351016440106426 0 7.6498458227762569 2.6645352591003757e-15 2.6812166883603948e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[7]" -type "matrix" "xform" 1 1 1 0 0 0 0 10.29522881644408 7.5495165674510645e-15
		 2.5473486394623725e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.14616377610309417 0.9892604058362412 1
		 1 1 yes;
	setAttr ".xm[8]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.64098666933441 3.8767792175072557
		 -3.4775081921847377 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.048147358144702168 -0.67919742764105595 -0.13879939639850619 0.71910181041968513 1
		 1 1 yes;
	setAttr ".xm[9]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.2271924873418731 -9.3258734068513149e-15
		 -1.1368683772161603e-13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948506 0.53969740289995682 0.049379025691938319 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[10]" -type "matrix" "xform" 1 1 1 0 0 0 0 -25.942629197482162 1.0658141036401503e-14
		 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1664063432051128 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[11]" -type "matrix" "xform" 1.0000000000000009 1 0.99999999999999978 2.2482902972560605e-16
		 0.23428317388843736 -2.8608812667764393e-05 0 -23.919990038655015 0 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[12]" -type "matrix" "xform" 1 1 1 3.0962937789519027 -0.77759160351188783
		 -2.675809886839922 0 -1.2686357154040735 -1.8318136906095788 0.61950730993277148 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[13]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999978 0.99999999999999967 -2.9425138072235502e-06
		 -6.1932535218995794e-06 0.44354399433670194 0 4.0516604453308673 1.3812950783176348e-11
		 4.3719694531318964e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[14]" -type "matrix" "xform" 0.99999999999999978 1 1.0000000000000002 -2.2053254471071296e-16
		 2.5710123034806624e-16 0.24272076006068743 0 2.6102879061749036 0 -1.0658141036401503e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[15]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.5358780239681762 -2.1252076385984648
		 -0.55475650764298778 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589730857 -0.67086110383210196 -0.73035777294519266 0.11326205235528281 1
		 1 1 no;
	setAttr ".xm[16]" -type "matrix" "xform" 0.99999999999999978 1 1 -3.1022200246462186e-07
		 -3.9031805958523027e-07 0.61468011035067749 0 4.2738801856345816 -2.482494210198638e-10
		 -5.1581849902504473e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[17]" -type "matrix" "xform" 0.99999999999999989 1.0000000000000007 0.99999999999999978 -2.4471549714765541e-16
		 2.1291445694219661e-16 0.41733309743888952 0 2.4666957502986691 1.4210854715202004e-14
		 -7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[18]" -type "matrix" "xform" 1 1 1 0 0 0 0 -6.7723296862230216 -0.27978723663700461
		 -0.36275273402219244 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800207 0.65392768619920127 0.74460445552019161 -0.086698209199445653 1
		 1 1 no;
	setAttr ".xm[19]" -type "matrix" "xform" 1 1 1 4.2771999351304468e-17 4.4447437339281213e-17
		 0.67472072861185006 0 4.4359145921492313 -5.3290705182007514e-15 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[20]" -type "matrix" "xform" 1 1.0000000000000004 1 -4.3377838053042662e-17
		 4.5667014322874431e-17 0.32769786023145298 0 2.5938963073742798 1.4210854715202004e-14
		 -1.0658141036401503e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[21]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3825985602606816 1.4813207129029979
		 0.2175109890033958 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313888827 -0.6176190457175601 -0.78453655612897033 0.038434237189574776 1
		 1 1 no;
	setAttr ".xm[22]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 -0.083441362873307043 -0.15991371689307504 0.22821267332554407 0 3.7442538243088563
		 -0.62912660693767819 -0.25276041286096529 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[23]" -type "matrix" "xform" 0.99999999999999967 1.0000000000000007 1.0000000000000002 -7.5480864761731701e-17
		 3.6730064516857789e-17 0.61751440177337902 0 4.1895887532116518 -1.3188092200522306e-06
		 1.0604575315653619e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[24]" -type "matrix" "xform" 0.99999999999999978 1.0000000000000002 1 -3.4616908061732521e-17
		 -2.8172087412438372e-18 0.30917388450391703 0 2.2084808571526509 -7.1054273576010019e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[25]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.1000190082973775 0.077638867047004942
		 1.1051857314747859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327074 -0.14064896677911912 0.1063938653225321 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[26]" -type "matrix" "xform" 1 0.99999999999999967 1 -2.2090156317416777e-16
		 9.8242169338792886e-17 0.53014553384961183 0 3.2113433856746667 -1.0148305311374894e-06
		 3.0120894800589326e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[27]" -type "matrix" "xform" 1 0.99999999999999989 1 5.6967175895581738e-17
		 2.8381188050168605e-17 0.35932428354175872 0 1.6941592092295537 7.1054273576010019e-15
		 -8.8817841970012523e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[28]" -type "matrix" "xform" 1 1 1 1.5970707287989025e-06 -1.7272370083675665e-15
		 8.3248609117360621e-09 0 -15.946661756748483 2.9185864391934047e-07 4.5590822139729426e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[29]" -type "matrix" "xform" 1 1 1 1.1128628787128129e-06 3.0207724709978668e-08
		 -2.1056107480074234e-08 0 -7.9733304050135274 6.3323703614059923e-08 6.1214450397528708e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[30]" -type "matrix" "xform" 1 1 1 5.3070195178143661e-13 2.3792325976042941e-07
		 -1.3578358637460943e-07 0 1.3843792601164751e-06 -2.7145519965188214e-07 -4.9580461336518056e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[31]" -type "matrix" "xform" 1 1 1 1.9437843710374102e-08 8.5653819506546881e-09
		 2.8195150377370807e-08 0 -17.295084873071218 2.1638773262111499e-07 -3.7567885868838857e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0058998186544699099 3.8789585246972899e-08 2.2885550165905089e-10 0.99998259591847038 1
		 1 1 no;
	setAttr ".xm[32]" -type "matrix" "xform" 1 1 1 4.7604797767663485e-07 -7.3040871468447449e-08
		 -2.6880013266818929e-08 0 -8.6475412902791504 2.5304690609573299e-07 -5.9611586067376265e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799857334752322 1.9595281799489555e-08 2.3123762860308417e-10 0.99993037925991579 1
		 1 1 no;
	setAttr ".xm[33]" -type "matrix" "xform" 1 1 1 1.5942175737862242e-15 -4.693018473877868e-07
		 -4.9014410172549118e-09 0 -1.7763568394002505e-15 4.4408920985006262e-16 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[34]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345595731
		 0.19315413354009436 -7.9999999999999991 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.046101807560602462 -0.99887540111039552 -0.0019555817656306046 0.010896425842871192 1
		 1 1 yes;
	setAttr ".xm[35]" -type "matrix" "xform" 1 1 1 0 0 0 0 50.884879303655445 -6.9388939039072284e-16
		 2.6645352591003757e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.041604680783302275 0.99913415042071274 1
		 1 1 yes;
	setAttr ".xm[36]" -type "matrix" "xform" 0.99999999999999944 1 0.99999999999999944 -4.1053561105643628e-17
		 -9.1627981083415987e-17 -0.099792039995178328 0 43.0893684535707 2.6645352591003757e-15
		 4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[37]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999967 4.6573144147700061e-18 2.5302314845434102e-18 -1.3335094917274555 0 5.0708992880109598
		 -12.614425958600854 -7.9936057773011271e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[38]" -type "matrix" "xform" 1 1 1 1.7161041695030145e-16 -5.0587262850384354e-10
		 1.1102230241910913e-16 0 28.726246491822632 0 1.7763568394002505e-15 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[39]" -type "matrix" "xform" 1 1 1 -2.175278136723275e-16 -3.8921911082563932e-09
		 -6.6613381435176405e-16 0 14.363123245911318 -1.7763568394002505e-15 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[40]" -type "matrix" "xform" 1 1 1 4.4564903616485817e-17 7.5176908324114549e-09
		 3.2196467715804674e-15 0 0 -1.7763568394002505e-15 -8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[41]" -type "matrix" "xform" 1 1 1 7.4599792225601508e-17 3.101180949689185e-09
		 -5.5511151219690454e-16 0 33.923253880095373 -2.4980018054066022e-16 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[42]" -type "matrix" "xform" 1 1 1 1.7734161856919416e-16 4.0058494094022555e-09
		 -9.9920072180743891e-16 0 16.961626940047651 -2.7755575615628914e-17 2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[43]" -type "matrix" "xform" 1 1 1 -8.4447832536887831e-17 1.9460082006017018e-08
		 6.6613381395341305e-16 0 -2.8421709430404007e-14 -2.4980018054066022e-16 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[44]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.6409866693344668 3.8767792175072415
		 3.4775081921847582 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67919742764105606 -0.048147358144700947 0.71910181041968524 0.13879939639850558 1
		 1 1 yes;
	setAttr ".xm[45]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418794 1.021405182655144e-14
		 -2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089082618687948423 0.53969740289995671 0.049379025691938784 0.83567500391746441 1
		 1 1 yes;
	setAttr ".xm[46]" -type "matrix" "xform" 1 1 1 0 0 0 0 25.942629197482148 -1.7763568394002505e-14
		 4.2632564145606011e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.16640634320511283 0.98605726453441955 1
		 1 1 yes;
	setAttr ".xm[47]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989 0.99999999999999989 -1.7719547742551232e-17
		 0.2342831738884372 -2.8608812667678799e-05 0 23.919990038655001 -7.1054273576010019e-15
		 -3.5527136788005009e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[48]" -type "matrix" "xform" 1 1.0000000000000002 1.0000000000000004 3.0962937789519027
		 -0.77759160351188694 -2.6758098868399225 0 1.2686357154041019 1.8318136906095752
		 -0.61950730993276437 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[49]" -type "matrix" "xform" 0.99999999999999989 1 0.99999999999999967 -2.9425138070570159e-06
		 -6.1932535213201843e-06 0.44354399433670144 0 -4.0516604453308673 -1.382716163789155e-11
		 -4.3709036390282563e-11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[50]" -type "matrix" "xform" 1.0000000000000002 1 1 -1.0951024224819728e-16
		 -1.3147682827073833e-16 0.24272076006068746 0 -2.6102879061749178 3.5527136788005009e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[51]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5358780239681948 2.1252076385984608
		 0.55475650764299189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.060783306589731023 -0.67086110383210185 -0.73035777294519288 0.11326205235528264 1
		 1 1 no;
	setAttr ".xm[52]" -type "matrix" "xform" 0.99999999999999989 1.0000000000000002 0.99999999999999989 -3.1022200246462176e-07
		 -3.9031805952971912e-07 0.61468011035067716 0 -4.2738801856345958 2.48254750090382e-10
		 5.1582915716608113e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[53]" -type "matrix" "xform" 1 0.99999999999999989 1 -7.8182043453882395e-17
		 1.8625427632794032e-17 0.41733309743888825 0 -2.4666957502986975 -7.1054273576010019e-15
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[54]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.7723296862230029 0.27978723663700578
		 0.36275273402220165 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10210879767800204 0.65392768619920094 0.74460445552019183 -0.086698209199445583 1
		 1 1 no;
	setAttr ".xm[55]" -type "matrix" "xform" 1 1 1.0000000000000002 -1.2739151879953648e-17
		 1.6691861723652016e-17 0.67472072861184973 0 -4.4359145921492313 1.0658141036401503e-14
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[56]" -type "matrix" "xform" 1 1 0.99999999999999989 -1.5622262437414125e-17
		 -1.3313583860337179e-17 0.32769786023145298 0 -2.5938963073743082 7.1054273576010019e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[57]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3825985602606892 -1.481320712902999
		 -0.21751098900338661 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.039647394313889209 -0.61761904571755988 -0.78453655612897055 0.038434237189574769 1
		 1 1 no;
	setAttr ".xm[58]" -type "matrix" "xform" 1 1 1.0000000000000002 -0.083441362873306571
		 -0.15991371689307465 0.22821267332554337 0 -3.7442538243088421 0.62912660693768885
		 0.25276041286096174 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[59]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999967 1 -4.7725289146103175e-17
		 -1.8781086714400331e-17 0.61751440177337802 0 -4.1895887532116802 1.3188092069515989e-06
		 -1.0604575297890051e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[60]" -type "matrix" "xform" 0.99999999999999978 1.0000000000000002 1.0000000000000002 1.5256391872600285e-17
		 2.4938366874384913e-17 0.30917388450391542 0 -2.2084808571526651 7.1054273576010019e-15
		 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[61]" -type "matrix" "xform" 1 1 1 0 0 0 0 -3.100019008297366 -0.077638867046999849
		 -1.1051857314747835 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10695263034327053 -0.14064896677911917 0.10639386532253192 0.97849851733579685 1
		 1 1 yes;
	setAttr ".xm[62]" -type "matrix" "xform" 1 1.0000000000000002 1 -2.6612533864765533e-17
		 4.2731018107534806e-17 0.53014553384961172 0 -3.2113433856746525 1.014830526002708e-06
		 -3.0120894756180405e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[63]" -type "matrix" "xform" 0.99999999999999978 1.0000000000000002 0.99999999999999989 8.472275151121027e-17
		 -1.1039669002797613e-16 0.3593242835417591 0 -1.6941592092295821 1.4210854715202004e-14
		 -2.1231301827739912e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[64]" -type "matrix" "xform" 1 1 1 1.08182964958512e-06 -6.4945811118219324e-08
		 4.0594123126932932e-08 0 15.94666095136445 -1.0734020250424692e-07 -1.6400243652014979e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[65]" -type "matrix" "xform" 1 1 1 1.9404091557882103e-06 5.1918358268756153e-08
		 -3.0067228184397346e-08 0 7.9733305555205902 -8.0196674190347039e-08 -1.1247605158359875e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[66]" -type "matrix" "xform" 1 1 1 -1.7222833206260737e-07 -1.1950459188189162e-07
		 7.3290778634209202e-08 0 3.794008449631292e-07 -9.1163720128406567e-08 -1.3948621102599645e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[67]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999967
		 0.99999999999999833 1.3297720257325253e-07 9.1781417651250027e-08 2.5223403808690039e-08 0 17.295085515775057
		 -9.7533423115692131e-08 5.5281149258235018e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0059001293061062251 -2.8392807976717996e-08 -1.1259027937650805e-08 0.99998259408560208 1
		 1 1 no;
	setAttr ".xm[68]" -type "matrix" "xform" 1 1 1 -1.8510935268298355e-07 -7.3525778477132489e-08
		 -1.9051371282054823e-08 0 8.6475423825332456 -8.5352365175594969e-08 3.7745845560266389e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.011799440696141954 5.7471190699417895e-08 2.1503880690791351e-08 0.99993038417644575 1
		 1 1 no;
	setAttr ".xm[69]" -type "matrix" "xform" 1 1 1 -0.00022152767880003694 8.4875104148135039e-07
		 1.2506500933867408e-08 0 8.8817841970012523e-16 4.4408920985006262e-16 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[70]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92761271345597152
		 0.19315413354010147 7.9999999999999982 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99887540111039552 0.046101807560602247 0.010896425842871421 0.0019555817656292628 1
		 1 1 yes;
	setAttr ".xm[71]" -type "matrix" "xform" 1 1 1 0 0 0 0 -50.88487930365546 2.7311486405778851e-14
		 -2.6645352591003757e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.041604680783301998 0.99913415042071274 1
		 1 1 yes;
	setAttr ".xm[72]" -type "matrix" "xform" 0.99999999999999822 0.99999999999999956
		 0.99999999999999922 -2.7751496375577785e-16 -3.2295149548647595e-16 -0.099792039995178258 0 -43.089368453570685
		 -7.1054273576010019e-15 8.8817841970012523e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[73]" -type "matrix" "xform" 0.99999999999999967 0.99999999999999978
		 0.99999999999999956 -2.254218540189416e-16 -2.3425650898258846e-16 -1.3335094917274555 0 -5.0708992880109669
		 12.614425958600851 -3.4638958368304884e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[74]" -type "matrix" "xform" 1 1 1 -2.6469779887190521e-23 -1.7143320048046075e-15
		 3.3306690738754701e-16 0 -28.726246491822618 -5.3290705182007514e-15 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[75]" -type "matrix" "xform" 1 1 1 -1.4250923983095974e-16 6.0074698163872185e-09
		 1.2212453266596122e-15 0 -14.363123245911318 -1.7763568394002505e-15 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[76]" -type "matrix" "xform" 1 1 1 -2.6469779673105168e-22 1.2863772876451032e-14
		 -1.1102230246251565e-16 0 7.1054273576010019e-15 0 8.8817841970012523e-16 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[77]" -type "matrix" "xform" 1 1 1 2.1028162314901689e-16 -5.7321815634235685e-09
		 1.1102230185982944e-16 0 -33.923253880095402 1.8873791418627661e-14 -2.6645352591003757e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[78]" -type "matrix" "xform" 1 1 1 -1.503217129219141e-17 1.6689062678700195e-33
		 2.2204460492503131e-16 0 -16.961626940047694 9.7699626167013776e-15 -1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[79]" -type "matrix" "xform" 1 1 1 -8.511536301937945e-18 1.3234889800375957e-23
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 no;
	setAttr ".xm[80]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.8896802499102243 3.884615267454778
		 2.3331122655065721e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 7.6382178455051576e-08 1.5593511478536243e-06 -0.23597495564053356 0.97175913698200467 1
		 1 1 yes;
	setAttr ".xm[81]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.683546000000064 0.00015703100003605641
		 4.3841862470061707e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.1288734818512077 0.99166104374203712 1
		 1 1 yes;
	setAttr ".xm[82]" -type "matrix" "xform" 1 1 1 1.4950003389690157e-06 3.2791962651043259e-09
		 7.7345600245272222e-07 0 7.7890216926664664 0.00010251789687742985 2.6258098901601676e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[83]" -type "matrix" "xform" 1 1 1 4.3181583572549488e-07 3.0053109731673356e-10
		 -8.4867158606452038e-07 0 3.8945085470691083 5.070714856003633e-05 1.2383109652697871e-10 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[84]" -type "matrix" "xform" 1 1 1 -6.5231069736441992e-08 -1.2229472208344874e-08
		 -1.328371922431916e-08 0 5.1598859727164381e-06 1.2468008989685586e-06 1.6550885445151819e-11 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[85]" -type "matrix" "xform" 0.99999999999999944 1.0000000000000002 1.0000000000000002 -7.6594754525455631e-08
		 -1.5627934511137316e-07 -0.16718402429717269 0 0.49922049000947766 2.9581812754938621
		 -2.3353211275889407e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[86]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 0.0058997737361192217 -0.00049452079635831038 -2.8729987160049575e-06 0 -0.4992245719571855
		 -2.9582054164285303 2.2603977356538962e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.0029189813026558381 0.00049262500763106506 -0.083493624323089724 0.99650391447608033 1
		 1 1 yes;
	setAttr ".xm[87]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -2.967889953708891e-05 2.0829965791048277 -3.5770309452232141e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[88]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 2.9107975592523871e-05 -2.0429266092840024 3.5082206935044269e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[89]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 0.22215031170242128 -7.6495421552635889e-08 -1.8877433709739861 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[90]" -type "matrix" "xform" 1 1 1 7.9853536398701606e-07 5.6918108219019875e-12
		 4.6824406195272547e-08 0 -0.16740074569656826 5.7656123431115702e-08 1.4225114365862055 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148218128171e-07 -0.05853731099064198 7.1153887646354644e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[91]" -type "matrix" "xform" 1 1 1 -5.2046188695544644e-07 4.3714980988727613e-07
		 1.4806520279165935e-07 0 3.1871186934040452e-06 3.1748160012057269e-07 -1.1475461789700603e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.01769022493995764 -5.5666396683338097e-08 -1.3911766870110481e-08 0.99984351572712138 1
		 1 1 no;
	setAttr ".xm[92]" -type "matrix" "xform" 1 1 1 -3.8163916471489756e-17 1.0755285551056205e-16
		 -4.163336342344337e-17 0 -2.0391023059279121 3.7807471347604569 1.9442799573314105 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[93]" -type "matrix" "xform" 1 1 1 1.6031064300857048e-07 -2.4351549027653503e-07
		 -2.0078720170536655e-07 0 -2.0796412888383458 -5.2507730495076324 0.25073941825030488 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[94]" -type "matrix" "xform" 1 1 1 -3.8163916471489756e-17 1.0755285551056205e-16
		 -4.163336342344337e-17 0 1.8460968932489834 0.7100886774885744 -2.7737621548980016 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243921 -0.28080602403705057 -0.030710052147679925 0.95192072896903979 1
		 1 1 yes;
	setAttr ".xm[95]" -type "matrix" "xform" 1 1 1 -1.0853573356802025e-06 -4.3568480912375238e-07
		 -1.5827201977261405e-07 0 5.709288075195218e-06 6.212917647019367e-07 -2.1773046867679113e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.017689848081294958 -3.5099206601646391e-07 -1.0642097693105201e-07 0.9998435223947425 1
		 1 1 no;
	setAttr ".xm[96]" -type "matrix" "xform" 1 1 1 2.775557561562892e-17 1.1275702593849249e-16
		 -1.387778780781446e-17 0 2.0796398125979323 5.2507738269428739 -0.25074371557527542 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[97]" -type "matrix" "xform" 1 1 1 3.9091003157570792e-07 2.0553793404269212e-07
		 -4.2825701378480786e-07 0 2.0391012125653276 -3.7807481359989907 -1.9442803597557088 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903996 -0.28080574450372225 -0.030709888094579113 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[98]" -type "matrix" "xform" 1 1 1 3.9091003157917731e-07 2.0553793393427188e-07
		 -4.2825701378480775e-07 0 -1.8460945685297929 -0.71008786430548199 2.7737649130940696 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903991 -0.28080574450372231 -0.030709888094579106 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[99]" -type "matrix" "xform" 1.0000000000000004 0.99999999999999989 0.99999999999999967 1.5305987781210769e-07
		 2.9696317398118246e-16 -0.1671841185810761 0 0.49922314169340609 2.9581952655744672
		 4.6052669233631605e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[100]" -type "matrix" "xform" 1 1 1 0.005900319728525929 -0.00049432277654363284
		 -2.9662723266230796e-06 0 -0.49922185243011086 -2.9581876247830028 -4.5783868074522616e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0029191406150601736 0.0004926176904447542 -0.083493624306147013 0.99650391401444316 1
		 1 1 yes;
	setAttr ".xm[101]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -2.9056714197395195e-05 2.0429267278445735 -4.0345676239894601e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[102]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 2.962663036498725e-05 -2.082996535952919 4.1137013226943964e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[103]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 0.16740093387851118 -4.2835413083253115e-07 -1.4225110972004771 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[104]" -type "matrix" "xform" 1 1 1 5.3972487912568183e-07 -3.2469027353004279e-08
		 5.20151866570654e-08 0 -0.22215036112133646 5.6843365570102833e-07 1.8877432627052784 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -8.3734148226988623e-07 -0.058537310990641946 7.1153887645468402e-06 0.99828522135242237 1
		 1 1 no;
	setAttr ".xm[105]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.7755575615628914e-16 0 0.18779704740523329 4.5099358985119951 1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668544 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[106]" -type "matrix" "xform" 0.99999999999999956 0.99999999999999967
		 1 -2.2660560680042737e-18 -4.7557854755709537e-17 -0.04161669274207578 0 -0.18599651324030475
		 -4.466696168286358 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[107]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 1 0 0 2.3869795029440866e-15 0 0.18599651324026922 4.4666961682863562 4.4408920985006262e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.020806844778668492 0.99978351417212141 1
		 1 1 yes;
	setAttr ".xm[108]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 7.3909077779430053e-19 9.5767488972453701e-19 -0.041616692742075689 0 -0.18779704740521908
		 -4.5099358985119951 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[109]" -type "matrix" "xform" 1 1 1 -1.4842222358891025e-18 -0.0089528643682462317
		 -2.8553627405108745e-18 0 0.79993655503660932 8.8770532069966901 0.0071619148329844506 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[110]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 2.3931518875712356
		 -6.8856854788981927 0.021426136727047407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.004476417234014666 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[111]" -type "matrix" "xform" 1 1 1 0 2.2551405187698487e-16 0 0 -0.057243470674194441
		 -9.1593399531575415e-16 6.3937013769780924 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.004476417234014666 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[112]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1 9.3796182318615761e-20 -0.0089528643682455378 -3.1942830401523643e-18 0 -2.3931518875712356
		 6.8778854795754505 -0.02142613672705096 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[113]" -type "matrix" "xform" 1 1 1 0 3.1225025876304978e-17 0 0 -0.79993655503660932
		 -8.8770532069966848 -0.0071619148329853388 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.0044764172340143278 0 0.99998998079418122 1 1 1 yes;
	setAttr ".xm[114]" -type "matrix" "xform" 1 1 1 0 1.7347234759768065e-17 0 0 0.057243470674166019
		 0 -6.3937013769780959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.0044764172340143278 0 0.99998998079418122 1
		 1 1 yes;
	setAttr ".xm[115]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 -3.9400967430654816 -2.8896707548708092 -2.6925502350708791e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[116]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.1278504909219862
		 -6.9040537706030758 4.4577838808432881e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[117]" -type "matrix" "xform" 1 1 1 0 0 -1.7347234759768071e-18 0 -2.3598245839357759
		 -6.9968577821554048 2.8582904152448743e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[118]" -type "matrix" "xform" 1.0000000000000007 1 0.99999999999999989 1.2335469229373952e-17
		 4.0109977394941461e-16 1.4704801662824648e-16 0 0.34387171483078305 -4.5604522683327886
		 -7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[119]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 0.0012413669866422339
		 2.5158018416556076 -9.8983505836258701e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[120]" -type "matrix" "xform" 1 1 0.99999999999999989 -3.2522503597421059e-09
		 1.6269235712078467e-08 1.1676854017302847e-08 0 -5.6161683140689291 -2.8078829101015756
		 1.3490852531175506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267574 0.79092168180925615 -0.56655406700099809 0.076316486466476846 1
		 1 1 no;
	setAttr ".xm[121]" -type "matrix" "xform" 1 0.99999999999999989 1 -3.2522505817867208e-09
		 1.6269233658165888e-08 1.1676854294858608e-08 0 5.6161553990582291 2.8079089430753577
		 -1.3490770884595875 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.21825484256267533 0.79092168180925626 -0.56655406700099842 0.076316486466475958 1
		 1 1 no;
	setAttr ".xm[122]" -type "matrix" "xform" 1.0000000000000007 0.99999999999999989
		 1.0000000000000002 0.27882526131125784 3.2295867446465572 0.35747862076334158 0 -0.13003639372401921
		 -0.42748935939727062 0.0090326042383743754 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[123]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 -5.5511151231257827e-17 -8.3266726846886741e-17 2.3111159332646827e-33 0 -0.092939849104823224
		 -0.70251570526252749 -0.020561655155919567 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.37941935441919783 0.91371269212297312 -0.14499380240721954 0.012118869955732907 1
		 1 1 yes;
	setAttr ".xm[124]" -type "matrix" "xform" 0.99999999999999989 1 1 2.7755575615628932e-17
		 -8.3266726846886741e-17 -4.4408920985006262e-16 0 0.64530541359000892 -1.0337684191679983
		 -0.099179200290809177 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806070025397454 0.75611401757832797 -0.13453354303836371 0.05541534995389473 1
		 1 1 yes;
	setAttr ".xm[125]" -type "matrix" "xform" 1 1 1.0000000000000002 -7.70371977754894e-34
		 1.3877787807814454e-17 -1.1102230246251563e-16 0 0.30737120973599019 -1.1821106670030854
		 0.012795115529151246 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317158315414 0.76625634194243475 -0.084576774299171445 0.038109246738131722 1
		 1 1 yes;
	setAttr ".xm[126]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 1.5407439555097894e-33 2.775557561562892e-17 1.1102230246251568e-16 0 -0.16496152272483755
		 -0.64963237563258502 -0.010965767331040155 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.34633520245692045 0.93351292551379461 -0.092423384556460472 0.0079663934706561655 1
		 1 1 yes;
	setAttr ".xm[127]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999989 0.17924870876165233
		 3.1907579539797135 0.37840512224065304 0 0.0097566940123030577 -0.62627658440709411
		 0.19072773034926271 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[128]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999967
		 0.99999999999999944 0.034700096005589653 3.0430032271756691 0.37218530248698611 0 0.14478671015100275
		 -0.62522803999102905 0.054605464536113146 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[129]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 6.5052130349130274e-18 -1.1573858191282761e-17 -3.7645206585083768e-35 0 -0.21927985396480665
		 -0.68039191021174616 0.059962946419279461 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.33286583944205939 0.94152684478977178 0.00012936364655210739 0.05222563295736244 1
		 1 1 yes;
	setAttr ".xm[130]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 0
		 0 0 0 0.44262871211201116 -1.1674609741902977 -0.1744171177961924 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308557 0.015993303709080996 0.049716674357998904 1
		 1 1 yes;
	setAttr ".xm[131]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1 -8.3266726846886728e-17 -1.3866695599588093e-32 -3.3306690738754691e-16 0 0.35997225062985194
		 -1.0044914815075445 0.030306462594378969 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755943328875 -0.79465996101688263 -0.10954779490783749 -0.059590559753185599 1
		 1 1 yes;
	setAttr ".xm[132]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628914e-17
		 -1.5407439555097887e-33 -1.1102230246251565e-16 0 -0.012844241410235213 -0.69852386285188572
		 -0.18318987036044843 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.36517286647374636 -0.92254919836856386 -0.090110157422200188 -0.08620854777928888 1
		 1 1 yes;
	setAttr ".xm[133]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 1.0000000000000002 3.035377678315335 0.22681456074419568 -2.759212500790575 0 -0.008897969522394078
		 -0.53397345773781524 -0.057093330916351714 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[134]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999989
		 0.99999999999999989 4.6222318665293681e-33 -1.6653345369377351e-16 -5.5511151231257839e-17 0 -0.28881122908877899
		 -0.77666693499215711 0.10702660267226349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.2177754570780685 -0.44078108077077199 0.76609461237456522 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[135]" -type "matrix" "xform" 1 0.99999999999999967 1.0000000000000002 -0.76412466194222251
		 -0.77347831594972571 2.2324028510382652 0 -0.092995528926863358 -0.74776544149076929
		 0.058108452627571694 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[136]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 0 0 0 0 -0.64530862789699484 1.033772745931909 0.099178466978877111 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63806069911713481 0.75611401853767068 -0.13453354295504596 0.055415350156170579 1
		 1 1 yes;
	setAttr ".xm[137]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999989 -5.5511151231257827e-17 -1.3877787807814457e-16 3.8518598887744717e-33 0 0.092932645278267501
		 0.70253901601402902 0.020558105201324395 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.37941935441919805 0.91371269212297301 -0.14499380240722057 0.012118869955733351 1
		 1 1 yes;
	setAttr ".xm[138]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999978
		 1.0000000000000002 0.27882526131125918 3.2295867446465572 0.35747862076334247 0 0.1300869336832946
		 0.42749737115858011 -0.0090328041227891731 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[139]" -type "matrix" "xform" 1 0.99999999999999989 1.0000000000000002 2.3111159332646827e-33
		 -4.163336342344337e-17 -1.1102230246251565e-16 0 -0.30734474282169799 1.1821151242411378
		 -0.012786813473642411 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.63580317134172704 0.76625634214275939 -0.084576774287164702 0.038109246764780655 1
		 1 1 yes;
	setAttr ".xm[140]" -type "matrix" "xform" 1 0.99999999999999989 1 -2.7755575615628907e-17
		 1.3877787807814457e-17 1.1102230246251563e-16 0 0.16497330343041483 0.64960365708683554
		 0.010971411859809876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34633520221586123 0.93351292560322785 -0.092423384554404631 0.0079663934945232405 1
		 1 1 yes;
	setAttr ".xm[141]" -type "matrix" "xform" 1.0000000000000004 0.99999999999999944
		 0.99999999999999989 0.17924870733867815 3.1907579592197139 0.37840515119501461 0 -0.0097425222843625647
		 0.62632109537290148 -0.19073555836700962 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[142]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999989
		 0.99999999999999989 0.034700096005592762 3.0430032271756695 0.37218530248698789 0 -0.14481344796617179
		 0.62524239210620181 -0.054608253490670222 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[143]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.3091741232762464e-17 3.2363434848692301e-17 1.1102230246251563e-16 0 0.21925389433539522
		 0.68035991504324755 -0.05996656124215427 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.33286583940055764 0.94152684480444415 0.00012936364885220153 0.052225632957356702 1
		 1 1 yes;
	setAttr ".xm[144]" -type "matrix" "xform" 0.99999999999999989 1 1.0000000000000002 9.0205620750793994e-17
		 2.7755575615628877e-17 8.8817841970012523e-16 0 -0.44265338170127677 1.1674220371286874
		 0.17441239141144216 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6032315642903372 0.79585434997308568 0.015993303709079976 0.049716674357999396 1
		 1 1 yes;
	setAttr ".xm[145]" -type "matrix" "xform" 1.0000000000000002 0.99999999999999989
		 1.0000000000000002 0 0 0 0 -0.35991630006155617 1.0045062980003849 -0.030304822923965302 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59410755975758744 -0.79465996077442913 -0.10954779488351792 -0.059590559797891941 1
		 1 1 yes;
	setAttr ".xm[146]" -type "matrix" "xform" 1 0.99999999999999978 1 5.5511151231257827e-17
		 5.5511151231257821e-17 2.2204460492503131e-16 0 0.012863941463479023 0.69853100111512134
		 0.18319344488131462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.3651728664737463 -0.92254919836856397 -0.09011015742219905 -0.086208547779289033 1
		 1 1 yes;
	setAttr ".xm[147]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 0.99999999999999967 3.0353776716611103 0.22681455767013856 -2.7592125303813826 0 0.008957472682361356
		 0.53395019911204145 0.057095533089779771 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[148]" -type "matrix" "xform" 0.99999999999999978 0.99999999999999978
		 0.99999999999999978 1.1102230246251563e-16 5.5511151231257815e-17 5.5511151231257815e-17 0 0.28881221121405076
		 0.77665484218863767 -0.10704700344571805 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.21777545707806917 -0.44078108077077183 0.76609461237456489 0.41398663507371058 1
		 1 1 yes;
	setAttr ".xm[149]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999933
		 1 -0.76412476383649763 -0.77347829145986169 2.2324030333422034 0 0.093011950531163734
		 0.74777116535866295 -0.058093641876983071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[150]" -type "matrix" "xform" 1 1 1 3.9091003156529952e-07 2.0553793392733299e-07
		 -4.2825701382644117e-07 0 6.3501177812513419 2.7291390216045208 -2.0160545373111205 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11853992839903978 -0.28080574450372214 -0.030709888094579009 0.9519208591065117 1
		 1 1 yes;
	setAttr ".xm[151]" -type "matrix" "xform" 1 1 1 1.6031064308836773e-07 -2.4351549037888371e-07
		 -2.0078720164985537e-07 0 -6.3501221820377936 -2.7291381106600348 2.0160455531035382 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.11854026877243926 -0.28080602403705029 -0.030710052147679925 0.9519207289690399 1
		 1 1 yes;
	setAttr ".xm[152]" -type "matrix" "xform" 1.0000000000000007 1.0000000000000007 1.0000000000000013 -6.0136566028402443e-17
		 2.8488563186865517e-16 7.6650509633709626e-17 0 -0.34414841807519281 4.5604182918902847
		 0.00011523384355172084 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[153]" -type "matrix" "xform" 1 1 1 0 0 -2.0816681711721685e-17 0 -0.00097755623600903618
		 -2.5153934276395504 -3.7146064117976607e-06 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[154]" -type "matrix" "xform" 1 1 1 7.3503344590672615e-07 -1.4429761016476056e-07
		 3.8672796649290722e-07 0 1.4007122498098568 4.2847543237057621 3.3515570085725825e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[155]" -type "matrix" "xform" 0.99999999999999978 1 0.99999999999999978 -6.289219633362861e-20
		 -1.3552527152912673e-20 -2.3955150665752208e-21 0 -0.34371943612941891 -3.6088561973584454
		 -0.61001866734908816 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 3.1065704247975371e-07 6.7113447887175844e-08 1.18840581216383e-08 0.99999999999994937 1.0000000000000002
		 1.0000000000000004 1.0000000000000018 yes;
	setAttr ".xm[156]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.3438717148307161 3.6088802562769589
		 0.6099587491636127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[157]" -type "matrix" "xform" 0.99999999999999956 0.99999999999999989
		 1 1.5703149028420686 0.46662208202660421 2.9289232613546319 0 7.3666955983805416
		 5.5511151231257827e-16 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[158]" -type "matrix" "xform" 1 1 0.99999999999999989 1.4276774207289122e-15
		 -3.1225022567582528e-16 -5.5511151231257827e-17 0 7.3695985333234706 -1.1102230246251565e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[159]" -type "matrix" "xform" 1 1 0.99999999999999989 2.8449465006019636e-16
		 -1.7347234759768071e-17 9.1344033031903749e-18 0 7.3695985333234972 8.8817841970012523e-16
		 1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[160]" -type "matrix" "xform" 1 1 0.99999999999999978 1.5703148809922025
		 0.46662211703267098 2.9289232292916254 0 7.3666955983805309 -4.4408920985006262e-16
		 8.8817841970012523e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[161]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.1832913578315177e-29
		 139.8020486634895 5.3260477933662118 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 -0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[162]" -type "matrix" "xform" 1 1 1 0 0 0 0 19.987378320308522 -5.3928601584374292e-09
		 1.0397265981509918e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[163]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.351462102730281 -0.089136169746006355
		 -9.129427805878418 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[164]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9693614879890333 9.6982952370332143
		 -11.555257693268555 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[165]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3271126662223196 10.455308030379777
		 1.5560523119194327 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[166]" -type "matrix" "xform" 1 1 1 -2.4492935562778254e-16 -6.6174448596352896e-24
		 3.3306690738754696e-16 0 2.1969801585299251 -10.483447262185308 1.5560522066337885 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70929924120752097 0.70490750203302188 7.4274074981640058e-09 7.4736819900378726e-09 1
		 1 1 yes;
	setAttr ".xm[167]" -type "matrix" "xform" 1 1 1 -2.4492935562778254e-16 -6.6174448596352896e-24
		 3.3306690738754696e-16 0 1.8487025995983402 -9.7220094843303553 -11.555257793366213 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70929924120752097 0.70490750203302188 7.4274074981640058e-09 7.4736819900378726e-09 1
		 1 1 yes;
	setAttr ".xm[168]" -type "matrix" "xform" 1 1 1 0 0 0 0 19.987377206627016 -2.2204460492503131e-15
		 8.8817841970012523e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[169]" -type "matrix" "xform" 1 1 1 0 0 0 0 19.987378320308522 -5.3928602694597316e-09
		 1.0397265892692076e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.7049075020330221 0.70929924120752086 1
		 1 1 yes;
	setAttr ".xm[170]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825256038787472 -7.8514162718883158
		 -1.558421627436785 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[171]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.8948587124511391 -7.8444173295206392
		 -1.5321763594664928 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39662690245854215 -0.45199488038181301 -0.61337259146967793 0.51201737508461975 1
		 1 1 no;
	setAttr ".xm[172]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 6.2831853071795862
		 6.2831853071795862 -6.2831853071795853 0 -1.9122784361071297 -7.8701407551794054
		 -1.4351866804222122 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.34531075875321526 -0.3921319497726255 -0.65360120409052325 0.54753856473148632 1
		 1 1 no;
	setAttr ".xm[173]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795853
		 6.2831853071795862 -6.2831853071795853 0 -1.9380812291148857 -7.9409271871768423
		 -1.2947925508541605 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31220752909447685 -0.36268486817606038 -0.67938606833492221 0.55625598003549714 1
		 1 1 no;
	setAttr ".xm[174]" -type "matrix" "xform" 0.99999999999999989 1 1 6.2831853071795862
		 6.2831853071795871 -6.2831853071795871 0 -1.975087508500792 -8.0460690950090807
		 -1.1300509599736959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.30140935602809049 -0.36386870791348802 -0.69238230286542657 0.54530607018340582 1
		 1 1 no;
	setAttr ".xm[175]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795845 0 -2.0401621860136459 -8.2018743957734479 -0.89309135134282558 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.31802914751199135 -0.35089191239675305 -0.6669881042438367 0.5752036125969292 1
		 1 1 no;
	setAttr ".xm[176]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795871
		 -6.2831853071795853 0 -2.1161383932623323 -8.3810965537053299 -0.61618121607523502 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.39321321601051529 -0.41761555105483644 -0.61004571434593735 0.54664873975889527 1
		 1 1 no;
	setAttr ".xm[177]" -type "matrix" "xform" 1 1 1 6.2831853071795871 6.2831853071795862
		 -6.2831853071795871 0 -2.1742652677366152 -8.4655707124831068 -0.36965220402961513 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.45054194021294525 -0.46587727597940454 -0.5603292069660184 0.51575333605900942 1
		 1 1 no;
	setAttr ".xm[178]" -type "matrix" "xform" 1 1 1 6.2831853071795853 6.2831853071795862
		 -6.2831853071795862 0 -2.2029916703461367 -8.4924568266441369 -0.18224446339057085 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.46684447698938986 -0.47002177105963616 -0.54433894842053732 0.51461721528422433 1
		 1 1 no;
	setAttr ".xm[179]" -type "matrix" "xform" 1 1 1 -12.566370614359172 -1.6564237503326203e-16
		 12.566370614359172 0 -2.2191402248840006 -8.5126716149447432 -0.0060345197239753869 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5210154231410371 -0.5083398673784898 -0.48865441014361111 0.48098895572558131 1
		 1 1 no;
	setAttr ".xm[180]" -type "matrix" "xform" 1 1 1 -9.1962028270220486e-16 -8.2704296969910748e-17
		 12.566370614359171 0 -2.2029321890367441 -8.492528786055118 0.17440806533623612 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.54433759463077147 -0.51461878119465521 -0.46684606036008436 0.47002005174203154 1
		 1 1 no;
	setAttr ".xm[181]" -type "matrix" "xform" 1 1 1 12.566370614359171 7.4891265064436157e-17
		 12.566370614359172 0 -2.1742514249500005 -8.4657100176875062 0.36412567824223924 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.56032790469742466 -0.51575488393289992 -0.45054357494389541 0.4658755477523252 1
		 1 1 no;
	setAttr ".xm[182]" -type "matrix" "xform" 1 1 1 1.1830814106161824e-15 1.7227972520794604e-16
		 12.566370614359174 0 -2.1150330315333292 -8.3790821265202631 0.61877412209008509 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61004457916828103 -0.54665012594444418 -0.39321499765955675 0.41761371726502594 1
		 1 1 no;
	setAttr ".xm[183]" -type "matrix" "xform" 1 1 1 12.566370614359171 2.0860049798621125e-16
		 12.566370614359172 0 -2.0402234834052706 -8.2020127510352054 0.89283242467045199 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66698718996922646 -0.57520477368749168 -0.31803110203459156 0.35088997546629919 1
		 1 1 no;
	setAttr ".xm[184]" -type "matrix" "xform" 0.99999999999999989 1 1 -2.4980018054066022e-16
		 3.6255720647915268e-16 12.566370614359172 0 -1.9750538808291935 -8.0459548058728814
		 1.1302538249888108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69238144193930851 -0.54530726917128136 -0.30141139418492574 0.36386686095672788 1
		 1 1 no;
	setAttr ".xm[185]" -type "matrix" "xform" 0.99999999999999989 1 1 12.566370614359172
		 -2.4806545706468351e-16 12.566370614359172 0 -1.9381093551659774 -7.9409834837403457
		 1.2947041851289773 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67938517528829057 -0.55625717616120429 -0.31220952710024397 0.36268298658126158 1
		 1 1 no;
	setAttr ".xm[186]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999989 -3.8857805861880469e-16
		 -8.2833045977892613e-17 12.566370614359172 0 -1.9125580899236638 -7.8708159193851843
		 1.4337036903747025 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65360021304210603 -0.54753986080091888 -0.34531267642342445 0.39213010321411845 1
		 1 1 no;
	setAttr ".xm[187]" -type "matrix" "xform" 0.99999999999999967 1 0.99999999999999978 12.566370614359172
		 1.2945373939476918e-16 12.566370614359172 0 -1.8938496260620354 -7.8449955301582817
		 1.5343610860101882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61337145460518805 -0.51201886772879657 -0.39662870375810466 0.45199315162998033 1
		 1 1 no;
	setAttr ".xm[188]" -type "matrix" "xform" 0.99999999999999933 1 0.99999999999999978 2.7755575615628918e-16
		 3.8518598887744733e-32 -2.7755575615628918e-16 0 -1.8825353128066524 -7.8514155990705268
		 1.5584382854203354 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[189]" -type "matrix" "xform" 1 1 1 -4.4354204941136489e-16 -1.6431944693806747e-10
		 -6.6597161674231131e-09 0 -1.8825256038787472 -7.8514162718883158 -1.558421627436785 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612976018935651 0.49379419236729649 -0.50612817754426698 0.49379573644444624 1
		 1 1 no;
	setAttr ".xm[190]" -type "matrix" "xform" 1 1 1 6.2831853043861097 -3.1685629667824836e-09
		 6.2831853077357485 0 -1.8675766147055697 -7.8926128892540381 -1.5291612942300026 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64305812804792051 0.19111865506375916 -0.67699473568429369 0.30270122479745171 1
		 1 1 no;
	setAttr ".xm[191]" -type "matrix" "xform" 1 1 1 6.2831853057768798 -1.9450387124955158e-09
		 6.2831853085042191 0 -1.8665142437048132 -7.9639889621071527 -1.4469206940003723 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65557417648337579 0.011913804084112078 -0.65207995547049813 0.38062092963207134 1
		 1 1 no;
	setAttr ".xm[192]" -type "matrix" "xform" 1 1 1 6.2831853065749534 -1.1028419841032536e-09
		 6.2831853081667592 0 -1.8407136884509612 -8.0812925426506368 -1.321099832351605 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66143441675356773 -0.085189985898714626 -0.63826999606174195 0.38452384940831497 1
		 1 1 no;
	setAttr ".xm[193]" -type "matrix" "xform" 1 1 1 6.283185307083853 -5.3285271331980662e-10
		 6.2831853076414319 0 -1.7962104843565214 -8.2478767133366233 -1.1312591025739318 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65636076819940237 -0.19668151839946188 -0.6660229843433092 0.29482250018477996 1
		 1 1 no;
	setAttr ".xm[194]" -type "matrix" "xform" 1 1 1 6.2831853071794921 -1.4701712069963894e-12
		 6.2831853071806592 0 -1.7428545598614278 -8.454043694267849 -0.85216878537911978 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6887583188119174 -0.1937555132678557 -0.65499673991219631 0.24300216058727891 1
		 1 1 no;
	setAttr ".xm[195]" -type "matrix" "xform" 1 1 1 6.2831853071796466 -1.3754735198046403e-12
		 1.1927507592712356e-12 0 -1.7177228070475223 -8.6485379619927407 -0.54517255800719666 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67791117584788774 0.25397256167209059 0.64651697239396388 -0.24072843617818168 1
		 1 1 no;
	setAttr ".xm[196]" -type "matrix" "xform" 1 1 1 6.2831853071796742 -1.3304669865821784e-12
		 1.2418364947474585e-12 0 -1.7095304714105737 -8.7439447768268934 -0.33261841471678033 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.66584691905237059 0.27429577238237313 0.649420098353787 -0.24426060979163394 1
		 1 1 no;
	setAttr ".xm[197]" -type "matrix" "xform" 1 1 1 6.2831853071795871 -1.3078626723284087e-12
		 6.2831853071808563 0 -1.7194483528268449 -8.7895647512090065 -0.16174460007928099 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66165950988240652 -0.26336086847177403 -0.64876398882268638 0.26824062471378862 1
		 1 1 no;
	setAttr ".xm[198]" -type "matrix" "xform" 1 1 1 6.2831853071796537 -1.3694982647916425e-12
		 6.283185307180787 0 -1.7329321149119608 -8.8201061450118772 -0.0042007890812100577 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.69246881376264713 -0.25147600152334765 -0.62946276891640662 0.24702911806520322 1
		 1 1 no;
	setAttr ".xm[199]" -type "matrix" "xform" 1 1 1 6.2831853071795862 -1.3071332211067599e-12
		 -6.2831853071783161 0 -1.7194493365969663 -8.7895646830348433 0.15407540843549086 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64876198427345444 -0.26824158877185539 -0.6616614725041462 0.26335989371649915 1
		 1 1 no;
	setAttr ".xm[200]" -type "matrix" "xform" 1 1 1 6.2831853071794983 -1.3306985721661121e-12
		 1.2421157852272079e-12 0 -1.709532525858549 -8.743944634455957 0.32692161265999414 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64941808409672175 -0.24426160641853964 -0.66584888980715995 0.27429486984001406 1
		 1 1 no;
	setAttr ".xm[201]" -type "matrix" "xform" 1 1 1 6.2831853071795258 -1.3763842496294563e-12
		 1.1932503596323999e-12 0 -1.7177262186002622 -8.6485386805902777 0.54248745661699793 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6465149150270163 -0.24072937500204919 -0.67791313727458669 0.25397167355683603 1
		 1 1 no;
	setAttr ".xm[202]" -type "matrix" "xform" 1 1 1 6.2831853071796804 -1.4704626405404545e-12
		 -6.2831853071785142 0 -1.7428598916070257 -8.454044279798179 0.85193128699658638 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6549946359894947 0.24300291381025024 0.68876030629496843 -0.19375461588612264 1
		 1 1 no;
	setAttr ".xm[203]" -type "matrix" "xform" 1 1 1 6.2831853072753194 -5.3285290765304997e-10
		 -6.2831853067177406 0 -1.7962175321030998 -8.2478762249357089 1.1312809994200437 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6660209816770758 0.2948232564432568 0.65636277833530976 -0.1966804582109038 1
		 1 1 no;
	setAttr ".xm[204]" -type "matrix" "xform" 1 1 1 6.283185307784219 -1.1028424565449165e-09
		 -6.2831853061924132 0 -1.840721918889443 -8.0812919722905043 1.3211201879297041 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.63826796220002224 0.3845242453439251 0.66143631918145218 -0.085188666144083325 1
		 1 1 no;
	setAttr ".xm[205]" -type "matrix" "xform" 1 1 1 6.2831853085822935 -1.9450384645534075e-09
		 -6.2831853058549534 0 -1.8665232579947997 -7.9639883374269909 1.4469394076853499 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65207791250723812 0.38062100966311407 0.65557613864712228 0.011915093779042596 1
		 1 1 no;
	setAttr ".xm[206]" -type "matrix" "xform" 1 1 1 6.2831853099730637 -3.1685618581130845e-09
		 -6.283185306623424 0 -1.8675861413458961 -7.8926122290685745 1.5291787783869248 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.67699271253233562 0.30270071874162335 0.64306018574324142 0.19111969956883793 1
		 1 1 no;
	setAttr ".xm[207]" -type "matrix" "xform" 1 1 1 2.7780763396607956e-16 -1.1148759693213544e-10
		 -4.5184902486283818e-09 0 -1.8825353128066524 -7.8514155990705268 1.5584382854203351 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975964732398 0.49379419289612164 -0.50612817808630073 0.49379573591562304 1
		 1 1 no;
	setAttr ".xm[208]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[209]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[210]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[211]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[212]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[213]" -type "matrix" "xform" 1 1 1 -7.9982792244955534e-07 -2.6897107075777592e-07
		 5.2015762611699531e-08 0 -8.3179983442870338 -0.23421221301943973 -3.6902483877089693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.027401009458430881 0.68285929581411187 -0.72965333882255312 -0.023629895175704567 1
		 1 1 no;
	setAttr ".xm[214]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[215]" -type "matrix" "xform" 1 1 1 1.6766494859155046e-09 1.3251953088681999e-24
		 1.5364583403813301e-25 0 15.276314141915023 -0.66666510324098738 -0.23259512495407542 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[216]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[217]" -type "matrix" "xform" 1 1 1 -3.7358078137980887e-08 -3.9231474221458578e-07
		 1.7747221797652936e-07 0 2.2701034659063684 -0.16849257165543818 -2.3451506203393282 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090864042157167091 -0.73673233087998069 0.66365248834412305 -0.092382753767491999 1
		 1 1 no;
	setAttr ".xm[218]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[219]" -type "matrix" "xform" 1 1 1 -8.7351898515775978e-08 3.0968112931036184e-07
		 -3.3786357366272247e-07 0 9.5350861259021258 -0.049088606305730309 6.6024945510889665e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.0043095761169174955 0.008122547781402643 -0.16242313102416744 0.98667835604088205 1
		 1 1 no;
	setAttr ".xm[220]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[221]" -type "matrix" "xform" 1 1 1 -6.5765615175905623e-11 -1.9968099496797911e-26
		 1.1619618915634355e-27 0 4.986384254736592 -0.34375709355330741 1.2434497875801753e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -3.9514086989413111e-19 0.0014376218797037942 0.0021873772694690386 0.9999965743061382 1
		 1 1 yes;
	setAttr ".xm[222]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[223]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[224]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[225]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[226]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[227]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[228]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[229]" -type "matrix" "xform" 1 1 1 5.4160604879362514e-07 2.009185912428714e-07
		 4.758449157641748e-08 0 8.3179977339076459 -0.23422280895807646 3.6902475259176484 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.72965333882255323 0.023629895175704421 -0.027401009458430898 0.68285929581411176 1
		 1 1 no;
	setAttr ".xm[230]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[231]" -type "matrix" "xform" 1 1 1 6.3765392965819956e-10 5.0399084806560511e-25
		 5.8433721677698674e-26 0 15.276314141915009 -0.66666510324100159 -0.23259512495407719 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.017135761537968502 0 0.99985317205903479 1
		 1 1 yes;
	setAttr ".xm[232]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[233]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[234]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[235]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977792049079767 -5.1625618604184824
		 -3.0255378400541941 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50010523644630966 0.49989474205212669 -0.5001036748994 0.49989630294665471 1
		 1 1 no;
	setAttr ".xm[236]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.44894278226615913
		 -0.18401212650169896 2.1363091819890183 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841859969194742 0.090512344640451117 0.021125460962961716 0.99342508329649548 1
		 1 1 yes;
	setAttr ".xm[237]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[238]" -type "matrix" "xform" 1 1 1 0.23360810753218131 -0.40234061126456877
		 -0.43485044274246787 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.40087774203409404 -0.45290564647529907 -0.61013986385495111 0.51176445545533888 1
		 1 1 yes;
	setAttr ".xm[239]" -type "matrix" "xform" 0.66197264440161574 1.1021921299515944
		 1 0 0 0 0 0.044855766375306416 2.5245096710397874 0.15444283002983639 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.4862617343533791 0.48494166130101091 0.53021325555582166 0.49724743787289283 1
		 1 1 yes;
	setAttr ".xm[240]" -type "matrix" "xform" 1 1 1 -0.058003319898012974 0.72383020551935373
		 -0.079669027797594522 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47751416514246486 -0.38421895523508581 -0.54200896931834797 0.57496286289187049 1
		 1 1 yes;
	setAttr ".xm[241]" -type "matrix" "xform" 0.6785375197975797 0.95799864639124532
		 1 0 0 0 0 0.059214626181272934 2.5389169532675822 0.15533543079980916 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49557169816285929 0.47655439569781033 0.51760793659052884 0.50930013145449882 1
		 1 1 yes;
	setAttr ".xm[242]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8977603558034843 -5.1625605538767454
		 3.0255955792552052 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.49989630294665394 0.50010367489940077 0.49989474205212592 0.50010523644631044 1
		 1 1 no;
	setAttr ".xm[243]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.44894370729995314
		 0.18401211987492161 -2.1363089881648811 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.066841864099626877 0.090512559469702922 0.021125451262397732 0.99342506365145145 1
		 1 1 yes;
	setAttr ".xm[244]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 -1.7763568394002505e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[245]" -type "matrix" "xform" 1 1 1 0.53200126771743783 0.0029727848858548088
		 0.010025488126381595 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.064989343048516224 -0.67638815196858926 -0.042556096839040547 0.73243732277135143 1
		 1 1 yes;
	setAttr ".xm[246]" -type "matrix" "xform" 1.1975992053004352 0.79913879068876204
		 1 0 0 0 0 -2.462140594008428 -0.00029764573881152501 6.2316871662915219e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.70788413856216958 0.0067958157402144836 -0.70565959166388148 0.029973387417574993 1
		 1 1 yes;
	setAttr ".xm[247]" -type "matrix" "xform" 1 1 1 -0.73566333107297788 -0.0022688543119592911
		 0.0043549249991153656 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10800905939387451 -0.52060676801724259 -0.12772602498256161 0.83725067854594493 1
		 1 1 yes;
	setAttr ".xm[248]" -type "matrix" "xform" 1.24781063655325 0.69061940645158038 1 0
		 0 0 0 -2.5739657448699802 4.8678124286993807e-05 1.5174167629083968e-06 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.70482462364600029 -0.029045690597641061 0.70875472608900425 -0.0067332018001021732 1
		 1 1 yes;
	setAttr ".xm[249]" -type "matrix" "xform" 1 1 1 2.2260632721892816e-07 0.018838865332075082
		 9.9413410438024742e-08 0 1.5056762133197878 7.5070726841770457 1.5419261387338663e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15951152046933148 -0.68888073166472075 0.68888038349887182 0.15950934019388496 1
		 1 1 no;
	setAttr ".xm[250]" -type "matrix" "xform" 1 1 1 -2.2151420150933658e-07 2.4661162094690787e-09
		 -9.8557642670254815e-08 0 10.563390829596955 -4.2760357700424162e-15 -0.046552117208733534 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0.015251496810226965 0 0.99988368915841785 1
		 1 1 yes;
	setAttr ".xm[251]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 9.4827687854422891
		 3.7321796315329531e-15 -2.3385609893011861e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.012722857859538445 0 0.9999190611683958 1 1 1 yes;
	setAttr ".xm[252]" -type "matrix" "xform" 1 1 1 0 2.4661162278949433e-09 0 0 10.536384444209347
		 -2.2139260131388231e-15 0.035821534330523264 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.02346357552664715 0 0.99972469241461936 1 1 1 yes;
	setAttr ".xm[253]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 8.2070163083248673
		 1.8807214628973473e-15 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.00096055918587931069 0 0.9999995386629188 1 1 1 yes;
	setAttr ".xm[254]" -type "matrix" "xform" 1 1 1 0 2.4661161294493861e-09 0 0 7.4884325296770413
		 1.7562207486616476e-15 0.021189175427991813 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.0088147932995396357 0 0.99996114895484134 1 1 1 yes;
	setAttr ".xm[255]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 4.5543586581220552
		 1.0647115208527094e-15 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.017460398155145457 0 0.9998475556284887 1 1 1 yes;
	setAttr ".xm[256]" -type "matrix" "xform" 1 1 1 0 2.4661163805506092e-09 0 0 8.1939419076200011
		 4.4656352014393452e-15 -2.020721012740978e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.049673452335513124 0 0.99876551208633124 1 1 1 yes;
	setAttr ".xm[257]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.5673177093418502 -5.6921998704852754e-08
		 -2.3594068920829159e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[258]" -type "matrix" "xform" 1 1 1 0 0 0 0 12.482656650018825 -7.426718696140574e-08
		 -3.0783681381763017e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[259]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[260]" -type "matrix" "xform" 1 1 1 3.8944537725842122e-15 9.0138253250326943e-08
		 6.5471963239805116e-08 0 4.2530390196097017 10.77130977070858 5.5192402113899419 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.3782104709457097 -0.37821047094570959 0.59745865101028073 0.59745865101028095 1
		 1 1 yes;
	setAttr ".xm[261]" -type "matrix" "xform" 1 1 1 -6.6467294437285689e-17 -6.8039369138794825e-09
		 3.2205305089405556e-09 0 4.2528131677824774 -10.771300081889816 5.5191355833121776 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59745865101028095 0.59745865101028073 0.37821047094570959 0.3782104709457097 1
		 1 1 yes;
	setAttr ".xm[262]" -type "matrix" "xform" 1 1 1 0.45147067833840204 -3.0694132441347363e-08
		 -7.275961944337105e-08 0 11.559844746539198 -10.610553688903337 -0.064109199610069695 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41448053453211336 0.51498461377259264 -0.59595391917958995 0.45588996510775948 1
		 1 1 no;
	setAttr ".xm[263]" -type "matrix" "xform" 1 1 1 0.7750111904053576 -0.21789524103559429
		 -0.23887808228062216 0 3.710114163503313 -1.1368683772161603e-13 3.5527136788005009e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16334516138569405 0.27854149049191035 -0.27089239992649744 0.90683532352268281 1
		 1 1 yes;
	setAttr ".xm[264]" -type "matrix" "xform" 1 1 1 0.12538130224185476 -0.059683413925607449
		 -0.3571596861617784 0 4.0725563230532487 8.5265128291212022e-14 -1.2789769243681803e-13 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18051798240081326 0.17788544273638804 0.027008285055259748 0.96697496339398192 1
		 1 1 yes;
	setAttr ".xm[265]" -type "matrix" "xform" 1 1 1 0.14248795753079574 0.23026417415148623
		 -0.080345506665518374 0 4.0006109334847366 -2.1316282072803006e-14 2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020971424288593093 -0.027413947918390729 0.11149405566238443 0.99316552012984671 1
		 1 1 yes;
	setAttr ".xm[266]" -type "matrix" "xform" 1 1 1 -0.097362896099633209 0.38168489929344435
		 0.14514040658241065 0 4.0603935283487544 -7.1054273576010019e-15 4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.071389841504829202 -0.14883679234685407 0.092570372479719693 0.98192760726683959 1
		 1 1 yes;
	setAttr ".xm[267]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[268]" -type "matrix" "xform" 1 1 1 0.50350514714478545 4.1006020464770464e-09
		 -4.5991031285753878e-09 0 12.566899404695164 -9.6150313351416621 0.071513720417332782 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54332247225669583 0.40457064582709801 -0.45375334041170345 0.57899152821188804 1
		 1 1 no;
	setAttr ".xm[269]" -type "matrix" "xform" 1 1 1 0.56908407903183811 -0.38500868437795283
		 -0.18640777234602562 0 3.4644126223781484 -2.0810261958104093e-08 -4.7554351567669073e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.044405792528022334 0.23820893735320914 -0.42228386868031159 0.87347636602681034 1
		 1 1 yes;
	setAttr ".xm[270]" -type "matrix" "xform" 1 1 1 0.39338315205201096 -0.18573442225732267
		 -0.27401196531058752 0 4.3037392478274086 4.2632564145606011e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17400122083625127 0.19635169321082077 -0.087211217863158774 0.96102226363365917 1
		 1 1 yes;
	setAttr ".xm[271]" -type "matrix" "xform" 1 1 1 -0.030987593584643962 0.015876666981339729
		 -0.13141720737013338 0 4.181807622551176 -7.1054273576010019e-15 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.050839916640124189 0.051504431728612514 0.036612817149271802 0.99670562254295114 1
		 1 1 yes;
	setAttr ".xm[272]" -type "matrix" "xform" 1 1 1 0.12036348611889762 0.16073074494383702
		 -0.054912447136772631 0 4.2405858650267163 2.8421709430404007e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.013845469812409465 -0.017827603972404502 0.081747532548058319 0.99639742092429218 1
		 1 1 yes;
	setAttr ".xm[273]" -type "matrix" "xform" 1 1 1 -0.27422613628046527 0.2670227663113845
		 -0.043179333783084875 0 4.2246017292904412 -3.5527136788005009e-14 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.026620080080550244 -0.052681510888382001 0.11017046964238202 0.99215850415435092 1
		 1 1 yes;
	setAttr ".xm[274]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[275]" -type "matrix" "xform" 1 1 1 0.28180597477669983 1.6638588366529264e-08
		 7.4364846238523222e-08 0 14.043917314267674 -8.3515692259221659 0.15407804390279989 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62938079819301485 0.46599988082158245 -0.38226311049846218 0.49050875251338294 1
		 1 1 no;
	setAttr ".xm[276]" -type "matrix" "xform" 1 1 1 0.16657712992334422 -0.18663500741767519
		 0.010533570859111338 0 3.6589284731835434 -1.6929959656408755e-08 -5.8478001108142053e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0015731991924447363 0.017124862808462073 -0.35508761471425648 0.93467483650445626 1
		 1 1 yes;
	setAttr ".xm[277]" -type "matrix" "xform" 1 1 1 0.375882884846373 -0.10434518109949192
		 -0.097616190672198705 0 4.0030741049005769 -8.5265128291212022e-14 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094743762826098421 0.14225531451370066 -0.13053594339965241 0.97659992442090782 1
		 1 1 yes;
	setAttr ".xm[278]" -type "matrix" "xform" 1 1 1 0.036754376770198251 0.063024627285098209
		 -0.13767769969643656 0 4.0831724074700873 -2.8421709430404007e-14 2.8421709430404007e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.061230068711689851 0.080745357838719653 0.071197012427159964 0.99230139135975504 1
		 1 1 yes;
	setAttr ".xm[279]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[280]" -type "matrix" "xform" 1 1 1 0.1664074764349939 -2.9141556668122256e-09
		 3.421383202683414e-08 0 14.951931269453581 -7.5211136838236436 -0.087329301588584415 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6320347144562688 0.52782869945912025 -0.37432424431774103 0.42639224179788793 1
		 1 1 no;
	setAttr ".xm[281]" -type "matrix" "xform" 1 1 1 0.17040092240406829 -0.11050539964674586
		 -0.0049174716551962294 0 4.0750092727693534 1.967038087968831e-09 1.171116892351165e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0073815378305819076 0.035025908130299058 -0.3541431012040927 0.93450594568919199 1
		 1 1 yes;
	setAttr ".xm[282]" -type "matrix" "xform" 1 1 1 0.36997183039461146 -0.10990467620587775
		 -0.081587009718689901 0 4.2876320313596068 -5.6843418860808015e-14 7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13613405303142886 0.14053384536649907 -0.1943974599906845 0.9612114155901974 1
		 1 1 yes;
	setAttr ".xm[283]" -type "matrix" "xform" 1 1 1 0.4143833470440455 -0.02955823715551428
		 -0.14436653328433313 0 4.1413681691741431 0 7.1054273576010019e-15 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17831145707108373 0.11992841067894842 -0.0094390494990498446 0.9765925992622323 1
		 1 1 yes;
	setAttr ".xm[284]" -type "matrix" "xform" 1 1 1 0.32802497756303522 0.23231687115775795
		 -0.19975834173395818 0 4.3499426101530219 7.1054273576010019e-15 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.043429001529634449 0.039314051682630254 0.15242651384174591 0.98657715615378339 1
		 1 1 yes;
	setAttr ".xm[285]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[286]" -type "matrix" "xform" 1 1 1 3.5996839562301617e-08 -6.3073126694564231e-09
		 1.8355733985840653e-08 0 11.13450705315293 -10.370759311270046 0.33848942153285977 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084844947099925044 -0.27041773600217633 -0.92181779653480711 0.26443814588440379 1
		 1 1 no;
	setAttr ".xm[287]" -type "matrix" "xform" 1 1 1 2.7686504091597737 0.017278520765435353
		 0.037843225583184675 0 2.6008897420573476 4.7741153252900403e-08 1.6404651859147634e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.93000072000406364 -0.363977974682195 -0.010685059690918201 0.050045221925496215 1
		 1 1 yes;
	setAttr ".xm[288]" -type "matrix" "xform" 1 1 1 -0.13858841596375779 0.24467850433967553
		 -0.7266573557982885 0 2.6511928129189641 3.5527136788005009e-14 -1.0658141036401503e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.063571288267562018 -0.023906635276354345 0.19527786790137486 0.97839343742977924 1
		 1 1 yes;
	setAttr ".xm[289]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[290]" -type "matrix" "xform" 1 1 1 -0.27606462167449519 -3.1858226335938633e-08
		 -9.9184254602802609e-08 0 10.470345513282581 -9.0848465124632973 0.097967074647777555 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23662118052248096 -0.20574559852158006 -0.64054804476594396 0.700983143851313 1
		 1 1 no;
	setAttr ".xm[291]" -type "matrix" "xform" 1 1 1 -0.99365940053776181 0.15394967857761332
		 -0.22640150308056317 0 2.1274797555267178 8.5265128291212022e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22328030716644459 -0.41420835725404437 -0.50483542982748153 0.72368399872006706 1
		 1 1 yes;
	setAttr ".xm[292]" -type "matrix" "xform" 1 1 1 -1.7127515388839774 -0.20224384528717648
		 -0.57917206034646818 0 2.6394080736763499 -7.815970093361102e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.7017785729713647 -0.32534900068867412 -0.021023075432680283 0.63341368201871673 1
		 1 1 yes;
	setAttr ".xm[293]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[294]" -type "matrix" "xform" 1 1 1 -0.58871132130422521 -2.902190415350382e-08
		 1.3813381944315262e-08 0 11.659360585550274 -10.690352657914914 0.51157115252927832 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.37693942322479668 0.61413663147404751 0.59970049279673476 -0.34801176422647118 1
		 1 1 no;
	setAttr ".xm[295]" -type "matrix" "xform" 1 1 1 -0.64116319438986236 0.23478917672635735
		 -0.28663701278127085 0 4.2885967811930641 4.9267299573330092e-08 3.2895343338168459e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.22660364973293748 -0.25319576300284674 -0.2194805848851025 0.91453319479590889 1
		 1 1 yes;
	setAttr ".xm[296]" -type "matrix" "xform" 1 1 1 -0.24702108125275421 0.061810932937138387
		 -0.11375023769757539 0 4.5340884300743483 -3.5527136788005009e-14 1.4210854715202004e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092516220210340089 -0.063472909040306072 -0.003884960665585923 0.99367844189988319 1
		 1 1 yes;
	setAttr ".xm[297]" -type "matrix" "xform" 1 1 1 0.24913418041829566 -0.33161626926996085
		 -0.043267425329907419 0 4.532349631042166 0 7.1054273576010019e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090439092198492763 0.078146807396151444 0.11412592256858679 0.98625002960404018 1
		 1 1 yes;
	setAttr ".xm[298]" -type "matrix" "xform" 1 1 1 0.14067995876799974 -0.42436195409338978
		 -0.11600463946360258 0 4.5179710886268225 -5.6843418860808015e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.032243738609480932 0.056325887812229164 0.22075158847536744 0.97316826493071051 1
		 1 1 yes;
	setAttr ".xm[299]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[300]" -type "matrix" "xform" 1 1 1 -0.48711264523091796 8.2840213201580938e-09
		 1.4324810048774101e-08 0 13.118840755789563 -10.023280050816982 0.24307552472855182 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47657025244159062 0.53983229596189353 0.5313438850621367 -0.44624607844926117 1
		 1 1 no;
	setAttr ".xm[301]" -type "matrix" "xform" 1 1 1 -0.25707445750961794 0.2967392312547813
		 -0.095466686122511163 0 4.257614263557322 7.0404837515525287e-08 -2.6201405489700846e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.070336992054541109 -0.13802067634345827 -0.31294420027560338 0.93705332183621048 1
		 1 1 yes;
	setAttr ".xm[302]" -type "matrix" "xform" 1 1 1 -0.82064730014139953 0.11277654776761636
		 -0.30591420501499944 0 4.4831290673189699 8.5265128291212022e-14 6.3948846218409017e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.33149761930554317 -0.24949646258216235 -0.11973951164966329 0.90195526103218948 1
		 1 1 yes;
	setAttr ".xm[303]" -type "matrix" "xform" 1 1 1 -0.29432373049685984 -0.16711771924131327
		 -0.22982205716715076 0 4.3959831042410258 7.1054273576010019e-15 -4.2632564145606011e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.052409745972236597 -0.037599698140709265 0.10867617125244583 0.99198234411140718 1
		 1 1 yes;
	setAttr ".xm[304]" -type "matrix" "xform" 1 1 1 0.019545786695121536 -0.43310121593267642
		 -0.14272019861866786 0 4.5214945161723819 1.0658141036401503e-14 7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.070891049651653909 0.083402588927564081 0.13365389970052929 0.98496451831236409 1
		 1 1 yes;
	setAttr ".xm[305]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[306]" -type "matrix" "xform" 1 1 1 -0.28955678051547729 -2.0562057726203384e-08
		 -1.1117330575951324e-08 0 14.07102776478655 -9.0881921846450808 0.4700482760667028 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52039384466942717 0.59301541921989354 0.47167965981558169 -0.3937527873093512 1
		 1 1 no;
	setAttr ".xm[307]" -type "matrix" "xform" 1 1 1 -0.52623215293941006 0.15241378971787767
		 -0.10414478433141151 0 5.4393351738680877 -8.9888089860323817e-08 8.9921819323990348e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.092181342153629914 -0.19388876786037579 -0.27822862241370622 0.93621502846627713 1
		 1 1 yes;
	setAttr ".xm[308]" -type "matrix" "xform" 1 1 1 -0.67210954826355418 -0.047449864254822678
		 -0.25544739709196784 0 5.7224209536090029 2.8421709430404007e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.12971758998090704 -0.16717093037661793 0.071055743230454549 0.9747709003866134 1
		 1 1 yes;
	setAttr ".xm[309]" -type "matrix" "xform" 1 1 1 0.01134805204773333 -0.21486546896777364
		 -0.17319448231217699 0 5.6743041256576703 -3.5527136788005009e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.012271928225658608 0.025466011624172884 0.13759018857390604 0.99008576499098244 1
		 1 1 yes;
	setAttr ".xm[310]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[311]" -type "matrix" "xform" 1 1 1 -0.40909294887190145 -8.1833122077012283e-08
		 -2.8849972743301528e-08 0 14.76624914810327 -8.1360405532038698 0.49815024985889211 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.5155648583716258 0.59500971570831662 0.47579428496428899 -0.39214297573751666 1
		 1 1 no;
	setAttr ".xm[312]" -type "matrix" "xform" 1 1 1 -0.34249673052058849 0.25207708765604525
		 -0.099849212848047847 0 5.2768869299535517 -1.1368683772161603e-13 2.1316282072803006e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.08200328237693888 -0.14985466411081202 -0.32227306981757614 0.93110639015850361 1
		 1 1 yes;
	setAttr ".xm[313]" -type "matrix" "xform" 1 1 1 -0.59918926148009211 0.1167435112365946
		 -0.14972446037539391 0 5.2858940783937811 -2.8421709430404007e-14 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.170454007603353 -0.13147989968328083 -0.077896840354802044 0.97344262775675139 1
		 1 1 yes;
	setAttr ".xm[314]" -type "matrix" "xform" 1 1 1 -0.2188257822137534 -0.1655517318743111
		 -0.29662490696246918 0 5.475489722544495 -4.2632564145606011e-14 -7.1054273576010019e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.095565669962619129 -0.081410754277070119 0.12704581802047121 0.98392014510129 1
		 1 1 yes;
	setAttr ".xm[315]" -type "matrix" "xform" 1 1 1 0.014493922294741664 -0.20446607764127964
		 -0.47010882376847773 0 5.3259893014724327 6.3948846218409017e-14 -5.6843418860808015e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.065953319468648811 -0.10417388950270078 0.17022863969017771 0.97766056002386492 1
		 1 1 yes;
	setAttr ".xm[316]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[317]" -type "matrix" "xform" 1 1 1 -4.0579464155426279e-09 4.8375343939506078e-09
		 3.7644982343775473e-08 0 17.043317186369848 -2.0220670344563585 -0.32638396616415061 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.76030032532266922 0.39209918154902723 -0.24865310820127207 0.45428325846840611 1
		 1 1 no;
	setAttr ".xm[318]" -type "matrix" "xform" 1 1 1 0.2517434142673603 -0.14546472763342799
		 -0.036064088893669174 0 2.4893927647862455 -2.8421709430404007e-14 -1.2042514541121818e-08 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.03716156970224125 0.10937765032783689 -0.26142534589096245 0.9582861450901905 1
		 1 1 yes;
	setAttr ".xm[319]" -type "matrix" "xform" 1 1 1 -0.17384261872883722 -0.092660793704895619
		 -0.010921304248149815 0 2.4527219098537723 -8.5265128291212022e-14 4.9737991503207013e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0010591050938175248 0.033899055776556754 -0.092242225906682324 0.99515883359071822 1
		 1 1 yes;
	setAttr ".xm[320]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[321]" -type "matrix" "xform" 1 1 1 1.4055002272305548 -9.464370312269691e-09
		 -2.3201453279105333e-08 0 7.0454953501284479 -5.7686102140994953 -7.4789343609185917 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.32385315277634991 -0.9325115233988962 0.15221832518446413 -0.048692665188142616 1
		 1 1 no;
	setAttr ".xm[322]" -type "matrix" "xform" 1 1 1 0.30975139813597324 -0.04984133635443385
		 0.1734208267267284 0 3.8994339199381614 3.6402660441581247e-08 6.0726108586095506e-09 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.054117112836187677 -0.035741148526551171 -0.060007380793525196 0.99608886282830156 1
		 1 1 yes;
	setAttr ".xm[323]" -type "matrix" "xform" 1 1 1 -1.6200961847375286 0.31271944462391843
		 0.30282210206782706 0 3.8753796785145767 -1.3988810110276972e-14 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.26349488639961138 -0.13794692836691611 -0.039341044346965441 0.95393572740781596 1
		 1 1 yes;
	setAttr ".xm[324]" -type "matrix" "xform" 1 1 1 -0.53567510940198404 0.61880633472049906
		 0.039540374506785526 0 3.8738202249231222 1.4210854715202004e-14 -1.5987211554602254e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.30117490267905089 -0.21960656083056396 0.17430017250304658 0.91141981890994894 1
		 1 1 yes;
	setAttr ".xm[325]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[326]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.436168815274073 -9.2821712339051707
		 -0.086203643238799726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.5370102245311007 -0.55464071945418225 0.46740594424565796 -0.43072656564951844 1
		 1 1 no;
	setAttr ".xm[327]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.6842749127368801 0
		 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.098149669675103565 0.21336511951404907 -0.35528274181868902 0.90477408311866347 1
		 1 1 yes;
	setAttr ".xm[328]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.0861246946358989 -1.4210854715202004e-14
		 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.15539376894301871 0.14386981915757893 -0.018142993932345093 0.97715151510930998 1
		 1 1 yes;
	setAttr ".xm[329]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.3542138218270452 1.4210854715202004e-14
		 -1.7763568394002505e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.042345277449608434 0.047665405785576626 0.11559435084104877 0.99124811859728057 1
		 1 1 yes;
	setAttr ".xm[330]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[331]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.95422099999999999
		 -0.74553599999999998 1.2150244631780774e-07 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[332]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.5853841945645684e-05
		 -2.8217865983027934 1.5924359185037464 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.35118023178006774 -0.35118036430445482 0.61373646201463816 0.61373638618517878 1
		 1 1 yes;
	setAttr ".xm[333]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0333029283221293 1.1471967024359046e-16
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.1167210741668856 0 0.99316473499884617 1
		 1 1 yes;
	setAttr ".xm[334]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0134628592404766 -3.119115312198587e-17
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.15232175999380265 0 0.98833095743905053 1
		 1 1 yes;
	setAttr ".xm[335]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92213062093366904
		 1.3035083173738419e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.070148210841866954 0 0.99753658003889012 1
		 1 1 yes;
	setAttr ".xm[336]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.94821701958468196
		 2.0002410538131297e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -0.039329575009993872 0 0.99922629295346965 1
		 1 1 yes;
	setAttr ".xm[337]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.76201279828010726
		 1.8913872956232023e-16 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 -0.031340980280144204 0 0.99950875081465873 1 1 1 yes;
	setAttr ".xm[338]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.6279771799057059 1.7383309535097934e-16
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[339]" -type "matrix" "xform" 1 1 1 5.4904916386097485e-16 2.162977167374795e-07
		 1.2772412461004159e-08 0 -1.737517085917375 -8.8275211160129885 1.2305494212866918e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[340]" -type "matrix" "xform" 1.0000000000000007 1.0000000000000011 1.0000000000000002 -1.1102229047307621e-16
		 2.1598257482491371e-07 -1.6653342372017294e-16 0 -2.2147732164010279 -8.523143920105273
		 1.2575274408751927e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[341]" -type "matrix" "xform" 1 1 1 -7.7040041016390239e-12 -5.0861370670626822e-11
		 1.224376156036707e-11 0 -1.8825256038787188 -7.8514162719707299 -1.5584216272912981 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72330838765809879 -0.56220012029869171 0.33328766480031136 -0.22287963920361428 1
		 1 1 no;
	setAttr ".xm[342]" -type "matrix" "xform" 1 1 1 -8.7136201032385965e-13 3.1941463363200889e-13
		 9.1674064173194422e-13 0 -5.3290705182007514e-15 5.6843418860808015e-14 -7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[343]" -type "matrix" "xform" 1 1 1 1.1595381773573089e-07 4.1220840345224184e-07
		 -6.1034828939914254e-08 0 -1.882539826420242 -7.8514152794665693 1.5584393116040054 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52963666997509684 -0.75587184796602791 -0.25791530207195246 -0.2856964196962325 1
		 1 1 no;
	setAttr ".xm[344]" -type "matrix" "xform" 1 1 1 -2.4286128663675299e-17 3.1225022567582528e-17
		 -5.2041704279304213e-18 0 -2.1316282072803006e-14 -8.5265128291212022e-14 1.7763568394002505e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[345]" -type "matrix" "xform" 1 1 1 6.371569938022838e-13 5.2863713406737041e-11
		 -1.1385337117362567e-12 0 -2.0962510907311582 -8.2628865146613428 0.79756355079681185 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[346]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.3743454961862737e-13
		 -5.2863990962492473e-11 1.1385337117699468e-12 0 -2.1073618075504328 -8.2670560414176997
		 -0.78861130532133572 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[347]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.9341087475650056 -7.8887793987084285 -1.3696936838415938 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[348]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.9306823487580971 -7.9024038613621483 1.3779603976003294 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[349]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999944 -6.373236502678969e-13
		 -2.1603543803872017e-07 1.1385337805953517e-12 0 -1.7418699342912305 -8.4869843496898447
		 -0.79823078792583002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[350]" -type "matrix" "xform" 1 1 0.99999999999999933 6.3715687086256627e-13
		 2.1603543798320894e-07 -1.1384226206264102e-12 0 -1.7416859135606728 -8.4870035932095398
		 0.79825373149077394 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[351]" -type "matrix" "xform" 1 1 1 -6.373236502678969e-13 -2.1603543803872017e-07
		 1.1385337805953517e-12 0 -1.8406639910366778 -8.0028192385838359 -1.4240631330226121 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61740614174160535 0.60235928896032997 -0.36213633122535643 0.35331320488992385 1
		 1 1 no;
	setAttr ".xm[352]" -type "matrix" "xform" 1 1 1 6.3715687086256627e-13 2.1603543798320894e-07
		 -1.1384226206264102e-12 0 -1.8405874071773951 -8.002837634097073 1.4240796995612557 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60236039138085995 0.61740501174651852 0.3533113253801542 0.36213825774681319 1
		 1 1 no;
	setAttr ".xm[353]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -1.7237789224739686 -8.8036907272161677
		 -0.0063072443458632964 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[354]" -type "matrix" "xform" 1 0.99999999999999989 0.99999999999999978 8.327240916014542e-16
		 5.2953419427125487e-11 2.1461553645352179e-09 0 -2.2281032650074337 -8.4906339138507221
		 -0.0083357945227417098 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975850350839 0.49379419401206665 -0.50612817923011988 0.49379573479968142 1
		 1 1 no;
	setAttr ".xm[355]" -type "matrix" "xform" 1 1 1 3.1005292266810725e-08 2.1148490762399202e-07
		 -3.1079389114420901e-08 0 4.8977792049080051 -5.1625618604184824 -3.0255378400541928 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65179301766768583 0.48951258216125237 -0.42813074108507698 0.39018888062503504 1
		 1 1 no;
	setAttr ".xm[356]" -type "matrix" "xform" 1 1 1 0.49834220988984118 0.30627952379061368
		 -0.52909698088640933 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[357]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225656
		 -0.55413068517553654 2.0122308310650965 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[358]" -type "matrix" "xform" 1 1 1 -8.2840640233110677e-10 -2.0433946057473432e-07
		 -7.8271160943146079e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[359]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.901761559953421 -0.44001460413102222
		 2.0127867015537895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[360]" -type "matrix" "xform" 1 1 1 -1.664122574395709e-09 -2.0833728584711331e-07
		 -1.4960872611444271e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[361]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8428479870225871
		 -0.18680962154292047 2.0498306576013867 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[362]" -type "matrix" "xform" 1 1 1 -4.4747798214463139e-09 -2.1481279191168167e-07
		 -3.4359190717270576e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[363]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.651376863175166 0.2190784334356124
		 2.1506761056779968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[364]" -type "matrix" "xform" 1 1 1 -1.0361694732866221e-08 -2.2151459530258195e-07
		 -5.7974875983844382e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[365]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3051931605799645
		 0.6475386998250201 2.3327372183632118 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[366]" -type "matrix" "xform" 1 1 1 -1.7320393411859419e-08 -2.2502606366396108e-07
		 -6.3307502029031801e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[367]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.91435072973679254
		 0.92020894931960129 2.5015859093419888 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[368]" -type "matrix" "xform" 1 1 1 -2.5445130220729105e-08 -2.2532170881614217e-07
		 -4.014963090252103e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[369]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.41712374201814484
		 1.0593653880451939 2.6435531694482233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[370]" -type "matrix" "xform" 1 1 1 -3.190568315011897e-08 -2.2289943559674655e-07
		 9.9402877218481709e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[371]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.083717869653032295
		 1.0397697937033286 2.6871212004845209 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[372]" -type "matrix" "xform" 1 1 1 -3.6079726452084256e-08 -2.1926283188589039e-07
		 8.0179502415478777e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[373]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.58789356729053921
		 0.91744020449246477 2.645443954446506 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[374]" -type "matrix" "xform" 1 1 1 -3.7396839938730265e-08 -2.1537079319162405e-07
		 1.6010125581981647e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[375]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0720351163478234 0.67978613269735888
		 2.5040854117433398 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[376]" -type "matrix" "xform" 1 1 1 -3.6216028457075853e-08 -2.1266279747213787e-07
		 2.2657445523747539e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[377]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.4569764020345559 0.37641624804336971
		 2.328854407787091 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[378]" -type "matrix" "xform" 1 1 1 -3.4538128080462249e-08 -2.1165486210934367e-07
		 2.6389732584957976e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[379]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6833247299506056 0.1579125858016539
		 2.20308696024758 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[380]" -type "matrix" "xform" 1 1 1 -3.367774831740739e-08 -2.1142378280090454e-07
		 2.7785074916686697e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[381]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830005 0.063639944138600413
		 2.1502427556486179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[382]" -type "matrix" "xform" 1 1 1 -6.4834891247562247e-10 -2.025742260656978e-07
		 -6.1929112210620829e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[383]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.9220459003225514
		 -0.55413068517555075 2.012230831065116 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[384]" -type "matrix" "xform" 1 1 1 -1.445557769773017e-09 -2.0185979906885197e-07
		 -1.3155000906206124e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[385]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.8506016512536583
		 -0.59243673710301437 2.0335628223445017 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[386]" -type "matrix" "xform" 1 1 1 -4.2411285983377584e-09 -1.997631357588286e-07
		 -3.2927039771929791e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[387]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6364599551777204
		 -0.70627961864414601 2.1078232484508579 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[388]" -type "matrix" "xform" 1 1 1 -9.1443072315415327e-09 -1.9721820002506209e-07
		 -5.4537058067462486e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[389]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.3189053392455676
		 -0.84994631869366799 2.2114279058556665 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[390]" -type "matrix" "xform" 1 1 1 -1.6113930557458474e-08 -1.9536765121410154e-07
		 -6.3803359897679159e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[391]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.92219956674101411
		 -0.98703341618508489 2.329071840198889 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[392]" -type "matrix" "xform" 1 1 1 -2.569099510587126e-08 -1.9554379646801572e-07
		 -3.8784512095213989e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[393]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.36773835626903661
		 -1.0933495407932128 2.4359116826740372 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[394]" -type "matrix" "xform" 1 1 1 -3.2663938161256452e-08 -1.9813898893499142e-07
		 1.874227962805391e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[395]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.14225480745387031
		 -1.1122214925050571 2.4792086530559612 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[396]" -type "matrix" "xform" 1 1 1 -3.658448467951151e-08 -2.0224406229853182e-07
		 9.434842533308028e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[397]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.63081150567859368
		 -1.0184191038586903 2.446030501026895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[398]" -type "matrix" "xform" 1 1 1 -3.7450513623057725e-08 -2.0592254278816584e-07
		 1.5943511654662818e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[399]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.0143511103689953 -0.84258197477461749
		 2.3826599599763405 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[400]" -type "matrix" "xform" 1 1 1 -3.6906885292331896e-08 -2.0836109096952292e-07
		 2.0394194882311313e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[401]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.2768222604636605 -0.63371529019519812
		 2.3106343541978127 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[402]" -type "matrix" "xform" 1 1 1 -3.5721108749179831e-08 -2.1009830120158472e-07
		 2.4054550412573915e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[403]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.5095055663478689 -0.38621291736137664
		 2.2416218081692989 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[404]" -type "matrix" "xform" 1 1 1 -3.4551784760320525e-08 -2.1098125107312762e-07
		 2.6399085652106398e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[405]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6700046218427431 -0.15828365563567104
		 2.1857435417215871 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[406]" -type "matrix" "xform" 1 1 1 -3.3677749901210003e-08 -2.1142377802617302e-07
		 2.7785076246352328e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[407]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.7740101253830076 0.063639944138600413
		 2.1502427556486179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[408]" -type "matrix" "xform" 1 1 1 -7.2270448430293699e-09 -2.1591548370108326e-07
		 -2.0564798882655632e-09 0 0.083717268904223374 1.0397698796429609 2.6871211859469906 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209614 -0.01732673914736188 -0.054206990661288729 0.99527072079149959 1
		 1 1 yes;
	setAttr ".xm[409]" -type "matrix" "xform" 1 1 1 -6.6170082868012172e-11 -5.2777739643744211e-11
		 4.8759722676698461e-12 0 0.14242158253221859 -1.1122180545978608 2.4792041459058893 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274875672208086 0.012855654817866638 -0.074198286521042198 0.99711886723061027 1
		 1 1 yes;
	setAttr ".xm[410]" -type "matrix" "xform" 1 1 1 0.10364137184880047 -0.0053000494540148772
		 0.35836950924492161 0 -1.2997743370483512 0.64071898021839502 2.3341839743222934 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.089968452397532442 -0.27124541290781967 -0.032274665279149017 0.95775255130476067 1
		 1 1 yes;
	setAttr ".xm[411]" -type "matrix" "xform" 1 1 1 5.1168433250912356e-08 -2.0984148939156934e-07
		 -0.2654357220276109 0 1.0662731636068834 0.67192514206931264 2.5009029203714821 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.065057965514676644 0.19944902313067039 -0.070024549757776403 0.97523541297808347 1
		 1 1 yes;
	setAttr ".xm[412]" -type "matrix" "xform" 1 1 1 9.2852030667262482e-09 -2.1434760788957048e-07
		 2.5393769589002867e-08 0 -0.91942591903668713 -0.98083258183578437 2.3247648013731599 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258928005 -0.094092400772244497 -0.081393910043315199 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[413]" -type "matrix" "xform" 1 1 1 -1.5310318264371994e-07 -1.4762871270962601e-07
		 0.73374126969787457 0 1.2767232674260036 -0.63316612625669677 2.3114565207102906 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.036310446668287463 0.18874460055130868 -0.068116033193234712 0.97898786164461427 1
		 1 1 yes;
	setAttr ".xm[414]" -type "matrix" "xform" 1 1 1 -4.2188058602083735e-11 -3.2005124245332403e-11
		 -2.3731962568905957e-12 0 -1.8415442721152147 0.53882220307929174 2.1607462442420857 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18364789511409785 -0.16327168456973754 0.38197916478446375 0.89090275861537493 1
		 1 1 yes;
	setAttr ".xm[415]" -type "matrix" "xform" 1 1 1 -3.0767520475764811e-11 -4.3098710364489831e-11
		 -2.3855995297559274e-12 0 -1.4782201886627462 0.92915995471909696 2.2581012505222482 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279457351529084 -0.2041408319858658 0.24397191038610644 0.9339711743371133 1
		 1 1 yes;
	setAttr ".xm[416]" -type "matrix" "xform" 1 1 1 -1.6787268623748906e-11 -5.0222976060081451e-11
		 -2.3520895106937167e-12 0 -1.008194076838091 1.233727124026359 2.4101979372509081 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003998754952359 -0.13325847765132248 0.097328953220419082 0.98013287575673647 1
		 1 1 yes;
	setAttr ".xm[417]" -type "matrix" "xform" 1 1 1 -7.2335366862393327e-12 -5.2457873656918142e-11
		 -2.3850223009925876e-12 0 -0.43756942257016007 1.3740585931925295 2.5662376537978169 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08782850160250745 -0.073005731704837012 0.00062653087303683047 0.993456554109723 1
		 1 1 yes;
	setAttr ".xm[418]" -type "matrix" "xform" 1 1 1 5.2679770268906823e-12 -5.2691570182575559e-11
		 -2.5386290293527681e-12 0 0.088691852656662462 1.377613015388846 2.6357312381437197 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179930946433952 0.025570101570747766 -0.12537050949400147 0.98885035438931446 1
		 1 1 yes;
	setAttr ".xm[419]" -type "matrix" "xform" 1 1 1 1.3623394079581829e-11 -5.1171582596246253e-11
		 -2.8304164571157472e-12 0 0.64581895626352193 1.2361821128119459 2.6147490036525944 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.08302621016941017 0.12036288508314086 -0.21035049969512737 0.96662924205580381 1
		 1 1 yes;
	setAttr ".xm[420]" -type "matrix" "xform" 1 1 1 2.2817220335443616e-11 -4.7786045953532938e-11
		 -3.1074587353197541e-12 0 1.1910360206362576 0.97244359768617983 2.5037355652675011 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199138466527528 0.17192327577532207 -0.3005309751392517 0.93258848249514259 1
		 1 1 yes;
	setAttr ".xm[421]" -type "matrix" "xform" 1 1 1 3.3207575578308265e-11 -4.1248282567290161e-11
		 -3.7326114428380778e-12 0 1.6303005776548574 0.62516010491745533 2.3474455111359305 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214051530672434 0.24209093085439834 -0.40455846701440484 0.87035653721526351 1
		 1 1 yes;
	setAttr ".xm[422]" -type "matrix" "xform" 1 1 1 3.9991121525488847e-11 -3.4710595508887009e-11
		 -4.0915881800719941e-12 0 1.88607497790764 0.27366056866094368 2.2146113775048288 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383053603373361 0.25974188268956622 -0.47782105644473855 0.82097754971566561 1
		 1 1 yes;
	setAttr ".xm[423]" -type "matrix" "xform" 1 1 1 1.0408403104515979e-17 -5.2954076887323787e-11
		 -2.3510429714157514e-12 0 1.9903089863693886 0.073126376516910341 2.150529464487267 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018783301713158 -0.1622475379965643 -0.060171158694305706 0.98097291596736969 1
		 1 1 yes;
	setAttr ".xm[424]" -type "matrix" "xform" 1 1 1 -0.00020942154066701382 0.00064656522961714733
		 0.0011213558940740124 0 -1.8415442721152644 0.53882220307920647 2.1607462442420982 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635703914590389 -0.10419109701550218 0.39729100105206633 0.90974028557414954 1
		 1 1 yes;
	setAttr ".xm[425]" -type "matrix" "xform" 1 1 1 -4.859151275138007e-13 -5.2946289713640734e-11
		 -2.4756672406405371e-12 0 0.090138694212775761 1.3933507902455062 2.6435101973089505 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490162301620583 -0.07397825714305363 -0.059407940992506889 0.99189683258459549 1
		 1 1 yes;
	setAttr ".xm[426]" -type "matrix" "xform" 1 1 1 -0.00040368505052095269 -0.00045044459247356976
		 -0.0012710992754142753 0 1.8940854349569634 0.27923234072866876 2.2118679046868692 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671788206761885 0.085969143739353798 -0.38565737410528028 0.91839554294175296 1
		 1 1 yes;
	setAttr ".xm[427]" -type "matrix" "xform" 1 1 1 5.7762735572936142e-13 -5.2954184440178638e-11
		 -2.2790319978580338e-12 0 -1.9005620307747684 -0.5518137729151249 2.0009549927581158 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892722284055417 -0.039558279527996974 -0.070604718981914047 0.99351259131644254 1
		 1 1 yes;
	setAttr ".xm[428]" -type "matrix" "xform" 1 1 1 1.9381733676761222e-08 -5.2953749651655156e-11
		 -1.6403846437959249e-08 0 1.7739757398722382 0.063860529367332219 2.1504218347892703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537172867420804 0.26549863850734806 -0.09161642970614664 0.95819757854748955 1
		 1 1 yes;
	setAttr ".xm[429]" -type "matrix" "xform" 1 1 1 -3.1005296175097963e-08 -2.1148490693792196e-07
		 3.1079396559751079e-08 0 4.8974606715216282 -5.1625538842295233 3.0255988686508091 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.48951389000388029 -0.65179176827743435 -0.39018721510704873 -0.42813266573113745 1
		 1 1 no;
	setAttr ".xm[430]" -type "matrix" "xform" 1 1 1 6.283185307139437 -1.691866915670064e-10
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1.0275841211271339e-07 0 0.99999999999999467 1
		 1 1 yes;
	setAttr ".xm[431]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407374 0.55361168484853351
		 -2.012150500121642 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[432]" -type "matrix" "xform" 1 1 1 6.2831834777536537 -7.6260061262469617e-06
		 -6.2831870313297804 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[433]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9017475930669789 0.43989678048490077
		 -2.0127687111993176 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[434]" -type "matrix" "xform" 1 1 1 6.283192743436123 -2.4064184400022912e-05
		 -6.2831786216370435 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[435]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.8427478699924755 0.18611709322672709
		 -2.0497229357518041 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[436]" -type "matrix" "xform" 1 1 1 -9.4247607596253147 3.1416441391713117
		 3.1416058582721185 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[437]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6513189699522393 -0.21949107321481165
		 -2.1506126723226746 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[438]" -type "matrix" "xform" 1 1 1 -3.1415612628268654 3.1416730457082229
		 3.141610217482913 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[439]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3052215051098592 -0.64737534197141144
		 -2.3327639497827963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[440]" -type "matrix" "xform" 1 1 1 -3.141565465772318 3.1416722639098977
		 3.1416025906685041 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[441]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.91437234838192438
		 -0.92013477945110367 -2.5016174983116439 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[442]" -type "matrix" "xform" 1 1 1 -3.1415723290649904 3.1416376445391214
		 3.1415958561675876 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[443]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.41701125790985216
		 -1.0601170330202194 -2.6434264207041664 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[444]" -type "matrix" "xform" 1 1 1 1.7425805181374886e-05 6.2831825452840677
		 -5.4245412396542647e-07 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[445]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.083744097464116152
		 -1.0399260121631357 -2.6870785872144829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[446]" -type "matrix" "xform" 1 1 1 1.2693526097136423e-05 6.283214088528303
		 -2.8122587644200276e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[447]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.58794971646821637
		 -0.9178402388111806 -2.6453821064307608 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[448]" -type "matrix" "xform" 1 1 1 1.5381657927121628e-05 6.2832188663890669
		 -6.5651340723563942e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[449]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0720354286874141
		 -0.67981279993915678 -2.5040824246573692 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[450]" -type "matrix" "xform" 1 1 1 8.3656757013608564e-06 6.2832054104990904
		 -5.2010808494964904e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[451]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.4570052721775646
		 -0.37663416137027639 -2.3288206309923876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[452]" -type "matrix" "xform" 1 1 1 5.4110698190280008e-06 6.2831907162611085
		 -4.1141251738219395e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[453]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6833662884828087
		 -0.15821562273086442 -2.2030402065381178 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[454]" -type "matrix" "xform" 1 1 1 5.4871734328989679e-08 6.2831855193676329
		 2.424508580468098e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[455]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758332
		 -0.063688645826516677 -2.1502361142816575 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[456]" -type "matrix" "xform" 1 1 1 6.283185307139437 2.0534763752778872e-07
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[457]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.9219719358407445 0.55361168484856194
		 -2.0121505001216349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[458]" -type "matrix" "xform" 1 1 1 6.2831857368727118 -9.6775282638451468e-07
		 -6.2831849161452924 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[459]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.850494206942777 0.59169526363584168
		 -2.0334476430835586 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[460]" -type "matrix" "xform" 1 1 1 6.2831870256632865 -2.7747909729560291e-06
		 -6.2831839729904075 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[461]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6364648755525515 0.70628849354667977
		 -2.1078251817848361 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[462]" -type "matrix" "xform" 1 1 1 6.2831887525327561 -3.4914099042060667e-06
		 -6.2831832523585769 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[463]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.3188063863827146 0.84926055027781899
		 -2.2113213665086953 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[464]" -type "matrix" "xform" 1 1 1 6.283186499846197 -7.6909015776679209e-07
		 -6.2831848349460371 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[465]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.92212606378262052
		 0.9865173671582852 -2.3289921614483173 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[466]" -type "matrix" "xform" 1 1 1 6.2831814995216435 2.1715219251396469e-05
		 -6.2831858857056826 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[467]" -type "matrix" "xform" 1 1 1 0 0 0 0 0.36766900114157508
		 1.0928620039817076 -2.4358357948869713 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[468]" -type "matrix" "xform" 1 1 1 6.2831550232537685 6.9571799983719759e-05
		 1.7396942165332526e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[469]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.14222208218171062
		 1.1124159575755357 -2.4792399288635174 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[470]" -type "matrix" "xform" 1 1 1 6.2831297046218744 0.00011709473560854273
		 1.4350585037239655e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[471]" -type "matrix" "xform" 1 1 1 0 0 0 0 -0.63086954984229138
		 1.018008392816057 -2.4459668606990306 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[472]" -type "matrix" "xform" 1 1 1 6.2831124886687117 0.00013760109368610648
		 3.1022076281352182e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[473]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.0144414120572804
		 0.84195399111771962 -2.3825621868996532 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[474]" -type "matrix" "xform" 1 1 1 6.2831085925143197 0.00013233797747792705
		 4.2422124632536497e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[475]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.2768198175289776
		 0.63370445935751718 -2.3106336851512452 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[476]" -type "matrix" "xform" 1 1 1 6.2831274499323984 9.9294363699924888e-05
		 3.8927715753699082e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[477]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.509568013397292 0.38577221615099688
		 -2.2415536902277644 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[478]" -type "matrix" "xform" 1 1 1 12.566339093615564 5.3566477875247642e-05
		 6.2832094222993158 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[479]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6700909513003346
		 0.15768375781621558 -2.185650057238286 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[480]" -type "matrix" "xform" 1 1 1 5.4871726338854156e-08 6.2831855193676382
		 2.4252473123899102e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[481]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.7740137786758403
		 -0.063688645826545098 -2.1502361142816628 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[482]" -type "matrix" "xform" 1 1 1 7.2270430958825361e-09 2.1591548446684657e-07
		 2.0564790140118618e-09 0 -0.08374469820877195 -1.039925926224015 -2.6870786017511907 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.078724701391209892 -0.017326739147361585 -0.054206990661288007 0.9952707207914997 1
		 1 1 yes;
	setAttr ".xm[483]" -type "matrix" "xform" 1 1 1 4.4155530427770434e-09 5.2777770446013385e-11
		 -4.8764757071011789e-12 0 -0.14246364064053552 1.111925119629916 -2.4791563476353051 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.0091274720089168961 0.012855868281954794 -0.074198315184487218 0.99711886248793169 1
		 1 1 yes;
	setAttr ".xm[484]" -type "matrix" "xform" 1 1 1 -8.255627292896861e-08 -3.1415924552526793
		 -2.2864956150669968e-08 0 1.2997323877743199 -0.64101202232799892 -2.3341367938949915 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087241177286391219 -0.24582379979002997 0.15223950242423173 0.9533009862284304 1
		 1 1 yes;
	setAttr ".xm[485]" -type "matrix" "xform" 1 1 1 4.8377458483628288e-08 -3.1415924437483032
		 4.9291246639882047e-09 0 -1.0663151974821972 -0.67221804415686393 -2.5008549191160636 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.090878646671435137 0.18908602085785248 -0.19846026990574109 0.95739285017397791 1
		 1 1 yes;
	setAttr ".xm[486]" -type "matrix" "xform" 1 1 1 1.7252994588545789e-09 -3.141592439242185
		 -2.5393772418169647e-08 0 0.91938398463565107 0.98053956659313712 -2.3247174258871564 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.018066457258927571 -0.094092400772244747 -0.081393910043314976 0.99206615437020496 1
		 1 1 yes;
	setAttr ".xm[487]" -type "matrix" "xform" 1 1 1 -1.5351977022959318e-07 -3.1415925059610723
		 -3.7962259114010521e-08 0 -1.2767648498227935 0.63287314458960964 -2.3114085656174659 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10159609039787926 0.16316006616322959 0.28757587279425023 0.93827349137237259 1
		 1 1 yes;
	setAttr ".xm[488]" -type "matrix" "xform" 1 1 1 4.2188481874687819e-11 3.2005471189927497e-11
		 2.37230547773593e-12 0 1.8415064518602078 -0.53897067132891152 -2.1606717130969457 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.1836477917828139 -0.16327150229346379 0.3819791708688603 0.89090281071195965 1
		 1 1 yes;
	setAttr ".xm[489]" -type "matrix" "xform" 1 1 1 3.0767874359456707e-11 4.3099150984179343e-11
		 2.3848154360708408e-12 0 1.4782174567261905 -0.93053018598536141 -2.2577112041161485 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.16279449930527945 -0.20414063697037549 0.24397190945446856 0.93397123014063621 1
		 1 1 yes;
	setAttr ".xm[490]" -type "matrix" "xform" 1 1 1 1.6787461178172851e-11 5.0223528677889282e-11
		 2.3515344068007828e-12 0 1.0079696133229659 -1.2364652224000565 -2.4095905251895697 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.11003994071765356 -0.13325826996625711 0.097328941894998411 0.98013291037596306 1
		 1 1 yes;
	setAttr ".xm[491]" -type "matrix" "xform" 1 1 1 7.2336303614321482e-12 5.2458536646529363e-11
		 2.3849944373762158e-12 0 0.4370771531536124 -1.377367917365433 -2.5656936294083401 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.087828472935711638 -0.073005518894025734 0.0006265163043274128 0.99345657229197259 1
		 1 1 yes;
	setAttr ".xm[492]" -type "matrix" "xform" 1 1 1 -5.2680360073551046e-12 5.2692179178949222e-11
		 2.5384707355580039e-12 0 -0.089247510662981977 -1.3809657735308178 -2.6351800514961585 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.076179926004818169 0.025570316952063965 -0.1253705233265395 0.98885034744682221 1
		 1 1 yes;
	setAttr ".xm[493]" -type "matrix" "xform" 1 1 1 -1.362354673510289e-11 5.1172803841611895e-11
		 2.8298578754593399e-12 0 -0.64645207588672626 -1.2389449794704319 -2.614164119697179 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.083026220942287066 0.12036309861276841 -0.21035050844990655 0.96662921263700774 1
		 1 1 yes;
	setAttr ".xm[494]" -type "matrix" "xform" 1 1 1 -2.2817553402202499e-11 4.7786892498660126e-11
		 3.1079167012270498e-12 0 -1.1916738483654097 -0.97488500632479713 -2.5031910497689172 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.10199141396272945 0.1719234854915308 -0.3005309772264117 0.93258843995712515 1
		 1 1 yes;
	setAttr ".xm[495]" -type "matrix" "xform" 1 1 1 -3.3207964156212918e-11 4.1248379711928763e-11
		 3.7328889972244691e-12 0 -1.6307371394187653 -0.62669016381025244 -2.347062232367163 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.14214056635292294 0.2420911318830031 -0.40455845650067002 0.87035647784931902 1
		 1 1 yes;
	setAttr ".xm[496]" -type "matrix" "xform" 1 1 1 -3.9992231748371436e-11 3.4711039598260505e-11
		 4.0925318682547815e-12 0 -1.8861537960163437 -0.27451522969829512 -2.2145073519171703 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.17383060355622937 0.25974207653192272 -0.47782103714693691 0.82097748532221482 1
		 1 1 yes;
	setAttr ".xm[497]" -type "matrix" "xform" 1 1 1 -1.8041117925524469e-16 5.2954923432380057e-11
		 2.350918071325475e-12 0 -1.9901188991541003 -0.07355444937721245 -2.1506127682602347 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.088018770653616712 -0.16224732593480973 -0.060171175601813162 0.98097295113898286 1
		 1 1 yes;
	setAttr ".xm[498]" -type "matrix" "xform" 1 1 1 -0.00020935370173638714 0.000646535944230735
		 0.0011213569858792456 0 1.8415022460801751 -0.53911528115796159 -2.1606993877420653 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.060635812904552347 -0.10419091882317158 0.39729095672071563 0.90974031807770606 1
		 1 1 yes;
	setAttr ".xm[499]" -type "matrix" "xform" 0.99999999999999989 0.99999999999999978
		 1 4.8561675520700063e-13 5.2946981868306453e-11 2.475271723713735e-12 0 -0.09018097762430699
		 -1.3936437182729549 -2.643462576570407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.084490146409749334 -0.073978042904410513 -0.059407956248894334 0.99189684900297059 1
		 1 1 yes;
	setAttr ".xm[500]" -type "matrix" "xform" 1 1 1 -0.000403610907061532 -0.000450427601655768
		 -0.0012711010462760047 0 -1.8941274664792758 -0.2795251833647967 -2.211819451642576 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.020671737794658616 0.085969349280733631 -0.38565740435772389 0.9183955121323597 1
		 1 1 yes;
	setAttr ".xm[501]" -type "matrix" "xform" 1 1 1 1.1733102774948214e-08 5.2954895663435723e-11
		 2.2788033250065268e-12 0 1.900507324931457 0.55143386844616771 -2.0008900762192354 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.079892713468937018 -0.039558064329149753 -0.070604734425650101 0.99351259949624415 1
		 1 1 yes;
	setAttr ".xm[502]" -type "matrix" "xform" 1 1 1 7.6044138828766526e-09 5.2954477517670043e-11
		 -1.6400808634596416e-08 0 -1.7739559364336124 -0.063729916002699838 -2.1504440386576462 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.054537148639359559 0.26549884514744027 -0.09161644128664588 0.9581975215630828 1
		 1 1 yes;
	setAttr ".xm[503]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.5915750767282191 -9.2818264498213523
		 -1.1534880686784996 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64363684588735537 0.41682505669272873 -0.36208451121158108 0.52998423511454607 1
		 1 1 no;
	setAttr ".xm[504]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.8337191568088542 -9.1870481363271033
		 -1.7167633873436821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.61642871162872426 0.43518963307226322 -0.39157607613074635 0.52658693807217416 1
		 1 1 no;
	setAttr ".xm[505]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0444083914252076 -9.1039067135571727
		 -2.3471022522914278 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.62188391732851445 0.47247700980397356 -0.38995912234872376 0.48780913426446854 1
		 1 1 no;
	setAttr ".xm[506]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.234552859380841 -8.9459321480848182
		 -3.0683367309514535 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64168255502320148 0.49811503910081212 -0.36887102762533897 0.45172898000805622 1
		 1 1 no;
	setAttr ".xm[507]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4270119939492929 -8.6916776346774398
		 -3.8355955456947233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.64878746840716661 0.54451986867036606 -0.35167433360611811 0.39862024101106558 1
		 1 1 no;
	setAttr ".xm[508]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5452645532116378 -8.3759951317221315
		 -4.4951554490413859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.6445427653902942 0.59357124520206972 -0.33510087316810716 0.34633106308021078 1
		 1 1 no;
	setAttr ".xm[509]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5940869418139698 -8.0082101606394041
		 -5.0768733443424905 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.61698848935560613 -0.68501063281675922 0.29416559189051417 -0.25209569904775003 1
		 1 1 no;
	setAttr ".xm[510]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5102178515226967 -7.4841715353962703
		 -5.6094822277796474 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58988744759981515 -0.75044903532326779 0.23882949243968127 -0.17838026260647855 1
		 1 1 no;
	setAttr ".xm[511]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3231279971573144 -6.8615237398363567
		 -6.0370766530067455 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69509540550453952 0.67815590284734562 -0.17080820677032965 0.16664784780994155 1
		 1 1 no;
	setAttr ".xm[512]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.591567890365809 -9.281825951815577
		 1.1535519073689353 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.41682678573717025 -0.64363583240600963 -0.52998279777602875 -0.36208642614234421 1
		 1 1 no;
	setAttr ".xm[513]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.827736044453701 -9.1932244021217073
		 1.7200965521217058 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.43519135790030139 -0.61642760554878873 -0.52658544940181073 -0.39157790234456746 1
		 1 1 no;
	setAttr ".xm[514]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.0416263359323068 -9.0953952317671671
		 2.3465259188539829 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47247861349105658 -0.62188280791458672 -0.48780752826761631 -0.38996095750635934 1
		 1 1 no;
	setAttr ".xm[515]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.4212459635155028 -8.6820597606841829
		 3.8330491390015489 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.54452118627198365 -0.64878645899644094 -0.39861840479573157 -0.35167623701626072 1
		 1 1 no;
	setAttr ".xm[516]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2333822087389308 -8.9417385609598981
		 3.06756760661741 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.4981165258469773 -0.64168150350957542 -0.45172728987584854 -0.3688729189209331 1
		 1 1 no;
	setAttr ".xm[517]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5426726920976819 -8.3717750511885107
		 4.4932499366907726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59357239634656755 -0.64454179631808617 -0.34632907498779958 -0.33510275276777873 1
		 1 1 no;
	setAttr ".xm[518]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.5804144182153834 -7.9972095573383752
		 5.0681593923931487 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.68501148158394198 0.61698762745372138 0.25209343207274298 0.29416736592114684 1
		 1 1 no;
	setAttr ".xm[519]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.50350089676121 -7.4777487740598909
		 5.5994849728088294 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.75044964252362167 0.58988674215589432 0.17837779764324985 0.2388311679258335 1
		 1 1 no;
	setAttr ".xm[520]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.3230903863112644 -6.861521133447007
		 6.037144004283026 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.67815645881857545 0.69509490941182561 0.16664558532716539 0.17081022558202422 1
		 1 1 no;
	setAttr ".xm[521]" -type "matrix" "xform" 1 1 1 -6.94626294870168e-17 5.1124975364302835e-09
		 1.6258070612007458e-08 0 5.5915750828797286 -9.2818262008181733 -1.1534905420038315 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.57008357847228652 0.41833620676040645 -0.57008179842243811 0.41833751299278132 1
		 1 1 no;
	setAttr ".xm[522]" -type "matrix" "xform" 1 1 1 -5.2347015614236926e-13 -5.2863935451341294e-11
		 1.1958212198375924e-12 0 6.4212685080667882 -8.6820605052311421 -3.8329827384701094 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.59884764109944522 0.58425295472417371 -0.39206449597387255 0.38251198496577321 1
		 1 1 no;
	setAttr ".xm[523]" -type "matrix" "xform" 1 1 1 -1.1360357099646383e-12 -5.2863824429038779e-11
		 6.4115379675105551e-13 0 6.3231280293178997 -6.8615224366417022 -6.0370785999793464 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.69229959826107823 0.67542819395830289 -0.18180850502978574 0.17738006808153359 1
		 1 1 no;
	setAttr ".xm[524]" -type "matrix" "xform" 1 1 1 9.29738472916946e-16 -5.1125492173120699e-09
		 -1.6258055013373962e-08 0 5.5910963223046792 -9.2816699913087817 1.1535494445110896 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.41833660886893093 0.57008246188149481 0.41833530263937935 0.57008424193341456 1
		 1 1 no;
	setAttr ".xm[525]" -type "matrix" "xform" 1 1 1 5.2169379923974139e-13 5.2863824429039439e-11
		 -1.1962653090198163e-12 0 6.4211081908840413 -8.6820979314971503 3.8330420344877867 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58425431348311907 0.5988465870770513 0.38250990957457948 0.39206610590534852 1
		 1 1 no;
	setAttr ".xm[526]" -type "matrix" "xform" 1 1 1 1.1363132656868772e-12 5.2864435051703047e-11
		 -6.4204197511069275e-13 0 6.322977984395493 -6.8615236890383668 6.037141728287307 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.6754288240451688 0.69229910948735618 0.17737766881810094 0.18181036619684324 1
		 1 1 no;
	setAttr ".xm[527]" -type "matrix" "xform" 1 1 1 3.8857805861880479e-16 -1.1102230246251568e-16
		 1.1102230246251563e-16 0 1.495428866347595 -7.2689254591411965 -4.7917412416201888 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.66648149151545732 -0.51538575008480991 0.47835595225089356 -0.24770049055863874 1
		 1 1 no;
	setAttr ".xm[528]" -type "matrix" "xform" 1 1 1 7.4024120153676099e-13 5.2636672798202689e-11
		 -5.0178750043788385e-12 0 1.4953990139619009 -7.2689233898976573 4.791778693941005 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.60531135036067751 0.64530882279232671 0.30095010597674293 0.35581417350001959 1
		 1 1 no;
	setAttr ".xm[529]" -type "matrix" "xform" 1 1 1 2.7755575632105181e-16 9.0150109599562194e-14
		 3.6552982862758646e-12 0 0.75632669249665696 -8.806608677981508 1.6755937096558037e-05 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[530]" -type "matrix" "xform" 1 1 1.0000000000000002 0.18929270062667797
		 9.0165490181700516e-14 3.6553101812596358e-12 0 -0.57788721563673562 -6.3299602678278584
		 1.2065149448500139e-05 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[531]" -type "matrix" "xform" 1 1 1 2.4999769986678032e-16 -5.2864032509432428e-11
		 1.3046305120116952e-12 0 2.7626215921599644 0.13552840493653662 -1.6028016275437693 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.094505107667796004 -1.0760925916377254e-07 9.1386232877953759e-09 0.99552437671042815 1
		 1 0.99999999999999978 no;
	setAttr ".xm[532]" -type "matrix" "xform" 1 1 1 1.8754747393352533e-16 -5.2233709371485339e-11
		 8.2430333753187757e-12 0 -3.7847003367119197e-07 -0.07801570437288774 1.7945141948880554 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.028719491485545857 -1.0677350968429597e-07 1.6207551421166537e-08 0.99958751033053628 1
		 1 0.99999999999999978 no;
	setAttr ".xm[533]" -type "matrix" "xform" 1 1 1 -8.602253271174304e-16 5.2864152786734516e-11
		 -1.3046074685068644e-12 0 -2.7626196645013401 0.13572391530999539 -1.6028359655176878 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99552437671042815 9.1386232877954073e-09 1.0760925916377248e-07 0.094505107667795768 1
		 1 0.99999999999999978 no;
	setAttr ".xm[534]" -type "matrix" "xform" 1 1 1 0.2624680135684086 3.1965137486376539e-14
		 1.3028000587699907e-12 0 -1.8685434565056482 -5.6773791186242102 7.9032646361304687e-06 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.50612975904586344 0.49379419348292686 -0.5061281786877635 0.49379573532881932 1
		 1 1 no;
	setAttr ".xm[535]" -type "matrix" "xform" 1 1 1 -7.2150406547701684e-16 3.4473903877621093e-17
		 1.3047401308268929e-12 0 2.6266441606518613 0.070830992159642392 -1.2832055548392702 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129724 -1.0720295509604647e-07 1.3068799426625743e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[536]" -type "matrix" "xform" 1 1 1 0.4082714640584762 3.447389712066404e-17
		 1.3047401307979626e-12 0 -4.2002976708392941e-07 0.14396607244674442 1.9711992067807955 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.13085763771129733 -1.0720295509604645e-07 1.3068799426625749e-08 0.99140116938230771 1
		 1 1 no;
	setAttr ".xm[537]" -type "matrix" "xform" 1 1 1 -4.4394831262548391e-16 8.3796731243561907e-17
		 -1.3047083555174597e-12 0 -2.6266436315536201 0.070830461190809046 -1.2832075745338258 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99140116938230771 1.3068799426625761e-08 1.0720295509604644e-07 0.13085763771129721 1
		 1 1 no;
	setAttr ".xm[538]" -type "matrix" "xform" 1 1 1 -0.55802535373957873 -0.86235996928280023
		 0.37113427545726307 0 -2.142966561689434 -6.3020949920387741 -3.6431927373101844 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.72952498310547087 -0.58947769198180122 0.33048263278386492 -0.1053118184679015 1
		 1 1 no;
	setAttr ".xm[539]" -type "matrix" "xform" 1 1 1 -0.55802560820066893 -0.8623603446012863
		 0.37113460705176132 0 -2.1428273734635752 -6.301980721854906 3.6432410976005833 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.58947809063799661 0.72952397662169755 0.10530982318633428 0.33048477927479436 1
		 1 1 no;
	setAttr ".xm[540]" -type "matrix" "xform" 1 1 1 -0.00077547738423497435 0.090417237835238334
		 -0.017141201898906815 0 13.363890593036812 1.4372147948893783 -6.0925967608967495 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.29674085579966925 -0.072556452995173229 -0.90237946084669252 0.30396008663979535 1
		 1 1 yes;
	setAttr ".xm[541]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[542]" -type "matrix" "xform" 1 1 1 -3.0010716134398763e-16 -1.3183898417423734e-16
		 -4.1633363423443352e-17 0 8.045453642247125 2.2438807550149988 -4.1434677099770099 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.19238282086113531 0.3147207522944821 -0.022701956752592317 0.92920628467112243 1
		 1 1 yes;
	setAttr ".xm[543]" -type "matrix" "xform" 1 1 1 4.1633363423443375e-16 -1.3877787807814412e-17
		 -2.2204460492503131e-16 0 9.4595187974194772 1.0716760400088674 -5.3028283221497432 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.18679828651183841 0.3428633420922797 -0.12293018645729969 0.91238111448184156 1
		 1 1 yes;
	setAttr ".xm[544]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.7534609990567276 2.8421709430404007e-14
		 -3.5527136788005009e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[545]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.7654831981509034 -1.4210854715202004e-14
		 1.0658141036401503e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[546]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[547]" -type "matrix" "xform" 1 1 1 -5.9834680001711395e-09 6.1297348175798586e-10
		 2.9696373512327469e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.29491121738262233 -0.78941577506998695 -0.22136537116205757 -0.49076214236922971 1
		 1 1 yes;
	setAttr ".xm[548]" -type "matrix" "xform" 1 1 1 5.5511151231258014e-16 2.0539125955565392e-15
		 1.8596235662471376e-15 0 4.2217770159966861 -0.43249790135706689 -0.20952977089794111 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0.19526362041306367 0.98075079329215076 1
		 1 1 yes;
	setAttr ".xm[549]" -type "matrix" "xform" 1 1 1 0.0041896447755215734 -0.15349829127575432
		 -0.054468196627642268 0 13.539495298871033 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.19378466263256422 -0.064469339669166695 -0.92506382426677092 0.32023136917538486 1
		 1 1 yes;
	setAttr ".xm[550]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[551]" -type "matrix" "xform" 0.99999988079071045 1 1 0.16168690515675491
		 1.1886835758738338e-15 6.5014699993595287e-17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 1 -0.64957844548541277 -0.31610924763916659 0.67361757392455257 -0.15608379421885649 1
		 1 1 yes;
	setAttr ".xm[552]" -type "matrix" "xform" 1 1 1 0 0 0 0 -5.3178290533725132
		 -2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.040901237501683091 -0.10049288483265671 0.33925400923495591 0.93441692305247215 1.0000001192093038
		 1 1 yes;
	setAttr ".xm[553]" -type "matrix" "xform" 1 1 1 0.00065992617226282263 -0.12604240715274512
		 -0.010457532561554423 0 13.363890593036814 1.4372147948893783 -6.0925967608967504 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.52309622362027819 -0.79625546307504325 -0.056206447644327834 0.29864429276408061 1
		 1 1 yes;
	setAttr ".xm[554]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[555]" -type "matrix" "xform" 1 1 1 -0.0017390185854515162 0.18701234659205648
		 -0.01854314004582595 0 13.539495298871032 1.0340374936070944 6.1814728871013838 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52156514552747757 0.77998608375093237 -0.10622780617703403 0.3291005337592135 1
		 1 1 yes;
	setAttr ".xm[556]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[557]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[558]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[559]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[560]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[561]" -type "matrix" "xform" 1 1 1 -4.4408920985006262e-16 -3.6082248300317588e-16
		 -1.3877787807814377e-17 0 2.7234218615202934 8.2800818998085433 0.001829057443381634 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.076379404101996479 0.70296954886326635 0.70300419241410317 0.076059880674338512 1
		 1 1 yes;
	setAttr ".xm[562]" -type "matrix" "xform" 1 1 1 3.4565643505569351e-08 1.354442376863951e-07
		 5.645017779755202e-16 0 1.8006120956543725 -5.00264799306201 0.20054753246171231 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.65867133796905708 -0.011454464113109158 -0.75209533848103105 0.019325258731440371 1
		 1 1 yes;
	setAttr ".xm[563]" -type "matrix" "xform" 1 1 1 6.4905336174093364e-11 2.4715402141568689e-07
		 -3.2975431415879046e-08 0 7.1054273576010019e-15 9.4368957093138306e-16 8.5940461489983306 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.52127652319645179 -0.018291187064478034 0.85266702003926675 0.029919421407304671 1
		 1 1 yes;
	setAttr ".xm[564]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[565]" -type "matrix" "xform" 1 1 1 0 0 4.4408920985006262e-16 0 1.843312039902969
		 4.9973336318009256 -0.43090286475866613 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.65676708076667645 0.02017898901653617 0.75309084324165154 0.033226372794312453 1
		 1 1 yes;
	setAttr ".xm[566]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.1054273576010019e-15
		 9.9920072216264089e-16 8.5995913842935465 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-0.036909777513786872 0.85367589325795301 -0.022440074634479661 -0.51901019319905217 1
		 1 1 yes;
	setAttr ".xm[567]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[568]" -type "matrix" "xform" 1 1 1 -1.1102230246251568e-16 -2.3592239273284576e-16
		 1.7347234759768073e-16 0 4.4098233039084249 -7.9775949135248307 4.7855023292131883e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.038411961755856185 -0.70606268928053895 -0.70604515724327954 0.038732879228279102 1
		 1 1 yes;
	setAttr ".xm[569]" -type "matrix" "xform" 1 1 1 0.13265057495460209 3.1516608241825494
		 0.0084610721249207543 0 -1.6038104389313901 3.5224893319268848 -1.1028910808846533 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.99758377078038141 -0.018355759882081799 0.010529841346111547 0.066172568304189827 1
		 1 1 yes;
	setAttr ".xm[570]" -type "matrix" "xform" 1 1 1 -2.8957776174501473 0.061538894960088852
		 -0.0092131505334556423 0 -13.884523486194851 1.4277529922779308e-05 -1.0658141036401503e-14 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.9915087600315764 -0.005252000539066987 -0.042398037768010315 0.12282182894097395 1
		 1 1 yes;
	setAttr ".xm[571]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[572]" -type "matrix" "xform" 1 1 1 -1.3783320039095983e-15 -2.8423513518160723e-08
		 9.6985337581690092e-08 0 -1.6066223558716501 -3.5210270942806403 -1.1028448784012284 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.99988449989743855 -0.015198252032689891 -9.306245352234214e-19 6.1225267615822506e-17 1
		 1 1 yes;
	setAttr ".xm[573]" -type "matrix" "xform" 1 1 1 -1.8603876073842534e-14 2.8438902720610119e-08
		 -6.5248671624259742e-07 0 13.884102093160053 -2.6645352591003757e-15 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[574]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[575]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[576]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[577]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[578]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[579]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[580]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[581]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[582]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[583]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[584]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[585]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[586]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[587]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[588]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[589]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[590]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[591]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[592]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[593]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[594]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[595]" -type "matrix" "xform" 1 1 1 0.23360810753218131 -0.40234061126456877
		 -0.43485044274246787 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.40087774203409404 -0.45290564647529907 -0.61013986385495111 0.51176445545533888 1
		 1 1 yes;
	setAttr ".xm[596]" -type "matrix" "xform" 1 1 1 -0.058003319898012974 0.72383020551935373
		 -0.079669027797594522 0 1.3245606951388027e-15 -3.2745507694276199e-14 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.47751416514246486 -0.38421895523508581 -0.54200896931834797 0.57496286289187049 1
		 1 1 yes;
	setAttr ".xm[597]" -type "matrix" "xform" 1 1 1 0.53200126771743783 0.0029727848858548088
		 0.010025488126381595 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.064989343048516224 -0.67638815196858926 -0.042556096839040547 0.73243732277135143 1
		 1 1 yes;
	setAttr ".xm[598]" -type "matrix" "xform" 1 1 1 -0.73566333107297788 -0.0022688543119592911
		 0.0043549249991153656 0 -3.2903313509358156e-06 0.00029968703239546812 0 0 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.10800905939387451 -0.52060676801724259 -0.12772602498256161 0.83725067854594493 1
		 1 1 yes;
	setAttr ".xm[599]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[600]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[601]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[602]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[603]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[604]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[605]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[606]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[607]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[608]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[609]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[610]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[611]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[612]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[613]" -type "matrix" "xform" 1 1 1 0.49834220988984118 0.30627952379061368
		 -0.52909698088640933 0 3.5527136788005009e-15 2.8421709430404007e-14 -3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[614]" -type "matrix" "xform" 1 1 1 -8.2840640233110677e-10 -2.0433946057473432e-07
		 -7.8271160943146079e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[615]" -type "matrix" "xform" 1 1 1 -1.664122574395709e-09 -2.0833728584711331e-07
		 -1.4960872611444271e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[616]" -type "matrix" "xform" 1 1 1 -4.4747798214463139e-09 -2.1481279191168167e-07
		 -3.4359190717270576e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[617]" -type "matrix" "xform" 1 1 1 -1.0361694732866221e-08 -2.2151459530258195e-07
		 -5.7974875983844382e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[618]" -type "matrix" "xform" 1 1 1 -1.7320393411859419e-08 -2.2502606366396108e-07
		 -6.3307502029031801e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[619]" -type "matrix" "xform" 1 1 1 -2.5445130220729105e-08 -2.2532170881614217e-07
		 -4.014963090252103e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[620]" -type "matrix" "xform" 1 1 1 -3.190568315011897e-08 -2.2289943559674655e-07
		 9.9402877218481709e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[621]" -type "matrix" "xform" 1 1 1 -3.6079726452084256e-08 -2.1926283188589039e-07
		 8.0179502415478777e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[622]" -type "matrix" "xform" 1 1 1 -3.7396839938730265e-08 -2.1537079319162405e-07
		 1.6010125581981647e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[623]" -type "matrix" "xform" 1 1 1 -3.6216028457075853e-08 -2.1266279747213787e-07
		 2.2657445523747539e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[624]" -type "matrix" "xform" 1 1 1 -3.4538128080462249e-08 -2.1165486210934367e-07
		 2.6389732584957976e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[625]" -type "matrix" "xform" 1 1 1 -3.367774831740739e-08 -2.1142378280090454e-07
		 2.7785074916686697e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[626]" -type "matrix" "xform" 1 1 1 -6.4834891247562247e-10 -2.025742260656978e-07
		 -6.1929112210620829e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[627]" -type "matrix" "xform" 1 1 1 -1.445557769773017e-09 -2.0185979906885197e-07
		 -1.3155000906206124e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[628]" -type "matrix" "xform" 1 1 1 -4.2411285983377584e-09 -1.997631357588286e-07
		 -3.2927039771929791e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[629]" -type "matrix" "xform" 1 1 1 -9.1443072315415327e-09 -1.9721820002506209e-07
		 -5.4537058067462486e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[630]" -type "matrix" "xform" 1 1 1 -1.6113930557458474e-08 -1.9536765121410154e-07
		 -6.3803359897679159e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[631]" -type "matrix" "xform" 1 1 1 -2.569099510587126e-08 -1.9554379646801572e-07
		 -3.8784512095213989e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[632]" -type "matrix" "xform" 1 1 1 -3.2663938161256452e-08 -1.9813898893499142e-07
		 1.874227962805391e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[633]" -type "matrix" "xform" 1 1 1 -3.658448467951151e-08 -2.0224406229853182e-07
		 9.434842533308028e-09 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[634]" -type "matrix" "xform" 1 1 1 -3.7450513623057725e-08 -2.0592254278816584e-07
		 1.5943511654662818e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[635]" -type "matrix" "xform" 1 1 1 -3.6906885292331896e-08 -2.0836109096952292e-07
		 2.0394194882311313e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[636]" -type "matrix" "xform" 1 1 1 -3.5721108749179831e-08 -2.1009830120158472e-07
		 2.4054550412573915e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[637]" -type "matrix" "xform" 1 1 1 -3.4551784760320525e-08 -2.1098125107312762e-07
		 2.6399085652106398e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[638]" -type "matrix" "xform" 1 1 1 -3.3677749901210003e-08 -2.1142377802617302e-07
		 2.7785076246352328e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1
		 1 1 yes;
	setAttr ".xm[639]" -type "matrix" "xform" 1 1 1 6.283185307139437 -1.691866915670064e-10
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1.0275841211271339e-07 0 0.99999999999999467 1
		 1 1 yes;
	setAttr ".xm[640]" -type "matrix" "xform" 1 1 1 6.2831834777536537 -7.6260061262469617e-06
		 -6.2831870313297804 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[641]" -type "matrix" "xform" 1 1 1 6.283192743436123 -2.4064184400022912e-05
		 -6.2831786216370435 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[642]" -type "matrix" "xform" 1 1 1 -9.4247607596253147 3.1416441391713117
		 3.1416058582721185 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[643]" -type "matrix" "xform" 1 1 1 -3.1415612628268654 3.1416730457082229
		 3.141610217482913 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[644]" -type "matrix" "xform" 1 1 1 -3.141565465772318 3.1416722639098977
		 3.1416025906685041 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[645]" -type "matrix" "xform" 1 1 1 -3.1415723290649904 3.1416376445391214
		 3.1415958561675876 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[646]" -type "matrix" "xform" 1 1 1 1.7425805181374886e-05 6.2831825452840677
		 -5.4245412396542647e-07 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[647]" -type "matrix" "xform" 1 1 1 1.2693526097136423e-05 6.283214088528303
		 -2.8122587644200276e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[648]" -type "matrix" "xform" 1 1 1 1.5381657927121628e-05 6.2832188663890669
		 -6.5651340723563942e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[649]" -type "matrix" "xform" 1 1 1 8.3656757013608564e-06 6.2832054104990904
		 -5.2010808494964904e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[650]" -type "matrix" "xform" 1 1 1 5.4110698190280008e-06 6.2831907162611085
		 -4.1141251738219395e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[651]" -type "matrix" "xform" 1 1 1 5.4871734328989679e-08 6.2831855193676329
		 2.424508580468098e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[652]" -type "matrix" "xform" 1 1 1 6.283185307139437 2.0534763752778872e-07
		 -6.283185307217936 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[653]" -type "matrix" "xform" 1 1 1 6.2831857368727118 -9.6775282638451468e-07
		 -6.2831849161452924 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[654]" -type "matrix" "xform" 1 1 1 6.2831870256632865 -2.7747909729560291e-06
		 -6.2831839729904075 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[655]" -type "matrix" "xform" 1 1 1 6.2831887525327561 -3.4914099042060667e-06
		 -6.2831832523585769 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[656]" -type "matrix" "xform" 1 1 1 6.283186499846197 -7.6909015776679209e-07
		 -6.2831848349460371 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[657]" -type "matrix" "xform" 1 1 1 6.2831814995216435 2.1715219251396469e-05
		 -6.2831858857056826 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[658]" -type "matrix" "xform" 1 1 1 6.2831550232537685 6.9571799983719759e-05
		 1.7396942165332526e-06 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[659]" -type "matrix" "xform" 1 1 1 6.2831297046218744 0.00011709473560854273
		 1.4350585037239655e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[660]" -type "matrix" "xform" 1 1 1 6.2831124886687117 0.00013760109368610648
		 3.1022076281352182e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[661]" -type "matrix" "xform" 1 1 1 6.2831085925143197 0.00013233797747792705
		 4.2422124632536497e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[662]" -type "matrix" "xform" 1 1 1 6.2831274499323984 9.9294363699924888e-05
		 3.8927715753699082e-05 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[663]" -type "matrix" "xform" 1 1 1 12.566339093615564 5.3566477875247642e-05
		 6.2832094222993158 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[664]" -type "matrix" "xform" 1 1 1 5.4871726338854156e-08 6.2831855193676382
		 2.4252473123899102e-11 0 7.1054273576010019e-15 2.8421709430404007e-14 3.5527136788005009e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[665]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[666]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[667]" -type "matrix" "xform" 1 1 1 -5.9834680001711395e-09 6.1297348175798586e-10
		 2.9696373512327469e-10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.29491121738262233 -0.78941577506998695 -0.22136537116205757 -0.49076214236922971 1
		 1 1 yes;
	setAttr ".xm[668]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[669]" -type "matrix" "xform" 0.99999988079071045 1 1 0.16168690515675491
		 1.1886835758738338e-15 6.5014699993595287e-17 0 0 1.4210854715202004e-14 -7.1054273576010019e-15 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.64957844548541277 -0.31610924763916659 0.67361757392455257 -0.15608379421885649 1
		 1 1 yes;
	setAttr ".xm[670]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[671]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[672]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[673]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[674]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[675]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[676]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[677]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[678]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[679]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[680]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[681]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[682]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[683]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[684]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[685]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[686]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[687]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[688]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[689]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[690]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[691]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[692]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[693]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[694]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[695]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[696]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[697]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[698]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[699]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[700]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[701]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[702]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[703]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[704]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[705]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[706]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[707]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[708]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[709]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[710]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[711]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[712]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[713]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[714]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[715]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[716]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[717]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[718]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[719]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[720]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[721]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[722]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[723]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[724]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[725]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[726]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[727]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[728]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[729]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[730]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[731]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[732]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[733]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[734]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[735]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[736]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[737]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[738]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[739]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[740]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[741]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[742]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[743]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[744]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[745]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[746]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[747]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[748]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[749]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[750]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[751]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[752]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[753]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[754]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[755]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[756]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[757]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[758]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[759]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[760]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[761]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[762]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[763]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[764]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[765]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[766]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[767]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[768]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[769]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[770]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[771]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[772]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[773]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[774]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[775]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[776]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[777]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[778]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[779]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[780]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[781]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[782]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[783]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[784]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[785]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[786]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[787]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[788]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[789]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[790]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[791]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[792]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[793]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[794]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[795]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[796]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[797]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[798]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[799]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[800]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[801]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[802]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[803]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[804]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[805]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[806]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[807]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[808]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[809]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[810]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[811]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[812]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[813]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[814]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[815]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[816]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[817]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[818]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[819]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[820]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[821]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[822]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[823]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[824]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[825]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[826]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[827]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[828]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[829]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[830]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[831]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[832]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[833]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[834]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[835]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[836]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[837]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[838]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[839]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[840]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[841]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[842]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[843]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[844]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[845]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[846]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[847]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[848]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[849]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[850]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[851]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[852]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[853]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[854]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[855]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[856]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[857]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[858]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[859]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[860]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[861]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[862]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[863]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[864]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[865]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[866]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[867]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[868]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[869]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[870]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[871]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[872]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[873]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[874]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[875]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[876]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[877]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[878]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[879]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[880]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[881]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[882]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[883]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[884]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[885]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[886]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[887]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[888]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[889]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[890]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[891]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[892]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[893]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[894]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[895]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[896]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[897]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[898]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[899]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[900]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[901]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[902]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[903]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[904]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[905]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[906]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[907]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[908]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[909]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[910]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[911]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[912]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[913]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[914]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[915]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[916]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[917]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[918]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[919]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[920]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[921]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[922]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[923]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[924]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[925]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[926]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[927]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[928]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[929]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[930]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[931]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[932]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[933]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[934]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[935]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[936]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[937]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[938]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[939]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[940]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[941]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[942]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[943]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[944]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[945]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[946]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[947]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[948]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[949]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[950]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[951]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[952]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[953]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834 8.5018797557623316e-15
		 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[954]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[955]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[956]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597 3.2751579226442118e-15
		 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[957]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[958]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[959]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[960]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168 -7.5638110974551864e-07
		 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[961]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202 -1.6903145549918008e-14
		 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[962]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976 -2.0261570199409107e-15
		 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[963]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[964]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573 -2.5118795932144167e-15
		 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1.0767006564407353e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[965]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765 -1.5184901946962981e-14
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1.4140166495197922e-08 0 0 0.99999999999999989 1
		 1 1 yes;
	setAttr ".xm[966]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338 6.9575421812739791e-15
		 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[967]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[968]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[969]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414 7.1991024253037494e-17
		 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[970]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[971]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608 1.9078976679770543e-15
		 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[972]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874 -1.021405182655144e-14
		 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[973]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[974]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[975]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[976]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[977]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[978]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784 1.3322676295501878e-15
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[979]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152 3.8302694349567901e-15
		 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[980]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731 8.8817841970012523e-15
		 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[981]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354 0.00031340591683348684
		 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 no;
	setAttr ".xm[982]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326 4.2835938450307663e-17
		 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[983]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[984]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227 -3.6970426720017713e-14
		 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[985]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201 -3.219646771412954e-15
		 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[986]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695 -1.7541523789077473e-14
		 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[987]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229 4.2188474935755949e-15
		 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[988]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078 6.6613381477509392e-15
		 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[989]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741 -9.8809849191638932e-15
		 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[990]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262 -1.021405182655144e-14
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[991]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741 -1.8429702208777599e-14
		 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[992]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[993]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818 -2.3592239273284576e-15
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[994]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437 -3.8746783559417963e-14
		 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[995]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974 3.6415315207705135e-14
		 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[996]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422 3.9065972678997696e-15
		 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[997]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713 2.298161660974074e-14
		 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[998]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466 1.0519363158323358e-14
		 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[999]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693 -6.2077079587830042e-15
		 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1000]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834
		 8.5018797557623316e-15 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1001]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[1002]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[1003]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597
		 3.2751579226442118e-15 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1004]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1005]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1006]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1007]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168
		 -7.5638110974551864e-07 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1008]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202
		 -1.6903145549918008e-14 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1009]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976
		 -2.0261570199409107e-15 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[1010]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1011]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573
		 -2.5118795932144167e-15 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-1.0767006564407353e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1012]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765
		 -1.5184901946962981e-14 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1013]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338
		 6.9575421812739791e-15 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1014]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1015]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152
		 3.8302694349567901e-15 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1016]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414
		 7.1991024253037494e-17 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1017]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1018]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608
		 1.9078976679770543e-15 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1019]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874
		 -1.021405182655144e-14 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1020]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[1021]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1022]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1023]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1024]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1025]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1026]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152
		 3.8302694349567901e-15 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1027]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731
		 8.8817841970012523e-15 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1028]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354
		 0.00031340591683348684 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 no;
	setAttr ".xm[1029]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326
		 4.2835938450307663e-17 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1030]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1031]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227
		 -3.6970426720017713e-14 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1032]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201
		 -3.219646771412954e-15 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1033]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695
		 -1.7541523789077473e-14 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1034]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229
		 4.2188474935755949e-15 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1035]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078
		 6.6613381477509392e-15 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1036]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741
		 -9.8809849191638932e-15 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1037]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262
		 -1.021405182655144e-14 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1038]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741
		 -1.8429702208777599e-14 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1039]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1040]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818
		 -2.3592239273284576e-15 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1041]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437
		 -3.8746783559417963e-14 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1042]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974
		 3.6415315207705135e-14 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[1043]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422
		 3.9065972678997696e-15 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1044]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713
		 2.298161660974074e-14 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1045]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466
		 1.0519363158323358e-14 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1046]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693
		 -6.2077079587830042e-15 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1047]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834
		 8.5018797557623316e-15 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1048]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[1049]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[1050]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597
		 3.2751579226442118e-15 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1051]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1052]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1053]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1054]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168
		 -7.5638110974551864e-07 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1055]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202
		 -1.6903145549918008e-14 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1056]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1428001608988976
		 -2.0261570199409107e-15 -2.491062911502695e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[1057]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1058]" -type "matrix" "xform" 1 1 1 0 0 0 0 1.6834114516420573
		 -2.5118795932144167e-15 -7.3552275381416621e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		-1.0767006564407353e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1059]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.0871390931996765
		 -1.5184901946962981e-14 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1060]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.3693037739038338
		 6.9575421812739791e-15 1.4415552085367267e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1061]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1062]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152
		 3.8302694349567901e-15 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1063]" -type "matrix" "xform" 1 1 1 0 0 0 0 11.415358161696414
		 7.1991024253037494e-17 -1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1064]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.6255433631835761
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1065]" -type "matrix" "xform" 1 1 1 0 0 0 0 6.2837258922446608
		 1.9078976679770543e-15 -1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1066]" -type "matrix" "xform" 1 1 1 0 0 0 0 -7.227192487341874
		 -1.021405182655144e-14 -5.6843418860808015e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1067]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.1428001608988723
		 -1.5543122344752192e-15 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.0911509194582554e-07 9.3247721897139286e-07 -4.2459822129081784e-07 0.99999999999946909 1
		 1 1 yes;
	setAttr ".xm[1068]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3770568740290798
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1069]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.6834114516420442
		 0 -3.0215606239281101e-08 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1070]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.0871390931996743
		 1.4210854715202004e-14 7.1054273576010019e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		1.4140166495197922e-08 0 0 0.99999999999999989 1 1 1 yes;
	setAttr ".xm[1071]" -type "matrix" "xform" 1 1 1 0 0 0 0 -2.3693037739038303
		 -1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1072]" -type "matrix" "xform" 1 1 1 0 0 0 0 15.219772817836784
		 1.3322676295501878e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1073]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.8460926743687152
		 3.8302694349567901e-15 4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1074]" -type "matrix" "xform" 1 1 1 0 0 0 0 7.2271924873418731
		 8.8817841970012523e-15 2.8421709430404007e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1075]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.103525764304354
		 0.00031340591683348684 -3.1442930792988761e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 no;
	setAttr ".xm[1076]" -type "matrix" "xform" 1 1 1 0 0 0 0 9.3415973268166326
		 4.2835938450307663e-17 1.4210854715202004e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1077]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.019183203021349 -2.0150547896946591e-14
		 8.4376949871511897e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1078]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.2148653839803227
		 -3.6970426720017713e-14 -4.4408920985006262e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1079]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.9929845915987201
		 -3.219646771412954e-15 -4.4408920985006262e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1080]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.1948391219356695
		 -1.7541523789077473e-14 -7.7715611723760958e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1081]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6857639723016229
		 4.2188474935755949e-15 1.1102230246251565e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1082]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.6385882870626078
		 6.6613381477509392e-15 5.6066262743570405e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1083]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4781855070791741
		 -9.8809849191638932e-15 -6.2172489379008766e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1084]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.4630398254118262
		 -1.021405182655144e-14 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1085]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.6740447598569741
		 -1.8429702208777599e-14 2.2204460492503131e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1086]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.415445288790055 4.8849813083506888e-15
		 -2.4980018054066022e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1087]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.5001546600535818
		 -2.3592239273284576e-15 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1088]" -type "matrix" "xform" 1 1 1 0 0 0 0 3.8378792688954437
		 -3.8746783559417963e-14 -6.106226635438361e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1089]" -type "matrix" "xform" 1 1 1 0 0 0 0 5.2305486517220974
		 3.6415315207705135e-14 -1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0.17231473267297617 -0.54707951064823634 0.24609181724412563 0.78131329146393713 1
		 1 1 yes;
	setAttr ".xm[1090]" -type "matrix" "xform" 1 1 1 0 0 0 0 18.930921929127422
		 3.9065972678997696e-15 2.2204460492503131e-16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1091]" -type "matrix" "xform" 1 1 1 0 0 0 0 2.1603497201071713
		 2.298161660974074e-14 -2.7061686225238191e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1092]" -type "matrix" "xform" 1 1 1 0 0 0 0 16.270007727035466
		 1.0519363158323358e-14 1.1102230246251565e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1093]" -type "matrix" "xform" 1 1 1 0 0 0 0 13.717093346974693
		 -6.2077079587830042e-15 1.5543122344752192e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1094]" -type "matrix" "xform" 1 1 1 0 0 0 0 14.105238910167834
		 8.5018797557623316e-15 -4.8849813083506888e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1095]" -type "matrix" "xform" 1 1 1 5.4167041143197322e-10 -0.27471495752535452
		 -2.0284912547036648e-09 0 23.365614380122395 5.530248139568414 -1.4855105870943132e-07 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.23349572414088948 -0.66744269177804449 0.66744269177804449 0.23349572414088948 1
		 1 1 yes;
	setAttr ".xm[1096]" -type "matrix" "xform" 1 1 1 0 -1.0755285551056204e-16 0 0 10.563390829596983
		 8.0349685642987922e-08 -0.046552117208761956 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0.015251496810226962 0 0.99988368915841785 1 1 1 yes;
	setAttr ".xm[1097]" -type "matrix" "xform" 1 1 1 0 0 0 0 4.9281280990951597
		 3.2751579226442118e-15 7.3309414094779868e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1098]" -type "matrix" "xform" 1 1 1 0 0 0 0 -4.9281280990951561
		 -7.1054273576010019e-15 -2.1316282072803006e-14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1099]" -type "matrix" "xform" 1 1 1 1.5703565285946943 -0.212452793193489
		 -2.6748777800623031 0 -5.9294127433773554 -2.9719846967053272 1.4166414112870029 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1100]" -type "matrix" "xform" 1 1 1 -2.2551405187698492e-16 -4.6620693416877068e-18
		 -3.3125086874863374e-16 0 6.782156749631838 -0.0070044851983253054 -0.015925858144290927 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1101]" -type "matrix" "xform" 1 1 1 0 0 0 0 -8.579846047389168
		 -7.5638110974551864e-07 -5.3290705182007514e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr ".xm[1102]" -type "matrix" "xform" 1 1 1 0 0 0 0 8.5798608203891202
		 -1.6903145549918008e-14 5.2839677078253544e-15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 
		0 0 0 1 1 1 1 yes;
	setAttr -s 147 ".m";
	setAttr -s 424 ".p";
	setAttr -s 122 ".g";
	setAttr ".g[0]" yes;
	setAttr ".g[1]" yes;
	setAttr ".g[2]" yes;
	setAttr ".g[8]" yes;
	setAttr ".g[9]" yes;
	setAttr ".g[10]" yes;
	setAttr ".g[34]" yes;
	setAttr ".g[35]" yes;
	setAttr ".g[44]" yes;
	setAttr ".g[45]" yes;
	setAttr ".g[46]" yes;
	setAttr ".g[70]" yes;
	setAttr ".g[71]" yes;
	setAttr ".g[80]" yes;
	setAttr ".g[91]" yes;
	setAttr ".g[95]" yes;
	setAttr ".g[157]" yes;
	setAttr ".g[158]" yes;
	setAttr ".g[159]" yes;
	setAttr ".g[160]" yes;
	setAttr ".g[161]" yes;
	setAttr ".g[170]" yes;
	setAttr ".g[171]" yes;
	setAttr ".g[172]" yes;
	setAttr ".g[173]" yes;
	setAttr ".g[174]" yes;
	setAttr ".g[175]" yes;
	setAttr ".g[176]" yes;
	setAttr ".g[177]" yes;
	setAttr ".g[178]" yes;
	setAttr ".g[179]" yes;
	setAttr ".g[180]" yes;
	setAttr ".g[181]" yes;
	setAttr ".g[182]" yes;
	setAttr ".g[183]" yes;
	setAttr ".g[184]" yes;
	setAttr ".g[185]" yes;
	setAttr ".g[186]" yes;
	setAttr ".g[187]" yes;
	setAttr ".g[188]" yes;
	setAttr ".g[189]" yes;
	setAttr ".g[190]" yes;
	setAttr ".g[191]" yes;
	setAttr ".g[192]" yes;
	setAttr ".g[193]" yes;
	setAttr ".g[194]" yes;
	setAttr ".g[195]" yes;
	setAttr ".g[196]" yes;
	setAttr ".g[197]" yes;
	setAttr ".g[198]" yes;
	setAttr ".g[199]" yes;
	setAttr ".g[200]" yes;
	setAttr ".g[201]" yes;
	setAttr ".g[202]" yes;
	setAttr ".g[203]" yes;
	setAttr ".g[204]" yes;
	setAttr ".g[205]" yes;
	setAttr ".g[206]" yes;
	setAttr ".g[207]" yes;
	setAttr ".g[235]" yes;
	setAttr ".g[242]" yes;
	setAttr ".g[249]" yes;
	setAttr ".g[561]" yes;
	setAttr ".g[568]" yes;
	setAttr ".g[595]" yes;
	setAttr ".g[596]" yes;
	setAttr ".g[597]" yes;
	setAttr ".g[598]" yes;
	setAttr ".g[613]" yes;
	setAttr ".g[614]" yes;
	setAttr ".g[615]" yes;
	setAttr ".g[616]" yes;
	setAttr ".g[617]" yes;
	setAttr ".g[618]" yes;
	setAttr ".g[619]" yes;
	setAttr ".g[620]" yes;
	setAttr ".g[621]" yes;
	setAttr ".g[622]" yes;
	setAttr ".g[623]" yes;
	setAttr ".g[624]" yes;
	setAttr ".g[625]" yes;
	setAttr ".g[626]" yes;
	setAttr ".g[627]" yes;
	setAttr ".g[628]" yes;
	setAttr ".g[629]" yes;
	setAttr ".g[630]" yes;
	setAttr ".g[631]" yes;
	setAttr ".g[632]" yes;
	setAttr ".g[633]" yes;
	setAttr ".g[634]" yes;
	setAttr ".g[635]" yes;
	setAttr ".g[636]" yes;
	setAttr ".g[637]" yes;
	setAttr ".g[638]" yes;
	setAttr ".g[639]" yes;
	setAttr ".g[640]" yes;
	setAttr ".g[641]" yes;
	setAttr ".g[642]" yes;
	setAttr ".g[643]" yes;
	setAttr ".g[644]" yes;
	setAttr ".g[645]" yes;
	setAttr ".g[646]" yes;
	setAttr ".g[647]" yes;
	setAttr ".g[648]" yes;
	setAttr ".g[649]" yes;
	setAttr ".g[650]" yes;
	setAttr ".g[651]" yes;
	setAttr ".g[652]" yes;
	setAttr ".g[653]" yes;
	setAttr ".g[654]" yes;
	setAttr ".g[655]" yes;
	setAttr ".g[656]" yes;
	setAttr ".g[657]" yes;
	setAttr ".g[658]" yes;
	setAttr ".g[659]" yes;
	setAttr ".g[660]" yes;
	setAttr ".g[661]" yes;
	setAttr ".g[662]" yes;
	setAttr ".g[663]" yes;
	setAttr ".g[664]" yes;
	setAttr ".g[667]" yes;
	setAttr ".g[669]" yes;
	setAttr ".bp" yes;
createNode blendShape -n "R_brow_main_blendShape";
	rename -uid "9D98E672-4834-096B-78D6-F59AD2B67BC9";
	addAttr -ci true -h true -sn "aal" -ln "attributeAliasList" -dt "attributeAlias";
	setAttr -s 3 ".w";
	setAttr -s 3 ".w";
	setAttr -s 3 ".it[0].itg";
	setAttr ".it[0].itg[0].iti[6000].ipt" -type "pointArray" 9 0 2.6192965139824764
		 0 1 0 2.4937522882146652 0 1 0 2.2420402761864864 0 1 0 2.2334838055830915 0 1 0
		 2.0078531100089094 0 1 0 1.863140151113555 0 1 0 1.672862473712371 0 1 0 1.5747835379461321
		 0 1 0 1.6328466617378297 0 1 ;
	setAttr ".it[0].itg[0].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].itg[1].iti[6000].ipt" -type "pointArray" 9 0 -1.0724038825396462
		 0 1 0 -1.2726549631173327 0 1 0 -1.5095596335188475 0 1 0 -1.7421696369995914 0 1 0
		 -1.9678013509062282 0 1 0 -2.0510314574392794 0 1 0 -1.8937372062247846 0 1 0 -1.5846664010179836
		 0 1 0 -1.4293977973910899 0 1 ;
	setAttr ".it[0].itg[1].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].itg[2].iti[6000].ipt" -type "pointArray" 9 0.71383593200519635
		 0.1412928443005228 0 1 0.71383593200519635 0.1412928443005228 0 1 0.55650998191398893
		 0 0 1 0.59713447101060657 0 0.11288426898269321 1 0.54966427201045054 0 0.12780640048653424
		 1 0.20019439396374494 0 0.066037454073622825 1 0.21468761498335098 0 0.14536522152558184
		 1 0.20015682955392666 0 0.31606291557640631 1 0.20015682955392666 0 0.31606291557640631
		 1 ;
	setAttr ".it[0].itg[2].iti[6000].ict" -type "componentList" 1 "cv[0:8]";
	setAttr ".it[0].siw" 1;
	setAttr ".mlid" 7;
	setAttr ".mlpr" 0;
	setAttr -s 3 ".pndr[0:2]"  0 0 0;
	setAttr -s 3 ".tgvs[0:2]" yes yes yes;
	setAttr -s 3 ".tpvs[0:2]" yes yes yes;
	setAttr ".tgdt[0].cid" -type "Int32Array" 3 0 1 2 ;
	setAttr ".aal" -type "attributeAlias" 6 "up" "weight[0]" "down" "weight[1]" "inner" "weight[2]" ;
createNode animCurveUU -n "R_brow_main_blendShape_up";
	rename -uid "7E41DD80-4E87-C728-C31B-408E5761648B";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  -1 0 0 0 1 1;
createNode animCurveUU -n "R_brow_main_blendShape_down";
	rename -uid "2504C47E-4CB2-A918-DA4F-A0A3D80E0D2D";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  -1 1 0 0 1 0;
createNode animCurveUU -n "R_brow_main_blendShape_inner";
	rename -uid "D9EECD38-4BD6-4870-A904-7F9A7747A845";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  -1 1 0 0;
createNode cluster -n "R_brow_curv_cluster";
	rename -uid "64E9792F-42B4-C54B-974E-C98B791D1594";
	setAttr ".ip[0].gtg" -type "string" "R_brow_curv_cluster";
	setAttr ".en" 0.99998998641967773;
	setAttr -s 2 ".wl[0].w";
	setAttr ".wl[0].w[1]" 0.5;
	setAttr ".wl[0].w[3]" 0.69999998807907104;
	setAttr ".gm[0]" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr ".ma" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode skinCluster -n "skinCluster64";
	rename -uid "46DBCDCD-4ABE-AA1B-8E96-E0BB9565F46F";
	setAttr -s 9 ".wl";
	setAttr ".wl[0:8].w"
		1 0 1
		2 0 0.77061329284296598 1 0.22938670715703402
		2 0 0.41481989091133398 1 0.58518010908866602
		2 0 0.14221169903996711 1 0.85778830096003289
		1 1 1
		2 1 0.79390449626730719 2 0.20609550373269284
		2 1 0.46937653522947909 2 0.53062346477052091
		2 1 0.1688402915345889 2 0.8311597084654111
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
createNode dagPose -n "bindPose40";
	rename -uid "B49908C1-4801-D390-979F-D587BE9029CD";
	setAttr -s 3 ".wm";
	setAttr -s 3 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 -1.1535200000000003 160.94300000000001
		 11.4543 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 6.123233995736766e-17 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 -2.5658541216885078e-49 -5.5511151231257827e-17
		 9.2444637330587321e-33 0 -3.8330099999999994 161.75800000000001 10.834300000000001 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.97891296090611868 -1.2508407005494076e-17 -0.2042777887339095 5.9941131210876813e-17 1
		 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 -5.1317082433770156e-48 3.3306690738754696e-16
		 -3.0814879110195774e-32 0 -6.037110000000002 161.61500000000004 9.0167000000000037 0
		 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -0.86352376889661464 -3.0879967500908018e-17 -0.50430814047622308 5.2875580978344897e-17 1
		 1 1 yes;
	setAttr -s 3 ".m";
	setAttr -s 3 ".p";
	setAttr ".bp" yes;
createNode pointMatrixMultDL -n "R_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "C5D12C91-48AF-530B-75CC-42B0AA107A1C";
createNode pointOnCurveInfo -n "R_brow_major_outer_control_pointOnCurveInfo";
	rename -uid "239634EF-4BB8-23CE-858E-72BE89B77690";
	setAttr ".pr" 1;
createNode pointMatrixMultDL -n "R_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "AF5FA819-48DF-DCD7-DA69-8E85C3593616";
createNode pointOnCurveInfo -n "R_brow_major_mid_control_pointOnCurveInfo";
	rename -uid "151D19C2-420A-61FF-E2DC-2988AB8B967B";
	setAttr ".pr" 0.49341457599857907;
createNode pointMatrixMultDL -n "R_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "9F58FC92-4A64-46C3-F0A8-3691ADF35C00";
createNode pointOnCurveInfo -n "R_brow_major_inner_control_pointOnCurveInfo";
	rename -uid "C7DDD39B-49D6-AFC3-DEB3-FC9C187B685E";
createNode pointMatrixMultDL -n "L_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "0B7A11C4-4415-06C0-64B3-70A7E59CDCD9";
createNode pointOnCurveInfo -n "L_brow_major_outer_control_pointOnCurveInfo";
	rename -uid "A36EE5AE-4BAF-D679-3EAA-39B590ED06A1";
	setAttr ".pr" 1;
createNode pointMatrixMultDL -n "L_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "A8BFCF76-4598-0B94-2104-6BB759130963";
createNode pointOnCurveInfo -n "L_brow_major_mid_control_pointOnCurveInfo";
	rename -uid "81F3A3F9-4485-B76A-7412-C78BCBA491D9";
	setAttr ".pr" 0.49341457599857902;
createNode pointMatrixMultDL -n "L_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL";
	rename -uid "15D0B211-477E-AF7D-EC4F-AE9FC882EEC4";
createNode pointOnCurveInfo -n "L_brow_major_inner_control_pointOnCurveInfo";
	rename -uid "AB1C7CD9-48CC-7CF5-1F64-AB945C1036FF";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "28E39CEC-4F09-282A-882F-6FBB3309CFBA";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode displayLayerManager -n "layerManager";
	rename -uid "F167892E-4731-5BF5-CF14-D6B2E1F49E05";
createNode displayLayer -n "defaultLayer";
	rename -uid "B91AB268-4C71-B40C-F933-38A8309F6C9A";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "FB8627CC-434E-17F7-7932-AEBDF3C28B17";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "9DC857DF-468D-382B-8CF9-6C9244293F04";
	setAttr ".g" yes;
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "14BB83AD-470D-62A5-B1F8-0AAB9A326447";
	setAttr ".bsdt[0].bscd" -type "Int32Array" 2 6 7 ;
	setAttr -s 2 ".bspr";
	setAttr -s 2 ".obsv";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "88F31AD8-4B48-F5AD-44A3-B2ADAA63ED8A";
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "D609B326-476E-091A-88EB-4CB49AB78F96";
	setAttr ".b" -type "string" "playbackOptions -min 0.625 -max 75 -ast 0.625 -aet 125 ";
	setAttr ".st" 6;
createNode transformGeometry -n "L_brow_tuner_curve_transformGeometry";
	rename -uid "F4D12637-4C9C-E0F9-47D9-34B49485183F";
	setAttr ".txf" -type "matrix" -1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode multMatrix -n "R_brow_main_control_parent_multMatrix";
	rename -uid "4DA5839B-438F-DBAF-E932-25924E988862";
	setAttr -s 2 ".i";
createNode nodeGraphEditorInfo -n "MayaNodeEditorSavedTabsInfo";
	rename -uid "BC50B395-4B35-FE38-1663-13A625D09ECE";
	setAttr ".tgi[0].tn" -type "string" "Untitled_1";
	setAttr ".tgi[0].vl" -type "double2" -832.14282407647238 -445.2380775459236 ;
	setAttr ".tgi[0].vh" -type "double2" 801.19044435402861 465.4761719798293 ;
	setAttr -s 6 ".tgi[0].ni";
	setAttr ".tgi[0].ni[0].x" -602.38092041015625;
	setAttr ".tgi[0].ni[0].y" 205.95237731933594;
	setAttr ".tgi[0].ni[0].nvs" 18304;
	setAttr ".tgi[0].ni[1].x" -407.38095092773438;
	setAttr ".tgi[0].ni[1].y" 7.1428561210632324;
	setAttr ".tgi[0].ni[1].nvs" 18304;
	setAttr ".tgi[0].ni[2].x" -228.57142639160156;
	setAttr ".tgi[0].ni[2].y" -53.571426391601562;
	setAttr ".tgi[0].ni[2].nvs" 18304;
	setAttr ".tgi[0].ni[3].x" -108.57142639160156;
	setAttr ".tgi[0].ni[3].y" 108.57142639160156;
	setAttr ".tgi[0].ni[3].nvs" 18304;
	setAttr ".tgi[0].ni[4].x" -291.66665649414062;
	setAttr ".tgi[0].ni[4].y" 439.28570556640625;
	setAttr ".tgi[0].ni[4].nvs" 18305;
	setAttr ".tgi[0].ni[5].x" 127.38095092773438;
	setAttr ".tgi[0].ni[5].y" 389.28570556640625;
	setAttr ".tgi[0].ni[5].nvs" 18306;
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
select -ne :defaultRenderingList1;
	setAttr -av -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
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
connectAttr "L_brow_main_tuner.m" "L_brow_main_control.opm";
connectAttr "L_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.o" "L_brow_major_inner_control_transform.t"
		;
connectAttr "L_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.o" "L_brow_major_mid_control_transform.t"
		;
connectAttr "L_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.o" "L_brow_major_outer_control_transform.t"
		;
connectAttr "L_brow_curv_control_pointConstraint1.ctx" "L_brow_curv_control_transform.tx"
		;
connectAttr "L_brow_curv_control_pointConstraint1.cty" "L_brow_curv_control_transform.ty"
		;
connectAttr "L_brow_curv_control_pointConstraint1.ctz" "L_brow_curv_control_transform.tz"
		;
connectAttr "L_brow_curv_control.t" "L_brow_curv_transform.t";
connectAttr "L_brow_curv_control.r" "L_brow_curv_transform.r";
connectAttr "L_brow_curv_control.s" "L_brow_curv_transform.s";
connectAttr "L_brow_curv_control_transform.pim" "L_brow_curv_control_pointConstraint1.cpim"
		;
connectAttr "L_brow_curv_control_transform.rp" "L_brow_curv_control_pointConstraint1.crp"
		;
connectAttr "L_brow_curv_control_transform.rpt" "L_brow_curv_control_pointConstraint1.crt"
		;
connectAttr "L_brow_major_mid_control.t" "L_brow_curv_control_pointConstraint1.tg[0].tt"
		;
connectAttr "L_brow_major_mid_control.rp" "L_brow_curv_control_pointConstraint1.tg[0].trp"
		;
connectAttr "L_brow_major_mid_control.rpt" "L_brow_curv_control_pointConstraint1.tg[0].trt"
		;
connectAttr "L_brow_major_mid_control.pm" "L_brow_curv_control_pointConstraint1.tg[0].tpm"
		;
connectAttr "L_brow_curv_control_pointConstraint1.w0" "L_brow_curv_control_pointConstraint1.tg[0].tw"
		;
connectAttr "L_brow_major_inner_control.t" "L_brow_curv_control_pointConstraint1.tg[1].tt"
		;
connectAttr "L_brow_major_inner_control.rp" "L_brow_curv_control_pointConstraint1.tg[1].trp"
		;
connectAttr "L_brow_major_inner_control.rpt" "L_brow_curv_control_pointConstraint1.tg[1].trt"
		;
connectAttr "L_brow_major_inner_control.pm" "L_brow_curv_control_pointConstraint1.tg[1].tpm"
		;
connectAttr "L_brow_curv_control_pointConstraint1.w1" "L_brow_curv_control_pointConstraint1.tg[1].tw"
		;
connectAttr "R_brow_main_control_parent_multMatrix.o" "R_brow_main_control.opm";
connectAttr "R_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.o" "R_brow_major_inner_control_transform.t"
		;
connectAttr "L_brow_major_inner_control_transform.r" "R_brow_major_inner_control_transform.r"
		;
connectAttr "R_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.o" "R_brow_major_mid_control_transform.t"
		;
connectAttr "L_brow_major_mid_control_transform.r" "R_brow_major_mid_control_transform.r"
		;
connectAttr "R_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.o" "R_brow_major_outer_control_transform.t"
		;
connectAttr "L_brow_major_outer_control_transform.r" "R_brow_major_outer_control_transform.r"
		;
connectAttr "R_brow_curv_control_pointConstraint1.ctx" "R_brow_curv_control_transform.tx"
		;
connectAttr "R_brow_curv_control_pointConstraint1.cty" "R_brow_curv_control_transform.ty"
		;
connectAttr "R_brow_curv_control_pointConstraint1.ctz" "R_brow_curv_control_transform.tz"
		;
connectAttr "L_brow_curv_control_transform.r" "R_brow_curv_control_transform.r";
connectAttr "R_brow_curv_control.t" "R_brow_curv_transform.t";
connectAttr "R_brow_curv_control.r" "R_brow_curv_transform.r";
connectAttr "R_brow_curv_control.s" "R_brow_curv_transform.s";
connectAttr "R_brow_curv_control_transform.pim" "R_brow_curv_control_pointConstraint1.cpim"
		;
connectAttr "R_brow_curv_control_transform.rp" "R_brow_curv_control_pointConstraint1.crp"
		;
connectAttr "R_brow_curv_control_transform.rpt" "R_brow_curv_control_pointConstraint1.crt"
		;
connectAttr "R_brow_major_inner_control.t" "R_brow_curv_control_pointConstraint1.tg[0].tt"
		;
connectAttr "R_brow_major_inner_control.rp" "R_brow_curv_control_pointConstraint1.tg[0].trp"
		;
connectAttr "R_brow_major_inner_control.rpt" "R_brow_curv_control_pointConstraint1.tg[0].trt"
		;
connectAttr "R_brow_major_inner_control.pm" "R_brow_curv_control_pointConstraint1.tg[0].tpm"
		;
connectAttr "R_brow_curv_control_pointConstraint1.w0" "R_brow_curv_control_pointConstraint1.tg[0].tw"
		;
connectAttr "R_brow_major_mid_control.t" "R_brow_curv_control_pointConstraint1.tg[1].tt"
		;
connectAttr "R_brow_major_mid_control.rp" "R_brow_curv_control_pointConstraint1.tg[1].trp"
		;
connectAttr "R_brow_major_mid_control.rpt" "R_brow_curv_control_pointConstraint1.tg[1].trt"
		;
connectAttr "R_brow_major_mid_control.pm" "R_brow_curv_control_pointConstraint1.tg[1].tpm"
		;
connectAttr "R_brow_curv_control_pointConstraint1.w1" "R_brow_curv_control_pointConstraint1.tg[1].tw"
		;
connectAttr "L_brow_curv_control_pointConstraint1.o" "R_brow_curv_control_pointConstraint1.o"
		;
connectAttr "L_brow_main_blendShape.og[0]" "L_brow_main_curveShape.cr";
connectAttr "L_brow_tuner_curveShape.l" "L_brow_main_curveShapeOrig1.cr";
connectAttr "L_brow_curv_cluster.og[0]" "L_brow_major_curveShape.cr";
connectAttr "L_brow_main_curveShape.ws" "L_brow_major_curveShapeOrig.cr";
connectAttr "R_brow_main_blendShape.og[0]" "R_brow_main_curveShape.cr";
connectAttr "L_brow_tuner_curve_transformGeometry.og" "R_brow_main_curveShapeOrig2.cr"
		;
connectAttr "R_brow_curv_cluster.og[0]" "R_brow_major_curveShape.cr";
connectAttr "R_brow_main_curveShape.ws" "R_brow_major_curveShapeOrig1.cr";
connectAttr "L_brow_curve_wire.og[0]" "L_brow_curveShape.cr";
connectAttr "L_brow_tuner_curveShape.l" "L_brow_mid_curveBaseWireShape.cr";
connectAttr "R_brow_curve_wire.og[0]" "R_brow_curveShape.cr";
connectAttr "L_brow_tuner_curve_transformGeometry.og" "R_brow_major_curveBaseWireShape.cr"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.ctx" "L_brow_major_inner_joint.tx"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.cty" "L_brow_major_inner_joint.ty"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.ctz" "L_brow_major_inner_joint.tz"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.crx" "L_brow_major_inner_joint.rx"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.cry" "L_brow_major_inner_joint.ry"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.crz" "L_brow_major_inner_joint.rz"
		;
connectAttr "L_brow_major_inner_joint.ro" "L_brow_major_inner_joint_parentConstraint1.cro"
		;
connectAttr "L_brow_major_inner_joint.pim" "L_brow_major_inner_joint_parentConstraint1.cpim"
		;
connectAttr "L_brow_major_inner_joint.rp" "L_brow_major_inner_joint_parentConstraint1.crp"
		;
connectAttr "L_brow_major_inner_joint.rpt" "L_brow_major_inner_joint_parentConstraint1.crt"
		;
connectAttr "L_brow_major_inner_joint.jo" "L_brow_major_inner_joint_parentConstraint1.cjo"
		;
connectAttr "L_brow_major_inner_control.t" "L_brow_major_inner_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_brow_major_inner_control.rp" "L_brow_major_inner_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_brow_major_inner_control.rpt" "L_brow_major_inner_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_brow_major_inner_control.r" "L_brow_major_inner_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_brow_major_inner_control.ro" "L_brow_major_inner_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_brow_major_inner_control.s" "L_brow_major_inner_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_brow_major_inner_control.pm" "L_brow_major_inner_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_brow_major_inner_joint_parentConstraint1.w0" "L_brow_major_inner_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.ctx" "L_brow_major_mid_joint.tx"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.cty" "L_brow_major_mid_joint.ty"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.ctz" "L_brow_major_mid_joint.tz"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.crx" "L_brow_major_mid_joint.rx"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.cry" "L_brow_major_mid_joint.ry"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.crz" "L_brow_major_mid_joint.rz"
		;
connectAttr "L_brow_major_mid_control.s" "L_brow_major_mid_joint.s";
connectAttr "L_brow_major_mid_joint.ro" "L_brow_major_mid_joint_parentConstraint1.cro"
		;
connectAttr "L_brow_major_mid_joint.pim" "L_brow_major_mid_joint_parentConstraint1.cpim"
		;
connectAttr "L_brow_major_mid_joint.rp" "L_brow_major_mid_joint_parentConstraint1.crp"
		;
connectAttr "L_brow_major_mid_joint.rpt" "L_brow_major_mid_joint_parentConstraint1.crt"
		;
connectAttr "L_brow_major_mid_joint.jo" "L_brow_major_mid_joint_parentConstraint1.cjo"
		;
connectAttr "L_brow_major_mid_control.t" "L_brow_major_mid_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_brow_major_mid_control.rp" "L_brow_major_mid_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_brow_major_mid_control.rpt" "L_brow_major_mid_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_brow_major_mid_control.r" "L_brow_major_mid_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_brow_major_mid_control.ro" "L_brow_major_mid_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_brow_major_mid_control.s" "L_brow_major_mid_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_brow_major_mid_control.pm" "L_brow_major_mid_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_brow_major_mid_joint_parentConstraint1.w0" "L_brow_major_mid_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.ctx" "L_brow_major_outer_joint.tx"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.cty" "L_brow_major_outer_joint.ty"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.ctz" "L_brow_major_outer_joint.tz"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.crx" "L_brow_major_outer_joint.rx"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.cry" "L_brow_major_outer_joint.ry"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.crz" "L_brow_major_outer_joint.rz"
		;
connectAttr "L_brow_major_outer_joint.ro" "L_brow_major_outer_joint_parentConstraint1.cro"
		;
connectAttr "L_brow_major_outer_joint.pim" "L_brow_major_outer_joint_parentConstraint1.cpim"
		;
connectAttr "L_brow_major_outer_joint.rp" "L_brow_major_outer_joint_parentConstraint1.crp"
		;
connectAttr "L_brow_major_outer_joint.rpt" "L_brow_major_outer_joint_parentConstraint1.crt"
		;
connectAttr "L_brow_major_outer_joint.jo" "L_brow_major_outer_joint_parentConstraint1.cjo"
		;
connectAttr "L_brow_major_outer_control.t" "L_brow_major_outer_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "L_brow_major_outer_control.rp" "L_brow_major_outer_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "L_brow_major_outer_control.rpt" "L_brow_major_outer_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "L_brow_major_outer_control.r" "L_brow_major_outer_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "L_brow_major_outer_control.ro" "L_brow_major_outer_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "L_brow_major_outer_control.s" "L_brow_major_outer_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "L_brow_major_outer_control.pm" "L_brow_major_outer_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "L_brow_major_outer_joint_parentConstraint1.w0" "L_brow_major_outer_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.ctx" "R_brow_major_inner_joint.tx"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.cty" "R_brow_major_inner_joint.ty"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.ctz" "R_brow_major_inner_joint.tz"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.crx" "R_brow_major_inner_joint.rx"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.cry" "R_brow_major_inner_joint.ry"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.crz" "R_brow_major_inner_joint.rz"
		;
connectAttr "R_brow_major_inner_joint.ro" "R_brow_major_inner_joint_parentConstraint1.cro"
		;
connectAttr "R_brow_major_inner_joint.pim" "R_brow_major_inner_joint_parentConstraint1.cpim"
		;
connectAttr "R_brow_major_inner_joint.rp" "R_brow_major_inner_joint_parentConstraint1.crp"
		;
connectAttr "R_brow_major_inner_joint.rpt" "R_brow_major_inner_joint_parentConstraint1.crt"
		;
connectAttr "R_brow_major_inner_joint.jo" "R_brow_major_inner_joint_parentConstraint1.cjo"
		;
connectAttr "R_brow_major_inner_control.t" "R_brow_major_inner_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_brow_major_inner_control.rp" "R_brow_major_inner_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_brow_major_inner_control.rpt" "R_brow_major_inner_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_brow_major_inner_control.r" "R_brow_major_inner_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_brow_major_inner_control.ro" "R_brow_major_inner_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_brow_major_inner_control.s" "R_brow_major_inner_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_brow_major_inner_control.pm" "R_brow_major_inner_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_brow_major_inner_joint_parentConstraint1.w0" "R_brow_major_inner_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.ctx" "R_brow_major_mid_joint.tx"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.cty" "R_brow_major_mid_joint.ty"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.ctz" "R_brow_major_mid_joint.tz"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.crx" "R_brow_major_mid_joint.rx"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.cry" "R_brow_major_mid_joint.ry"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.crz" "R_brow_major_mid_joint.rz"
		;
connectAttr "R_brow_major_mid_joint.ro" "R_brow_major_mid_joint_parentConstraint1.cro"
		;
connectAttr "R_brow_major_mid_joint.pim" "R_brow_major_mid_joint_parentConstraint1.cpim"
		;
connectAttr "R_brow_major_mid_joint.rp" "R_brow_major_mid_joint_parentConstraint1.crp"
		;
connectAttr "R_brow_major_mid_joint.rpt" "R_brow_major_mid_joint_parentConstraint1.crt"
		;
connectAttr "R_brow_major_mid_joint.jo" "R_brow_major_mid_joint_parentConstraint1.cjo"
		;
connectAttr "R_brow_major_mid_control.t" "R_brow_major_mid_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_brow_major_mid_control.rp" "R_brow_major_mid_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_brow_major_mid_control.rpt" "R_brow_major_mid_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_brow_major_mid_control.r" "R_brow_major_mid_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_brow_major_mid_control.ro" "R_brow_major_mid_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_brow_major_mid_control.s" "R_brow_major_mid_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_brow_major_mid_control.pm" "R_brow_major_mid_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_brow_major_mid_joint_parentConstraint1.w0" "R_brow_major_mid_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.ctx" "R_brow_major_outer_joint.tx"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.cty" "R_brow_major_outer_joint.ty"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.ctz" "R_brow_major_outer_joint.tz"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.crx" "R_brow_major_outer_joint.rx"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.cry" "R_brow_major_outer_joint.ry"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.crz" "R_brow_major_outer_joint.rz"
		;
connectAttr "R_brow_major_outer_joint.ro" "R_brow_major_outer_joint_parentConstraint1.cro"
		;
connectAttr "R_brow_major_outer_joint.pim" "R_brow_major_outer_joint_parentConstraint1.cpim"
		;
connectAttr "R_brow_major_outer_joint.rp" "R_brow_major_outer_joint_parentConstraint1.crp"
		;
connectAttr "R_brow_major_outer_joint.rpt" "R_brow_major_outer_joint_parentConstraint1.crt"
		;
connectAttr "R_brow_major_outer_joint.jo" "R_brow_major_outer_joint_parentConstraint1.cjo"
		;
connectAttr "R_brow_major_outer_control.t" "R_brow_major_outer_joint_parentConstraint1.tg[0].tt"
		;
connectAttr "R_brow_major_outer_control.rp" "R_brow_major_outer_joint_parentConstraint1.tg[0].trp"
		;
connectAttr "R_brow_major_outer_control.rpt" "R_brow_major_outer_joint_parentConstraint1.tg[0].trt"
		;
connectAttr "R_brow_major_outer_control.r" "R_brow_major_outer_joint_parentConstraint1.tg[0].tr"
		;
connectAttr "R_brow_major_outer_control.ro" "R_brow_major_outer_joint_parentConstraint1.tg[0].tro"
		;
connectAttr "R_brow_major_outer_control.s" "R_brow_major_outer_joint_parentConstraint1.tg[0].ts"
		;
connectAttr "R_brow_major_outer_control.pm" "R_brow_major_outer_joint_parentConstraint1.tg[0].tpm"
		;
connectAttr "R_brow_major_outer_joint_parentConstraint1.w0" "R_brow_major_outer_joint_parentConstraint1.tg[0].tw"
		;
connectAttr "L_brow_main_tuner.t" "R_brow_main_tuner.t";
connectAttr "L_brow_main_tuner.r" "R_brow_main_tuner.r";
connectAttr "L_brow_main_tuner.s" "R_brow_main_tuner.s";
connectAttr "L_brow_curveShapeOrig.ws" "L_brow_curve_wire.ip[0].ig";
connectAttr "L_brow_curveShapeOrig.l" "L_brow_curve_wire.orggeom[0]";
connectAttr "L_brow_mid_curveBaseWireShape.ws" "L_brow_curve_wire.bw[0]";
connectAttr "L_brow_major_curveShape.ws" "L_brow_curve_wire.dw[0]";
connectAttr "R_brow_curveShapeOrig1.ws" "R_brow_curve_wire.ip[0].ig";
connectAttr "R_brow_curveShapeOrig1.l" "R_brow_curve_wire.orggeom[0]";
connectAttr "R_brow_major_curveBaseWireShape.ws" "R_brow_curve_wire.bw[0]";
connectAttr "R_brow_major_curveShape.ws" "R_brow_curve_wire.dw[0]";
connectAttr "L_brow_main_curveShapeOrig1.ws" "L_brow_main_blendShape.ip[0].ig";
connectAttr "L_brow_main_curveShapeOrig1.l" "L_brow_main_blendShape.orggeom[0]";
connectAttr "L_brow_main_blendShape_up.o" "L_brow_main_blendShape.w[0]";
connectAttr "L_brow_main_blendShape_down.o" "L_brow_main_blendShape.w[1]";
connectAttr "L_brow_main_blendShape_inner.o" "L_brow_main_blendShape.w[2]";
connectAttr "shapeEditorManager.obsv[6]" "L_brow_main_blendShape.tgdt[0].dpvs";
connectAttr "L_brow_main_control.ty" "L_brow_main_blendShape_up.i";
connectAttr "L_brow_main_control.ty" "L_brow_main_blendShape_down.i";
connectAttr "L_brow_main_control.tx" "L_brow_main_blendShape_inner.i";
connectAttr "skinCluster60.og[0]" "L_brow_curv_cluster.ip[0].ig";
connectAttr "L_brow_main_curveShapeOrig1.l" "L_brow_curv_cluster.orggeom[0]";
connectAttr "L_brow_curv_transform.m" "L_brow_curv_cluster.wt";
connectAttr "L_brow_curv_compensation_transform.wim" "L_brow_curv_cluster.post";
connectAttr "L_brow_curv_compensation_transform.wm" "L_brow_curv_cluster.pre";
connectAttr "L_brow_major_curveShapeOrig.ws" "skinCluster60.ip[0].ig";
connectAttr "L_brow_major_curveShapeOrig.l" "skinCluster60.orggeom[0]";
connectAttr "bindPose36.msg" "skinCluster60.bp";
connectAttr "L_brow_major_inner_joint.wm" "skinCluster60.ma[0]";
connectAttr "L_brow_major_mid_joint.wm" "skinCluster60.ma[1]";
connectAttr "L_brow_major_outer_joint.wm" "skinCluster60.ma[2]";
connectAttr "L_brow_major_inner_joint.liw" "skinCluster60.lw[0]";
connectAttr "L_brow_major_mid_joint.liw" "skinCluster60.lw[1]";
connectAttr "L_brow_major_outer_joint.liw" "skinCluster60.lw[2]";
connectAttr "L_brow_major_inner_joint.obcc" "skinCluster60.ifcl[0]";
connectAttr "L_brow_major_mid_joint.obcc" "skinCluster60.ifcl[1]";
connectAttr "L_brow_major_outer_joint.obcc" "skinCluster60.ifcl[2]";
connectAttr "L_brow_major_inner_joint_basis.wim" "skinCluster60.pm[0]";
connectAttr "L_brow_major_mid_joint_basis.wim" "skinCluster60.pm[1]";
connectAttr "L_brow_major_outer_joint_basis.wim" "skinCluster60.pm[2]";
connectAttr "L_brow_major_inner_joint.msg" "bindPose36.m[0]";
connectAttr "L_brow_major_mid_joint.msg" "bindPose36.m[1]";
connectAttr "L_brow_major_outer_joint.msg" "bindPose36.m[2]";
connectAttr "bindPose36.w" "bindPose36.p[0]";
connectAttr "bindPose36.w" "bindPose36.p[1]";
connectAttr "bindPose36.w" "bindPose36.p[2]";
connectAttr "L_brow_major_inner_joint.bps" "bindPose36.wm[0]";
connectAttr "L_brow_major_mid_joint.bps" "bindPose36.wm[1]";
connectAttr "L_brow_major_outer_joint.bps" "bindPose36.wm[2]";
connectAttr "L_brow_major_inner_joint.msg" "bindPose16.m[488]";
connectAttr "L_brow_major_mid_joint.msg" "bindPose16.m[489]";
connectAttr "L_brow_major_outer_joint.msg" "bindPose16.m[490]";
connectAttr "R_brow_major_inner_joint.msg" "bindPose16.m[491]";
connectAttr "R_brow_major_mid_joint.msg" "bindPose16.m[492]";
connectAttr "R_brow_major_outer_joint.msg" "bindPose16.m[493]";
connectAttr "bindPose16.w" "bindPose16.p[0]";
connectAttr "bindPose16.m[0]" "bindPose16.p[1]";
connectAttr "bindPose16.m[1]" "bindPose16.p[2]";
connectAttr "bindPose16.w" "bindPose16.p[3]";
connectAttr "bindPose16.m[3]" "bindPose16.p[4]";
connectAttr "bindPose16.m[4]" "bindPose16.p[5]";
connectAttr "bindPose16.w" "bindPose16.p[6]";
connectAttr "bindPose16.m[6]" "bindPose16.p[7]";
connectAttr "bindPose16.w" "bindPose16.p[8]";
connectAttr "bindPose16.m[8]" "bindPose16.p[9]";
connectAttr "bindPose16.w" "bindPose16.p[10]";
connectAttr "bindPose16.m[10]" "bindPose16.p[11]";
connectAttr "bindPose16.w" "bindPose16.p[12]";
connectAttr "bindPose16.m[12]" "bindPose16.p[13]";
connectAttr "bindPose16.w" "bindPose16.p[14]";
connectAttr "bindPose16.m[14]" "bindPose16.p[15]";
connectAttr "bindPose16.m[510]" "bindPose16.p[16]";
connectAttr "bindPose16.w" "bindPose16.p[17]";
connectAttr "bindPose16.m[31]" "bindPose16.p[33]";
connectAttr "bindPose16.m[30]" "bindPose16.p[34]";
connectAttr "bindPose16.m[28]" "bindPose16.p[35]";
connectAttr "bindPose16.m[38]" "bindPose16.p[40]";
connectAttr "bindPose16.m[37]" "bindPose16.p[41]";
connectAttr "bindPose16.m[36]" "bindPose16.p[42]";
connectAttr "bindPose16.m[35]" "bindPose16.p[43]";
connectAttr "bindPose16.m[45]" "bindPose16.p[47]";
connectAttr "bindPose16.m[44]" "bindPose16.p[48]";
connectAttr "bindPose16.m[43]" "bindPose16.p[49]";
connectAttr "bindPose16.m[28]" "bindPose16.p[50]";
connectAttr "bindPose16.m[28]" "bindPose16.p[51]";
connectAttr "bindPose16.m[28]" "bindPose16.p[52]";
connectAttr "bindPose16.m[28]" "bindPose16.p[53]";
connectAttr "bindPose16.m[28]" "bindPose16.p[54]";
connectAttr "bindPose16.m[56]" "bindPose16.p[58]";
connectAttr "bindPose16.m[55]" "bindPose16.p[59]";
connectAttr "bindPose16.m[54]" "bindPose16.p[60]";
connectAttr "bindPose16.m[28]" "bindPose16.p[61]";
connectAttr "bindPose16.m[63]" "bindPose16.p[65]";
connectAttr "bindPose16.m[62]" "bindPose16.p[66]";
connectAttr "bindPose16.m[61]" "bindPose16.p[67]";
connectAttr "bindPose16.m[28]" "bindPose16.p[68]";
connectAttr "bindPose16.m[27]" "bindPose16.p[69]";
connectAttr "bindPose16.m[69]" "bindPose16.p[71]";
connectAttr "bindPose16.m[27]" "bindPose16.p[72]";
connectAttr "bindPose16.m[27]" "bindPose16.p[73]";
connectAttr "bindPose16.m[27]" "bindPose16.p[74]";
connectAttr "bindPose16.m[74]" "bindPose16.p[76]";
connectAttr "bindPose16.m[26]" "bindPose16.p[78]";
connectAttr "bindPose16.m[78]" "bindPose16.p[80]";
connectAttr "bindPose16.m[78]" "bindPose16.p[81]";
connectAttr "bindPose16.m[78]" "bindPose16.p[82]";
connectAttr "bindPose16.m[26]" "bindPose16.p[83]";
connectAttr "bindPose16.m[26]" "bindPose16.p[84]";
connectAttr "bindPose16.m[84]" "bindPose16.p[86]";
connectAttr "bindPose16.m[26]" "bindPose16.p[87]";
connectAttr "bindPose16.m[87]" "bindPose16.p[89]";
connectAttr "bindPose16.m[89]" "bindPose16.p[91]";
connectAttr "bindPose16.m[25]" "bindPose16.p[93]";
connectAttr "bindPose16.m[24]" "bindPose16.p[95]";
connectAttr "bindPose16.m[101]" "bindPose16.p[103]";
connectAttr "bindPose16.m[100]" "bindPose16.p[104]";
connectAttr "bindPose16.m[98]" "bindPose16.p[105]";
connectAttr "bindPose16.m[108]" "bindPose16.p[110]";
connectAttr "bindPose16.m[107]" "bindPose16.p[111]";
connectAttr "bindPose16.m[106]" "bindPose16.p[112]";
connectAttr "bindPose16.m[105]" "bindPose16.p[113]";
connectAttr "bindPose16.m[115]" "bindPose16.p[117]";
connectAttr "bindPose16.m[114]" "bindPose16.p[118]";
connectAttr "bindPose16.m[113]" "bindPose16.p[119]";
connectAttr "bindPose16.m[98]" "bindPose16.p[120]";
connectAttr "bindPose16.m[98]" "bindPose16.p[121]";
connectAttr "bindPose16.m[98]" "bindPose16.p[122]";
connectAttr "bindPose16.m[98]" "bindPose16.p[123]";
connectAttr "bindPose16.m[98]" "bindPose16.p[124]";
connectAttr "bindPose16.m[126]" "bindPose16.p[128]";
connectAttr "bindPose16.m[125]" "bindPose16.p[129]";
connectAttr "bindPose16.m[124]" "bindPose16.p[130]";
connectAttr "bindPose16.m[98]" "bindPose16.p[131]";
connectAttr "bindPose16.m[133]" "bindPose16.p[135]";
connectAttr "bindPose16.m[132]" "bindPose16.p[136]";
connectAttr "bindPose16.m[131]" "bindPose16.p[137]";
connectAttr "bindPose16.m[98]" "bindPose16.p[138]";
connectAttr "bindPose16.m[97]" "bindPose16.p[139]";
connectAttr "bindPose16.m[139]" "bindPose16.p[141]";
connectAttr "bindPose16.m[97]" "bindPose16.p[142]";
connectAttr "bindPose16.m[97]" "bindPose16.p[143]";
connectAttr "bindPose16.m[97]" "bindPose16.p[144]";
connectAttr "bindPose16.m[144]" "bindPose16.p[146]";
connectAttr "bindPose16.m[96]" "bindPose16.p[148]";
connectAttr "bindPose16.m[148]" "bindPose16.p[150]";
connectAttr "bindPose16.m[148]" "bindPose16.p[151]";
connectAttr "bindPose16.m[148]" "bindPose16.p[152]";
connectAttr "bindPose16.m[96]" "bindPose16.p[153]";
connectAttr "bindPose16.m[96]" "bindPose16.p[154]";
connectAttr "bindPose16.m[154]" "bindPose16.p[156]";
connectAttr "bindPose16.m[95]" "bindPose16.p[157]";
connectAttr "bindPose16.m[24]" "bindPose16.p[159]";
connectAttr "bindPose16.m[160]" "bindPose16.p[176]";
connectAttr "bindPose16.m[160]" "bindPose16.p[177]";
connectAttr "bindPose16.m[160]" "bindPose16.p[178]";
connectAttr "bindPose16.m[160]" "bindPose16.p[191]";
connectAttr "bindPose16.m[160]" "bindPose16.p[197]";
connectAttr "bindPose16.m[160]" "bindPose16.p[204]";
connectAttr "bindPose16.m[160]" "bindPose16.p[209]";
connectAttr "bindPose16.m[160]" "bindPose16.p[215]";
connectAttr "bindPose16.m[160]" "bindPose16.p[219]";
connectAttr "bindPose16.m[160]" "bindPose16.p[223]";
connectAttr "bindPose16.m[160]" "bindPose16.p[229]";
connectAttr "bindPose16.m[160]" "bindPose16.p[235]";
connectAttr "bindPose16.m[160]" "bindPose16.p[240]";
connectAttr "bindPose16.m[160]" "bindPose16.p[246]";
connectAttr "bindPose16.m[160]" "bindPose16.p[250]";
connectAttr "bindPose16.m[160]" "bindPose16.p[255]";
connectAttr "bindPose16.m[160]" "bindPose16.p[260]";
connectAttr "bindPose16.m[160]" "bindPose16.p[268]";
connectAttr "bindPose16.m[160]" "bindPose16.p[269]";
connectAttr "bindPose16.m[160]" "bindPose16.p[270]";
connectAttr "bindPose16.m[160]" "bindPose16.p[272]";
connectAttr "bindPose16.m[160]" "bindPose16.p[274]";
connectAttr "bindPose16.m[160]" "bindPose16.p[275]";
connectAttr "bindPose16.m[160]" "bindPose16.p[276]";
connectAttr "bindPose16.m[160]" "bindPose16.p[277]";
connectAttr "bindPose16.m[160]" "bindPose16.p[278]";
connectAttr "bindPose16.m[160]" "bindPose16.p[279]";
connectAttr "bindPose16.m[160]" "bindPose16.p[280]";
connectAttr "bindPose16.m[160]" "bindPose16.p[281]";
connectAttr "bindPose16.m[160]" "bindPose16.p[282]";
connectAttr "bindPose16.m[160]" "bindPose16.p[283]";
connectAttr "bindPose16.m[160]" "bindPose16.p[284]";
connectAttr "bindPose16.m[160]" "bindPose16.p[285]";
connectAttr "bindPose16.m[160]" "bindPose16.p[286]";
connectAttr "bindPose16.m[160]" "bindPose16.p[287]";
connectAttr "bindPose16.m[160]" "bindPose16.p[288]";
connectAttr "bindPose16.m[160]" "bindPose16.p[289]";
connectAttr "bindPose16.m[160]" "bindPose16.p[290]";
connectAttr "bindPose16.m[160]" "bindPose16.p[291]";
connectAttr "bindPose16.m[160]" "bindPose16.p[292]";
connectAttr "bindPose16.m[160]" "bindPose16.p[293]";
connectAttr "bindPose16.m[160]" "bindPose16.p[294]";
connectAttr "bindPose16.m[160]" "bindPose16.p[295]";
connectAttr "bindPose16.m[160]" "bindPose16.p[296]";
connectAttr "bindPose16.m[160]" "bindPose16.p[297]";
connectAttr "bindPose16.m[160]" "bindPose16.p[298]";
connectAttr "bindPose16.m[160]" "bindPose16.p[299]";
connectAttr "bindPose16.m[160]" "bindPose16.p[300]";
connectAttr "bindPose16.m[160]" "bindPose16.p[301]";
connectAttr "bindPose16.m[160]" "bindPose16.p[302]";
connectAttr "bindPose16.m[160]" "bindPose16.p[303]";
connectAttr "bindPose16.m[160]" "bindPose16.p[304]";
connectAttr "bindPose16.m[160]" "bindPose16.p[305]";
connectAttr "bindPose16.m[160]" "bindPose16.p[306]";
connectAttr "bindPose16.m[160]" "bindPose16.p[307]";
connectAttr "bindPose16.m[160]" "bindPose16.p[308]";
connectAttr "bindPose16.m[160]" "bindPose16.p[309]";
connectAttr "bindPose16.m[160]" "bindPose16.p[310]";
connectAttr "bindPose16.m[160]" "bindPose16.p[311]";
connectAttr "bindPose16.m[160]" "bindPose16.p[312]";
connectAttr "bindPose16.m[160]" "bindPose16.p[313]";
connectAttr "bindPose16.m[160]" "bindPose16.p[314]";
connectAttr "bindPose16.m[160]" "bindPose16.p[315]";
connectAttr "bindPose16.m[160]" "bindPose16.p[316]";
connectAttr "bindPose16.m[160]" "bindPose16.p[317]";
connectAttr "bindPose16.m[160]" "bindPose16.p[318]";
connectAttr "bindPose16.m[160]" "bindPose16.p[319]";
connectAttr "bindPose16.m[160]" "bindPose16.p[320]";
connectAttr "bindPose16.m[160]" "bindPose16.p[321]";
connectAttr "bindPose16.m[160]" "bindPose16.p[322]";
connectAttr "bindPose16.m[580]" "bindPose16.p[324]";
connectAttr "bindPose16.m[581]" "bindPose16.p[326]";
connectAttr "bindPose16.m[582]" "bindPose16.p[328]";
connectAttr "bindPose16.m[583]" "bindPose16.p[330]";
connectAttr "bindPose16.m[584]" "bindPose16.p[332]";
connectAttr "bindPose16.m[585]" "bindPose16.p[334]";
connectAttr "bindPose16.m[586]" "bindPose16.p[336]";
connectAttr "bindPose16.m[587]" "bindPose16.p[338]";
connectAttr "bindPose16.m[588]" "bindPose16.p[340]";
connectAttr "bindPose16.m[589]" "bindPose16.p[342]";
connectAttr "bindPose16.m[590]" "bindPose16.p[344]";
connectAttr "bindPose16.m[591]" "bindPose16.p[346]";
connectAttr "bindPose16.m[592]" "bindPose16.p[348]";
connectAttr "bindPose16.m[593]" "bindPose16.p[350]";
connectAttr "bindPose16.m[594]" "bindPose16.p[352]";
connectAttr "bindPose16.m[595]" "bindPose16.p[354]";
connectAttr "bindPose16.m[596]" "bindPose16.p[356]";
connectAttr "bindPose16.m[597]" "bindPose16.p[358]";
connectAttr "bindPose16.m[598]" "bindPose16.p[360]";
connectAttr "bindPose16.m[599]" "bindPose16.p[362]";
connectAttr "bindPose16.m[600]" "bindPose16.p[364]";
connectAttr "bindPose16.m[601]" "bindPose16.p[366]";
connectAttr "bindPose16.m[602]" "bindPose16.p[368]";
connectAttr "bindPose16.m[603]" "bindPose16.p[370]";
connectAttr "bindPose16.m[604]" "bindPose16.p[372]";
connectAttr "bindPose16.m[605]" "bindPose16.p[374]";
connectAttr "bindPose16.m[322]" "bindPose16.p[375]";
connectAttr "bindPose16.m[322]" "bindPose16.p[376]";
connectAttr "bindPose16.m[322]" "bindPose16.p[377]";
connectAttr "bindPose16.m[322]" "bindPose16.p[378]";
connectAttr "bindPose16.m[322]" "bindPose16.p[379]";
connectAttr "bindPose16.m[322]" "bindPose16.p[380]";
connectAttr "bindPose16.m[322]" "bindPose16.p[381]";
connectAttr "bindPose16.m[322]" "bindPose16.p[382]";
connectAttr "bindPose16.m[322]" "bindPose16.p[383]";
connectAttr "bindPose16.m[322]" "bindPose16.p[384]";
connectAttr "bindPose16.m[322]" "bindPose16.p[385]";
connectAttr "bindPose16.m[322]" "bindPose16.p[386]";
connectAttr "bindPose16.m[322]" "bindPose16.p[387]";
connectAttr "bindPose16.m[322]" "bindPose16.p[388]";
connectAttr "bindPose16.m[322]" "bindPose16.p[389]";
connectAttr "bindPose16.m[322]" "bindPose16.p[390]";
connectAttr "bindPose16.m[322]" "bindPose16.p[391]";
connectAttr "bindPose16.m[322]" "bindPose16.p[392]";
connectAttr "bindPose16.m[322]" "bindPose16.p[393]";
connectAttr "bindPose16.m[322]" "bindPose16.p[394]";
connectAttr "bindPose16.m[322]" "bindPose16.p[395]";
connectAttr "bindPose16.m[160]" "bindPose16.p[396]";
connectAttr "bindPose16.m[606]" "bindPose16.p[398]";
connectAttr "bindPose16.m[607]" "bindPose16.p[400]";
connectAttr "bindPose16.m[608]" "bindPose16.p[402]";
connectAttr "bindPose16.m[609]" "bindPose16.p[404]";
connectAttr "bindPose16.m[610]" "bindPose16.p[406]";
connectAttr "bindPose16.m[611]" "bindPose16.p[408]";
connectAttr "bindPose16.m[612]" "bindPose16.p[410]";
connectAttr "bindPose16.m[613]" "bindPose16.p[412]";
connectAttr "bindPose16.m[614]" "bindPose16.p[414]";
connectAttr "bindPose16.m[615]" "bindPose16.p[416]";
connectAttr "bindPose16.m[616]" "bindPose16.p[418]";
connectAttr "bindPose16.m[617]" "bindPose16.p[420]";
connectAttr "bindPose16.m[618]" "bindPose16.p[422]";
connectAttr "bindPose16.m[619]" "bindPose16.p[424]";
connectAttr "bindPose16.m[620]" "bindPose16.p[426]";
connectAttr "bindPose16.m[621]" "bindPose16.p[428]";
connectAttr "bindPose16.m[622]" "bindPose16.p[430]";
connectAttr "bindPose16.m[623]" "bindPose16.p[432]";
connectAttr "bindPose16.m[624]" "bindPose16.p[434]";
connectAttr "bindPose16.m[625]" "bindPose16.p[436]";
connectAttr "bindPose16.m[626]" "bindPose16.p[438]";
connectAttr "bindPose16.m[627]" "bindPose16.p[440]";
connectAttr "bindPose16.m[628]" "bindPose16.p[442]";
connectAttr "bindPose16.m[629]" "bindPose16.p[444]";
connectAttr "bindPose16.m[630]" "bindPose16.p[446]";
connectAttr "bindPose16.m[631]" "bindPose16.p[448]";
connectAttr "bindPose16.m[396]" "bindPose16.p[449]";
connectAttr "bindPose16.m[396]" "bindPose16.p[450]";
connectAttr "bindPose16.m[396]" "bindPose16.p[451]";
connectAttr "bindPose16.m[396]" "bindPose16.p[452]";
connectAttr "bindPose16.m[396]" "bindPose16.p[453]";
connectAttr "bindPose16.m[396]" "bindPose16.p[454]";
connectAttr "bindPose16.m[396]" "bindPose16.p[455]";
connectAttr "bindPose16.m[396]" "bindPose16.p[456]";
connectAttr "bindPose16.m[396]" "bindPose16.p[457]";
connectAttr "bindPose16.m[396]" "bindPose16.p[458]";
connectAttr "bindPose16.m[396]" "bindPose16.p[459]";
connectAttr "bindPose16.m[396]" "bindPose16.p[460]";
connectAttr "bindPose16.m[396]" "bindPose16.p[461]";
connectAttr "bindPose16.m[396]" "bindPose16.p[462]";
connectAttr "bindPose16.m[396]" "bindPose16.p[463]";
connectAttr "bindPose16.m[396]" "bindPose16.p[464]";
connectAttr "bindPose16.m[396]" "bindPose16.p[465]";
connectAttr "bindPose16.m[396]" "bindPose16.p[466]";
connectAttr "bindPose16.m[396]" "bindPose16.p[467]";
connectAttr "bindPose16.m[396]" "bindPose16.p[468]";
connectAttr "bindPose16.m[396]" "bindPose16.p[469]";
connectAttr "bindPose16.m[160]" "bindPose16.p[488]";
connectAttr "bindPose16.m[160]" "bindPose16.p[489]";
connectAttr "bindPose16.m[160]" "bindPose16.p[490]";
connectAttr "bindPose16.m[160]" "bindPose16.p[491]";
connectAttr "bindPose16.m[160]" "bindPose16.p[492]";
connectAttr "bindPose16.m[160]" "bindPose16.p[493]";
connectAttr "bindPose16.m[160]" "bindPose16.p[494]";
connectAttr "bindPose16.m[160]" "bindPose16.p[495]";
connectAttr "bindPose16.m[160]" "bindPose16.p[496]";
connectAttr "bindPose16.m[160]" "bindPose16.p[497]";
connectAttr "bindPose16.m[497]" "bindPose16.p[499]";
connectAttr "bindPose16.m[497]" "bindPose16.p[500]";
connectAttr "bindPose16.m[160]" "bindPose16.p[501]";
connectAttr "bindPose16.m[501]" "bindPose16.p[503]";
connectAttr "bindPose16.m[501]" "bindPose16.p[504]";
connectAttr "bindPose16.m[160]" "bindPose16.p[505]";
connectAttr "bindPose16.m[160]" "bindPose16.p[506]";
connectAttr "bindPose16.m[159]" "bindPose16.p[507]";
connectAttr "bindPose16.m[159]" "bindPose16.p[508]";
connectAttr "bindPose16.m[159]" "bindPose16.p[509]";
connectAttr "bindPose16.m[24]" "bindPose16.p[510]";
connectAttr "bindPose16.m[510]" "bindPose16.p[512]";
connectAttr "bindPose16.m[24]" "bindPose16.p[518]";
connectAttr "bindPose16.m[24]" "bindPose16.p[522]";
connectAttr "bindPose16.m[24]" "bindPose16.p[524]";
connectAttr "bindPose16.m[22]" "bindPose16.p[528]";
connectAttr "bindPose16.m[21]" "bindPose16.p[529]";
connectAttr "bindPose16.m[20]" "bindPose16.p[530]";
connectAttr "bindPose16.m[532]" "bindPose16.p[535]";
connectAttr "bindPose16.m[531]" "bindPose16.p[536]";
connectAttr "bindPose16.m[536]" "bindPose16.p[538]";
connectAttr "bindPose16.m[531]" "bindPose16.p[539]";
connectAttr "bindPose16.m[531]" "bindPose16.p[540]";
connectAttr "bindPose16.m[530]" "bindPose16.p[541]";
connectAttr "bindPose16.m[541]" "bindPose16.p[543]";
connectAttr "bindPose16.m[541]" "bindPose16.p[544]";
connectAttr "bindPose16.m[530]" "bindPose16.p[545]";
connectAttr "bindPose16.m[530]" "bindPose16.p[546]";
connectAttr "bindPose16.m[20]" "bindPose16.p[547]";
connectAttr "bindPose16.m[549]" "bindPose16.p[552]";
connectAttr "bindPose16.m[548]" "bindPose16.p[553]";
connectAttr "bindPose16.m[553]" "bindPose16.p[555]";
connectAttr "bindPose16.m[548]" "bindPose16.p[556]";
connectAttr "bindPose16.m[548]" "bindPose16.p[557]";
connectAttr "bindPose16.m[547]" "bindPose16.p[558]";
connectAttr "bindPose16.m[558]" "bindPose16.p[560]";
connectAttr "bindPose16.m[558]" "bindPose16.p[561]";
connectAttr "bindPose16.m[547]" "bindPose16.p[562]";
connectAttr "bindPose16.m[547]" "bindPose16.p[563]";
connectAttr "bindPose16.m[20]" "bindPose16.p[564]";
connectAttr "bindPose16.m[564]" "bindPose16.p[569]";
connectAttr "bindPose16.m[20]" "bindPose16.p[573]";
connectAttr "bindPose16.m[573]" "bindPose16.p[577]";
connectAttr "bindPose16.m[322]" "bindPose16.p[580]";
connectAttr "bindPose16.m[322]" "bindPose16.p[581]";
connectAttr "bindPose16.m[322]" "bindPose16.p[582]";
connectAttr "bindPose16.m[322]" "bindPose16.p[583]";
connectAttr "bindPose16.m[322]" "bindPose16.p[584]";
connectAttr "bindPose16.m[322]" "bindPose16.p[585]";
connectAttr "bindPose16.m[322]" "bindPose16.p[586]";
connectAttr "bindPose16.m[322]" "bindPose16.p[587]";
connectAttr "bindPose16.m[322]" "bindPose16.p[588]";
connectAttr "bindPose16.m[322]" "bindPose16.p[589]";
connectAttr "bindPose16.m[322]" "bindPose16.p[590]";
connectAttr "bindPose16.m[322]" "bindPose16.p[591]";
connectAttr "bindPose16.m[322]" "bindPose16.p[592]";
connectAttr "bindPose16.m[322]" "bindPose16.p[593]";
connectAttr "bindPose16.m[322]" "bindPose16.p[594]";
connectAttr "bindPose16.m[322]" "bindPose16.p[595]";
connectAttr "bindPose16.m[322]" "bindPose16.p[596]";
connectAttr "bindPose16.m[322]" "bindPose16.p[597]";
connectAttr "bindPose16.m[322]" "bindPose16.p[598]";
connectAttr "bindPose16.m[322]" "bindPose16.p[599]";
connectAttr "bindPose16.m[322]" "bindPose16.p[600]";
connectAttr "bindPose16.m[322]" "bindPose16.p[601]";
connectAttr "bindPose16.m[322]" "bindPose16.p[602]";
connectAttr "bindPose16.m[322]" "bindPose16.p[603]";
connectAttr "bindPose16.m[322]" "bindPose16.p[604]";
connectAttr "bindPose16.m[322]" "bindPose16.p[605]";
connectAttr "bindPose16.m[396]" "bindPose16.p[606]";
connectAttr "bindPose16.m[396]" "bindPose16.p[607]";
connectAttr "bindPose16.m[396]" "bindPose16.p[608]";
connectAttr "bindPose16.m[396]" "bindPose16.p[609]";
connectAttr "bindPose16.m[396]" "bindPose16.p[610]";
connectAttr "bindPose16.m[396]" "bindPose16.p[611]";
connectAttr "bindPose16.m[396]" "bindPose16.p[612]";
connectAttr "bindPose16.m[396]" "bindPose16.p[613]";
connectAttr "bindPose16.m[396]" "bindPose16.p[614]";
connectAttr "bindPose16.m[396]" "bindPose16.p[615]";
connectAttr "bindPose16.m[396]" "bindPose16.p[616]";
connectAttr "bindPose16.m[396]" "bindPose16.p[617]";
connectAttr "bindPose16.m[396]" "bindPose16.p[618]";
connectAttr "bindPose16.m[396]" "bindPose16.p[619]";
connectAttr "bindPose16.m[396]" "bindPose16.p[620]";
connectAttr "bindPose16.m[396]" "bindPose16.p[621]";
connectAttr "bindPose16.m[396]" "bindPose16.p[622]";
connectAttr "bindPose16.m[396]" "bindPose16.p[623]";
connectAttr "bindPose16.m[396]" "bindPose16.p[624]";
connectAttr "bindPose16.m[396]" "bindPose16.p[625]";
connectAttr "bindPose16.m[396]" "bindPose16.p[626]";
connectAttr "bindPose16.m[396]" "bindPose16.p[627]";
connectAttr "bindPose16.m[396]" "bindPose16.p[628]";
connectAttr "bindPose16.m[396]" "bindPose16.p[629]";
connectAttr "bindPose16.m[396]" "bindPose16.p[630]";
connectAttr "bindPose16.m[396]" "bindPose16.p[631]";
connectAttr "L_brow_major_inner_joint.bps" "bindPose16.wm[488]";
connectAttr "L_brow_major_mid_joint.bps" "bindPose16.wm[489]";
connectAttr "L_brow_major_outer_joint.bps" "bindPose16.wm[490]";
connectAttr "R_brow_major_inner_joint.bps" "bindPose16.wm[491]";
connectAttr "R_brow_major_mid_joint.bps" "bindPose16.wm[492]";
connectAttr "R_brow_major_outer_joint.bps" "bindPose16.wm[493]";
connectAttr "L_brow_major_inner_joint.msg" "bindPose20.m[471]";
connectAttr "L_brow_major_mid_joint.msg" "bindPose20.m[472]";
connectAttr "L_brow_major_outer_joint.msg" "bindPose20.m[473]";
connectAttr "R_brow_major_inner_joint.msg" "bindPose20.m[474]";
connectAttr "R_brow_major_mid_joint.msg" "bindPose20.m[475]";
connectAttr "R_brow_major_outer_joint.msg" "bindPose20.m[476]";
connectAttr "bindPose20.w" "bindPose20.p[0]";
connectAttr "bindPose20.w" "bindPose20.p[1]";
connectAttr "bindPose20.w" "bindPose20.p[2]";
connectAttr "bindPose20.w" "bindPose20.p[3]";
connectAttr "bindPose20.w" "bindPose20.p[4]";
connectAttr "bindPose20.w" "bindPose20.p[5]";
connectAttr "bindPose20.m[156]" "bindPose20.p[6]";
connectAttr "bindPose20.w" "bindPose20.p[7]";
connectAttr "bindPose20.w" "bindPose20.p[8]";
connectAttr "bindPose20.w" "bindPose20.p[9]";
connectAttr "bindPose20.w" "bindPose20.p[10]";
connectAttr "bindPose20.w" "bindPose20.p[11]";
connectAttr "bindPose20.w" "bindPose20.p[12]";
connectAttr "bindPose20.w" "bindPose20.p[13]";
connectAttr "bindPose20.m[27]" "bindPose20.p[29]";
connectAttr "bindPose20.m[26]" "bindPose20.p[30]";
connectAttr "bindPose20.m[24]" "bindPose20.p[31]";
connectAttr "bindPose20.m[34]" "bindPose20.p[36]";
connectAttr "bindPose20.m[33]" "bindPose20.p[37]";
connectAttr "bindPose20.m[32]" "bindPose20.p[38]";
connectAttr "bindPose20.m[31]" "bindPose20.p[39]";
connectAttr "bindPose20.m[41]" "bindPose20.p[43]";
connectAttr "bindPose20.m[40]" "bindPose20.p[44]";
connectAttr "bindPose20.m[39]" "bindPose20.p[45]";
connectAttr "bindPose20.m[24]" "bindPose20.p[46]";
connectAttr "bindPose20.m[24]" "bindPose20.p[47]";
connectAttr "bindPose20.m[24]" "bindPose20.p[48]";
connectAttr "bindPose20.m[24]" "bindPose20.p[49]";
connectAttr "bindPose20.m[24]" "bindPose20.p[50]";
connectAttr "bindPose20.m[52]" "bindPose20.p[54]";
connectAttr "bindPose20.m[51]" "bindPose20.p[55]";
connectAttr "bindPose20.m[50]" "bindPose20.p[56]";
connectAttr "bindPose20.m[24]" "bindPose20.p[57]";
connectAttr "bindPose20.m[59]" "bindPose20.p[61]";
connectAttr "bindPose20.m[58]" "bindPose20.p[62]";
connectAttr "bindPose20.m[57]" "bindPose20.p[63]";
connectAttr "bindPose20.m[24]" "bindPose20.p[64]";
connectAttr "bindPose20.m[23]" "bindPose20.p[65]";
connectAttr "bindPose20.m[65]" "bindPose20.p[67]";
connectAttr "bindPose20.m[23]" "bindPose20.p[68]";
connectAttr "bindPose20.m[23]" "bindPose20.p[69]";
connectAttr "bindPose20.m[23]" "bindPose20.p[70]";
connectAttr "bindPose20.m[70]" "bindPose20.p[72]";
connectAttr "bindPose20.m[22]" "bindPose20.p[74]";
connectAttr "bindPose20.m[74]" "bindPose20.p[76]";
connectAttr "bindPose20.m[74]" "bindPose20.p[77]";
connectAttr "bindPose20.m[74]" "bindPose20.p[78]";
connectAttr "bindPose20.m[22]" "bindPose20.p[79]";
connectAttr "bindPose20.m[22]" "bindPose20.p[80]";
connectAttr "bindPose20.m[80]" "bindPose20.p[82]";
connectAttr "bindPose20.m[22]" "bindPose20.p[83]";
connectAttr "bindPose20.m[83]" "bindPose20.p[85]";
connectAttr "bindPose20.m[85]" "bindPose20.p[87]";
connectAttr "bindPose20.m[21]" "bindPose20.p[89]";
connectAttr "bindPose20.m[20]" "bindPose20.p[91]";
connectAttr "bindPose20.m[97]" "bindPose20.p[99]";
connectAttr "bindPose20.m[96]" "bindPose20.p[100]";
connectAttr "bindPose20.m[94]" "bindPose20.p[101]";
connectAttr "bindPose20.m[104]" "bindPose20.p[106]";
connectAttr "bindPose20.m[103]" "bindPose20.p[107]";
connectAttr "bindPose20.m[102]" "bindPose20.p[108]";
connectAttr "bindPose20.m[101]" "bindPose20.p[109]";
connectAttr "bindPose20.m[111]" "bindPose20.p[113]";
connectAttr "bindPose20.m[110]" "bindPose20.p[114]";
connectAttr "bindPose20.m[109]" "bindPose20.p[115]";
connectAttr "bindPose20.m[94]" "bindPose20.p[116]";
connectAttr "bindPose20.m[94]" "bindPose20.p[117]";
connectAttr "bindPose20.m[94]" "bindPose20.p[118]";
connectAttr "bindPose20.m[94]" "bindPose20.p[119]";
connectAttr "bindPose20.m[94]" "bindPose20.p[120]";
connectAttr "bindPose20.m[122]" "bindPose20.p[124]";
connectAttr "bindPose20.m[121]" "bindPose20.p[125]";
connectAttr "bindPose20.m[120]" "bindPose20.p[126]";
connectAttr "bindPose20.m[94]" "bindPose20.p[127]";
connectAttr "bindPose20.m[129]" "bindPose20.p[131]";
connectAttr "bindPose20.m[128]" "bindPose20.p[132]";
connectAttr "bindPose20.m[127]" "bindPose20.p[133]";
connectAttr "bindPose20.m[94]" "bindPose20.p[134]";
connectAttr "bindPose20.m[93]" "bindPose20.p[135]";
connectAttr "bindPose20.m[135]" "bindPose20.p[137]";
connectAttr "bindPose20.m[93]" "bindPose20.p[138]";
connectAttr "bindPose20.m[93]" "bindPose20.p[139]";
connectAttr "bindPose20.m[93]" "bindPose20.p[140]";
connectAttr "bindPose20.m[140]" "bindPose20.p[142]";
connectAttr "bindPose20.m[92]" "bindPose20.p[144]";
connectAttr "bindPose20.m[144]" "bindPose20.p[146]";
connectAttr "bindPose20.m[144]" "bindPose20.p[147]";
connectAttr "bindPose20.m[144]" "bindPose20.p[148]";
connectAttr "bindPose20.m[92]" "bindPose20.p[149]";
connectAttr "bindPose20.m[92]" "bindPose20.p[150]";
connectAttr "bindPose20.m[150]" "bindPose20.p[152]";
connectAttr "bindPose20.m[91]" "bindPose20.p[153]";
connectAttr "bindPose20.m[20]" "bindPose20.p[155]";
connectAttr "bindPose20.m[156]" "bindPose20.p[172]";
connectAttr "bindPose20.m[156]" "bindPose20.p[173]";
connectAttr "bindPose20.m[156]" "bindPose20.p[174]";
connectAttr "bindPose20.m[156]" "bindPose20.p[187]";
connectAttr "bindPose20.m[156]" "bindPose20.p[193]";
connectAttr "bindPose20.m[156]" "bindPose20.p[200]";
connectAttr "bindPose20.m[156]" "bindPose20.p[205]";
connectAttr "bindPose20.m[156]" "bindPose20.p[211]";
connectAttr "bindPose20.m[156]" "bindPose20.p[215]";
connectAttr "bindPose20.m[156]" "bindPose20.p[219]";
connectAttr "bindPose20.m[156]" "bindPose20.p[225]";
connectAttr "bindPose20.m[156]" "bindPose20.p[231]";
connectAttr "bindPose20.m[156]" "bindPose20.p[236]";
connectAttr "bindPose20.m[156]" "bindPose20.p[242]";
connectAttr "bindPose20.m[156]" "bindPose20.p[246]";
connectAttr "bindPose20.m[156]" "bindPose20.p[251]";
connectAttr "bindPose20.m[156]" "bindPose20.p[256]";
connectAttr "bindPose20.m[156]" "bindPose20.p[264]";
connectAttr "bindPose20.m[0]" "bindPose20.p[265]";
connectAttr "bindPose20.m[5]" "bindPose20.p[266]";
connectAttr "bindPose20.m[156]" "bindPose20.p[267]";
connectAttr "bindPose20.m[156]" "bindPose20.p[268]";
connectAttr "bindPose20.m[156]" "bindPose20.p[269]";
connectAttr "bindPose20.m[156]" "bindPose20.p[270]";
connectAttr "bindPose20.m[156]" "bindPose20.p[271]";
connectAttr "bindPose20.m[156]" "bindPose20.p[272]";
connectAttr "bindPose20.m[156]" "bindPose20.p[273]";
connectAttr "bindPose20.m[156]" "bindPose20.p[274]";
connectAttr "bindPose20.m[156]" "bindPose20.p[275]";
connectAttr "bindPose20.m[156]" "bindPose20.p[276]";
connectAttr "bindPose20.m[156]" "bindPose20.p[277]";
connectAttr "bindPose20.m[156]" "bindPose20.p[278]";
connectAttr "bindPose20.m[156]" "bindPose20.p[279]";
connectAttr "bindPose20.m[156]" "bindPose20.p[280]";
connectAttr "bindPose20.m[156]" "bindPose20.p[281]";
connectAttr "bindPose20.m[156]" "bindPose20.p[282]";
connectAttr "bindPose20.m[156]" "bindPose20.p[283]";
connectAttr "bindPose20.m[156]" "bindPose20.p[284]";
connectAttr "bindPose20.m[156]" "bindPose20.p[285]";
connectAttr "bindPose20.m[156]" "bindPose20.p[286]";
connectAttr "bindPose20.m[156]" "bindPose20.p[287]";
connectAttr "bindPose20.m[156]" "bindPose20.p[288]";
connectAttr "bindPose20.m[156]" "bindPose20.p[289]";
connectAttr "bindPose20.m[156]" "bindPose20.p[290]";
connectAttr "bindPose20.m[156]" "bindPose20.p[291]";
connectAttr "bindPose20.m[156]" "bindPose20.p[292]";
connectAttr "bindPose20.m[156]" "bindPose20.p[293]";
connectAttr "bindPose20.m[156]" "bindPose20.p[294]";
connectAttr "bindPose20.m[156]" "bindPose20.p[295]";
connectAttr "bindPose20.m[156]" "bindPose20.p[296]";
connectAttr "bindPose20.m[156]" "bindPose20.p[297]";
connectAttr "bindPose20.m[156]" "bindPose20.p[298]";
connectAttr "bindPose20.m[156]" "bindPose20.p[299]";
connectAttr "bindPose20.m[156]" "bindPose20.p[300]";
connectAttr "bindPose20.m[156]" "bindPose20.p[301]";
connectAttr "bindPose20.m[156]" "bindPose20.p[302]";
connectAttr "bindPose20.m[156]" "bindPose20.p[303]";
connectAttr "bindPose20.m[156]" "bindPose20.p[304]";
connectAttr "bindPose20.m[156]" "bindPose20.p[305]";
connectAttr "bindPose20.m[305]" "bindPose20.p[358]";
connectAttr "bindPose20.m[305]" "bindPose20.p[359]";
connectAttr "bindPose20.m[305]" "bindPose20.p[360]";
connectAttr "bindPose20.m[305]" "bindPose20.p[361]";
connectAttr "bindPose20.m[305]" "bindPose20.p[362]";
connectAttr "bindPose20.m[305]" "bindPose20.p[363]";
connectAttr "bindPose20.m[305]" "bindPose20.p[364]";
connectAttr "bindPose20.m[305]" "bindPose20.p[365]";
connectAttr "bindPose20.m[305]" "bindPose20.p[366]";
connectAttr "bindPose20.m[305]" "bindPose20.p[367]";
connectAttr "bindPose20.m[305]" "bindPose20.p[368]";
connectAttr "bindPose20.m[305]" "bindPose20.p[369]";
connectAttr "bindPose20.m[305]" "bindPose20.p[370]";
connectAttr "bindPose20.m[305]" "bindPose20.p[371]";
connectAttr "bindPose20.m[305]" "bindPose20.p[372]";
connectAttr "bindPose20.m[305]" "bindPose20.p[373]";
connectAttr "bindPose20.m[305]" "bindPose20.p[374]";
connectAttr "bindPose20.m[305]" "bindPose20.p[375]";
connectAttr "bindPose20.m[305]" "bindPose20.p[376]";
connectAttr "bindPose20.m[305]" "bindPose20.p[377]";
connectAttr "bindPose20.m[305]" "bindPose20.p[378]";
connectAttr "bindPose20.m[156]" "bindPose20.p[379]";
connectAttr "bindPose20.m[379]" "bindPose20.p[432]";
connectAttr "bindPose20.m[379]" "bindPose20.p[433]";
connectAttr "bindPose20.m[379]" "bindPose20.p[434]";
connectAttr "bindPose20.m[379]" "bindPose20.p[435]";
connectAttr "bindPose20.m[379]" "bindPose20.p[436]";
connectAttr "bindPose20.m[379]" "bindPose20.p[437]";
connectAttr "bindPose20.m[379]" "bindPose20.p[438]";
connectAttr "bindPose20.m[379]" "bindPose20.p[439]";
connectAttr "bindPose20.m[379]" "bindPose20.p[440]";
connectAttr "bindPose20.m[379]" "bindPose20.p[441]";
connectAttr "bindPose20.m[379]" "bindPose20.p[442]";
connectAttr "bindPose20.m[379]" "bindPose20.p[443]";
connectAttr "bindPose20.m[379]" "bindPose20.p[444]";
connectAttr "bindPose20.m[379]" "bindPose20.p[445]";
connectAttr "bindPose20.m[379]" "bindPose20.p[446]";
connectAttr "bindPose20.m[379]" "bindPose20.p[447]";
connectAttr "bindPose20.m[379]" "bindPose20.p[448]";
connectAttr "bindPose20.m[379]" "bindPose20.p[449]";
connectAttr "bindPose20.m[379]" "bindPose20.p[450]";
connectAttr "bindPose20.m[379]" "bindPose20.p[451]";
connectAttr "bindPose20.m[379]" "bindPose20.p[452]";
connectAttr "bindPose20.m[156]" "bindPose20.p[471]";
connectAttr "bindPose20.m[156]" "bindPose20.p[472]";
connectAttr "bindPose20.m[156]" "bindPose20.p[473]";
connectAttr "bindPose20.m[156]" "bindPose20.p[474]";
connectAttr "bindPose20.m[156]" "bindPose20.p[475]";
connectAttr "bindPose20.m[156]" "bindPose20.p[476]";
connectAttr "bindPose20.m[156]" "bindPose20.p[477]";
connectAttr "bindPose20.m[156]" "bindPose20.p[478]";
connectAttr "bindPose20.m[156]" "bindPose20.p[479]";
connectAttr "bindPose20.m[156]" "bindPose20.p[480]";
connectAttr "bindPose20.m[480]" "bindPose20.p[482]";
connectAttr "bindPose20.m[480]" "bindPose20.p[483]";
connectAttr "bindPose20.m[156]" "bindPose20.p[484]";
connectAttr "bindPose20.m[484]" "bindPose20.p[486]";
connectAttr "bindPose20.m[484]" "bindPose20.p[487]";
connectAttr "bindPose20.m[156]" "bindPose20.p[488]";
connectAttr "bindPose20.m[156]" "bindPose20.p[489]";
connectAttr "bindPose20.m[155]" "bindPose20.p[490]";
connectAttr "bindPose20.m[155]" "bindPose20.p[491]";
connectAttr "bindPose20.m[155]" "bindPose20.p[492]";
connectAttr "bindPose20.m[20]" "bindPose20.p[493]";
connectAttr "bindPose20.m[493]" "bindPose20.p[495]";
connectAttr "bindPose20.m[493]" "bindPose20.p[496]";
connectAttr "bindPose20.m[20]" "bindPose20.p[502]";
connectAttr "bindPose20.m[20]" "bindPose20.p[506]";
connectAttr "bindPose20.m[20]" "bindPose20.p[508]";
connectAttr "bindPose20.m[18]" "bindPose20.p[512]";
connectAttr "bindPose20.m[17]" "bindPose20.p[513]";
connectAttr "bindPose20.m[16]" "bindPose20.p[514]";
connectAttr "bindPose20.m[516]" "bindPose20.p[519]";
connectAttr "bindPose20.m[515]" "bindPose20.p[520]";
connectAttr "bindPose20.m[520]" "bindPose20.p[522]";
connectAttr "bindPose20.m[515]" "bindPose20.p[523]";
connectAttr "bindPose20.m[515]" "bindPose20.p[524]";
connectAttr "bindPose20.m[514]" "bindPose20.p[525]";
connectAttr "bindPose20.m[525]" "bindPose20.p[527]";
connectAttr "bindPose20.m[525]" "bindPose20.p[528]";
connectAttr "bindPose20.m[514]" "bindPose20.p[529]";
connectAttr "bindPose20.m[514]" "bindPose20.p[530]";
connectAttr "bindPose20.m[16]" "bindPose20.p[531]";
connectAttr "bindPose20.m[533]" "bindPose20.p[536]";
connectAttr "bindPose20.m[532]" "bindPose20.p[537]";
connectAttr "bindPose20.m[537]" "bindPose20.p[539]";
connectAttr "bindPose20.m[532]" "bindPose20.p[540]";
connectAttr "bindPose20.m[532]" "bindPose20.p[541]";
connectAttr "bindPose20.m[531]" "bindPose20.p[542]";
connectAttr "bindPose20.m[542]" "bindPose20.p[544]";
connectAttr "bindPose20.m[542]" "bindPose20.p[545]";
connectAttr "bindPose20.m[531]" "bindPose20.p[546]";
connectAttr "bindPose20.m[531]" "bindPose20.p[547]";
connectAttr "bindPose20.m[16]" "bindPose20.p[548]";
connectAttr "bindPose20.m[548]" "bindPose20.p[553]";
connectAttr "bindPose20.m[16]" "bindPose20.p[557]";
connectAttr "bindPose20.m[557]" "bindPose20.p[561]";
connectAttr "L_brow_major_inner_joint.bps" "bindPose20.wm[471]";
connectAttr "L_brow_major_mid_joint.bps" "bindPose20.wm[472]";
connectAttr "L_brow_major_outer_joint.bps" "bindPose20.wm[473]";
connectAttr "R_brow_major_inner_joint.bps" "bindPose20.wm[474]";
connectAttr "R_brow_major_mid_joint.bps" "bindPose20.wm[475]";
connectAttr "R_brow_major_outer_joint.bps" "bindPose20.wm[476]";
connectAttr "L_brow_major_inner_joint.msg" "bindPose15.m[521]";
connectAttr "L_brow_major_mid_joint.msg" "bindPose15.m[522]";
connectAttr "L_brow_major_outer_joint.msg" "bindPose15.m[523]";
connectAttr "R_brow_major_inner_joint.msg" "bindPose15.m[524]";
connectAttr "R_brow_major_mid_joint.msg" "bindPose15.m[525]";
connectAttr "R_brow_major_outer_joint.msg" "bindPose15.m[526]";
connectAttr "bindPose15.w" "bindPose15.p[0]";
connectAttr "bindPose15.m[0]" "bindPose15.p[1]";
connectAttr "bindPose15.m[1]" "bindPose15.p[2]";
connectAttr "bindPose15.m[2]" "bindPose15.p[3]";
connectAttr "bindPose15.m[3]" "bindPose15.p[4]";
connectAttr "bindPose15.m[4]" "bindPose15.p[5]";
connectAttr "bindPose15.m[5]" "bindPose15.p[6]";
connectAttr "bindPose15.m[6]" "bindPose15.p[7]";
connectAttr "bindPose15.m[7]" "bindPose15.p[8]";
connectAttr "bindPose15.m[8]" "bindPose15.p[9]";
connectAttr "bindPose15.m[9]" "bindPose15.p[10]";
connectAttr "bindPose15.m[10]" "bindPose15.p[11]";
connectAttr "bindPose15.m[11]" "bindPose15.p[12]";
connectAttr "bindPose15.m[12]" "bindPose15.p[13]";
connectAttr "bindPose15.m[13]" "bindPose15.p[14]";
connectAttr "bindPose15.m[11]" "bindPose15.p[15]";
connectAttr "bindPose15.m[15]" "bindPose15.p[16]";
connectAttr "bindPose15.m[16]" "bindPose15.p[17]";
connectAttr "bindPose15.m[11]" "bindPose15.p[18]";
connectAttr "bindPose15.m[18]" "bindPose15.p[19]";
connectAttr "bindPose15.m[19]" "bindPose15.p[20]";
connectAttr "bindPose15.m[11]" "bindPose15.p[21]";
connectAttr "bindPose15.m[21]" "bindPose15.p[22]";
connectAttr "bindPose15.m[22]" "bindPose15.p[23]";
connectAttr "bindPose15.m[23]" "bindPose15.p[24]";
connectAttr "bindPose15.m[21]" "bindPose15.p[25]";
connectAttr "bindPose15.m[25]" "bindPose15.p[26]";
connectAttr "bindPose15.m[26]" "bindPose15.p[27]";
connectAttr "bindPose15.m[10]" "bindPose15.p[28]";
connectAttr "bindPose15.m[10]" "bindPose15.p[29]";
connectAttr "bindPose15.m[10]" "bindPose15.p[30]";
connectAttr "bindPose15.m[9]" "bindPose15.p[31]";
connectAttr "bindPose15.m[9]" "bindPose15.p[32]";
connectAttr "bindPose15.m[8]" "bindPose15.p[33]";
connectAttr "bindPose15.m[3]" "bindPose15.p[34]";
connectAttr "bindPose15.m[34]" "bindPose15.p[35]";
connectAttr "bindPose15.m[35]" "bindPose15.p[36]";
connectAttr "bindPose15.m[36]" "bindPose15.p[37]";
connectAttr "bindPose15.m[35]" "bindPose15.p[38]";
connectAttr "bindPose15.m[35]" "bindPose15.p[39]";
connectAttr "bindPose15.m[35]" "bindPose15.p[40]";
connectAttr "bindPose15.m[34]" "bindPose15.p[41]";
connectAttr "bindPose15.m[34]" "bindPose15.p[42]";
connectAttr "bindPose15.m[34]" "bindPose15.p[43]";
connectAttr "bindPose15.m[7]" "bindPose15.p[44]";
connectAttr "bindPose15.m[44]" "bindPose15.p[45]";
connectAttr "bindPose15.m[45]" "bindPose15.p[46]";
connectAttr "bindPose15.m[46]" "bindPose15.p[47]";
connectAttr "bindPose15.m[47]" "bindPose15.p[48]";
connectAttr "bindPose15.m[48]" "bindPose15.p[49]";
connectAttr "bindPose15.m[49]" "bindPose15.p[50]";
connectAttr "bindPose15.m[47]" "bindPose15.p[51]";
connectAttr "bindPose15.m[51]" "bindPose15.p[52]";
connectAttr "bindPose15.m[52]" "bindPose15.p[53]";
connectAttr "bindPose15.m[47]" "bindPose15.p[54]";
connectAttr "bindPose15.m[54]" "bindPose15.p[55]";
connectAttr "bindPose15.m[55]" "bindPose15.p[56]";
connectAttr "bindPose15.m[47]" "bindPose15.p[57]";
connectAttr "bindPose15.m[57]" "bindPose15.p[58]";
connectAttr "bindPose15.m[58]" "bindPose15.p[59]";
connectAttr "bindPose15.m[59]" "bindPose15.p[60]";
connectAttr "bindPose15.m[57]" "bindPose15.p[61]";
connectAttr "bindPose15.m[61]" "bindPose15.p[62]";
connectAttr "bindPose15.m[62]" "bindPose15.p[63]";
connectAttr "bindPose15.m[46]" "bindPose15.p[64]";
connectAttr "bindPose15.m[46]" "bindPose15.p[65]";
connectAttr "bindPose15.m[46]" "bindPose15.p[66]";
connectAttr "bindPose15.m[45]" "bindPose15.p[67]";
connectAttr "bindPose15.m[45]" "bindPose15.p[68]";
connectAttr "bindPose15.m[44]" "bindPose15.p[69]";
connectAttr "bindPose15.m[3]" "bindPose15.p[70]";
connectAttr "bindPose15.m[70]" "bindPose15.p[71]";
connectAttr "bindPose15.m[71]" "bindPose15.p[72]";
connectAttr "bindPose15.m[72]" "bindPose15.p[73]";
connectAttr "bindPose15.m[71]" "bindPose15.p[74]";
connectAttr "bindPose15.m[71]" "bindPose15.p[75]";
connectAttr "bindPose15.m[71]" "bindPose15.p[76]";
connectAttr "bindPose15.m[70]" "bindPose15.p[77]";
connectAttr "bindPose15.m[70]" "bindPose15.p[78]";
connectAttr "bindPose15.m[70]" "bindPose15.p[79]";
connectAttr "bindPose15.m[7]" "bindPose15.p[80]";
connectAttr "bindPose15.m[80]" "bindPose15.p[81]";
connectAttr "bindPose15.m[80]" "bindPose15.p[82]";
connectAttr "bindPose15.m[80]" "bindPose15.p[83]";
connectAttr "bindPose15.m[80]" "bindPose15.p[84]";
connectAttr "bindPose15.m[30]" "bindPose15.p[85]";
connectAttr "bindPose15.m[30]" "bindPose15.p[86]";
connectAttr "bindPose15.m[11]" "bindPose15.p[87]";
connectAttr "bindPose15.m[11]" "bindPose15.p[88]";
connectAttr "bindPose15.m[11]" "bindPose15.p[89]";
connectAttr "bindPose15.m[11]" "bindPose15.p[90]";
connectAttr "bindPose15.m[9]" "bindPose15.p[91]";
connectAttr "bindPose15.m[91]" "bindPose15.p[92]";
connectAttr "bindPose15.m[91]" "bindPose15.p[93]";
connectAttr "bindPose15.m[91]" "bindPose15.p[94]";
connectAttr "bindPose15.m[45]" "bindPose15.p[95]";
connectAttr "bindPose15.m[95]" "bindPose15.p[96]";
connectAttr "bindPose15.m[95]" "bindPose15.p[97]";
connectAttr "bindPose15.m[95]" "bindPose15.p[98]";
connectAttr "bindPose15.m[66]" "bindPose15.p[99]";
connectAttr "bindPose15.m[66]" "bindPose15.p[100]";
connectAttr "bindPose15.m[47]" "bindPose15.p[101]";
connectAttr "bindPose15.m[47]" "bindPose15.p[102]";
connectAttr "bindPose15.m[47]" "bindPose15.p[103]";
connectAttr "bindPose15.m[47]" "bindPose15.p[104]";
connectAttr "bindPose15.m[40]" "bindPose15.p[105]";
connectAttr "bindPose15.m[40]" "bindPose15.p[106]";
connectAttr "bindPose15.m[76]" "bindPose15.p[107]";
connectAttr "bindPose15.m[76]" "bindPose15.p[108]";
connectAttr "bindPose15.m[43]" "bindPose15.p[109]";
connectAttr "bindPose15.m[43]" "bindPose15.p[110]";
connectAttr "bindPose15.m[43]" "bindPose15.p[111]";
connectAttr "bindPose15.m[79]" "bindPose15.p[112]";
connectAttr "bindPose15.m[79]" "bindPose15.p[113]";
connectAttr "bindPose15.m[79]" "bindPose15.p[114]";
connectAttr "bindPose15.m[81]" "bindPose15.p[115]";
connectAttr "bindPose15.m[5]" "bindPose15.p[116]";
connectAttr "bindPose15.m[4]" "bindPose15.p[117]";
connectAttr "bindPose15.m[31]" "bindPose15.p[118]";
connectAttr "bindPose15.m[36]" "bindPose15.p[119]";
connectAttr "bindPose15.m[11]" "bindPose15.p[120]";
connectAttr "bindPose15.m[47]" "bindPose15.p[121]";
connectAttr "bindPose15.m[17]" "bindPose15.p[122]";
connectAttr "bindPose15.m[16]" "bindPose15.p[123]";
connectAttr "bindPose15.m[15]" "bindPose15.p[124]";
connectAttr "bindPose15.m[18]" "bindPose15.p[125]";
connectAttr "bindPose15.m[19]" "bindPose15.p[126]";
connectAttr "bindPose15.m[20]" "bindPose15.p[127]";
connectAttr "bindPose15.m[24]" "bindPose15.p[128]";
connectAttr "bindPose15.m[23]" "bindPose15.p[129]";
connectAttr "bindPose15.m[22]" "bindPose15.p[130]";
connectAttr "bindPose15.m[25]" "bindPose15.p[131]";
connectAttr "bindPose15.m[26]" "bindPose15.p[132]";
connectAttr "bindPose15.m[27]" "bindPose15.p[133]";
connectAttr "bindPose15.m[13]" "bindPose15.p[134]";
connectAttr "bindPose15.m[14]" "bindPose15.p[135]";
connectAttr "bindPose15.m[51]" "bindPose15.p[136]";
connectAttr "bindPose15.m[52]" "bindPose15.p[137]";
connectAttr "bindPose15.m[53]" "bindPose15.p[138]";
connectAttr "bindPose15.m[54]" "bindPose15.p[139]";
connectAttr "bindPose15.m[55]" "bindPose15.p[140]";
connectAttr "bindPose15.m[56]" "bindPose15.p[141]";
connectAttr "bindPose15.m[60]" "bindPose15.p[142]";
connectAttr "bindPose15.m[59]" "bindPose15.p[143]";
connectAttr "bindPose15.m[58]" "bindPose15.p[144]";
connectAttr "bindPose15.m[61]" "bindPose15.p[145]";
connectAttr "bindPose15.m[62]" "bindPose15.p[146]";
connectAttr "bindPose15.m[63]" "bindPose15.p[147]";
connectAttr "bindPose15.m[49]" "bindPose15.p[148]";
connectAttr "bindPose15.m[50]" "bindPose15.p[149]";
connectAttr "bindPose15.m[95]" "bindPose15.p[150]";
connectAttr "bindPose15.m[91]" "bindPose15.p[151]";
connectAttr "bindPose15.m[67]" "bindPose15.p[152]";
connectAttr "bindPose15.m[72]" "bindPose15.p[153]";
connectAttr "bindPose15.m[81]" "bindPose15.p[154]";
connectAttr "bindPose15.m[67]" "bindPose15.p[155]";
connectAttr "bindPose15.m[31]" "bindPose15.p[156]";
connectAttr "bindPose15.m[566]" "bindPose15.p[159]";
connectAttr "bindPose15.m[563]" "bindPose15.p[160]";
connectAttr "bindPose15.m[2]" "bindPose15.p[161]";
connectAttr "bindPose15.m[161]" "bindPose15.p[169]";
connectAttr "bindPose15.m[81]" "bindPose15.p[170]";
connectAttr "bindPose15.m[81]" "bindPose15.p[171]";
connectAttr "bindPose15.m[81]" "bindPose15.p[172]";
connectAttr "bindPose15.m[81]" "bindPose15.p[173]";
connectAttr "bindPose15.m[81]" "bindPose15.p[174]";
connectAttr "bindPose15.m[81]" "bindPose15.p[175]";
connectAttr "bindPose15.m[81]" "bindPose15.p[176]";
connectAttr "bindPose15.m[81]" "bindPose15.p[177]";
connectAttr "bindPose15.m[81]" "bindPose15.p[178]";
connectAttr "bindPose15.m[81]" "bindPose15.p[179]";
connectAttr "bindPose15.m[81]" "bindPose15.p[180]";
connectAttr "bindPose15.m[81]" "bindPose15.p[181]";
connectAttr "bindPose15.m[81]" "bindPose15.p[182]";
connectAttr "bindPose15.m[81]" "bindPose15.p[183]";
connectAttr "bindPose15.m[81]" "bindPose15.p[184]";
connectAttr "bindPose15.m[81]" "bindPose15.p[185]";
connectAttr "bindPose15.m[81]" "bindPose15.p[186]";
connectAttr "bindPose15.m[81]" "bindPose15.p[187]";
connectAttr "bindPose15.m[81]" "bindPose15.p[188]";
connectAttr "bindPose15.m[81]" "bindPose15.p[189]";
connectAttr "bindPose15.m[81]" "bindPose15.p[190]";
connectAttr "bindPose15.m[81]" "bindPose15.p[191]";
connectAttr "bindPose15.m[81]" "bindPose15.p[192]";
connectAttr "bindPose15.m[81]" "bindPose15.p[193]";
connectAttr "bindPose15.m[81]" "bindPose15.p[194]";
connectAttr "bindPose15.m[81]" "bindPose15.p[195]";
connectAttr "bindPose15.m[81]" "bindPose15.p[196]";
connectAttr "bindPose15.m[81]" "bindPose15.p[197]";
connectAttr "bindPose15.m[81]" "bindPose15.p[198]";
connectAttr "bindPose15.m[81]" "bindPose15.p[199]";
connectAttr "bindPose15.m[81]" "bindPose15.p[200]";
connectAttr "bindPose15.m[81]" "bindPose15.p[201]";
connectAttr "bindPose15.m[81]" "bindPose15.p[202]";
connectAttr "bindPose15.m[81]" "bindPose15.p[203]";
connectAttr "bindPose15.m[81]" "bindPose15.p[204]";
connectAttr "bindPose15.m[81]" "bindPose15.p[205]";
connectAttr "bindPose15.m[81]" "bindPose15.p[206]";
connectAttr "bindPose15.m[81]" "bindPose15.p[207]";
connectAttr "bindPose15.m[10]" "bindPose15.p[213]";
connectAttr "bindPose15.m[213]" "bindPose15.p[215]";
connectAttr "bindPose15.m[9]" "bindPose15.p[217]";
connectAttr "bindPose15.m[217]" "bindPose15.p[219]";
connectAttr "bindPose15.m[219]" "bindPose15.p[221]";
connectAttr "bindPose15.m[46]" "bindPose15.p[229]";
connectAttr "bindPose15.m[229]" "bindPose15.p[231]";
connectAttr "bindPose15.m[81]" "bindPose15.p[235]";
connectAttr "bindPose15.m[595]" "bindPose15.p[239]";
connectAttr "bindPose15.m[596]" "bindPose15.p[241]";
connectAttr "bindPose15.m[81]" "bindPose15.p[242]";
connectAttr "bindPose15.m[597]" "bindPose15.p[246]";
connectAttr "bindPose15.m[598]" "bindPose15.p[248]";
connectAttr "bindPose15.m[81]" "bindPose15.p[249]";
connectAttr "bindPose15.m[81]" "bindPose15.p[262]";
connectAttr "bindPose15.m[81]" "bindPose15.p[268]";
connectAttr "bindPose15.m[81]" "bindPose15.p[275]";
connectAttr "bindPose15.m[81]" "bindPose15.p[280]";
connectAttr "bindPose15.m[81]" "bindPose15.p[286]";
connectAttr "bindPose15.m[81]" "bindPose15.p[290]";
connectAttr "bindPose15.m[81]" "bindPose15.p[294]";
connectAttr "bindPose15.m[81]" "bindPose15.p[300]";
connectAttr "bindPose15.m[81]" "bindPose15.p[306]";
connectAttr "bindPose15.m[81]" "bindPose15.p[311]";
connectAttr "bindPose15.m[81]" "bindPose15.p[317]";
connectAttr "bindPose15.m[81]" "bindPose15.p[321]";
connectAttr "bindPose15.m[81]" "bindPose15.p[326]";
connectAttr "bindPose15.m[81]" "bindPose15.p[331]";
connectAttr "bindPose15.m[81]" "bindPose15.p[339]";
connectAttr "bindPose15.m[81]" "bindPose15.p[340]";
connectAttr "bindPose15.m[81]" "bindPose15.p[341]";
connectAttr "bindPose15.m[81]" "bindPose15.p[343]";
connectAttr "bindPose15.m[81]" "bindPose15.p[345]";
connectAttr "bindPose15.m[81]" "bindPose15.p[346]";
connectAttr "bindPose15.m[81]" "bindPose15.p[347]";
connectAttr "bindPose15.m[81]" "bindPose15.p[348]";
connectAttr "bindPose15.m[81]" "bindPose15.p[349]";
connectAttr "bindPose15.m[81]" "bindPose15.p[350]";
connectAttr "bindPose15.m[81]" "bindPose15.p[351]";
connectAttr "bindPose15.m[81]" "bindPose15.p[352]";
connectAttr "bindPose15.m[81]" "bindPose15.p[353]";
connectAttr "bindPose15.m[81]" "bindPose15.p[354]";
connectAttr "bindPose15.m[81]" "bindPose15.p[355]";
connectAttr "bindPose15.m[613]" "bindPose15.p[357]";
connectAttr "bindPose15.m[614]" "bindPose15.p[359]";
connectAttr "bindPose15.m[615]" "bindPose15.p[361]";
connectAttr "bindPose15.m[616]" "bindPose15.p[363]";
connectAttr "bindPose15.m[617]" "bindPose15.p[365]";
connectAttr "bindPose15.m[618]" "bindPose15.p[367]";
connectAttr "bindPose15.m[619]" "bindPose15.p[369]";
connectAttr "bindPose15.m[620]" "bindPose15.p[371]";
connectAttr "bindPose15.m[621]" "bindPose15.p[373]";
connectAttr "bindPose15.m[622]" "bindPose15.p[375]";
connectAttr "bindPose15.m[623]" "bindPose15.p[377]";
connectAttr "bindPose15.m[624]" "bindPose15.p[379]";
connectAttr "bindPose15.m[625]" "bindPose15.p[381]";
connectAttr "bindPose15.m[626]" "bindPose15.p[383]";
connectAttr "bindPose15.m[627]" "bindPose15.p[385]";
connectAttr "bindPose15.m[628]" "bindPose15.p[387]";
connectAttr "bindPose15.m[629]" "bindPose15.p[389]";
connectAttr "bindPose15.m[630]" "bindPose15.p[391]";
connectAttr "bindPose15.m[631]" "bindPose15.p[393]";
connectAttr "bindPose15.m[632]" "bindPose15.p[395]";
connectAttr "bindPose15.m[633]" "bindPose15.p[397]";
connectAttr "bindPose15.m[634]" "bindPose15.p[399]";
connectAttr "bindPose15.m[635]" "bindPose15.p[401]";
connectAttr "bindPose15.m[636]" "bindPose15.p[403]";
connectAttr "bindPose15.m[637]" "bindPose15.p[405]";
connectAttr "bindPose15.m[638]" "bindPose15.p[407]";
connectAttr "bindPose15.m[355]" "bindPose15.p[408]";
connectAttr "bindPose15.m[355]" "bindPose15.p[409]";
connectAttr "bindPose15.m[355]" "bindPose15.p[410]";
connectAttr "bindPose15.m[355]" "bindPose15.p[411]";
connectAttr "bindPose15.m[355]" "bindPose15.p[412]";
connectAttr "bindPose15.m[355]" "bindPose15.p[413]";
connectAttr "bindPose15.m[355]" "bindPose15.p[414]";
connectAttr "bindPose15.m[355]" "bindPose15.p[415]";
connectAttr "bindPose15.m[355]" "bindPose15.p[416]";
connectAttr "bindPose15.m[355]" "bindPose15.p[417]";
connectAttr "bindPose15.m[355]" "bindPose15.p[418]";
connectAttr "bindPose15.m[355]" "bindPose15.p[419]";
connectAttr "bindPose15.m[355]" "bindPose15.p[420]";
connectAttr "bindPose15.m[355]" "bindPose15.p[421]";
connectAttr "bindPose15.m[355]" "bindPose15.p[422]";
connectAttr "bindPose15.m[355]" "bindPose15.p[423]";
connectAttr "bindPose15.m[355]" "bindPose15.p[424]";
connectAttr "bindPose15.m[355]" "bindPose15.p[425]";
connectAttr "bindPose15.m[355]" "bindPose15.p[426]";
connectAttr "bindPose15.m[355]" "bindPose15.p[427]";
connectAttr "bindPose15.m[355]" "bindPose15.p[428]";
connectAttr "bindPose15.m[81]" "bindPose15.p[429]";
connectAttr "bindPose15.m[639]" "bindPose15.p[431]";
connectAttr "bindPose15.m[640]" "bindPose15.p[433]";
connectAttr "bindPose15.m[641]" "bindPose15.p[435]";
connectAttr "bindPose15.m[642]" "bindPose15.p[437]";
connectAttr "bindPose15.m[643]" "bindPose15.p[439]";
connectAttr "bindPose15.m[644]" "bindPose15.p[441]";
connectAttr "bindPose15.m[645]" "bindPose15.p[443]";
connectAttr "bindPose15.m[646]" "bindPose15.p[445]";
connectAttr "bindPose15.m[647]" "bindPose15.p[447]";
connectAttr "bindPose15.m[648]" "bindPose15.p[449]";
connectAttr "bindPose15.m[649]" "bindPose15.p[451]";
connectAttr "bindPose15.m[650]" "bindPose15.p[453]";
connectAttr "bindPose15.m[651]" "bindPose15.p[455]";
connectAttr "bindPose15.m[652]" "bindPose15.p[457]";
connectAttr "bindPose15.m[653]" "bindPose15.p[459]";
connectAttr "bindPose15.m[654]" "bindPose15.p[461]";
connectAttr "bindPose15.m[655]" "bindPose15.p[463]";
connectAttr "bindPose15.m[656]" "bindPose15.p[465]";
connectAttr "bindPose15.m[657]" "bindPose15.p[467]";
connectAttr "bindPose15.m[658]" "bindPose15.p[469]";
connectAttr "bindPose15.m[659]" "bindPose15.p[471]";
connectAttr "bindPose15.m[660]" "bindPose15.p[473]";
connectAttr "bindPose15.m[661]" "bindPose15.p[475]";
connectAttr "bindPose15.m[662]" "bindPose15.p[477]";
connectAttr "bindPose15.m[663]" "bindPose15.p[479]";
connectAttr "bindPose15.m[664]" "bindPose15.p[481]";
connectAttr "bindPose15.m[429]" "bindPose15.p[482]";
connectAttr "bindPose15.m[429]" "bindPose15.p[483]";
connectAttr "bindPose15.m[429]" "bindPose15.p[484]";
connectAttr "bindPose15.m[429]" "bindPose15.p[485]";
connectAttr "bindPose15.m[429]" "bindPose15.p[486]";
connectAttr "bindPose15.m[429]" "bindPose15.p[487]";
connectAttr "bindPose15.m[429]" "bindPose15.p[488]";
connectAttr "bindPose15.m[429]" "bindPose15.p[489]";
connectAttr "bindPose15.m[429]" "bindPose15.p[490]";
connectAttr "bindPose15.m[429]" "bindPose15.p[491]";
connectAttr "bindPose15.m[429]" "bindPose15.p[492]";
connectAttr "bindPose15.m[429]" "bindPose15.p[493]";
connectAttr "bindPose15.m[429]" "bindPose15.p[494]";
connectAttr "bindPose15.m[429]" "bindPose15.p[495]";
connectAttr "bindPose15.m[429]" "bindPose15.p[496]";
connectAttr "bindPose15.m[429]" "bindPose15.p[497]";
connectAttr "bindPose15.m[429]" "bindPose15.p[498]";
connectAttr "bindPose15.m[429]" "bindPose15.p[499]";
connectAttr "bindPose15.m[429]" "bindPose15.p[500]";
connectAttr "bindPose15.m[429]" "bindPose15.p[501]";
connectAttr "bindPose15.m[429]" "bindPose15.p[502]";
connectAttr "bindPose15.m[81]" "bindPose15.p[521]";
connectAttr "bindPose15.m[81]" "bindPose15.p[522]";
connectAttr "bindPose15.m[81]" "bindPose15.p[523]";
connectAttr "bindPose15.m[81]" "bindPose15.p[524]";
connectAttr "bindPose15.m[81]" "bindPose15.p[525]";
connectAttr "bindPose15.m[81]" "bindPose15.p[526]";
connectAttr "bindPose15.m[81]" "bindPose15.p[527]";
connectAttr "bindPose15.m[81]" "bindPose15.p[528]";
connectAttr "bindPose15.m[81]" "bindPose15.p[529]";
connectAttr "bindPose15.m[81]" "bindPose15.p[530]";
connectAttr "bindPose15.m[530]" "bindPose15.p[532]";
connectAttr "bindPose15.m[530]" "bindPose15.p[533]";
connectAttr "bindPose15.m[81]" "bindPose15.p[534]";
connectAttr "bindPose15.m[534]" "bindPose15.p[536]";
connectAttr "bindPose15.m[534]" "bindPose15.p[537]";
connectAttr "bindPose15.m[81]" "bindPose15.p[538]";
connectAttr "bindPose15.m[81]" "bindPose15.p[539]";
connectAttr "bindPose15.m[7]" "bindPose15.p[540]";
connectAttr "bindPose15.m[540]" "bindPose15.p[542]";
connectAttr "bindPose15.m[540]" "bindPose15.p[543]";
connectAttr "bindPose15.m[667]" "bindPose15.p[548]";
connectAttr "bindPose15.m[7]" "bindPose15.p[549]";
connectAttr "bindPose15.m[669]" "bindPose15.p[552]";
connectAttr "bindPose15.m[7]" "bindPose15.p[553]";
connectAttr "bindPose15.m[7]" "bindPose15.p[555]";
connectAttr "bindPose15.m[3]" "bindPose15.p[561]";
connectAttr "bindPose15.m[561]" "bindPose15.p[565]";
connectAttr "bindPose15.m[3]" "bindPose15.p[568]";
connectAttr "bindPose15.m[568]" "bindPose15.p[572]";
connectAttr "bindPose15.m[235]" "bindPose15.p[595]";
connectAttr "bindPose15.m[235]" "bindPose15.p[596]";
connectAttr "bindPose15.m[242]" "bindPose15.p[597]";
connectAttr "bindPose15.m[242]" "bindPose15.p[598]";
connectAttr "bindPose15.m[355]" "bindPose15.p[613]";
connectAttr "bindPose15.m[355]" "bindPose15.p[614]";
connectAttr "bindPose15.m[355]" "bindPose15.p[615]";
connectAttr "bindPose15.m[355]" "bindPose15.p[616]";
connectAttr "bindPose15.m[355]" "bindPose15.p[617]";
connectAttr "bindPose15.m[355]" "bindPose15.p[618]";
connectAttr "bindPose15.m[355]" "bindPose15.p[619]";
connectAttr "bindPose15.m[355]" "bindPose15.p[620]";
connectAttr "bindPose15.m[355]" "bindPose15.p[621]";
connectAttr "bindPose15.m[355]" "bindPose15.p[622]";
connectAttr "bindPose15.m[355]" "bindPose15.p[623]";
connectAttr "bindPose15.m[355]" "bindPose15.p[624]";
connectAttr "bindPose15.m[355]" "bindPose15.p[625]";
connectAttr "bindPose15.m[355]" "bindPose15.p[626]";
connectAttr "bindPose15.m[355]" "bindPose15.p[627]";
connectAttr "bindPose15.m[355]" "bindPose15.p[628]";
connectAttr "bindPose15.m[355]" "bindPose15.p[629]";
connectAttr "bindPose15.m[355]" "bindPose15.p[630]";
connectAttr "bindPose15.m[355]" "bindPose15.p[631]";
connectAttr "bindPose15.m[355]" "bindPose15.p[632]";
connectAttr "bindPose15.m[355]" "bindPose15.p[633]";
connectAttr "bindPose15.m[355]" "bindPose15.p[634]";
connectAttr "bindPose15.m[355]" "bindPose15.p[635]";
connectAttr "bindPose15.m[355]" "bindPose15.p[636]";
connectAttr "bindPose15.m[355]" "bindPose15.p[637]";
connectAttr "bindPose15.m[355]" "bindPose15.p[638]";
connectAttr "bindPose15.m[429]" "bindPose15.p[639]";
connectAttr "bindPose15.m[429]" "bindPose15.p[640]";
connectAttr "bindPose15.m[429]" "bindPose15.p[641]";
connectAttr "bindPose15.m[429]" "bindPose15.p[642]";
connectAttr "bindPose15.m[429]" "bindPose15.p[643]";
connectAttr "bindPose15.m[429]" "bindPose15.p[644]";
connectAttr "bindPose15.m[429]" "bindPose15.p[645]";
connectAttr "bindPose15.m[429]" "bindPose15.p[646]";
connectAttr "bindPose15.m[429]" "bindPose15.p[647]";
connectAttr "bindPose15.m[429]" "bindPose15.p[648]";
connectAttr "bindPose15.m[429]" "bindPose15.p[649]";
connectAttr "bindPose15.m[429]" "bindPose15.p[650]";
connectAttr "bindPose15.m[429]" "bindPose15.p[651]";
connectAttr "bindPose15.m[429]" "bindPose15.p[652]";
connectAttr "bindPose15.m[429]" "bindPose15.p[653]";
connectAttr "bindPose15.m[429]" "bindPose15.p[654]";
connectAttr "bindPose15.m[429]" "bindPose15.p[655]";
connectAttr "bindPose15.m[429]" "bindPose15.p[656]";
connectAttr "bindPose15.m[429]" "bindPose15.p[657]";
connectAttr "bindPose15.m[429]" "bindPose15.p[658]";
connectAttr "bindPose15.m[429]" "bindPose15.p[659]";
connectAttr "bindPose15.m[429]" "bindPose15.p[660]";
connectAttr "bindPose15.m[429]" "bindPose15.p[661]";
connectAttr "bindPose15.m[429]" "bindPose15.p[662]";
connectAttr "bindPose15.m[429]" "bindPose15.p[663]";
connectAttr "bindPose15.m[429]" "bindPose15.p[664]";
connectAttr "bindPose15.m[540]" "bindPose15.p[667]";
connectAttr "bindPose15.m[549]" "bindPose15.p[669]";
connectAttr "L_brow_major_inner_joint.bps" "bindPose15.wm[521]";
connectAttr "L_brow_major_mid_joint.bps" "bindPose15.wm[522]";
connectAttr "L_brow_major_outer_joint.bps" "bindPose15.wm[523]";
connectAttr "R_brow_major_inner_joint.bps" "bindPose15.wm[524]";
connectAttr "R_brow_major_mid_joint.bps" "bindPose15.wm[525]";
connectAttr "R_brow_major_outer_joint.bps" "bindPose15.wm[526]";
connectAttr "R_brow_main_curveShapeOrig2.ws" "R_brow_main_blendShape.ip[0].ig";
connectAttr "R_brow_main_curveShapeOrig2.l" "R_brow_main_blendShape.orggeom[0]";
connectAttr "R_brow_main_blendShape_up.o" "R_brow_main_blendShape.w[0]";
connectAttr "R_brow_main_blendShape_down.o" "R_brow_main_blendShape.w[1]";
connectAttr "R_brow_main_blendShape_inner.o" "R_brow_main_blendShape.w[2]";
connectAttr "shapeEditorManager.obsv[7]" "R_brow_main_blendShape.tgdt[0].dpvs";
connectAttr "R_brow_main_control.ty" "R_brow_main_blendShape_up.i";
connectAttr "R_brow_main_control.ty" "R_brow_main_blendShape_down.i";
connectAttr "R_brow_main_control.tx" "R_brow_main_blendShape_inner.i";
connectAttr "skinCluster64.og[0]" "R_brow_curv_cluster.ip[0].ig";
connectAttr "R_brow_main_curveShapeOrig2.l" "R_brow_curv_cluster.orggeom[0]";
connectAttr "R_brow_curv_transform.m" "R_brow_curv_cluster.wt";
connectAttr "R_brow_curv_compensation_transform.wim" "R_brow_curv_cluster.post";
connectAttr "R_brow_curv_compensation_transform.wm" "R_brow_curv_cluster.pre";
connectAttr "R_brow_major_curveShapeOrig1.ws" "skinCluster64.ip[0].ig";
connectAttr "R_brow_major_curveShapeOrig1.l" "skinCluster64.orggeom[0]";
connectAttr "bindPose40.msg" "skinCluster64.bp";
connectAttr "R_brow_major_inner_joint.wm" "skinCluster64.ma[0]";
connectAttr "R_brow_major_mid_joint.wm" "skinCluster64.ma[1]";
connectAttr "R_brow_major_outer_joint.wm" "skinCluster64.ma[2]";
connectAttr "R_brow_major_inner_joint.liw" "skinCluster64.lw[0]";
connectAttr "R_brow_major_mid_joint.liw" "skinCluster64.lw[1]";
connectAttr "R_brow_major_outer_joint.liw" "skinCluster64.lw[2]";
connectAttr "R_brow_major_inner_joint.obcc" "skinCluster64.ifcl[0]";
connectAttr "R_brow_major_mid_joint.obcc" "skinCluster64.ifcl[1]";
connectAttr "R_brow_major_outer_joint.obcc" "skinCluster64.ifcl[2]";
connectAttr "R_brow_major_inner_joint_basis.wim" "skinCluster64.pm[0]";
connectAttr "R_brow_major_mid_joint_basis.wim" "skinCluster64.pm[1]";
connectAttr "R_brow_major_outer_joint_basis.wim" "skinCluster64.pm[2]";
connectAttr "R_brow_major_inner_joint.msg" "bindPose40.m[0]";
connectAttr "R_brow_major_mid_joint.msg" "bindPose40.m[1]";
connectAttr "R_brow_major_outer_joint.msg" "bindPose40.m[2]";
connectAttr "bindPose40.w" "bindPose40.p[0]";
connectAttr "bindPose40.w" "bindPose40.p[1]";
connectAttr "bindPose40.w" "bindPose40.p[2]";
connectAttr "R_brow_major_inner_joint.bps" "bindPose40.wm[0]";
connectAttr "R_brow_major_mid_joint.bps" "bindPose40.wm[1]";
connectAttr "R_brow_major_outer_joint.bps" "bindPose40.wm[2]";
connectAttr "R_brow_major_outer_control_pointOnCurveInfo.p" "R_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_brow_major_outer_control_transform.pim" "R_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_brow_main_curveShape.ws" "R_brow_major_outer_control_pointOnCurveInfo.ic"
		;
connectAttr "R_brow_major_mid_control_pointOnCurveInfo.p" "R_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_brow_major_mid_control_transform.pim" "R_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_brow_main_curveShape.ws" "R_brow_major_mid_control_pointOnCurveInfo.ic"
		;
connectAttr "R_brow_major_inner_control_pointOnCurveInfo.p" "R_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "R_brow_major_inner_control_transform.pim" "R_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "R_brow_main_curveShape.ws" "R_brow_major_inner_control_pointOnCurveInfo.ic"
		;
connectAttr "L_brow_major_outer_control_pointOnCurveInfo.p" "L_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_brow_major_outer_control_transform.pim" "L_brow_major_outer_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_brow_main_curveShape.ws" "L_brow_major_outer_control_pointOnCurveInfo.ic"
		;
connectAttr "L_brow_major_mid_control_pointOnCurveInfo.p" "L_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_brow_major_mid_control_transform.pim" "L_brow_major_mid_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_brow_main_curveShape.ws" "L_brow_major_mid_control_pointOnCurveInfo.ic"
		;
connectAttr "L_brow_major_inner_control_pointOnCurveInfo.p" "L_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.ip"
		;
connectAttr "L_brow_major_inner_control_transform.pim" "L_brow_major_inner_control_transform_parentInverse_pointMatrixMultDL.im"
		;
connectAttr "L_brow_main_curveShape.ws" "L_brow_major_inner_control_pointOnCurveInfo.ic"
		;
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "L_brow_main_blendShape.mlpr" "shapeEditorManager.bspr[6]";
connectAttr "R_brow_main_blendShape.mlpr" "shapeEditorManager.bspr[7]";
connectAttr "L_brow_tuner_curveShape.ws" "L_brow_tuner_curve_transformGeometry.ig"
		;
connectAttr "R_brow_main_tuner.m" "R_brow_main_control_parent_multMatrix.i[0]";
connectAttr "R_brow_main_tuner.opm" "R_brow_main_control_parent_multMatrix.i[1]"
		;
connectAttr "R_brow_main_tunerShape.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[0].dn"
		;
connectAttr "L_brow_tuner_curveShape.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[1].dn"
		;
connectAttr "L_brow_tuner_curve_transformGeometry.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[2].dn"
		;
connectAttr "L_brow_tuner_curve.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[3].dn"
		;
connectAttr "R_brow_main_tuner.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[4].dn"
		;
connectAttr "R_brow_main_control_parent_multMatrix.msg" "MayaNodeEditorSavedTabsInfo.tgi[0].ni[5].dn"
		;
connectAttr "R_brow_main_control_parent_multMatrix.msg" ":defaultRenderUtilityList1.u"
		 -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
dataStructure -fmt "raw" -as "name=OrgStruct:float[3]=Origin Point";
dataStructure -fmt "raw" -as "name=IdStruct:int32=ID";
dataStructure -fmt "raw" -as "name=faceConnectOutputStructure:bool=faceConnectOutput:string[200]=faceConnectOutputAttributes:string[200]=faceConnectOutputGroups";
dataStructure -fmt "raw" -as "name=Curvature:float=mean:float=gaussian:float=ABS:float=RMS";
dataStructure -fmt "raw" -as "name=DiffArea:float=value";
dataStructure -fmt "raw" -as "name=keyValueStructure:string=value";
dataStructure -fmt "raw" -as "name=OffStruct:float=Offset";
dataStructure -fmt "raw" -as "name=Offset:float[3]=value";
dataStructure -fmt "raw" -as "name=faceConnectMarkerStructure:bool=faceConnectMarker:string[200]=faceConnectOutputGroups";
dataStructure -fmt "raw" -as "name=idStructure:int32=ID";
dataStructure -fmt "raw" -as "name=DiffEdge:float=value";
// End of face_brows.ma
