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
  // function toDateTimeObject(utime) {
  //   const d = new Date(utime);
  //   return {
  //     day: d.getDay(),
  //     hours: d.getHours(),
  //     minutes: d.getMinutes(),
  //     seconds: d.getSeconds(),
  //   };
  // };
  // const dto = toDateTimeObject;

  var vegaSpec = {
    $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
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
    mark: 'area',
    encoding: {
      x: {field: 'time', type: 'temporal'},
      y: {field: 'wifi', type: 'quantitative', title: 'WiFi Connection'},
      y: {field: 'rco2', type: 'quantitative', title: 'CO2 Concentration'},
      y: {field: 'pmo2', type: 'quantitative', title: 'Particulate Matter'},
      y: {field: 'tvoc', type: 'quantitative', title: 'Total Volatile Organic Compounds'},
      y: {field: 'atmp', type: 'quantitative', title: 'Ambient Temperature'},
      y: {field: 'rhum', type: 'quantitative', title: 'Relative Humidity'},
    },
  };
  '''
::
++  style
  ^~
  %-  trip
  '''
  :root {
    --measure: 80ch;
  }
  #viz {
    width: 10rem;
    height: 10rem;
    background: red;
  }
  '''
--
