#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


(*[name of this script] [name of file with data] [r0 value]*)


(*output:ru,c,l*)


scriptPath = ExpandFileName[First[$ScriptCommandLine]];
scriptName = Last[FileNameSplit[ scriptPath ]];


filename=$ScriptCommandLine[[2]];


r0=ToExpression[$ScriptCommandLine[[3]]]*1.0;


rint=ToExpression[$ScriptCommandLine[[4]]]*1.0;


(*Print["\nStringPath:"<>StringPart[scriptPath,1;;StringLength[scriptPath]-StringLength[scriptName]]]*)


scriptDirectory=StringPart[scriptPath,1;;StringLength[scriptPath]-StringLength[scriptName]];


(*r0=100.;*)


(*currentlist=Import[scriptDirectory<>"run2.csv"];*)


currentlist=Import[scriptDirectory<>filename];


(*listfun=Interpolation[currentlist];*)


freqlist=currentlist[[;;,1]];


voltlist=currentlist[[;;,2]];


maxvolt=Max[voltlist];


halfvalue=maxvolt/Sqrt[2];


(*nearesthalfvalue=Nearest[voltlist,halfvalue][[1]];*)


(*nearesthalfvaluepos=Position[voltlist,nearesthalfvalue][[1,1]];*)


(*nearesthalfvalueposhalf=Round[nearesthalfvaluepos/1*.75];*)


(*nearesthalfvalueposhalf=1;*)


(*voltlist=voltlist[[nearesthalfvalueposhalf;;]];*)


(*freqlist=freqlist[[nearesthalfvalueposhalf;;]];*)


(*currentlist=currentlist[[nearesthalfvalueposhalf;;]];*)


listfun=Interpolation[currentlist];


maxvoltpos=Position[voltlist,Max@voltlist][[1,1]];


firstfreq=freqlist[[1]];


lastfreq=freqlist[[-1]];


f0=freqlist[[maxvoltpos]];


leftsearch=(f0-firstfreq)/2;


w0=2\[Pi] f0;


fl=f/.FindRoot[listfun[f]==maxvolt/Sqrt[2],{f,f0-leftsearch,firstfreq,lastfreq}]


wl=2\[Pi] fl;


ruguess2=r0/maxvolt-r0-rint;


e1=w0==1/Sqrt[l c];


e2=maxvolt==r0/Sqrt[(ru+r0+rint)^2+(2\[Pi] f0 l-1/(2\[Pi] f0 c))^2]/.{ru->ruguess2};


e3=wl==-ru/(2l)+Sqrt[(ru/(2 l))^2+1/(l c)]/.{ru->ruguess2};


sol2=FindRoot[{e1,e3},{{c,5*10^-8,2.7*10^-9,10.*10^-7},{l,.1,.027,10}}];


cguess=Check[c/.sol2,5*10^-8];


lguess=Check[l/.sol2,.1];


(*sol1=NSolve[{e1,e2,e3},{l,c,ru}];*)


(*cguesslist=c/.sol1;*)


(*cguess=Select[cguesslist, Positive][[1]];*)


(*lguesslist=l/.sol1;*)


(*lguess=Select[lguesslist, Positive][[1]];*)


(*ruguesslist=ru/.sol1;*)


(*ruguess=Select[ruguesslist, Positive][[1]];*)


(*fit1=NonlinearModelFit[currentlist,{r0/Sqrt[(ru+r0+rint)^2+(2\[Pi] f l-1/(2\[Pi] f c))^2],10000>ru>1,10*10^-7>c>2.7*10^-9,10>l>.027},{{ru},{c},{l}},f,Method->"NMinimize"];*)


(*fit1=NonlinearModelFit[currentlist,{r0/Sqrt[(ru+r0+rint)^2+(2\[Pi] f l-1/(2\[Pi] f c))^2],10000>ru>1,10*10^-7>c>2.7*10^-9,10>l>.027},{{ru,ruguess},{c,cguess},{l,lguess}},f,Method->"NMinimize"];*)


(*fit1=NonlinearModelFit[currentlist,{r0/Sqrt[(ru+r0+rint)^2+(2\[Pi] f l-1/(2\[Pi] f c))^2],10000>ru>1,10*10^-7>c>2.7*10^-9,10>l>.027},{{ru,ruguess2},{c,cguess},{l,lguess}},f,Method->"NMinimize",Weights->(Sqrt[#2]&)];*)


fit1=NonlinearModelFit[currentlist,{r0/Sqrt[(ru+r0+rint)^2+(2\[Pi] f l-1/(2\[Pi] f c))^2],10000>ru>1,10*10^-7>c>2.7*10^-9,10>l>.027},{{ru,ruguess2},{c,cguess},{l,lguess}},f,Method->"NMinimize",Weights->(Sqrt[#2]&),MaxIterations->10000];


(*Print[fit1["BestFitParameters"]]*)


para=fit1["BestFitParameters"];


ru=DecimalForm[ru/.para];


c=DecimalForm[c/.para];


l=DecimalForm[l/.para];


Print[ToString[ru]<>","<>ToString[c]<>","<>ToString[l]]
