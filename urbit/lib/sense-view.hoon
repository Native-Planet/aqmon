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
    ;script(src "/apps/sense/static/graph-script.js");
    ;style: {style}
  ==
::
++  document
  |.
  ^-  manx
  ;html
    ;+  head
    ;body(hx-ext "json-enc,include-vals")
    ::
    ;center-l
      ;stack-l(space "var(--s0)")
        ;h1: Sense
        ;div#viz;
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
  '''
--
