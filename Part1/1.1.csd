<CsoundSynthesizer>
<CsOptions>

-odac  

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

itable = p4
iadFactor = 0.01
iatkDur = p3 * iadFactor
idecDur = p3 * (1 - iadFactor)

aenv = linseg(0, iatkDur, 1, idecDur, 0)
aosc = oscili(0.5 * aenv, 440, itable)
aosc = moogvcf2(aosc, 2300, 0.2)
outs aosc, aosc

endin

</CsInstruments>

<CsScore>
r 30      
i1 0 2 1  
i. + . 2
i. + . 3

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
