;A Csound Document is encapsulated within a CsoundSynthesizer

<CsoundSynthesizer>

;CsOptions set all our command line flags
<CsOptions>

-odac  ;realtime audio output
-b 256 ;SW buffer 
-B 512 ;HW buffer

</CsOptions>

;CsInstruments is where we write our orchestra (aka the various instruments)
<CsInstruments>

;global settings for sample rate, # of channels, amplitude type, control rate
sr = 44100
ksmps = 32 ;number of samples in a control cycle
nchnls = 2
0dbfs = 1

; Instr blocks encapsulate our instruments
instr 1

itable = p4
iadFactor = 0.01
iatkDur = p3 * iadFactor
idecDur = p3 * (1 - iadFactor)

;instruments are built using opcodes, the outputs are on the left, the inputs on the right

aenv linseg 0, iatkDur, 1, idecDur, 0
aosc oscili 0.5 * aenv, 440, itable
aosc moogvcf2 aosc, 2300, 0.2
outs aosc, aosc

endin

</CsInstruments>

;we can perform with an instrument by calling it from the CsScore
<CsScore>

;f : statement to create a table from a gen routine
f 1 0 4096 10 1                     ; Sine wave
f 2 0 4096 7 1 2048 1 0 -1 2048 -1  ; Square wave
f 3 0 4096 7 0 2048 1 0 -1 2048 0   ; Saw wave 

r 5       ;r : repeat the score 30 times

i1 0 2 1  ;i insN start dur itable
i. + . 2
i. + . 3

</CsScore>
</CsoundSynthesizer>













<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>408</x>
 <y>139</y>
 <width>677</width>
 <height>513</height>
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
