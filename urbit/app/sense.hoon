/+  default-agent, dbug
!:
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
  data=((mop @da point) lth)
  ==
+$  point  [wifi=@ rco2=@ pm02=@ tvoc=@ nox=@ atmp=@ rhum=@]
+$  card  card:agent:gall
++  myon  ((on @da point) lth)
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
  :_  this
  [%pass / %arvo %l %spin /data]~ 
++  on-save   !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  [~ this]
  ::?>  ?=(%uart-action mark)
  ::=/  act  !<(action vase)
  ::?-    -.act
      ::%spin
    :::_  this
    ::[%pass / %arvo %l %spin name.act]~
    ::::
      ::%shut
    :::_  this
    ::[%pass /shut %arvo %l %shut name.act]~
    ::::
      ::%spit
    :::_  this
    ::[%pass /spit %arvo %l %spit name.act mark.act data.act]~
  ::==
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
  =/  cad  +.sign-arvo
  ?+  sign-arvo  (on-arvo:default wire sign-arvo)
      [%lick %soak *]
      ?+  mark.sign-arvo  [~ this]
      ::
        %connect
      ~&  >  'Connected'
      `this
      ::
        %disconnect
      ~&  >  'Disconnected'
      `this
      ::
        %error
      ~&  >  ['Error: ' ;;(@tas noun.sign-arvo)]
      `this
        %data
      =/  d  ;;((list [@tas @]) noun.sign-arvo)
      =/  =point  :*
        wifi=+.&1.d
        rco2=+.&2.d
        pm02=+.&3.d
        tvoc=+.&4.d
        nox=+.&5.d
        atmp=+.&6.d
        rhum=+.&7.d
      ==
      ~&  >  ['Data' now.bowl point]
      :-  ~
      this(data (put:myon data now.bowl point))
      ==
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-agent  
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  [~ this]
::
++  on-fail   on-fail:default
--
