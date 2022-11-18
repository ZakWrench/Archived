#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 13:52:06 2022

@author: zak
"""

import plotly.graph_objects as go
import plotly.express as px
from plotly.offline import init_notebook_mode, plot
init_notebook_mode()


df = px.data.gapminder().query("country == 'India'")
df2 = px.data.gapminder().query("country == 'Morocco'")



fig = go.Figure(data = [go.Scatter(x = df['year'], y = df['lifeExp'],
                                   line = dict(color = 'firebrick', width = 4),
                                   text = df['country'], name = 'India'),
                        go.Scatter(x = df2['year'], y = df2['lifeExp'],
                                   line = dict(color = 'blue', width = 4),
                                   text = df2['country'], name = 'Morocco')])

fig.update_layout(title = 'Life expectency over the years',
                  xaxis_title = 'Years',
                  yaxis_title = 'Life expectancy (years)',)

plot(fig)