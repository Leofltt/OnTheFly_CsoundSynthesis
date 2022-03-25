<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr 1

iHam = ftgen(8,0,128,10,1)

initf = ftgen(1,0,128,7,0,64,1,64,0)
ivel = ftgen(2, 0, 128, 7, 0, 64, 1,64, 1)   
imass = ftgen(3, 0, 128, -7, 1, 128, 1)
istif = ftgen(4, 0, 16384, -23, "files/string-128.matrix")
icentr = ftgen(5, 0, 128,-7 ,0.5 ,128, 0)
idamp = ftgen(6, 0, 128, 7, 1, 128, 1)
itraj = ftgen(7, 0, 128, -7, .001, 128,128)
;itraj2 = ftgen(7, 0, 128, -7, .001, 64, 10, 50, 100, 18, 14)

kpitch = p4 + 0.03 * p4 * lfo(1,5)
kenvm = adsr(0.001, 0.8, 0.2, 1)
kAmp = adsr(0.1, 0.6, 0.6, 1)
kenv3 = adsr(0.8, 0.6, 0.8, 1)

kstif = 0.7 + 0.1 * kenv3
kmass =100-(5*kenvm)       
kcentr = 0.1
kdamp = -0.02
ileft = 0.01
iright = 0.9
kpos = 0.1
kstrength = 0.005
id = 1

a2 init 0
scanu 2,      ;ftable with initial position of masses, if negative indicates an hammer shape
      0.1,         ;update period (how often model updates state)
      ivel,     ;ftable of initial velocity
      imass,    ;ftable with masses of the objects
      istif,    ;connection matrix 
      icentr,   ;ftable with centring forces for each mass
      idamp,    ;ftable with dampening factors for each mass
      kmass,       ;scaling of the mass
      kstif,       ;scaling of the spring stiffness
      kcentr,      ;scaling of centering forces
      kdamp,       ;scaling of dampening factor
      ileft,iright,;hammers position
      kpos,        ;position of hammer along the string 0 < x < 1
      kstrength,    ;hammer strength
      a2,          ;audio input (model excitation) you can try exciting with a sample for unique outcomes
      0,           ;if 1, display masses' evolution
      id           ;id for the scans opcode. If negative, will be a ftable where the waveshape will be written to (for table reading opcodes)
a1 scans .05*kAmp,kpitch,itraj,id
a1 dcblock a1
outs a1, a1
endin


instr 2

iNoteLength = p4
kPitch = cpsmidinn(60)

kmetro metro 1/iNoteLength

schedkwhen(kmetro, 0, -1, 1, 0, iNoteLength, kPitch)
endin

schedule(2,0,-1,5)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
