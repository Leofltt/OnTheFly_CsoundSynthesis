<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;UDO definition example

;args : name, output_params, input_params
opcode ADEnv, a, io

iAD, iExp xin 

if iExp == 1 then
aEnv = expseg:a(0.01, (p3 -0.02)*iAD+0.01, 1, (p3 -0.02)*(1-iAD)+0.01, 0.01)
else
aEnv = linseg:a(0, (p3 -0.02)*iAD+0.01, 1, (p3 -0.02)*(1-iAD)+0.01, 0)
endif

xout aEnv
endop

gisine   ftgen 1, 0, 4096, 10, 1                           ; Sine wave
gisquare ftgen 2, 0, 4096, 7, 1, 2048, 1, 0, -1, 2048, -1  ; Square wave
gisaw    ftgen 3, 0, 4096, 7, 0, 2048, 1, 0, -1, 2048, 0   ; Saw wave  

instr 1

aosc = oscili(1, 440,gisine)
aosc *= ADEnv(0.1,1)

outs aosc, aosc
endin

instr 2

iNoteLength = p4

kmetro metro 1/iNoteLength

schedkwhen(kmetro, 0, -1, 1, 0, iNoteLength)
endin

schedule(2,0,100,2)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
