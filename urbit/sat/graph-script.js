const concat = [
  ['c_atmp',  'Temp (°C)'],
  ['rhum',    'Humidity (%)'],
  ['rco2',    'Room CO2 (ppm)'],
  ['pm02',    'Particles (ug/㎥)'],
  ['tvoc',    'Volatiles (ppb)'],
  ['wifi',    'Wi-Fi (dB)'],
].map(([field, title]) => ({
  mark: {
    type: 'line',
    color: "#EDF02C",
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
      scale: {
        zero: false,
        }
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
      tooltip: true,
      interpolate: 'monotone',
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
  oldest = 60 * 1000 * 12 * 60;
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
      : `/apps/sense/entries/since/${new Date() - 60 * 1000 * 12 * 60}`;

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
