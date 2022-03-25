<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

isize = 16384

ifn ftgen 1,0,isize,-7,0.8,0.55*isize,-1,0.45*isize,-1

/*********************************
idel LPdel ifo,ifc
idel - lowpass delay (samples)
ifo - fund freq
ifc - cutoff freq
**********************************/
opcode LPdel,i,ii
 ifo,ifc xin
 ipi = $M_PI
 itheta = 2*ipi*ifc/sr
 iomega = 2*ipi*ifo/sr
 ib = sqrt((2 - cos(itheta))^2 -1) - 2 + cos(itheta)
 iden = (1 + 2*ib*cos(iomega) + ib*ib)
 ire = (1. + ib + cos(iomega)*(ib+ib*ib))/iden
 img =  sin(iomega)*(ib + ib*ib)/iden
 xout -taninv2(img,ire)/iomega
endop


/*********************************
asig Reed ain,kpr,kem,ifn
ain - input (feedback) signal
kpr - pressure amount
kem - embouch pos (0-1)
ifn - reed transfer fn
**********************************/
opcode Reed,a,akki
 ain,kpr,kem,ifn xin
 apr linsegr 0,.005,1,p3,1,.01,0
 asig = ain-apr*kpr-kem
 awsh tablei .25*asig,ifn,1,.5
 asig *= awsh
 xout asig
endop

/**********************
asig Ap ain,ic
ain - input signal
ic - all-pass coefficient
********************/
opcode Ap,a,ai
 setksmps 1
 asig,ic xin
 aap init 0
 aap = ic*(asig - aap) + delay1(asig)
 xout aap
endop

/******************************
asig Clarinet kamp,ifun,ipr,iem,ifc
kamp - amplitude
ifun - fundamental
ipr - air pressure
iem - embouch pos
ifc - lowpass filter factor
*******************************/
opcode Clarinet,a,kiiii
 kamp,ifun,ipr,ioff,ifc xin
 awg2 init 0
 aap init 0
 ifun *= 2
 ifc = ifun*ifc
 ilpd = LPdel(ifun,ifc)
 ides = sr/ifun
 idtt = int(ides - ilpd)
 ifrc = ides - (idtt + ilpd)
 ic = (1-ifrc)/(1+ifrc)
 awg1 delayr idtt/sr
 afdb = Ap(tone(awg1,ifc), ic)
      delayw Reed(-afdb,ipr,ioff,1)
 xout dcblock2(awg1*kamp)
endop

instr 1
 asig Pipe p4,p5,p6,p7,p8
     outs asig,asig
endin

</CsInstruments>
<CsScore>

i1 0 1 0.5 440 0.7 0.7 6
i1 + 1 0.5 880 0.9 0.7 5
i1 + 1 0.5 660 0.7 0.7 4.5
i1 + 1 0.5 550 0.8 0.6 3
i1 + 1 0.5 440 0.7 0.6 3.5

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
