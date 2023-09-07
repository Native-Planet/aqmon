/-  *sense
|_  [%0 =data]
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
++  document
  |.
  ^-  manx
  ;html
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
      ;script: {vega-spec}
      ;style: {style}
    ==
    ;body(hx-ext "json-enc,include-vals")
    ::
    ;center-l
      ;stack-l(space "var(--s0)")
        ;h1: Sense
        ;div#viz(data-script "on load call vegaEmbed('#viz', vegaSpec)");
      ==
    ==
    ::
    ==
  ==
::
++  vega-spec
  ^~
  %-  trip
  '''
  var vegaSpec = {
    $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
    width: 600,
    height: 200,
    data: {
      values: [
        {time: 1692650224451, wifi: 89, rco2: 722, pm02: 6, tvoc: 272, nox: 1, atmp: 223, rhum: 28},
        {time: 1692650304183, wifi: 84, rco2: 704, pm02: 7, tvoc: 275, nox: 1, atmp: 225, rhum: 29},
        {time: 1692650316838, wifi: 83, rco2: 761, pm02: 6, tvoc: 278, nox: 1, atmp: 228, rhum: 28},
        {time: 1692650327176, wifi: 87, rco2: 812, pm02: 6, tvoc: 269, nox: 1, atmp: 219, rhum: 24},
        {time: 1692650334730, wifi: 92, rco2: 800, pm02: 8, tvoc: 271, nox: 1, atmp: 214, rhum: 21},
        {time: 1692650342971, wifi: 88, rco2: 815, pm02: 9, tvoc: 279, nox: 1, atmp: 208, rhum: 20},
        {time: 1692650349419, wifi: 85, rco2: 781, pm02: 7, tvoc: 277, nox: 1, atmp: 201, rhum: 17},
      ],
    },
    transform: [
      {calculate: "datum.wifi / 100",          as: "n_wifi"},
      {calculate: "(datum.rco2 - 400) / 1600", as: "n_rco2"},
      {calculate: "(datum.pm02 - 2) / 8",      as: "n_pm02"},
      {calculate: "(datum.tvoc - 100) / 900",  as: "n_tvoc"},
      {calculate: "(datum.atmp - 100) / 300",  as: "n_atmp"},
      {calculate: "datum.rhum / 100",          as: "n_rhum"},
      {
        fold: ["n_rco2", "n_pm02", "n_tvoc", "n_atmp", "n_rhum"],
        as: ["normal", "value"],
      },
      {
        fold: ["rco2", "pm02", "tvoc", "atmp", "rhum"],
        as: ["raw", "raw_value"],
      },
    ],
    mark: {
      type: 'rect',
      width: 75,
      height: 25,
    },

    encoding: {
      x: {
        field: 'time',
        type: 'ordinal',
        title: 'Time',
        timeUnit: 'hoursminutesseconds',
        axis: {
          labelAngle: 60,
          labelOverlap: false,
        },
      },
      y: {
        field: "normal",
        type: "nominal",
        title: null,
        axis: { labelExpr: "replace(datum.label, 'n_', '')" },
      },

      color: {
        scale: {type: "log"},
        field: 'value',
        type: 'quantitative',
      }
    },
  };
  '''
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
    width: 40rem;
    height: 30rem;
  }
  '''
--
