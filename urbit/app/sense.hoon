/-  *sense
/+  default-agent, dbug, sense, view=sense-view, server, schooner, verb
/*  bpdu  %woff2  /sat/bpdotsunicase-bold/woff2
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
  $(unix-ms (add unix-ms 1))
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this     .
      default  ~(. (default-agent this %|) bowl)
      hc       ~(. ^hc bowl)
  ++  on-init
    ^-  (quip card _this)
    :_  this
    %-  limo
      :~  :*  %pass  /eyre/connect  %arvo  %e
              %connect  [~ /apps/sense]  %sense
          ==
          [%pass / %arvo %l %spin /data]
      ==
  ::
  ++  on-save   !>(state)
  ++  on-load
    |=  old=vase
    ^-  (quip card _this)
    [~ this(state !<(versioned-state old))]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?+    mark  (on-poke:default mark vase)
      ::
        %handle-http-request
      =/  req  !<([eyre-id=@ta =inbound-request:eyre] vase)
      ?>  =(method.request.inbound-request.req %'GET')
      ::
      =^  cards  state
        ^-  (quip card _state)
        (handle-http:hc req)
      ::
      [cards this]
    ==
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?>  (team:title our.bowl src.bowl)
    =/  now  now.bowl
    ?+  path  (on-peek:default path)
        [%x %entries *]
      =/  path  t.t.path
      ?+  path  (on-peek:default path)
          [%all ~]
        :^  ~  ~  %sense-update
        !>  ^-  update
        [now %data (tap:data-on data)]
      ::
          [%last @ ~]
        =/  count=@  (rash i.t.path dem)
        :^  ~  ~  %sense-update
        !>  ^-  update
        [now %data (tab:data-on data `(unm:chrono:userlib now) count)]
      ::
          [%before @ @ ~]
        =/  before=@  (unm:chrono:userlib (slav %da `@t`i.t.path))
        =/  count=@   (rash i.t.t.path dem)
        :^  ~  ~  %sense-update
        !>  ^-  update
        [now %data (tab:data-on data `(unm:chrono:userlib before) count)]
      ::
          [%between @ @ ~]
        =/  start=@  (unm:chrono:userlib (slav %da `@t`i.t.path))
        =/  end=@    (unm:chrono:userlib (slav %da `@t`i.t.t.path))
        :^  ~  ~  %sense-update
        !>  ^-  update
        [now %data (tap:data-on (lot:data-on data `end `start))]
      ::
          [%since @ ~]
        :: this is a unix timestamp
        =/  end=@  i.t.path
        :^  ~  ~  %sense-update
        !>  ^-  update
        [now %data (tab:data-on data `end 10.000)]
      ==
    ==
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?+    sign-arvo  (on-arvo:default wire sign-arvo)
    ::
        [%lick %soak *]
      ?+    mark.sign-arvo  [~ this]
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
      ::
          %data
        =/  d  ;;((list [@tas @]) noun.sign-arvo)
        =/  now=@  (unique-time now.bowl data)
        =/  =point  :*  wifi=+.&1.d
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
    ::
    ==
  ++  on-watch  
    |=  =path
    ^-  (quip card _this)
    ?>  (team:title our.bowl src.bowl)
    ?+    path  (on-watch:default path)
    ::
        [%updates ~]
      `this
    ::
        [%http-response * ~]
      `this
    ==
  ++  on-leave  on-leave:default
  ++  on-agent  
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    [~ this]
  ::
  ++  on-fail   on-fail:default
  --
::
|%
::
++  hc  ::  helper core
  |_  =bowl:gall
  ::
  ++  handle-http
    |=  [eyre-id=@ta =inbound-request:eyre]
    ::
    =/  rest  (parse-request-line:server url.request.inbound-request)
    =*  send  (cury response:schooner eyre-id)
    =*  dump  [(send 404 ~ [%none ~]) state]
    =*  derp  [(send 500 ~ [%stock ~]) state]
    ^-  (quip card _state)
    ::
    ~&  handle-http+site.rest
    ?+    method.request.inbound-request  derp
    ::
        %'GET'
      ?+    site.rest  dump
      ::
          [%apps %sense ~]
        :_  state
        (send 200 ~ %manx (~(document view state)))
      ::
          [%apps %sense %entries %all ~]
        ::  get the last 200 data points
        =/  out  .^(json %gx /(scot %p our.bowl)/sense/(scot %da now.bowl)/entries/all/json)
        :_  state
        (send 200 ~ %json out)
      ::
          [%apps %sense %entries %last @t ~]
        =/  count=(unit @ud)  (slaw %ud i.t.t.t.t.site.rest)
        ?~  count  derp
        =/  out
          .^(json %gx /(scot %p our.bowl)/sense/(scot %da now.bowl)/entries/last/(scot %u u.count)/json)
        :_  state
        (send 200 ~ %json out)
      ::
          [%apps %sense %entries %since @ ~]
        =/  since=@  (rash i.t.t.t.t.site.rest dem)
        =/  out
          .^(json %gx /(scot %p our.bowl)/sense/(scot %da now.bowl)/entries/since/(scot %u since)/json)
        :_  state
        (send 200 ~ %json out)
      ::
      :: static files
          [%apps %sense %static %bpdu-bold ~]
        :_  state
        (send 200 ~ %font-woff2 q.bpdu)
      ==
    ==
  ::
  --
--
