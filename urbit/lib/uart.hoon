  ::
::::  UART helper library
::
::
|%
+$  cc-name  $:
    vintr=@uxC
    vquit=@uxC
    verase=@uxC
    vkill=@uxC
    veof=@uxC
    vtime=@uxC
    vmin=@uxC
    vswtc=@uxC
    vstart=@uxC
    vstop=@uxC
    vsusp=@uxC
    veol=@uxC
    vreprint=@uxC
    vdiscard=@uxC
    vwerase=@uxC
    vlnext=@uxC
    veol2=@uxC
  ==
+$  termios   
  $:
    iflag=@ux
    oflag=@ux
    cflag=@ux
    lflag=@ux
    line=@uxC
    cc=cc-name
  == ::termis
::
++  off  |%
  ++  iflag  0
  ++  oflag  4
  ++  cflag  8
  ++  lflag  12
  ++  line   16
  ++  cc  |%
    ++  vintr     17
    ++  vquit     18
    ++  verase    19
    ++  vkill     20
    ++  veof      21
    ++  vtime     22
    ++  vmin      23
    ++  vswtc     24
    ++  vstart    25
    ++  vstop     26
    ++  vsusp     27
    ++  veol      28
    ++  vreprint  29
    ++  vdiscard  30
    ++  vwerase   31
    ++  vlnext    32
    ++  veol2     33
  --
--
::
++  baud  |%
  ++  cbaud     10.017
  ++  b0        0
  ++  b50       1
  ++  b75       2
  ++  b110      3
  ++  b134      4
  ++  b150      5
  ++  b200      6
  ++  b300      7
  ++  b600      10
  ++  b1200     11
  ++  b1800     12
  ++  b2400     13
  ++  b4800     14
  ++  b9600     15
  ++  b19200    16
  ++  b38400    17
  ++  b57600    10.001
  ++  b115200   10.002
  ++  b230400   10.003
  ++  b460800   10.004
  ++  b500000   10.005
  ++  b576000   10.006
  ++  b921600   10.007
  ++  b1000000  10.010
  ++  b1152000  10.011
  ++  b1500000  10.012
  ++  b2000000  10.013
  ++  b2500000  10.014
  ++  b3000000  10.015
  ++  b3500000  10.016
  ++  b4000000  10.017
--
::
++  unpack-term
  |=  bytestr=@
  ^-  termios
  =/  termios  *termios
  %_  termios
    iflag        (cut 3 [iflag:off 4] bytestr)
    oflag        (cut 3 [oflag:off 4] bytestr)
    cflag        (cut 3 [cflag:off 4] bytestr)
    lflag        (cut 3 [lflag:off 4] bytestr)
    line         (cut 3 [line:off 1] bytestr)
    vintr.cc     (cut 3 [vintr:cc:off 1] bytestr)
    vquit.cc     (cut 3 [vquit:cc:off 1] bytestr)
    verase.cc    (cut 3 [verase:cc:off 1] bytestr)
    vkill.cc     (cut 3 [vkill:cc:off 1] bytestr)
    veof.cc      (cut 3 [veof:cc:off 1] bytestr)
    vtime.cc     (cut 3 [vtime:cc:off 1] bytestr)
    vmin.cc      (cut 3 [vmin:cc:off 1] bytestr)
    vswtc.cc     (cut 3 [vswtc:cc:off 1] bytestr)
    vstart.cc    (cut 3 [vstart:cc:off 1] bytestr)
    vstop.cc     (cut 3 [vstop:cc:off 1] bytestr)
    vsusp.cc     (cut 3 [vsusp:cc:off 1] bytestr)
    veol.cc      (cut 3 [veol:cc:off 1] bytestr)
    vreprint.cc  (cut 3 [vreprint:cc:off 1] bytestr)
    vdiscard.cc  (cut 3 [vdiscard:cc:off 1] bytestr)
    vwerase.cc   (cut 3 [vwerase:cc:off 1] bytestr)
    vlnext.cc    (cut 3 [vlnext:cc:off 1] bytestr)
    veol2.cc     (cut 3 [veol2:cc:off 1] bytestr)
  ==
::
++  pack-term
  |=  =termios
  ^-  @ux
  ;:  con
    (lsh [3 veol2:cc:off] veol2.cc.termios)
    (lsh [3 vlnext:cc:off] vlnext.cc.termios)
    (lsh [3 vwerase:cc:off] vwerase.cc.termios)
    (lsh [3 vdiscard:cc:off] vdiscard.cc.termios)
    (lsh [3 vreprint:cc:off] vreprint.cc.termios)
    (lsh [3 veol:cc:off] veol.cc.termios)
    (lsh [3 vsusp:cc:off] vsusp.cc.termios)
    (lsh [3 vstop:cc:off] vstop.cc.termios)
    (lsh [3 vstart:cc:off] vstart.cc.termios)
    (lsh [3 vswtc:cc:off] vswtc.cc.termios)
    (lsh [3 vmin:cc:off] vmin.cc.termios)
    (lsh [3 vtime:cc:off] vtime.cc.termios)
    (lsh [3 veof:cc:off] veof.cc.termios)
    (lsh [3 vkill:cc:off] vkill.cc.termios)
    (lsh [3 verase:cc:off] verase.cc.termios)
    (lsh [3 vquit:cc:off] vquit.cc.termios)
    (lsh [3 vintr:cc:off] vintr.cc.termios)
    (lsh [3 line:off] line.termios)
    (lsh [3 lflag:off] lflag.termios)
    (lsh [3 cflag:off] cflag.termios)
    (lsh [3 oflag:off] oflag.termios)
    (lsh [3 iflag:off] iflag.termios)
  ==
::
++  set-speed
  |=  [term=termios speed=@]
  ^-  termios
  %_  term
    cflag   (con (dis cflag.term (not 5 1 cbaud:baud)) speed)
  ==
::
++  get-speed
  |=  =termios
  ^-  @ud
  (dis cflag.termios cbaud:baud)
::
++  tcgets  0x5401
++  tcsets  0x5402
++  tcsbrk  0x5409
++  tcxonc  0x540A
++  tcflsh  0x540B
--
