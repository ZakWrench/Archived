#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 14:37:08 2022

@author: zak
"""

import plotly.express as px
from plotly.offline import init_notebook_mode, plot
init_notebook_mode()

df = px.data.election()
#df.columns

geojson = px.data.election_geojson()

fig = px.choropleth(df, geojson = geojson, locations = 'district',
                    featureidkey = "properties.district", projection = "mercator",
                    color = 'Bergeron')

fig.update_geos(fitbounds = "locations", visible = False)

plot(fig)



