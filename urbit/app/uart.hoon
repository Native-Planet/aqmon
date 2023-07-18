/-  *uart
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  [%0 name=@tas]
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  [~ this]
  :::_  this
  ::[%pass /init %arvo %l %spin %uart]
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  ?=(%uart-action mark)
  =/  act  !<(action vase)
  ?-    -.act
      %spin
    :_  this
    [%pass / %arvo %l %spin name.act]~
    ::
      %shut
    :_  this
    [%pass /shut %arvo %l %shut name.act]~
    ::
      %spit
    :_  this
    [%pass /spit %arvo %l %spit name.act mark.act data.act]~
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ~&  >>  path
  =/  dev  `@tas`(snag 2 path)
  ?+  path  (on-peek:default path)
    [%s %agents *]  ``noun+!>(dev)
  ==
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ::=/  cmd    (snag 0 wire)
  ::=/  device  (snag 1 wire)
  =/  cad  +.sign-arvo
  ~&  >  ['wire' wire]
  ~&  >  ['sign-arvo' sign-arvo]
  ?+  sign-arvo  (on-arvo:default wire sign-arvo)
      [%lick %soak *]
    ~&  ['data' noun.sign-arvo]
    [~ this]
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-agent  on-agent:default
++  on-fail   on-fail:default
--
