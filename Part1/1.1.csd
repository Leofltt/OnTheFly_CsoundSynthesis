<CsoundSynthesizer>
<CsOptions>

-odac  
-d

</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32 
nchnls = 2
0dbfs = 1

gisine = ftgen(1, 0, 4096, 10, 1)                             ; Sine wave
gisquare = ftgen(2, 0, 4096, 7, 1, 2048, 1, 0, -1, 2048, -1)  ; Square wave
gisaw = ftgen(3, 0, 4096, 7, 0, 2048, 1, 0, -1, 2048, 0)      ; Saw wave  

instr 1

itable = 1
iadFactor = 0.01
iatkDur = p3 * iadFactor
idecDur = p3 * (1 - iadFactor)

kRand = randomh(1, 13, 1/iNoteLength)
kPitch = cpsmidinn(48+kRand)

aenv = linseg(0, iatkDur, 1, idecDur, 0)
aosc = oscili(0.5 * aenv, kPitch, itable)
aosc = moogvcf2(aosc, 2300, 0.2)
outs aosc, aosc

endin

instr 2

iNoteLength = p4

kmetro metro 1/iNoteLength

schedkwhen(kmetro, 0, -1, 1, 0, iNoteLength)
endin

schedule(2,0,-1,0.5)

</CsInstruments>

<CsScore>


</CsScore>
</CsoundSynthesizer>



<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
