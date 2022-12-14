#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 14:25:28 2022

@author: zak
"""

import plotly.express as px
from plotly.offline import init_notebook_mode, plot
init_notebook_mode()

df = px.data.gapminder().query('year == 2007')

fig = px.scatter(df, x = 'gdpPercap', y = 'lifeExp', size = 'pop',
                 color = 'continent', hover_name = 'country',
                 log_x = True, size_max = 50)



plot(fig)