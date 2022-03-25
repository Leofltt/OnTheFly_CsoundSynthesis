<CsoundSynthesizer>
<CsOptions>
-odac -d
--opcode-lib=~/Users/$USER/Library/csound/6.0/plugins64 

</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr 1

aEnv = expseg:a(1,p3,0.001)

aSig = oscili(0dbfs/2, p4)

aOut = example(aSig,aEnv)

outs aOut, aOut
endin

instr 2

iDur = p4

kRand = randomh(1, 13, 1/iDur)
kNote = cpsmidinn(60+kRand)

ktrig metro 1/iDur

schedkwhen(ktrig, 0, -1, 1, 0, iDur, kNote)
endin

schedule(2,0,10,0.7)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>

