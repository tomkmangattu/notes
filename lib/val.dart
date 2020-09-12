int a = 0; //for 2d array
int hhhh = 0; /*hhhh&kkkk for condition of both selected */
int kkkk = 0;
int gggg = 0;
String ssss = "SGPA:0.00";
List<String> d;
List<int> valueco;
int car = 0;
int i = 0;
double k = 0, kk;
double output = 0;
int fina = 0;
double finall = 0;
int sem = 2, batch = 0;
double attpercent = 75;
var uid;
Map<String, Map<int, String>> apis = {
  'S1': {
    2015: 'https://sheet.best/api/sheets/c2e4d444-f447-449b-ade2-19ef8769987d',
    2016: 'https://sheet.best/api/sheets/9cdcad95-48cb-4ac4-8bd5-1f11b5c58f31',
    2017: 'https://sheet.best/api/sheets/d0863581-9dc0-4e94-9b81-e6c977bf957e',
    2018: 'https://sheet.best/api/sheets/d3341a26-6049-4b85-a704-88230abc8cfb'
  },
  'S2': {
    2015: 'https://sheet.best/api/sheets/b0108136-ba9a-4074-941d-70128522f59c',
    2016: 'https://sheet.best/api/sheets/f2678c88-0288-4a08-8c6f-250c32ca7ff8',
    2017: 'https://sheet.best/api/sheets/d598c2b6-fba0-481d-b560-69255ff2ca9e',
    2018: 'https://sheet.best/api/sheets/ed5dc85c-ea7b-409a-9f9f-36f3a4159aba'
  },
  'S3': {
    2015: 'https://sheet.best/api/sheets/8059d73f-ad08-4488-aa96-c20a5abec62b',
    2016: 'https://sheet.best/api/sheets/c90d754d-0c50-4e3d-8d6d-9a1307ae8e78',
    2017: 'https://sheet.best/api/sheets/eaf5ef85-b7e7-4242-be1a-9c812066e60a'
  },
  'S4': {
    2015: 'https://sheet.best/api/sheets/c6cdeb2b-1c76-42a8-9f0a-582fdf498524',
    2016: 'https://sheet.best/api/sheets/7bfcd2f3-7ba9-4cee-b560-0ac348b5a30a',
    2017: 'https://sheet.best/api/sheets/4f259683-7d26-4a72-b181-058d745d750c'
  },
  'S5': {
    2015: 'https://sheet.best/api/sheets/78cd1aee-18fd-4cbe-b2a4-08e12ef65e14',
    2016: 'https://sheet.best/api/sheets/559167b6-3998-4b45-aafd-bb81eae171e5'
  },
  'S6': {
    2015: 'https://sheet.best/api/sheets/e6239070-35f9-4aba-9586-ed15c3d221de',
    2016: 'https://sheet.best/api/sheets/54de945b-1241-4693-8100-72d9ef640ae8'
  },
  'S7': {
    2015: 'https://sheet.best/api/sheets/36314362-3b33-41c6-abc1-77683bd44488'
  },
  'S8': {
    2016: 'https://sheet.best/api/sheets/b53be13f-824c-4fec-adce-529d4ca61bcc'
  }
};
List<int> bottom = [1, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> top = [1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0];
List<String> branch = ["CS", "CE", "EC", "EE", "ME", "IT"];
List<String> semester = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"];
List<int> gradesel = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<int> grade2sel = [0, 0, 0, 0, 0, 0, 0, 0, 0];
List<List<List<String>>> subs = [
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Discrete Computatioal Structures (CS201)",
      "Switching Theory and Logic Design (CS203)",
      "Data Structues (CS205)",
      "Electronic Devices& Circuits (CS207)",
      "Life Skills (HS210) or Business Economics (HS200)",
      "Data Structue Lab (CS231)",
      "Electronics Circuits Lab (CS233)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Computer Organization and Architecture (CS202)",
      "Operating Systems (CS204)",
      "Object Oriented Design and Programming (CS206)",
      "Principles of Database Design (CS208)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "FOSS Lab (CS232)",
      "Digital Systems Lab (CS234)"
    ],
    [
      "Theory of Computation (CS301)",
      "System Software (CS303)",
      "Microprocessors and Microcontrollers (CS305)",
      "Data Communication (CS307)",
      "Graph Theory and Combinatorics (CS309)",
      "Elective 1(CS36X)  ",
      "Design Project (CS341)",
      "System Software Lab (CS331)",
      "Application Software Development Lab(CS333)"
    ],
    [
      "Design and Analysis of Algorithms (CS302)",
      "Compiler Design (CS304)",
      "Computer Networks (CS306)",
      "Software Engineering and Project Management (CS308)",
      "Principles of Management (HS300)",
      "Elective 2 (CS36X) ",
      "Microprocessor Lab (CS332)",
      "Network Programming Lab (CS334)",
      "Comprehensive Exam (CS352)"
    ],
    [
      "Computer Graphics (CS401)",
      "Programming Paradigms (CS403)",
      "Computer System Architecture (CS405)",
      "Distributed Computing (CS407)",
      "Cryptography and Network Security (CS409)",
      "Elective 3(CS46X) ",
      "Seminar & Project Preliminary (CS451)",
      "Compiler Design Lab (CS431)"
    ],
    [
      "Data Mining and Ware Housing (CS402)",
      "Embedded Systems (CS404)",
      "Elective 4(CS46X)",
      "Elective 5 (Non Departmental) ",
      "Project (CS492)"
    ]
  ],
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Mechanics of Solids (ME201)",
      "Mechanics of Fluids (ME203)",
      "Thermodynamics (ME205)",
      "Metallurgy and Materials Engineering (ME210)",
      "Life Skills (HS210) or Business Economics (HS200)",
      "Computer Aided Machine Drawing Lab (ME231)",
      "Material Testing Lab (CE230)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Advanced Mechanics of Solids (ME202)",
      "Thermal Engineering (ME204)",
      "Fluid Machinery (ME206)",
      "Manufacturing Technology (ME220)",
      "Life Skills (HS210) or Business Economics (HS200)",
      "Thermal Engineering Lab (ME232)",
      "Fluid Mechanics & Machines Lab (ME230)"
    ],
    [
      "Mechanics of Machinery (ME301)",
      "Machine Tools & Digital Manufacturing (ME303)",
      "Computer Programming & Numerical Methods (ME305)",
      "Electrical Drives & Control for Automation (EE311)",
      "Principles of Management (HS300)",
      "Elective 1(ME36X)",
      "Design Project (ME341)",
      "Electrical and Electronics Lab (EE335)",
      "Manufacturing Technology Lab I(ME 331)"
    ],
    [
      "Heat & Mass Transfer (ME302)",
      "Dynamics of Machinery (ME304)",
      "Advanced Manufacturing Technology (ME306)",
      "Computer Aided Design and Analysis (ME308)",
      "Metrology and Instrumentation (ME312)",
      "Elective 2(ME36X) ",
      "Computer Aided Design & Analysis Lab (ME332)",
      "Manufacturing Technology Lab II (ME334)",
      "Comprehensive Exam (ME352)"
    ],
    [
      "Design of Machine Elements I (ME401)",
      "Advanced Energy Engineering (ME403)",
      "Refrigeration and Air Conditioning (ME405)",
      "Mechatronics (ME407)",
      "Compressible Fluid Flow (ME409)",
      "Elective 3(ME46X)",
      "Seminar & Project Preliminary (ME451)",
      "Mechanical Engineering Lab (ME431)"
    ],
    [
      "Design of Machine Elements II (ME402)",
      "Industrial Engineering (ME404)",
      "Elective 4 (ME46X) ",
      "Elective 5 (Non Departmental) ",
      "Project (ME492)"
    ]
  ],
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Mechanics of Solids (CE201)",
      "Fluid Mechanics I (CE203)",
      "Engineering Geology (CE205)",
      "Surveying (CE207)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Civil Engineering Drafting Lab (CE231)",
      "Surveying Lab (CE233)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Structural Analysis I (CE202)",
      "Construction Technology (CE204)",
      "Fluid Mechanics II (CE206)",
      "Geotechnical Engineering I (CE208)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Materials Testing Lab I (CE232)",
      "Fluid Mechanics Lab (CE234)"
    ],
    [
      "Design of Concrete Structures I (CE301)",
      "Structural Analysis II (CE303)",
      "Geotechnical Engineering II (CE305)",
      "Geomatics (CE307)",
      "Water Resources Engineering (CE309)",
      "Elective 1(CE36X)  ",
      "Design Project (CE341)",
      "Materials Testing Lab II (CE331)",
      "Geotechnical Engineering Lab (CE333 )"
    ],
    [
      "Design of Hydraulic Structures (CE302)",
      "Design of Concrete Structures II (CE304)",
      "Computer Programming and Computational Techniques (CE306)",
      "Transportation Engineering I (CE308)",
      "Principles of Management (HS300)",
      "Elective 2 (CE36X) ",
      "Transportation Engineering Lab (CE332)",
      "Computer Aided Civil Engineering Lab (CE334)",
      "Comprehensive Exam (CE352)"
    ],
    [
      "Design of Steel Structures (CE401)",
      "Structural Analysis III (CE403)",
      "Environmental Engineering I (CE405)",
      "Transportation Engineering II (CE407)",
      "Quantity Surveying and Valuation (CE409)",
      "Elective 3(CE46X) ",
      "Seminar & Project Preliminary (CE451)",
      "Environmental Engineering Lab (CE431)"
    ],
    [
      "Environmental Engineering II (CE402)",
      "Civil Engineering Project Management (CE404)",
      "Elective 4 (CE46X) ",
      "Elective 5 (Non Departmental) ",
      "Project (CE492)"
    ]
  ],
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Network Theory (EC201)",
      "Solid State Devices (EC203)",
      "Electronic Circuits (EC205)",
      "Logic Circuit Design (EC207)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Electronic Devices & Circuits Lab (EC231)",
      "Electronic Design Automation Lab (EC223)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Signals & Systems (EC202)",
      "Analog Integrated Circuits (EC204)",
      "Computer Organization (EC206)",
      "Analog Communication Engineering (EC208)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Analog Integrated Circuits Lab (EC232)",
      "Logic Circuit Design Lab (EC230)"
    ],
    [
      "Digital Signal Processing (EC301)",
      "Applied Electromagnetic Theory (EC303)",
      "Microprocessors & Microcontrollers (EC305)",
      "Power Electronics & Instrumentation (EC307)",
      "Principles of Management (HS300)",
      "Elective 1(EC36X) ",
      "Design Project (EC341)",
      "Digital Signal Processing Lab (EC333)",
      "Power Electronics & Instrumentation Lab (EC335 )"
    ],
    [
      "Digital Communication (EC302)",
      "VLSI (EC304)",
      "Antenna & Wave Propagation (EC306)",
      "Embedded Systems (EC308)",
      "Object Oriented Programming (EC312)",
      "Elective 2 (EC36X) ",
      "Communication Engg Lab (Analog & Digital) (EC332)",
      "Microcontroller Lab (EC334)",
      "Comprehensive Exam (EC352)"
    ],
    [
      "Information Theory & Coding (EC401)",
      "Microwave & Radar Engineering (EC403)",
      "Optical Communication (EC405)",
      "Computer Communication (EC407)",
      "Control Systems (EC409)",
      "Elective 3(EC46X) ",
      "Seminar & Project Preliminary (EC451)",
      "Communication Systems Lab (Optical & Microwave) (EC431)"
    ],
    [
      "Nano electronics (EC402)",
      "Advanced Communication Systems (EC404)",
      "Elective 4 (EC46X) ",
      "Elective 5 (Non Departmental) ",
      "Project (EC492)"
    ]
  ],
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Circuits and Networks (EE201)",
      "Analog Electronic Circuits (EE203)",
      "DC Machines and Transformers (EE205)",
      "Computer Programming (EE207)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Electronic Circuits Lab (EE231)",
      "Programming Lab (EE233)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Synchronous and Induction Machines (EE202)",
      "Digital Electronics and Logic Design(EE204)",
      "Material Science (EE206)",
      "Measurements and Instrumentation(EE208)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Electrical Machines Lab I (EE232)",
      "Circuits and Measurements Lab (EE234)"
    ],
    [
      "Power Generation, Transmission and Protection (EE301)",
      "Linear Control Systems (EE303)",
      "Power Electronics (EE305)",
      "Signals and Systems (EE307)",
      "Microprocessor and Embedded Systems (EE309)",
      "Elective 1(EE36X) ",
      "Design Project (EE341)",
      "Digital Circuits and Embedded Systems Lab (EE331)",
      "Electrical Machines Lab II (EE333)"
    ],
    [
      "Electromagnetics (EE302)",
      "Advanced Control Theory (EE304)",
      "Power System Analysis (EE306)",
      "Electric Drives (EE308)",
      "Principles of Management (HS300)",
      "Elective 2 (EE36X) ",
      "Systems and Control Lab (EE332)",
      "Power Electronics & Drives Lab (EE334)",
      "Comprehensive Exam (EE352)"
    ],
    [
      "Electronic Communication (EE401)",
      "Distributed Generation and Smart Grids (EE403)",
      "Electrical System Design (EE405)",
      "Digital Signal Processing (EE407)",
      "Electrical Machine Design (EE409)",
      "Elective 3(EE46X)",
      "Seminar & Project Preliminary (EE451)",
      "Power System Lab (EE431)"
    ],
    [
      "Special Electric Machines (EE402)",
      "Industrial Instrumentation & Automation (EE404)",
      "Elective 4 (EE46X)",
      "Elective 5 (Non Departmental) ",
      "Project (EE492)"
    ]
  ],
  [
    [
      "Linear Algebra and Calculus",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Life Skills",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
    ],
    [
      "Vector Calculus, Differential Equations and Transforms",
      "Engineering Physics/ Engineering Chemistry ",
      "Engineering Mechanics /Engineering Graphics",
      "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
      "Engineering Physics Lab/Engineering Chemistry Lab",
      "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
      "Professional Communication",
      "Programming in C",
    ],
    [
      "Linear Algebra & Complex Analysis (MA201)",
      "Discrete Computational Structures (CS201)",
      "Digital System Design (IT201)",
      "Data Structures (CS205)",
      "Data Communication (IT203)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Data Structures Lab (CS231)",
      "Digital Circuits Lab (IT231)"
    ],
    [
      "Probability Distributions, Transforms and Numerical Methods (MA202)",
      "Computer Organization and Architecture (CS202)",
      "Algorithm Analysis & Design (IT202)",
      "Object Oriented Techniques (IT204)",
      "Principles of Data Base Design (CS208)",
      "Lifeskills (HS210) or Business Economics (HS200)",
      "Object Oriented Programming Lab (IT232)",
      "Algorithm Design Lab (IT234)"
    ],
    [
      "Software Architecture & Design Patterns (IT301)",
      "Theory of Computation (IT303)",
      "Microprocessors & Microcontrollers (CS305)",
      "Operating Systems (IT305)",
      "Computer Networks (IT307)",
      "Elective 1(IT36X) ",
      "Design Project (IT341)",
      "Microcontroller Lab (IT331)",
      "Database Lab (IT333)"
    ],
    [
      "Internet Technology (IT302)",
      "Compiler Design (CS304)",
      "Data Warehousing & Mining (IT304)",
      "Distributed Systems (IT306)",
      "Principles of Management (HS300)",
      "Elective 2 (IT36X) ",
      "Internet Technology Lab (IT332)",
      "Computer Networks Lab (IT334)",
      "Comprehensive Exam (IT352)"
    ],
    [
      "Embedded Systems (IT401)",
      "Mobile Computing (IT403)",
      "Internet Working with TCP IP (IT405)",
      "Knowledge Engineering (IT407)",
      "Web Application Development (IT409)",
      "Elective 3(IT46X) ",
      "Seminar & Project Preliminary (IT451)",
      "Web Application Lab (IT431)"
    ],
    [
      "Cryptography & Cyber Security (IT402)",
      "Data Analytics (IT404)",
      "Elective 4 (IT46X)",
      "Elective 5 (Non Departmental) ",
      "Project (IT492)"
    ]
  ]
];
List<List<List<String>>> shorts = [
  [
    [],
    [],
    ["Maths", "CS", "STLD", "DS", "ED & C", "LS / BE", "DS Lab", "EC Lab"],
    ["Maths", "COA", "OS", "OOD&P", "PDD", "LS / BE", "FOSS Lab", "DS Lab"],
    ["TC", "SS", "MP & MC", "DC", "GT&C", "E1", "Project", "SS Lab", "ASD Lab"],
    ["DAA", "CD", "CN", "SE & PM", "PM", "E2", "MP Lab", "NP Lab", "Exam"],
    ["CG", "PP", "CSA", "DC", "CNS", "E3", "Seminar", "CD Lab"],
    ["DM & WH", "ES", "E4", "E5", "Project"]
  ],
  [
    [],
    [],
    ["Maths", "MS", "MF", "T-dynamics", "MME", "LS / BE", "CAMD Lab", "MT Lab"],
    ["Maths", "AMS", "TE", "FM", "MT", "LS / BE", "TE Lab", "FMM Lab"],
    [
      "MM",
      "MT & DM",
      "CP & NP",
      "EDCA",
      "PM",
      "E1",
      "Project",
      "EE Lab",
      "MT Lab I"
    ],
    ["HMT", "DM", "AMT", "CADA", "MI", "ES", "CADA Lab", "MT Lab II", "Exam"],
    ["DME I", "AEE", "R & AC", "M-tronics", "CFF", "E3", "Seminar", "ME Lab"],
    ["DME II", "IE", "E4", "E5", "Project"]
  ],
  [
    [],
    [],
    [
      "Maths",
      "MS",
      "FM I",
      "Geology",
      "Surveying",
      "LS / BE",
      "Drafting Lab",
      "Survey Lab"
    ],
    ["Maths", "SA I", "CT", "FM II", "GE I", "LS / BE", "MT Lab I", "FM Lab"],
    [
      "DCS I",
      "SA II",
      "GE II",
      "Geomatics",
      "WRE",
      "E1",
      "Project",
      "MT Lab II",
      "GEL"
    ],
    [
      "DHS",
      "DCS II",
      "CP & CT",
      "TE I",
      "PM",
      "E2",
      "TEL",
      "CACE Lab (CE334)",
      "Exam"
    ],
    ["DSS", "SA III", "EE I", "TE II", "QSV", "E3", "Seminar", "EE Lab"],
    ["EE II", "CEPM", "E4", "E5", "Project"]
  ],
  [
    [],
    [],
    ["Maths", "NT", "SSD", "EC", "LCD", "LS / BE", "EDC Lab", "EDA Lab"],
    ["Maths", "S & S", "AIC", "CO", "ACE", "LS / BE", "AIC Lab", "LCD Lab"],
    ["DSP", "AET", "Mp & Mc", "PE & I", "PM", "E1", "DP", "DSP Lab", "PE&IL"],
    ["DC", "VLSI", "A&WP", "ES", "OOP", "E2", "CE Lab", "Mc Lab", "Exam"],
    ["IT&C", "M&RE", "OC", "CC", "CS", "E3", "Seminar", "CS Lab"],
    ["NE", "ACS", "E4", "E5", "Project"]
  ],
  [
    [],
    [],
    ["Maths", "CN", "AEC", "DC MT", "CP", "LS / BE", "EC Lab", "Prog Lab"],
    ["Maths", "SIM", "DELD", "MS", "MI", "LS / BE ", "EM LabI", "CM Lab"],
    [
      "PGTP",
      "LCS",
      "PE",
      "S&S",
      "MES",
      "E1",
      "Project",
      "DCES Lab",
      "EM LabII"
    ],
    ["EM", "ACT", "PSA", "ED", "PM", "E2", "SC Lab", "PED Lab", "Exam"],
    ["EC", "DG&SG", "ESD", "DSP", "EMD", "E3", "Seminar", "PS Lab"],
    ["SEM", "IIA", "E4", "E5", "Project"]
  ],
  [
    [],
    [],
    ["Maths", "DCS", "DSD", "DS", "DC", "LS/BE", "DS Lab", "DC Lab"],
    ["Maths", "COA", "AAD", "OOT", "PDBD", "LS/BE", "OOP Lab", "AD Lab"],
    [
      "SA & DP",
      "TC",
      "Mp & Mc",
      "OS",
      "CN",
      "E1",
      "Project",
      "MC Lab",
      "D Lab"
    ],
    ["IT", "CD", "DWM", "DS", "PM", "E2", "IT Lab", "CNL", "CE"],
    ["ES", "MC", "TCP IP", "KE", "Web App", "E3", "Seminar", "WAL"],
    ["CCS", "DA", "E4", "E5", "Project"]
  ]
];
