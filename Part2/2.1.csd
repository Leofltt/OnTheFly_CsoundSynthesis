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

aAmp = 0.8
aFreq = p4

aModDepth1 = 110
kModRatio1 = 2.2
aModFreq1 = aFreq * kModRatio1

aModDepth2 = 5
kModRatio2 = 3
aModFreq2 = aFreq * kModRatio2

kAlgo = 1

if kAlgo == 0 then ; Mod1 -> Mod2 -> Carrier
amod1 PMOp aModDepth1,aModFreq1,a(0),0.7,p3
amod2 PMOp aModDepth2,aModFreq2,amod1,0.2,p3
acar PMOp aAmp,aFreq,amod2,0.8,p3

elseif kAlgo == 1 then ; Mod1 + Mod2 -> Carrier 
amod1 PMOp aModDepth1,aModFreq1,a(0),0.6,p3
amod2 PMOp aModDepth2,aModFreq2,a(0),0.7,p3
acar PMOp aAmp,aFreq,amod1 + amod2,0.1,p3
endif

outs acar,acar
endin

instr 2

iNoteLength = p4
kRand = randomh(1, 7, 1/iNoteLength)
kPitch = cpsmidinn(60+kRand)

kmetro metro 1/iNoteLength

schedkwhen(kmetro, 0, -1, 1, 0, iNoteLength, kPitch)
endin

schedule(2,0,-1,1)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
