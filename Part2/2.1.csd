<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

giSine = ftgen(1, 0, 4097, 10, 1)      

opcode ADEnv, a, iio
iAD, iDur, iExp xin 

if iExp == 1 then
aEnv = expseg:a(0.01, (iDur -0.02)*iAD+0.01, 1, (iDur -0.02)*(1-iAD)+0.01, 0.01)
else
aEnv = linseg:a(0, (iDur -0.02)*iAD+0.01, 1, (iDur -0.02)*(1-iAD)+0.01, 0)
endif

xout aEnv
endop

opcode PMOp,a,aaaiiop
amp,aFreq,aPM,iAD,iDur,iExp,ifn xin

aph = phasor(aFreq)
a1 = tablei:a( aph+aPM/(2*$M_PI),ifn,1,0,1)
a1 *= ADEnv(iAD,iDur,iExp)
  
xout a1
endop

instr 1

aAmp = p4
aFreq = p5
aModDepth = p6
iModRatio = p7
aModFreq = aFreq * iModRatio

amod PMOp aModDepth,aModFreq,a(0),0.7,p3
acar PMOp aAmp,aFreq,amod,0.8,p3
outs acar,acar
endin

schedule(1,0,1,0dbfs/2,330,1.1,3.333)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>

