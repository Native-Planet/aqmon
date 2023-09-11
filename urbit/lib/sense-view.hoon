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
      ;script: {page-script}
      ;style: {style}
    ==
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
++  page-script
  ^~
  %-  trip
  '''
  const concat = [
    ['wifi',    'Wi-Fi'],
    ['rco2',    'Room CO2'],
    ['pm02',    'Particles'],
    ['tvoc',    'Volatiles'],
    ['c_atmp',  'Temp'],
    ['rhum',    'Humidity'],
  ].map(([field, title]) => ({
    mark: {
      type: 'line',
      color: "#EDF02C",
      point: {
        color: "#EDF02C",
      },
    },
    width: 700,
    autosize: {
      type: 'fit-x',
      contains: 'padding',
      resize: true,
    },
    encoding: {
      x: {
        field: 'time',
        type: 'temporal',
        title: null,
        axis: {
          labelAngle: 30,
          labelOverlap: false,
          format: '%m-%d %H:%M',
        },
      },
      y: {
        field,
        type: "quantitative",
        title,
      },
    },
  }));

  var vegaSpec = {
    $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
    data: {
      name: 'points',
    },
    width: 800,
    autosize: {
      type: 'fit-x',
      contains: 'padding',
      resize: true,
    },
    transform: [
      /* corrected ambient temp */
      {calculate: "datum.atmp / 10.0", as: "c_atmp"}
    ],
    config: {
      background: 'transparent',
      axis: {
        domainColor: "#DDE3DF",
        tickColor: "#DDE3DF",
        labelColor: "#ABBAAE",
        titleColor: "#F1F2EE",
        titleFont: 'BPdotsUnicase',
        titleFontSize: 20,
        labelFont: 'Inter',
        labelFontSize: 14,
      },
      line: {
        point: true,
        tooltip: true,
      }
    },
    vconcat: concat,
  };

  async function setup() {
    try {
      const result = await vegaEmbed('#viz', vegaSpec);
      return result.view;
    } catch (err) {
      console.error('error during setup:', err);
    }
  };

  const makeFilter = () => {
    now = Date.now();
    oldest = 60 * 1000 * 20;
    return dat => now - dat.time > oldest;
  };

  async function getLatest() {
    try {
      const latest = (() => {
        const strLatest = sessionStorage.getItem("latestPoint");
        if (!strLatest) {
          return;
        }
        return JSON.parse(strLatest);
      })();

      console.log('latest:', latest);

      const endpoint = !!latest?.time
        ? `/apps/sense/entries/since/${latest.time}`
        : `/apps/sense/entries/since/${new Date() - 60 * 1000}`;

      const newPoints = await
        fetch(endpoint)
        .then(res => res.json());
      console.log('got', newPoints.length, 'new data points');
      
      return newPoints;
    } catch (err) {
      console.error('error fetching new points:', err);
      return [];
    }
  }

  async function updateData(chart) {
    try {
      if (!chart) {
        throw new Error("tried to update data but chart isn't ready yet");
      }

      const newPoints = await getLatest();
      const newLatest = newPoints?.[0];
      if (!newLatest) {
        console.error('aborting update, no new data available');
        return;
      }
      sessionStorage.setItem('latestPoint', JSON.stringify(newLatest));

      const changeset = vega.changeset()
        .insert(newPoints)
        .remove(makeFilter());

      chart.change('points', changeset).run();

    } catch (err) {
      console.error('error updating data:', err);
    }
  }

  window.addEventListener('load', function() {
    sessionStorage.removeItem('latestPoint');
    setup().then(view => {
      const updateInterval = setInterval(() => {
        
        updateData(view)
      }, 3500);
      document.addEventListener('beforeUnload', () => clearInterval(updateInterval));
    });
  });
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
    width: 80vw;
    height: 90vh;
  }
  '''
--
