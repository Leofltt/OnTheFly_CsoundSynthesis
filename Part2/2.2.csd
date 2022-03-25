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

opcode declick,a,a
ain xin
aout = ain * expseg(0.001, 0.05,1,p3-0.1,1,0.1,0.005)
xout aout
endop


ifn ftgen 1,0,isize,-7,0.8,0.55*isize,-1,0.45*isize,-1

opcode LPdel,i,ii
;output:
;idel - lowpass delay (samples)
;inputs:
;ifund - fund freq
;icf - cutoff freq
 ifund,icf xin
 ipi = $M_PI
 itheta = 2*ipi*icf/sr
 iomega = 2*ipi*ifund/sr
 ib = sqrt((2 - cos(itheta))^2 -1) - 2 + cos(itheta)
 iden = (1 + 2*ib*cos(iomega) + ib*ib)
 ire = (1. + ib + cos(iomega)*(ib+ib*ib))/iden
 img =  sin(iomega)*(ib + ib*ib)/iden
 xout -taninv2(img,ire)/iomega
endop

opcode Reed,a,akki
;ain - input (feedback) signal
;kpr - pressure amount
;kem - embouch pos (0-1)
;ifn - reed transfer fn
 ain,kpr,kem,ifn xin
 apr linsegr 0,.005,1,p3,1,.01,0
 asig = ain-apr*kpr-kem
 awsh tablei .25*asig,ifn,1,.5
 asig *= awsh
 xout asig
endop


opcode Ap,a,ai
;ain - input signal
;ic - all-pass coefficient
 setksmps 1
 asig,ic xin
 aap init 0
 aap = ic*(asig - aap) + delay1(asig)
 xout aap
endop

opcode Clarinet,a,kiiii
 kamp,ifund,iap,iem,ifilt xin
;kamp - amplitude
;ifund - fundamental
;iap - air pressure
;iem - embouch pos
;ifilt - lowpass filter factor
 setksmps 1
 awg2 init 0
 aap init 0
 ifund *= 2
 ifilt = ifund*ifilt
 ilpd = LPdel(ifund,ifilt)
 ides = sr/ifund
 idtt = int(ides - ilpd)
 ifrc = ides - (idtt + ilpd)
 ic = (1-ifrc)/(1+ifrc)
 awg1 delayr idtt/sr
 afdb = Ap(tone(awg1,ifilt), ic)
      delayw Reed(-afdb,iap,iem,1)
 xout dcblock2(awg1*kamp)
endop

instr 1
iAmp = 0.5
iPitch = p4
iAp = 0.7
iEm = 0.8
iF = 2.5
 asig Clarinet iAmp,iPitch,iAp,iEm,iF
 asig = declick(asig)
 outs asig,asig
endin

instr 2

iNoteLength = p4
kRand = randomh(1, 7, 1/iNoteLength)
kPitch = cpsmidinn(40+kRand)

kmetro metro 1/iNoteLength

schedkwhen(kmetro, 0, -1, 1, 0, iNoteLength, kPitch)
endin

schedule(2,0,-1,1)


</CsInstruments>
<CsScore>


</CsScore>
</CsoundSynthesizer>
