#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 14:09:29 2022

@author: zak
"""

import plotly.graph_objects as go
import plotly.express as px
from plotly.offline import init_notebook_mode, plot
init_notebook_mode()


#Query() queries the column of a DataFrame with a boolean oxpression.

df = px.data.gapminder().query("country == 'India'")

df2 = px.data.gapminder().query("country == 'Morocco'")

df3 = px.data.gapminder().query("country == 'Iceland'")

fig = go.Figure()

fig.add_trace(go.Scatter(x = df['year'], y = df['lifeExp'], mode = 'markers', name = 'India'))
#fig.add_trace(go.Scatter(x = df2['year'], y = df2['lifeExp'], mode = 'lines'))
fig.add_trace(go.Scatter(x = df2['year'], y = df2['lifeExp'], mode = 'markers', name = 'Morocco'))
fig.add_trace(go.Scatter(x = df3['year'], y = df3['lifeExp'], mode = 'lines', name = 'Iceland'))


fig.update_layout(title = 'Life Expectancy over the years',
                  xaxis_title = 'Years',
                  yaxis_title = 'Life Expectancy (years)')

plot(fig)