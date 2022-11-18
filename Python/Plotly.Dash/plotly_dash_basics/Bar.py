#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 11 18:42:08 2022

@author: zak
"""

import plotly.graph_objects as go
import plotly.express as px

from plotly.offline import init_notebook_mode, plot
init_notebook_mode()
#px.data.gapminder().country.unique()

df = px.data.gapminder().query("country =='India'")
df2 = px.data.gapminder().query("country =='Morocco'")


fig = go.Figure([go.Bar(x = df['year'], y = df['gdpPercap'], marker_color = 'indianred', name = 'India'),
                 go.Bar(x = df2['year'], y = df2['gdpPercap'], marker_color = 'blue', name = 'Morocco')])

fig.update_layout(title = 'GDP per catipa over the years',
                  xaxis_title = 'Years',
                  yaxis_title = 'GDP per capita',
                  barmode = 'group')

plot(fig)