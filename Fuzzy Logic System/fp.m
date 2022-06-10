fis = mamfis(Name="Fizzy Drink");

fis = addInput(fis, [7 16], Name="Temperature");
fis = addMF(fis,"Temperature","trimf",[7, 7, 9],Name="Verycold");
fis = addMF(fis,"Temperature","trimf",[7, 9, 11],Name="Cold");
fis = addMF(fis,"Temperature","trimf",[10, 12, 14],Name="Normal");
fis = addMF(fis,"Temperature","trimf",[12, 14, 16],Name="Hot");
fis = addMF(fis,"Temperature","trimf",[13, 16, 16],Name="Veryhot");

fis = addInput(fis, [1.75, 4.0], Name="Pressure");
fis = addMF(fis,"Pressure","trimf",[1.75, 1.75, 2.25],Name="Verybad");
fis = addMF(fis,"Pressure","trimf",[1.75, 2.25, 2.5],Name="Bad");
fis = addMF(fis,"Pressure","trimf",[2.25, 2.75, 3.25],Name="Normal");
fis = addMF(fis,"Pressure","trimf",[2.5, 3.25, 3.5],Name="Good");
fis = addMF(fis,"Pressure","trimf",[2.75, 4.0, 4.0],Name="Verygood");

fis = addOutput(fis, [2.0, 6.0], Name="Carbondioxide");
fis = addMF(fis,"Carbondioxide","trimf",[2.0, 2.0, 3.0],Name="Verybad");
fis = addMF(fis,"Carbondioxide","trimf",[2.0, 3.0, 4.0],Name="Bad");
fis = addMF(fis,"Carbondioxide","trimf",[3.0, 4.0, 5.0],Name="Normal");
fis = addMF(fis,"Carbondioxide","trimf",[4.0, 5.0, 6.0],Name="Good");
fis = addMF(fis,"Carbondioxide","trimf",[5.0, 6.0, 6.0],Name="Verygood");

rule1 = "If Temperature is Verycold and Pressure is Verybad then Carbondioxide is Normal";
rule2 = "If Temperature is Verycold and Pressure is Bad then Carbondioxide is Normal";
rule3 = "If Temperature is Verycold and Pressure is Normal then Carbondioxide is Good";
rule4 = "If Temperature is Verycold and Pressure is Good then Carbondioxide is Verygood";
rule5 = "If Temperature is Verycold and Pressure is Verygood then Carbondioxide is Verygood";
rule6 = "If Temperature is Cold and Pressure is Verybad then Carbondioxide is Bad";
rule7 = "If Temperature is Cold and Pressure is Bad then Carbondioxide is Good";
rule8 = "If Temperature is Cold and Pressure is Normal then Carbondioxide is Good";
rule9 = "If Temperature is Cold and Pressure is Good then Carbondioxide is Good";
rule10 = "If Temperature is Cold and Pressure is Verygood then Carbondioxide is Verygood";
rule11 = "If Temperature is Normal and Pressure is Verybad then Carbondioxide is Bad";
rule12 = "If Temperature is Normal and Pressure is Bad then Carbondioxide is Normal";
rule13 = "If Temperature is Normal and Pressure is Normal then Carbondioxide is Normal";
rule14 = "If Temperature is Normal and Pressure is Good then Carbondioxide is Good";
rule15 = "If Temperature is Normal and Pressure is Verygood then Carbondioxide is Verygood";
rule16 = "If Temperature is Hot and Pressure is Verybad then Carbondioxide is Bad";
rule17 = "If Temperature is Hot and Pressure is Bad then Carbondioxide is Bad";
rule18 = "If Temperature is Hot and Pressure is Normal then Carbondioxide is Normal";
rule19 = "If Temperature is Hot and Pressure is Good then Carbondioxide is Normal";
rule20 = "If Temperature is Hot and Pressure is Verygood then Carbondioxide is Good";
rule21 = "If Temperature is Veryhot and Pressure is Verybad then Carbondioxide is Verybad";
rule22 = "If Temperature is Veryhot and Pressure is Bad then Carbondioxide is Bad";
rule23 = "If Temperature is Veryhot and Pressure is Normal then Carbondioxide is Normal";
rule24 = "If Temperature is Veryhot and Pressure is Good then Carbondioxide is Normal";
rule25 = "If Temperature is Veryhot and Pressure is Verygood then Carbondioxide is Good";

rules = [
    rule1 rule2 rule3 rule4 rule5 
    rule6 rule7 rule8 rule9 rule10 
    rule11 rule12 rule13 rule14 rule15 
    rule16 rule17 rule18 rule19 rule20 
    rule21 rule22 rule23 rule24 rule25
];

fis = addRule(fis,rules);

input = [12, 3.95];
[~,~,~,aggregatedOut,~] = evalfis(fis, input);

aggregatedOutRange = fis.output.Range;
aggregatedOutLength = length(aggregatedOut);

x = linspace(aggregatedOutRange(1),aggregatedOutRange(2),aggregatedOutLength);
y = aggregatedOut;
output = defuzz(x, y, 'centroid');

plot(x,y,[output output],[0 1],LineWidth=3);
xlabel('Percentage of Carbon Dioxide');
ylabel('Membership');
title(['T: ' num2str(input(1)) ' P: ' num2str(input(2)) ' -> C: ' num2str(output)]);
legend('Aggregated','Output');