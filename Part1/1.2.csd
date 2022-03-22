<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

schedule(1,0,10,0dbfs/20,220,100)

ginitf = ftgen(0,0,128,7,0,128/2,1,128/2,0)
gifnvel  ftgen 1, 0, 128, 7, 0, 64, 1,64, 0      ; generating all bunch of tables needed
gifnmass  ftgen 2, 0, 128, -7, 1, 128, 1
gifnstif  ftgen 3, 0, 16384, -23, "string-128.matrxB"
gifncentr  ftgen 4, 0, 128,-7 ,0.5 ,128, 0
gifndamp  ftgen 5, 0, 128, -7, 1, 128, 1
gitraj  ftgen 7, 0, 128, -7, .001, 128,128

instr 1
kpitch  p5
kenvm   adsr 0.02, 0.6, 0.2, 1
kenv2   adsr 0.1, 0.6, 0.8, 1
kenv3   adsr 0.8, 0.6, 0.8, 1

kstif   = 0.3 + 0.1*kvib * kenv3
kmass   = 10-(5*kenvm)                      ; modulated mass
kcentr  = 0.1
kdamp   = -0.02
ileft   = 0.2
iright  = 0.8
kpos    = 0.2
kstrngth = 0.05
id = 1

a2 init 0
scanu ginitf,      ;ftable with initial position of masses, if negative indicates an hammer shape
      0.1,         ;update period (how often model updates state)
      gifnvel,     ;ftable of initial velocity
      gifnmass,    ;ftable with masses of the objects
      gifnstif,    ;connection matrix 
      gifncentr,   ;ftable with centring forces for each mass
      gifndamp,    ;ftable with dampening factors for each mass
      kmass,       ;scaling of the mass
      kstif,       ;scaling of the spring stiffness
      kcentr,      ;scaling of centering forces
      kdamp,       ;scaling of dampening factor
      ileft,iright,;hammers position
      kpos,        ;position of hammer along the string 0 < x < 1
      kstrngth,    ;hammer strength
      a2,          ;audio input (model excitation) you can try exciting with a sample for fun
      0,           ;if 1, display masses' evolution
      id           ;id for the scans opcode. If negative, will be a ftable where the waveshape will be written to (for table reading opcodes)
a1      scans .01*kenv2, ;amp
              kpitch,    ;pitch
              gitraj,    ;trajectory
              id
        outs a1, a1
endin

schedule(1,0,10,0dbfs/20,220,100)

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
