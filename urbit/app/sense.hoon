/-  *sense
/+  default-agent, dbug, sense
!:
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
  =data
  ==
++  data-on  ((on @ point) gth)
+$  card  card:agent:gall
++  unique-time
  |=  [time=@da =data]
  ^-  @
  =/  unix-ms=@
    (unm:chrono:userlib time)
  |-
  ?.  (has:data-on data unix-ms)
    unix-ms
  $(time (add unix-ms 1))
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
  `this(state !<(versioned-state old))
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
  ?>  (team:title our.bowl src.bowl)
  =/  now  now.bowl
  ?+  path  (on-peek:default path)
      [%x %entries *]
    ?+  t.t.path  (on-peek:default path)
        [%all ~]
      :^  ~  ~  %sense-update
      !>  ^-  update
      [now %data (tap:data-on data)]
    ::
        [%before @ @ ~]
      =/  before=@da  (rash i.t.t.t.path dem)
      =/  max=@  (rash i.t.t.t.t.path dem)
      :^  ~  ~  %sense-update
      !>  ^-  update
      [now %data (tab:data-on data `before max)]
    ::
        [%between @ @ ~]
      =/  start=@da
        =+  (rash i.t.t.t.path dem)
        ?:(=(0 -) - (sub - 1))
      =/  end=@  (add 1 (rash i.t.t.t.t.path dem))
      :^  ~  ~  %sense-update
      !>  ^-  update
      [now %data (tap:data-on (lot:data-on data `end `start))]
    ==
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
      =/  now=@  (unique-time now.bowl data)
      =/  =point  :*
        wifi=+.&1.d
        rco2=+.&2.d
        pm02=+.&3.d
        tvoc=+.&4.d
        nox=+.&5.d
        atmp=+.&6.d
        rhum=+.&7.d
      ==
      ~&  >  ['Data' now point]
      :-  ~
      this(data (put:data-on data now point))
      ==
  ==
++  on-watch  
  |=  =path
  ^-  (quip card _this)
  ?>  (team:title our.bowl src.bowl)
  ?+  path  (on-watch:default path)
    [%updates ~]  `this
  ==
++  on-leave  on-leave:default
++  on-agent  
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  [~ this]
::
++  on-fail   on-fail:default
--
