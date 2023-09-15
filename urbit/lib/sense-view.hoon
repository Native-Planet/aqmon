/-  *sense
|%
::
:: +$  data  ((mop @ point) gth)
:: +$  point  [wifi=@ rco2=@ pm02=@ tvoc=@ nox=@ atmp=@ rhum=@]
::
::::  details:
  ::  wifi:  0   <->  100     (as in decibels, actually negative)
  ::  rco2: ~400 <-> ~2000
  ::  pmo2: ~6   <-> ~10
  ::  tvoc: ~100 <-> ~1000
  ::  nox:  ~1               (no sensor on device)
  ::  atmp: ~100 <-> ~300    (ambient temp in tenths of a degree Centigrade)
  ::  rhum:  0   <-> 100     (relative humidity, percent)
::::
::
++  head
  ^-  manx
  ;head
    ;title: Sense
    ;meta(charset "utf-8");
    ;link
      =rel   "stylesheet"
      =href  "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.css";
    ;link
      =rel   "stylesheet"
      =href  "https://unpkg.com/@fontsource/inter@5.0.8/index.css";
    ;script
      =type  "module"
      =src   "https://unpkg.com/@yungcalibri/layout@0.1.5/umd/bundle.js";
    ;script
      =nomodule  ""
      =src       "https://unpkg.com/@yungcalibri/layout@0.1.5/dist/bundle.js";
    ;script(src "https://unpkg.com/hyperscript.org@0.9.11");
    ;script(src "https://unpkg.com/htmx.org@1.9.0");
    ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/json-enc.js");
    ;script(src "https://unpkg.com/htmx.org@1.9.0/dist/ext/include-vals.js");
    ;script:"htmx.logAll();"
    ;script(src "https://unpkg.com/vega@5");
    ;script(src "https://unpkg.com/vega-lite@5");
    ;script(src "https://unpkg.com/vega-embed@6");
    ;style: {style}
  ==
::
++  graphs
  ^-  manx
  ;html
    ;+  head
    ;body(hx-ext "json-enc,include-vals", hx-boost "true")
    ;script(src "/apps/sense/static/graph-script.js");
    ::
    ;center-l
      ;stack-l(space "var(--s0)")
        ;sidebar-l
          ;h1: Sense
          ;cluster-l
            ;a/"/apps/sense": Graphs
            ;a/"/apps/sense/dashboard": Dashboard
          ==
        ==
        ;div#viz;
      ==
    ==
    ::
    ==
  ==
::
++  dashboard
  |=  =point
  ^-  manx
  ;html
    ;+  head
    ;body
      =hx-boost    "true"
      =hx-trigger  "every 1250ms"
      =hx-get      "/apps/sense/dashboard"
    ::
    ;center-l
      ;h1: Dashboard
      ;div#now
        ;div(data-field "rco2")
          ;div.value
            ;span: {<rco2.point>}
            ;span.unit: ppm
          ==
          ;div.label: CO2
        ==
        ;div(data-field "tvoc")
          ;div.value
            ;span: {<tvoc.point>}
            ;span.unit: ppb
          ==
          ;div.label: Volatiles
        ==
        ;div(data-field "rhum")
          ;div.value
            ;span: {<rhum.point>}
            ;span.unit: %
          ==
          ;div.label: Humidity
        ==
        ;div(data-field "wifi")
          ;div.value
            ;span: -{<wifi.point>}
            ;span.unit: dB
          ==
          ;div.label: Wi-Fi
        ==
        ;div(data-field "pm02")
          ;div.value
            ;span: {<pm02.point>}
          ==
          ;div.label: Particles (μg/㎥)
        ==
        ;div(data-field "atmp")
          ;div.value
            ;span: {(scow %ud (div atmp.point 10))}
            ;span.unit: °C
          ==
          ;div.label: Temp
        ==
      ==
    ==
    ::
    ==
  ==
::
++  style
  ^~
  %-  trip
  '''
  @font-face {
    font-family: 'BPdotsUnicase';
    src: url('/apps/sense/static/bpdu-bold.woff2') format('woff2');
    font-weight: bold;
    font-style: normal;
    font-display: swap;
  }
  :root {
    --measure: 80ch;

    --white-100: #F1F2EE;

    --gray-100: #DDE3DF;
    --gray-200: #ABBAAE;
    --gray-300: #8FA393;
    --gray-400: #5C7060;

    --np-white:  #F8F8F6;
    --np-gray:   #E8E8E3;
    --np-black:  #313933;
    --np-yellow: #EDF02C;

    --np-dark-bg: #161D17;
    --np-dark-hl: #2C3A2E;

    --np-button-green: #08A317;
    --np-active-green: #D7DB0F;
    --np-status-green: #067510;
  }
  body {
    font-family: "Inter", sans-serif;
    background-color: var(--np-dark-bg);
  }
  h1 {
    font-family: "BPdotsUnicase", ui-monospace;
    color: var(--np-white);
  }
  #viz {
    width: 80vw;
    height: 90vh;
  }
  #now {
    color: var(--np-white);
    display: grid;
    grid-template-areas:
      "rco2 rco2 rco2 ."
      "rco2 rco2 rco2 ."
      ". atmp atmp atmp"
      ". atmp atmp atmp";
    grid-template-rows: 2fr 1fr 1fr 2fr;
    grid-template-columns: 30% 1fr 1fr 30%;
    grid-auto-flow: row dense;
    gap: var(--s1);
    justify-content: stretch;
  }
  [data-field] {
    padding: var(--s1);
    background: var(--np-dark-hl);
    color: var(--np-white);
    border-radius: var(--s0);
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
    position: relative;
  }
  [data-field=rco2], [data-field=atmp] {
    background-color: var(--gray-100);
    color: var(--np-black);
    grid-row: span 2;
    grid-column: span 2;
    font-size: 170%;
  }
  [data-field=rco2] {
    grid-area: rco2;
    background: repeating-linear-gradient(
        -45deg,
        var(--gray-100),
        var(--gray-100) 16px,
        var(--np-dark-hl) 17px 33px,
        var(--gray-100) 34px 50px,
        var(--np-dark-hl) 51px 67px,
        var(--gray-100) 68px 84px,
        var(--gray-100) calc(84px + 100%)
      )
      0 0/100% 100%;
  }
  [data-field=atmp] {
    grid-area: atmp;
  }
  [data-field] .value {
    flex-basis: 80%;
    flex-grow: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    font-family: BPdotsUnicase, monospace;
    font-size: 250%;
  }
  [data-field] .label {
    flex-basis: 20%;
    flex-grow: 0;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  [data-field] .unit {
    font-size: 1.2rem;
  }
  '''
--
